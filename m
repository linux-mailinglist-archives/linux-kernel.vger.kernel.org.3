Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7971E53C995
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbiFCLwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbiFCLwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:52:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398D114023;
        Fri,  3 Jun 2022 04:52:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62F8B1F91A;
        Fri,  3 Jun 2022 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654257120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ui33Z+w/TviDBdC6KsyMWh/zxsx5gyUAC0B+pWMln6Q=;
        b=qpRtqP65XH8ivCc1L9Nl099CU5P38dAZjunHdMmuCnBmRtVu3aSRy8dJf2+2IU31sVapGo
        4iNrn477TafTZ4sGturQumsMciZf+GWbc+v/GO2OItQmgAn99ACxb5Y+7jU45lGkbIjN3N
        oiEG4Z5EwG4ROIdutDNWgfL7Rcs8UhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654257120;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ui33Z+w/TviDBdC6KsyMWh/zxsx5gyUAC0B+pWMln6Q=;
        b=RwJhyeaecUH5Q000ZNdiA2XMrvdxcBaN8bGjVcysY/AmCTxNmxvmlGNdOewoisKfJblQe7
        pNoQTiWfXE9XCRAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDEF813AA2;
        Fri,  3 Jun 2022 11:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e0saN9/1mWLQTAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 03 Jun 2022 11:51:59 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 6470e32b;
        Fri, 3 Jun 2022 11:52:40 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Gregory Farnum <gfarnum@redhat.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4] ceph: prevent a client from exceeding the MDS
 maximum xattr size
References: <20220602143652.28244-1-lhenriques@suse.de>
        <b89ca6a2-4332-b4db-2a40-ae3b00ebdf35@redhat.com>
Date:   Fri, 03 Jun 2022 12:52:40 +0100
In-Reply-To: <b89ca6a2-4332-b4db-2a40-ae3b00ebdf35@redhat.com> (Xiubo Li's
        message of "Fri, 3 Jun 2022 19:29:55 +0800")
Message-ID: <87zgiu2cc7.fsf@brahms.olymp>
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

> On 6/2/22 10:36 PM, Lu=C3=ADs Henriques wrote:
>> The MDS tries to enforce a limit on the total key/values in extended
>> attributes.  However, this limit is enforced only if doing a synchronous
>> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
>> doesn't have a chance to enforce these limits.
>>
>> This patch adds support for decoding the xattrs maximum size setting tha=
t is
>> distributed in the mdsmap.  Then, when setting an xattr, the kernel clie=
nt
>> will revert to do a synchronous operation if that maximum size is exceed=
ed.
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
>>   fs/ceph/mdsmap.c            | 28 ++++++++++++++++++++++++----
>>   fs/ceph/xattr.c             | 12 ++++++++----
>>   include/linux/ceph/mdsmap.h |  1 +
>>   3 files changed, 33 insertions(+), 8 deletions(-)
>>
>> * Changes since v3
>>
>> As per Xiubo review:
>>    - Always force a (sync) SETXATTR Op when connecting to an old cluster
>>    - use '>' instead of '>=3D'
>> Also fixed the warning detected by 0day.
>>
>> * Changes since v2
>>
>> Well, a lot has changed since v2!  Now the xattr max value setting is
>> obtained through the mdsmap, which needs to be decoded, and the feature
>> that was used in the previous revision was dropped.  The drawback is that
>> the MDS isn't unable to know in advance if a client is aware of this xat=
tr
>> max value.
>>
>> * Changes since v1
>>
>> Added support for new feature bit to get the MDS max_xattr_pairs_size
>> setting.
>>
>> Also note that this patch relies on a patch that hasn't been merged yet
>> ("ceph: use correct index when encoding client supported features"),
>> otherwise the new feature bit won't be correctly encoded.
>>
>> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
>> index 30387733765d..c6ce83a48175 100644
>> --- a/fs/ceph/mdsmap.c
>> +++ b/fs/ceph/mdsmap.c
>> @@ -13,6 +13,12 @@
>>     #include "super.h"
>>   +/*
>> + * Maximum size of xattrs the MDS can handle per inode by default.  This
>> + * includes the attribute name and 4+4 bytes for the key/value sizes.
>> + */
>> +#define MDS_MAX_XATTR_SIZE (1<<16) /* 64K */
>
> This macro makes no sense anymore, right ?

Ah, yeah.  That's still leftovers from the previous version.

> I will merge this patch by removing this then.

Thanks!  Also... maybe you could also fix the (embarrassing) issue
detected by 0day that I _tried_ to fix but failed (see below).

> -- Xiubo
>
>
>> +
>>   #define CEPH_MDS_IS_READY(i, ignore_laggy) \
>>   	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].laggy)
>>   @@ -352,12 +358,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p,=
 void
