Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D218B530D92
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiEWJq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiEWJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:46:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57D1262D;
        Mon, 23 May 2022 02:46:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A4B521A56;
        Mon, 23 May 2022 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653299188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GekKf6//40DiaCxW7x/Hs55TeT8ziwCO2ibyKExmano=;
        b=pmUKfHvcesU5Kp9YpeKKlsV4pPc4HfQRr9NVbCDqxV3fMsTtVkQC2X0HKxvY7oi956depe
        LeREyd/bYH8NL5spKy4AZEDNn0TrkDxZCqdwvr3rsPIE6x+Rwb6OIirI/tucSUPxpmQ1gw
        uoTq81sw4nYBUIMOQ8eE8QwIKsPitvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653299188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GekKf6//40DiaCxW7x/Hs55TeT8ziwCO2ibyKExmano=;
        b=uqRLNoSlzvMnFPC8e+6XsEPu07Bkcp4Jd6KD+UBe/MNcjBT3ezWqNOKVPCnMQkNg8L8iCP
        9ZDv0SnzrebgO+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAF99139F5;
        Mon, 23 May 2022 09:46:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BiCfNvNXi2IiawAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 23 May 2022 09:46:27 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 94e8ddd4;
        Mon, 23 May 2022 09:47:06 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ceph: try to prevent exceeding the MDS maximum
 xattr size
References: <20220520115426.438-1-lhenriques@suse.de>
        <13988024-efc7-2ab1-036a-eb1d2b2fbd15@redhat.com>
Date:   Mon, 23 May 2022 10:47:06 +0100
In-Reply-To: <13988024-efc7-2ab1-036a-eb1d2b2fbd15@redhat.com> (Xiubo Li's
        message of "Mon, 23 May 2022 09:47:41 +0800")
Message-ID: <874k1gmvhh.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiubo Li <xiubli@redhat.com> writes:

> On 5/20/22 7:54 PM, Lu=C3=ADs Henriques wrote:
>> The MDS tries to enforce a limit on the total key/values in extended
>> attributes.  However, this limit is enforced only if doing a synchronous
>> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
>> doesn't have a chance to enforce these limits.
>>
>> This patch forces the usage of the synchronous operation if xattrs size =
hits
>> the maximum size that is set on the MDS by default (64k).
>>
>> While there, fix a dout() that would trigger a printk warning:
>>
>> [   98.718078] ------------[ cut here ]------------
>> [   98.719012] precision 65536 too large
>> [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprint=
f+0x5e3/0x600
>> ...
>>
>> URL: https://tracker.ceph.com/issues/55725
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/xattr.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
>> index afec84088471..09751a5f028c 100644
>> --- a/fs/ceph/xattr.c
>> +++ b/fs/ceph/xattr.c
>> @@ -15,6 +15,12 @@
>>   #define XATTR_CEPH_PREFIX "ceph."
>>   #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
>>   +/*
>> + * Maximum size of xattrs the MDS can handle per inode by default.  This
>> + * includes the attribute name and 4+4 bytes for the key/value sizes.
>> + */
>> +#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */
>
> The max size is changeable in MDS side. Possibly we should do something as
> mentioned in your ceph PR [1].
>

Right, as I mentioned in that PR, having clients that are aware of that
limit will allow them to behave correctly.  But the MDS still needs to
handle the case where these limits are exceeded (for ex. kernel clients
that don't know about this limit).  So, we still need to do something
similar to what I've proposed in there.

Cheers
--=20
Lu=C3=ADs

> @Jeff, any better idea ?
>
>
> [1]
> https://github.com/ceph/ceph/pull/46357/commits/741f8ba36f14774834c0d5618=
519425ccf1ccc85#r878966753
>
> Thanks.
>
> -- Xiubo
>
>
>> +
>>   static int __remove_xattr(struct ceph_inode_info *ci,
>>   			  struct ceph_inode_xattr *xattr);
>>   @@ -1078,7 +1084,7 @@ static int ceph_sync_setxattr(struct inode *inod=
e,
>> const char *name,
>>   			flags |=3D CEPH_XATTR_REMOVE;
>>   	}
>>   -	dout("setxattr value=3D%.*s\n", (int)size, value);
>> +	dout("setxattr value size: ld\n", size);
>>     	/* do request */
>>   	req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
>> @@ -1176,8 +1182,13 @@ int __ceph_setxattr(struct inode *inode, const ch=
ar *name,
>>   	spin_lock(&ci->i_ceph_lock);
>>   retry:
>>   	issued =3D __ceph_caps_issued(ci, NULL);
>> -	if (ci->i_xattrs.version =3D=3D 0 || !(issued & CEPH_CAP_XATTR_EXCL))
>> +	required_blob_size =3D __get_required_blob_size(ci, name_len, val_len);
>> +	if ((ci->i_xattrs.version =3D=3D 0) || !(issued & CEPH_CAP_XATTR_EXCL)=
 ||
>> +	    (required_blob_size >=3D MDS_MAX_XATTR_PAIRS_SIZE)) {
>> +		dout("%s do sync setxattr: version: %llu blob size: %d\n",
>> +		     __func__, ci->i_xattrs.version, required_blob_size);
>>   		goto do_sync;
>> +	}
>>     	if (!lock_snap_rwsem && !ci->i_head_snapc) {
>>   		lock_snap_rwsem =3D true;
>> @@ -1193,8 +1204,6 @@ int __ceph_setxattr(struct inode *inode, const cha=
r *name,
>>   	     ceph_cap_string(issued));
>>   	__build_xattrs(inode);
>>   -	required_blob_size =3D __get_required_blob_size(ci, name_len, val_le=
n);
>> -
>>   	if (!ci->i_xattrs.prealloc_blob ||
>>   	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
>>   		struct ceph_buffer *blob;
>>
>

