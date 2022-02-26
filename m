Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109FA4C5442
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 07:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiBZGxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 01:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiBZGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 01:53:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA8AAE0E7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 22:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645858343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WU6wrRQBG1YD8M2NVQyF5GPAIpDNAv2OwNskDJIZW78=;
        b=PRx03egaOrsNvo4utp/pIwejStl5MxxD0aRUQPK0/3Xy54Oj2RsCBN5TM5lbHT2hVKMmRF
        oT2sg2nZXMLxy009hR8NBkjYCsNbY4vcv6aFPrA+oclBMV9191hAHvjhhMv5R/0r/xeL4+
        pXyapRp47lktOw0UH8295V12ZdeGr28=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-EkhRTVCTPaCtyZT3O6BeYQ-1; Sat, 26 Feb 2022 01:52:22 -0500
X-MC-Unique: EkhRTVCTPaCtyZT3O6BeYQ-1
Received: by mail-pj1-f71.google.com with SMTP id ev5-20020a17090aeac500b001bc3cb23d4cso4185493pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 22:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WU6wrRQBG1YD8M2NVQyF5GPAIpDNAv2OwNskDJIZW78=;
        b=sND3S0HLb3IrmkGkdlnb+Jc4HXL+rqgktwu/fyCgHk3JkAtAlinWRB6mDVhkHYGY7f
         eiZfTyR979T1n0zIDHQdYHWVZVi9gDGTiG5R6iWk/Ncg8inm857KecSpcxCDNd9JWRkh
         wO12MdpYDjNbzVYasiaUOwxPTsTcGQW+WoK4Qr/1gVb+nepp8qjPxP8NZJh2DYS7bKe2
         QOhf0YsUGfWEAlIjyro6EbBGE2sWtWl0k+zvNkO4Ygv2b/ZzWejnoRq3p8o/Q7+jrwKe
         LHzLZPeQ/G13hwL3aHsuhNPdaBlGqv3Mqup0TRp8I5TrQDXNzhhkl5CTIu80Hd//4Dn9
         Ii8g==
X-Gm-Message-State: AOAM531OHBufMuU2HW8XcredTUOVLMcRFLlJXQSZke+DsRWhglpuFNDK
        KOdx7OyVWKOS6Lwf+0p32sTZjYNx5b6qdofe2b4TnoxhdJ9qQj3jcTXNe5HqC2uUiDISgamUsXw
        TYb+GkqNrhtRDdU3qzuVNVCzvOWQRymt4DmNCxrV8kVcOOqsj2xAxAHRKwqpyCI4YYXD8MWP8Fg
        ==
X-Received: by 2002:a17:902:a511:b0:14d:a378:b5b0 with SMTP id s17-20020a170902a51100b0014da378b5b0mr11024681plq.9.1645858340668;
        Fri, 25 Feb 2022 22:52:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAn7K7C7mcNJjP/BN0SZCwl5hyIirz333tnhk6wz4KzDEkEnbPFYEG9TYll8BYuZNam4JSMw==
X-Received: by 2002:a17:902:a511:b0:14d:a378:b5b0 with SMTP id s17-20020a170902a51100b0014da378b5b0mr11024662plq.9.1645858340228;
        Fri, 25 Feb 2022 22:52:20 -0800 (PST)
Received: from [10.72.12.114] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q10-20020a65524a000000b00372e458e87esm4311831pgp.67.2022.02.25.22.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 22:52:19 -0800 (PST)
Subject: Re: [RFC PATCH] ceph: add support for encrypted snapshot names
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224112142.18052-1-lhenriques@suse.de>
 <7d2a798d-ce32-4bf7-b184-267bb79f44e3@redhat.com>
 <87h78ni8ed.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <3bc5797e-f23e-6416-4626-161e34c409ff@redhat.com>
Date:   Sat, 26 Feb 2022 14:52:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87h78ni8ed.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/22 5:48 PM, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
>
>> On 2/24/22 7:21 PM, Luís Henriques wrote:
>>> Since filenames in encrypted directories are already encrypted and shown
>>> as a base64-encoded string when the directory is locked, snapshot names
>>> should show a similar behaviour.
>>>
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>>    fs/ceph/dir.c   | 15 +++++++++++++++
>>>    fs/ceph/inode.c | 10 +++++++++-
>>>    2 files changed, 24 insertions(+), 1 deletion(-)
>>>
>>> Support on the MDS for names that'll be > MAX_NAME when base64 encoded is
>>> still TBD.  I thought it would be something easy to do, but snapshots
>>> don't seem to make use of the CDir/CDentry (which is where alternate_name
>>> is stored on the MDS).  I'm still looking into this, but I may need some
>>> help there :-(
>>>
>>> Cheers,
>>> --
>>> Luís
>>>
>>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>>> index a449f4a07c07..20ae600ee7cd 100644
>>> --- a/fs/ceph/dir.c
>>> +++ b/fs/ceph/dir.c
>>> @@ -1065,6 +1065,13 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>>    		op = CEPH_MDS_OP_MKSNAP;
>>>    		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
>>>    		     dentry, dentry);
>>> +		/* XXX missing support for alternate_name in snapshots */
>>> +		if (IS_ENCRYPTED(dir) && (dentry->d_name.len >= 189)) {
>>> +			dout("encrypted snapshot name too long: %pd len: %d\n",
>>> +			     dentry, dentry->d_name.len);
>>> +			err = -ENAMETOOLONG;
>>> +			goto out;
>>> +		}
>>>    	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
>>>    		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>>>    		op = CEPH_MDS_OP_MKDIR;
>>> @@ -1109,6 +1116,14 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>>    	    !req->r_reply_info.head->is_target &&
>>>    	    !req->r_reply_info.head->is_dentry)
>>>    		err = ceph_handle_notrace_create(dir, dentry);
>>> +
>>> +	/*
>>> +	 * If we have created a snapshot we need to clear the cache, otherwise
>>> +	 * snapshot will show encrypted filenames in readdir.
>>> +	 */
>> Do you mean dencrypted filenames ?
> What I see without this d_drop() is that, if I run an 'ls' in a snapshot
> directory immediately after creating it, the filenames in that snapshot
> will be encrypted.  Maybe there's a bug somewhere else and this d_drop()
> isn't the right fix...?

