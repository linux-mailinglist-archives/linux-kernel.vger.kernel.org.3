Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B6452C893
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiESAXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiESAXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 869ED93475
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652919783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VoxOY06m8DziO/FKC/Ga8w+ya/GIIKz9WcySFIlWpjA=;
        b=TCZjjCalIsyTGgHuoMBMzuQ/akwVJ1iHPN5EdVSQlCCOB0WsDT9Ku4SkBSUcWl8I5UKQrE
        OQk6lp/esgKu95OuZ4HXZOEiv3oV1IYLaEcU7BHlaiCvgRrrFNwpSHp+pN1SWE5PtK4wIX
        xoWpgx/jZNgFbwWPtnbW1JJP4vpUEEQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-4066ie91Mxq32xOVzYyzBA-1; Wed, 18 May 2022 20:23:01 -0400
X-MC-Unique: 4066ie91Mxq32xOVzYyzBA-1
Received: by mail-pf1-f200.google.com with SMTP id b20-20020a62a114000000b0050a6280e374so1789841pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VoxOY06m8DziO/FKC/Ga8w+ya/GIIKz9WcySFIlWpjA=;
        b=LJWZMklTS3FGsMCtsyJcOubPrzeduVObHF/nksDdnihi/8Iu73O6+5HRV9y/Mhn/4j
         ydo3A9LVtpiZsuqSKr2TYyLCS1sGQdAmfQ8t+CqiPrtSA5WQr1GbPSVoeN51+5ed6OPP
         1xIH4KUuD9dZ1kSoDy5cUdX7z+SWsyzpxxinNaN/L5KRz31kOWVADerwaxR0gp1MxvdX
         zbVLPKNbP7YljOCvhiRBmymPJOoJ4oA4oGWcxLBuMid4+V4uBIIMGgxvtds5oTQBqaDU
         QLWeysdoJ3cXIuj4ISUqsLoqFKbSRxHURg7Jy+E68c7aOx2zNQBCwzsVyDNthdyhGa/q
         rQgQ==
X-Gm-Message-State: AOAM533BYapSSTVpXrFYLZBtDJPVPcYADsg0HVBEus7CZiFRDpMsTxwv
        JI0wVxXQnA/EQ5cwtxDYckdcu+FHH7A+1lbDQosNh6w27TP9Qfa0L3IwyjonlYKYoYSPWXLik9x
        OBaZ81SD7NcWG6/2At6oJt89S
X-Received: by 2002:a63:2b0b:0:b0:39d:890a:ab68 with SMTP id r11-20020a632b0b000000b0039d890aab68mr1659093pgr.247.1652919780052;
        Wed, 18 May 2022 17:23:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuXxpaAVTm7lCh3lmkqa7YwcxhY0bBLjANaCHxYE/8/CI51SFADDpCGqik9TMOPoCWCgsK9g==
X-Received: by 2002:a63:2b0b:0:b0:39d:890a:ab68 with SMTP id r11-20020a632b0b000000b0039d890aab68mr1659074pgr.247.1652919779770;
        Wed, 18 May 2022 17:22:59 -0700 (PDT)
Received: from [10.72.12.136] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709026b4700b0016152774878sm2288399plt.176.2022.05.18.17.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 17:22:58 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] ceph: wait the first reply of inflight async
 unlink
To:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     willy@infradead.org, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220518144545.246604-1-xiubli@redhat.com>
 <20220518144545.246604-3-xiubli@redhat.com>
 <b6e662fb38e55d3cc5158a7d1a8ea1eb5cdae80e.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <708e3416-8a5a-6dfc-5d06-f82dd48c9913@redhat.com>
