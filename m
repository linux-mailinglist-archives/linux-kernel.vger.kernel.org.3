Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7B473CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhLNGEA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Dec 2021 01:04:00 -0500
Received: from prt-mail.chinatelecom.cn ([42.123.76.223]:40727 "EHLO
        chinatelecom.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230238AbhLNGD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:03:57 -0500
HMM_SOURCE_IP: 172.18.0.48:58330.1093354738
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-182.150.57.243 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 0AE942800F1;
        Tue, 14 Dec 2021 14:02:57 +0800 (CST)
X-189-SAVE-TO-SEND: renlei1@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 7524f4eb91b54d7dbeb0d30380fbbb3a for david@fromorbit.com;
        Tue, 14 Dec 2021 14:03:38 CST
X-Transaction-ID: 7524f4eb91b54d7dbeb0d30380fbbb3a
X-Real-From: renlei1@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: renlei1@chinatelecom.cn
From:   <renlei1@chinatelecom.cn>
To:     <david@fromorbit.com>
Cc:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211214031517.508012-1-renlei1@chinatelecom.cn> <20211214044910.GT449541@dread.disaster.area>
In-Reply-To: <20211214044910.GT449541@dread.disaster.area>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB4ZnM6IG5vdCBhbGxvdyByZW5hbWUgaWYgcw==?=
        =?gb2312?B?cmMgaXMgcXVvdGEgZW5hYmxlZCBhbmQgcHJvamVjdCBJRHMgYXJlIGRpZmY=?=
        =?gb2312?B?ZXJlbnQ=?=
Date:   Tue, 14 Dec 2021 14:02:57 +0800
Message-ID: <001301d7f0b0$58cb7c80$0a627580$@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIhmVxlPsWW/XjW+beLtPQhB5gnxwFkd06Gq5MJexA=
Content-Language: zh-cn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's make sense, thanks very much for your detailed response!

Regards,
RenLei

-----邮件原件-----
发件人: david@fromorbit.com <david@fromorbit.com> 
发送时间: 2021年12月14日 12:49
收件人: renlei1@chinatelecom.cn
抄送: djwong@kernel.org; linux-xfs@vger.kernel.org;
linux-kernel@vger.kernel.org
主题: Re: [PATCH] xfs: not allow rename if src is quota enabled and project
IDs are different

On Tue, Dec 14, 2021 at 11:15:17AM +0800, renlei1@chinatelecom.cn wrote:
> From: Ren Lei <renlei1@chinatelecom.cn>
> 
> xfs not allow rename if target is using project inheritance and 
> project IDs are different to avoid tree quota mechanism not work.

Lesson #1: project quotas are *not* directory quotas.

> But if only src with directory quota enabled, rename to other 
> directory without quota enabled can succeed and skip quota mechanism. 
> which might result to unexpected quota behavior.

Yes, this is explicitly done this way, because project quotas are not
directory quotas.

Lesson #2: directory tree semantics use PROJINHERIT to define an entry
barrier to the directory, not an exit barrier.

That is, we restrict moving inodes with incompatible project IDs into a
directory that might be used as a directory tree, but we don't prevent
moving inodes out of PROJINHERIT directories into locations that have no
PROJINHERIT set.

The reason for this is simple: destinations that don't have PROJINHERIT set
are unrestricted and can contain inodes with any valid projid. This is the
traditional use of project quotas, because...

Lesson #3a: PROJINHERIT only defines the default project ID for newly
created inodes in a directory.

Lesson #3b: Unprivileged users in the init namespace are allowed to change
PROJINHERIT and projid on any inode they have write permissions on.

That is, PROJINHERIT does not prevent users from changing the project ID of
files within the directory, or even that of the directory so that it no
longer matches the projid of the existing directory contents. Hence
directory tree quotas will only remain valid with the co-operation of
unprivileged users, as project ID and PROJINHERIT are user modifiable inode
attributes.

Lesson #4: Using project quotas to provide directory tree quotas does not
result in an access-based space usage enforcement mechanism without some
other mechanism for preventing users from accessing and changing project
quota information. (e.g. containers and user
namespaces)

> This patch fix this by disable rename if src is using project 
> inheritance and the project IDs are not the same.
> 
> following steps can easy reproduce this issue:
> 1. first init a directory quota /mnt/test
> 	mount -o prjquota /dev/sdb  /mnt
> 	mkdir /mnt/test
> 	echo 1:/mnt/test >> /etc/projects
> 	echo test:1 >> /etc/projid
> 	xfs_quota -x -c 'project -s test' /mnt
> 	xfs_quota -x -c 'limit -p bhard=10m test' /mnt
>
> 2. fill /mnt/test with tesfile util directory full:
> 	[root@rhost1 test]# dd if=/dev/zero of=/mnt/test/testfile
> 	dd: writing to '/mnt/test/testfile': No space left on device 3. mv 
> testfile out to /mnt,  test is empty but cannot create files:
> 	[root@rhost1 test]# mv testfile ../
> 	[root@rhost1 test]# ls -a
> 	.  ..
> 	[root@rhost1 test]# touch aaa
> 	touch: cannot touch 'aaa': Disk quota exceeded

Yup, exfiltration is not prohibited, as per above. What you need to do here
is prevent infiltration to the "../" directory by use of a default directory
quota for all the "non-controlled" part of the directory heirarchy. That is:

> 	mount -o prjquota /dev/sdb  /mnt
> 	mkdir /mnt/test
> 	echo 1:/mnt > /etc/projects
> 	echo 2:/mnt/test >> /etc/projects
> 	echo default:1 >> /etc/projid
> 	echo test:2 >> /etc/projid
> 	xfs_quota -x -c 'project -s default' /mnt
> 	xfs_quota -x -c 'project -s test' /mnt
> 	xfs_quota -x -c 'limit -p bhard=10m test' /mnt

So now you have the default "unlimited" directory quota on the entire
filesytem, with the sub-tree "test" set up with a hard limit.
Now step #3 in your test will behave as you expect, because ".." has a
PROJINHERIT w/ projid = 1 set and that will trigger the "destination
directory has directory quota and different projid"
-EXDEV error case in rename.

i.e. you fix this problem by setting up the directory tree quota
configuration properly, not by changing the kernel code behaviour...

Note: you can set the default directory tree project ID at mkfs time
via:

# mkfs.xfs -f -d projinherit=42 /dev/sdb

So you don't actually need to set up a default project in /etc/projects to
make this work correctly.

Cheers,

Dave.
--
Dave Chinner
david@fromorbit.com