BTW, how did you reproduce this ?

The snapshot name hasn't encrypted yet ? Did you add one patch to do this ?

Locally I have one patch to support this, but not finished yet:


diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 914a6e68bb56..bc9b2b0c9c66 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2464,7 +2464,7 @@ static u8 *get_fscrypt_altname(const struct 
ceph_mds_request *req, u32 *plen)
  char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 
*pbase, int for_wire)
  {
         struct dentry *cur;
-       struct inode *inode;
+       struct inode *inode, *pinode = NULL;
         char *path;
         int pos;
         unsigned seq;
@@ -2485,18 +2485,29 @@ char *ceph_mdsc_build_path(struct dentry 
*dentry, int *plen, u64 *pbase, int for
         for (;;) {
                 struct dentry *parent;

+               parent = dget_parent(cur);
                 spin_lock(&cur->d_lock);
+               pinode = d_inode(parent);
+               ihold(pinode);
+               if (ceph_snap(pinode) == CEPH_SNAPDIR) {
+                       struct ceph_vino vino = {
+                               .ino = ceph_ino(pinode),
+                               .snap = CEPH_NOSNAP,
+                       };
+                       pinode = ceph_find_inode(pinode->i_sb, vino);
+                       BUG_ON(!pinode);
+               }
+
                 inode = d_inode(cur);
                 if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
                         dout("build_path path+%d: %p SNAPDIR\n",
                              pos, cur);
                         spin_unlock(&cur->d_lock);
-                       parent = dget_parent(cur);
                 } else if (for_wire && inode && dentry != cur && 
ceph_snap(inode) == CEPH_NOSNAP) {
                         spin_unlock(&cur->d_lock);
                         pos++; /* get rid of any prepended '/' */
                         break;
-               } else if (!for_wire || 
!IS_ENCRYPTED(d_inode(cur->d_parent))) {
+               } else if (!for_wire || !IS_ENCRYPTED(pinode)) {
                         pos -= cur->d_name.len;
                         if (pos < 0) {
                                 spin_unlock(&cur->d_lock);
@@ -2504,7 +2515,6 @@ char *ceph_mdsc_build_path(struct dentry *dentry, 
int *plen, u64 *pbase, int for
                         }
                         memcpy(path + pos, cur->d_name.name, 
cur->d_name.len);
                         spin_unlock(&cur->d_lock);
-                       parent = dget_parent(cur);
                 } else {
                         int len, ret;
                         char buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
@@ -2516,20 +2526,21 @@ char *ceph_mdsc_build_path(struct dentry 
*dentry, int *plen, u64 *pbase, int for
                         memcpy(buf, cur->d_name.name, cur->d_name.len);
                         len = cur->d_name.len;
                         spin_unlock(&cur->d_lock);
-                       parent = dget_parent(cur);

-                       ret = __fscrypt_prepare_readdir(d_inode(parent));
+                       ret = __fscrypt_prepare_readdir(pinode);
                         if (ret < 0) {
                                 dput(parent);
                                 dput(cur);
+                               iput(pinode);
                                 return ERR_PTR(ret);
                         }

-                       if (fscrypt_has_encryption_key(d_inode(parent))) {
-                               len = 
ceph_encode_encrypted_fname(d_inode(parent), cur, buf);
+                       if (fscrypt_has_encryption_key(pinode)) {
+                               len = 
ceph_encode_encrypted_fname(pinode, cur, buf);
                                 if (len < 0) {
                                         dput(parent);
                                         dput(cur);
+                                       iput(pinode);
                                         return ERR_PTR(len);
                                 }
                         }
@@ -2552,7 +2563,11 @@ char *ceph_mdsc_build_path(struct dentry *dentry, 
int *plen, u64 *pbase, int for
                         break;

                 path[pos] = '/';
+               iput(pinode);
+               pinode = NULL;
         }
+       if (pinode)
+               iput(pinode);
         inode = d_inode(cur);
         base = inode ? ceph_ino(inode) : 0;
         dput(cur);


Are you doing the same thing too ? If so I will leave this to you, or I 
can send one patch to support it.

Thanks

- Xiubo




> Cheers,