Date:   Thu, 19 May 2022 08:22:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b6e662fb38e55d3cc5158a7d1a8ea1eb5cdae80e.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/22 4:28 AM, Jeff Layton wrote:
> On Wed, 2022-05-18 at 22:45 +0800, Xiubo Li wrote:
>> In async unlink case the kclient won't wait for the first reply
>> from MDS and just drop all the links and unhash the dentry and then
>> succeeds immediately.
>>
>> For any new create/link/rename,etc requests followed by using the
>> same file names we must wait for the first reply of the inflight
>> unlink request, or the MDS possibly will fail these following
>> requests with -EEXIST if the inflight async unlink request was
>> delayed for some reasons.
>>
>> And the worst case is that for the none async openc request it will
>> successfully open the file if the CDentry hasn't been unlinked yet,
>> but later the previous delayed async unlink request will remove the
>> CDenty. That means the just created file is possiblly deleted later
>> by accident.
>>
>> We need to wait for the inflight async unlink requests to finish
>> when creating new files/directories by using the same file names.
>>
>> URL: https://tracker.ceph.com/issues/55332
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/dir.c        | 70 +++++++++++++++++++++++++++++++++++++++---
>>   fs/ceph/file.c       |  4 +++
>>   fs/ceph/mds_client.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/ceph/mds_client.h |  1 +
>>   fs/ceph/super.c      |  3 ++
>>   fs/ceph/super.h      | 19 +++++++++---
>>   6 files changed, 160 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index eae417d71136..01e7facef9b2 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -856,6 +856,10 @@ static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>>   	if (ceph_snap(dir) != CEPH_NOSNAP)
>>   		return -EROFS;
>>   
>> +	err = ceph_wait_on_conflict_unlink(dentry);
>> +	if (err)
>> +		return err;
>> +
>>   	if (ceph_quota_is_max_files_exceeded(dir)) {
>>   		err = -EDQUOT;
>>   		goto out;
>> @@ -918,6 +922,10 @@ static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>>   	if (ceph_snap(dir) != CEPH_NOSNAP)
>>   		return -EROFS;
>>   
>> +	err = ceph_wait_on_conflict_unlink(dentry);
>> +	if (err)
>> +		return err;
>> +
>>   	if (ceph_quota_is_max_files_exceeded(dir)) {
>>   		err = -EDQUOT;
>>   		goto out;
>> @@ -968,9 +976,13 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>   	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
>>   	struct ceph_mds_request *req;
>>   	struct ceph_acl_sec_ctx as_ctx = {};
>> -	int err = -EROFS;
>> +	int err;
>>   	int op;
>>   
>> +	err = ceph_wait_on_conflict_unlink(dentry);
>> +	if (err)
>> +		return err;
>> +
>>   	if (ceph_snap(dir) == CEPH_SNAPDIR) {
>>   		/* mkdir .snap/foo is a MKSNAP */
>>   		op = CEPH_MDS_OP_MKSNAP;
>> @@ -980,6 +992,7 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>   		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>>   		op = CEPH_MDS_OP_MKDIR;
>>   	} else {
>> +		err = -EROFS;
>>   		goto out;
>>   	}
>>   
>> @@ -1037,6 +1050,10 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
>>   	struct ceph_mds_request *req;
>>   	int err;
>>   
>> +	err = ceph_wait_on_conflict_unlink(dentry);
>> +	if (err)
>> +		return err;
>> +
>>   	if (ceph_snap(dir) != CEPH_NOSNAP)
>>   		return -EROFS;
>>   
>> @@ -1071,9 +1088,27 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
>>   static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
>>   				 struct ceph_mds_request *req)
>>   {
>> +	struct dentry *dentry = req->r_dentry;
>> +	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
>> +	struct ceph_dentry_info *di = ceph_dentry(dentry);
>>   	int result = req->r_err ? req->r_err :
>>   			le32_to_cpu(req->r_reply_info.head->result);
>>   
>> +	if (!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags))
>> +		pr_warn("%s dentry %p:%pd async unlink bit is not set\n",
>> +			__func__, dentry, dentry);
>> +
> This is a pr_warn so it won't have a "ceph: " prefix or anything
> prepending it like dout messages do. You should probably prepend this
> with something like that.

The pr_fmt already help add the module name:

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Such as for one current log in ceph:

2022-05-02T17:28:51.006593+00:00 smithi040 kernel: ceph: ceph: async 
create failure path=(1)client.0/tmp/ceph/src/os/ObjectStore.h result=-17!


>
>> +	spin_lock(&fsc->async_unlink_conflict_lock);
>> +	hash_del_rcu(&di->hnode);
>> +	spin_unlock(&fsc->async_unlink_conflict_lock);
>> +
>> +	spin_lock(&dentry->d_lock);
>> +	di->flags &= ~CEPH_DENTRY_ASYNC_UNLINK;
>> +	wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);
>> +	spin_unlock(&dentry->d_lock);
>> +
>> +	synchronize_rcu();
>> +
>>   	if (result == -EJUKEBOX)
>>   		goto out;
>>   
>> @@ -1081,7 +1116,7 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
>>   	if (result) {
>>   		int pathlen = 0;
>>   		u64 base = 0;
>> -		char *path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
>> +		char *path = ceph_mdsc_build_path(dentry, &pathlen,
>>   						  &base, 0);
>>   
>>   		/* mark error on parent + clear complete */
>> @@ -1089,13 +1124,13 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
>>   		ceph_dir_clear_complete(req->r_parent);
>>   
>>   		/* drop the dentry -- we don't know its status */
>> -		if (!d_unhashed(req->r_dentry))
>> -			d_drop(req->r_dentry);
>> +		if (!d_unhashed(dentry))
>> +			d_drop(dentry);
>>   
>>   		/* mark inode itself for an error (since metadata is bogus) */
>>   		mapping_set_error(req->r_old_inode->i_mapping, result);
>>   
>> -		pr_warn("ceph: async unlink failure path=(%llx)%s result=%d!\n",
>> +		pr_warn("async unlink failure path=(%llx)%s result=%d!\n",
> Ditto here: why remove the prefix?

The log will be:

2022-05-02T17:28:51.006593+00:00 smithi040 kernel: ceph: ceph: async 
create failure path=(1)client.0/tmp/ceph/src/os/ObjectStore.h result=-17!

And the prefix "ceph:" is really needed ?

>>   			base, IS_ERR(path) ? "<<bad>>" : path, result);
>>   		ceph_mdsc_free_path(path, pathlen);
>>   	}
>> @@ -1180,6 +1215,8 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
>>   
>>   	if (try_async && op == CEPH_MDS_OP_UNLINK &&
>>   	    (req->r_dir_caps = get_caps_for_async_unlink(dir, dentry))) {
>> +		struct ceph_dentry_info *di = ceph_dentry(dentry);
>> +
>>   		dout("async unlink on %llu/%.*s caps=%s", ceph_ino(dir),
>>   		     dentry->d_name.len, dentry->d_name.name,
>>   		     ceph_cap_string(req->r_dir_caps));
>> @@ -1187,6 +1224,16 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
>>   		req->r_callback = ceph_async_unlink_cb;
>>   		req->r_old_inode = d_inode(dentry);
>>   		ihold(req->r_old_inode);
>> +
>> +		spin_lock(&dentry->d_lock);
>> +		di->flags |= CEPH_DENTRY_ASYNC_UNLINK;
>> +		spin_unlock(&dentry->d_lock);
>> +
>> +		spin_lock(&fsc->async_unlink_conflict_lock);
>> +		hash_add_rcu(fsc->async_unlink_conflict, &di->hnode,
>> +			     dentry->d_name.hash);
>> +		spin_unlock(&fsc->async_unlink_conflict_lock);
>> +
>>   		err = ceph_mdsc_submit_request(mdsc, dir, req);
>>   		if (!err) {
>>   			/*
>> @@ -1198,6 +1245,15 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
>>   		} else if (err == -EJUKEBOX) {
>>   			try_async = false;
>>   			ceph_mdsc_put_request(req);
>> +
>> +			spin_lock(&dentry->d_lock);
>> +			di->flags &= ~CEPH_DENTRY_ASYNC_UNLINK;
>> +			spin_unlock(&dentry->d_lock);
>> +
>> +			spin_lock(&fsc->async_unlink_conflict_lock);
>> +			hash_del_rcu(&di->hnode);
>> +			spin_unlock(&fsc->async_unlink_conflict_lock);
>> +
> You're clearing the flag here before removing it from the hash. That
> might end up causing a waiter to trip the pr_warn in
> ceph_wait_on_conflict_unlink. You probably want to reverse the order
> here.

Sure. Will fix it.

-- Xiubo

