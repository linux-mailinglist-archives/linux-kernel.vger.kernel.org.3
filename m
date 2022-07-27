Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54462581ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbiG0E0O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Jul 2022 00:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbiG0E0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:26:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D776B3CBD7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:26:08 -0700 (PDT)
Received: from canpemm100009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lt0y94Wc9z1HBMF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:23:13 +0800 (CST)
Received: from canpemm500008.china.huawei.com (7.192.105.151) by
 canpemm100009.china.huawei.com (7.192.105.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 12:26:06 +0800
Received: from canpemm500008.china.huawei.com ([7.192.105.151]) by
 canpemm500008.china.huawei.com ([7.192.105.151]) with mapi id 15.01.2375.024;
 Wed, 27 Jul 2022 12:26:06 +0800
From:   wangboshi <wangboshi@huawei.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Qinchao(OS Kernel Lab)" <qinchao15@huawei.com>,
        "Likun(OSLab)" <hw.likun@huawei.com>
Subject: fs: An unexpected ACL pass
Thread-Topic: fs: An unexpected ACL pass
Thread-Index: AdihY2HUnuNpmPylRqC5e73sW2zJmQ==
Date:   Wed, 27 Jul 2022 04:26:06 +0000
Message-ID: <5e404aede1284bacbcd96fa180e4fdf6@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.108.234.231]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone.

We want to talk about a detail about ACL. In `acl_permission_check` function, when file modes don't contain any group permissions, the ACL check is bypassed. 
```
static int acl_permission_check(struct user_namespace *mnt_userns,
				struct inode *inode, int mask)
{
	unsigned int mode = inode->i_mode;
	kuid_t i_uid;

	/* Are we the owner? If so, ACL's don't matter */
	i_uid = i_uid_into_mnt(mnt_userns, inode);
	if (likely(uid_eq(current_fsuid(), i_uid))) {
		mask &= 7;
		mode >>= 6;
		return (mask & ~mode) ? -EACCES : 0;
	}

	/* Do we have ACL's? */
	if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
		int error = check_acl(mnt_userns, inode, mask);
		if (error != -EAGAIN)
			return error;
	}

	/* Only RWX matters for group/other mode bits */
	mask &= 7;

	/*
	 * Are the group permissions different from
	 * the other permissions in the bits we care
	 * about? Need to check group ownership if so.
	 */
	if (mask & (mode ^ (mode >> 3))) {
		kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
		if (in_group_p(kgid))
			mode >>= 3;
	}

	/* Bits in 'mode' clear that we require? */
	return (mask & ~mode) ? -EACCES : 0;
}
```
It causes that users or groups can get permissions by the other-permission bits even if ACL explicitly restricts that they have no permission.
For example, we(1000) create a file and set its ACLs which give owner, user(2000), group(3000) and other all permissions with no mask permissions.
```
$ echo data > test
$ setfacl -m u::rwx,g::rwx,u:2000:rwx,g:3000:rwx,m::-,o:rwx test
$ getfacl test
# file: test
# owner: 1000
# group: 1000
user::rwx
user:2000:rwx                   #effective:---
group::rwx                      #effective:---
group:3000:rwx                  #effective:---
mask::---
other::rwx
```
Let user(2000) and group(3000) access the file.
```
$ sudo capsh --gid=2000 --uid=2000 -- -c 'cat test'
data
$ sudo capsh --gid=3000 --uid=3000 -- -c 'cat test'
data
```
We can see these successful accesses. It is unexpected. In contrast, according to the ACL access check algorithm described in POSIX 1003.1e draft 17 23.1.5 section, accesses should be denied, because user(2000) and group(3000) are explicitly specified by us and we restrict the permission of the specific users and groups via no mask permissions. And the getfacl tool tells us that all effective permissions of user(1000), group(3000) and owner group contain nothing too.

What's more, if we add x permission to mask permissions, read accesses are denied. It's counterintuitive that we can do something with no permission and are denied with more other permissions.

We want to trace the original of the design. We find similar implementations in earlier version where ext2 ACL was introduced. The design looks like an optimization, but it should base on an assumption that there is no other-permissions if no group-permissions. Is the assumption always valid?