>> *end, bool msgr2)
>>   		__decode_and_drop_type(p, end, u8, bad_ext);
>>   	}
>>   	if (mdsmap_ev >=3D 8) {
>> -		u32 name_len;
>>   		/* enabled */
>>   		ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
>> -		ceph_decode_32_safe(p, end, name_len, bad_ext);
>> -		ceph_decode_need(p, end, name_len, bad_ext);
>> -		*p +=3D name_len;
>> +		/* fs_name */
>> +		ceph_decode_skip_string(p, end, bad_ext);
>>   	}
>>   	/* damaged */
>>   	if (mdsmap_ev >=3D 9) {
>> @@ -370,6 +374,22 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, vo=
id *end, bool msgr2)
>>   	} else {
>>   		m->m_damaged =3D false;
>>   	}
>> +	if (mdsmap_ev >=3D 17) {
>> +		/* balancer */
>> +		ceph_decode_skip_string(p, end, bad_ext);
>> +		/* standby_count_wanted */
>> +		ceph_decode_skip_32(p, end, bad_ext);
>> +		/* old_max_mds */
>> +		ceph_decode_skip_32(p, end, bad_ext);
>> +		/* min_compat_client */
>> +		ceph_decode_skip_8(p, end, bad_ext);
>> +		/* required_client_features */
>> +		ceph_decode_skip_set(p, end, 64, bad_ext);
>> +		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
>> +	} else {
>> +		/* This forces the usage of the (sync) SETXATTR Op */
>> +		m->m_max_xattr_size =3D 0;
>> +	}
>>   bad_ext:
>>   	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
>>   	     !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
>> index 8c2dc2c762a4..1be415e9220b 100644
>> --- a/fs/ceph/xattr.c
>> +++ b/fs/ceph/xattr.c
>> @@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *inode,=
 const char *name,
>>   			flags |=3D CEPH_XATTR_REMOVE;
>>   	}
>>   -	dout("setxattr value=3D%.*s\n", (int)size, value);
>> +	dout("setxattr value size: %lu\n", size);

This should be "%zu" and not "%lu".  I'm OK sending v5 to fix these 2
issues if you prefer.

[ And then there's also the MDS-side which hasn't been merged yet.  But
  this patch is probably worth in itself as it will change the client
  behavior to do the sync operation. ]

Cheers,
--=20
Lu=C3=ADs

>>     	/* do request */
>>   	req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
>> @@ -1184,8 +1184,14 @@ int __ceph_setxattr(struct inode *inode, const ch=
ar *name,
>>   	spin_lock(&ci->i_ceph_lock);
>>   retry:
>>   	issued =3D __ceph_caps_issued(ci, NULL);
>> -	if (ci->i_xattrs.version =3D=3D 0 || !(issued & CEPH_CAP_XATTR_EXCL))
>> +	required_blob_size =3D __get_required_blob_size(ci, name_len, val_len);
>> +	if ((ci->i_xattrs.version =3D=3D 0) || !(issued & CEPH_CAP_XATTR_EXCL)=
 ||
>> +	    (required_blob_size > mdsc->mdsmap->m_max_xattr_size)) {
>> +		dout("%s do sync setxattr: version: %llu size: %d max: %llu\n",
>> +		     __func__, ci->i_xattrs.version, required_blob_size,
>> +		     mdsc->mdsmap->m_max_xattr_size);
>>   		goto do_sync;
>> +	}
>>     	if (!lock_snap_rwsem && !ci->i_head_snapc) {
>>   		lock_snap_rwsem =3D true;
>> @@ -1201,8 +1207,6 @@ int __ceph_setxattr(struct inode *inode, const cha=
r *name,
>>   	     ceph_cap_string(issued));
>>   	__build_xattrs(inode);
>>   -	required_blob_size =3D __get_required_blob_size(ci, name_len, val_le=
n);
>> -
>>   	if (!ci->i_xattrs.prealloc_blob ||
>>   	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
>>   		struct ceph_buffer *blob;
>> diff --git a/include/linux/ceph/mdsmap.h b/include/linux/ceph/mdsmap.h
>> index 523fd0452856..4c3e0648dc27 100644
>> --- a/include/linux/ceph/mdsmap.h
>> +++ b/include/linux/ceph/mdsmap.h
>> @@ -25,6 +25,7 @@ struct ceph_mdsmap {
>>   	u32 m_session_timeout;          /* seconds */
>>   	u32 m_session_autoclose;        /* seconds */
>>   	u64 m_max_file_size;
>> +	u64 m_max_xattr_size;		/* maximum size for xattrs blob */
>>   	u32 m_max_mds;			/* expected up:active mds number */
>>   	u32 m_num_active_mds;		/* actual up:active mds number */
>>   	u32 possible_max_rank;		/* possible max rank index */
>>
>

