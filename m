Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E2353B72C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiFBK1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiFBK1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:27:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24510674E4;
        Thu,  2 Jun 2022 03:27:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 828BF21AA3;
        Thu,  2 Jun 2022 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654165665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Da598dtK90BYSxT4JI9NwigzIxzcw6bjaEU84OlHLkI=;
        b=kMRX92IEOGCgOshra5CDdndHRRaaXmCMMN4F62PrqDxfH2ikbgA+/TfbkFdeLuwd9wafPk
        FjbcOKUj5tKUOX7kfIGSiZwkPvat1GdMO6FJ4iZHMR09JWo6ZW4nTbry7srjSLY3zvoLUA
        4kPZ/fhmy2yIdYH0ictNbilEmemnFY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654165665;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Da598dtK90BYSxT4JI9NwigzIxzcw6bjaEU84OlHLkI=;
        b=5wbYX8s7WEX+jBi9wmk3VPKd1uR3GxCnhA74XhVcktt05Hf3NHty/AREZ5WednckSpDSIR
        09yz8SjoFR4M4JCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E95A913AC8;
        Thu,  2 Jun 2022 10:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o+AdNaCQmGLTYAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 02 Jun 2022 10:27:44 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 120c6ef4;
        Thu, 2 Jun 2022 10:28:24 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Gregory Farnum <gfarnum@redhat.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3] ceph: prevent a client from exceeding the MDS
 maximum xattr size
References: <20220601162939.12278-1-lhenriques@suse.de>
        <b788a7f9-9177-0398-7d21-a19ce7e6c957@redhat.com>
        <87h7534dr9.fsf@brahms.olymp>
        <289f5136-d2fc-1474-eb0f-521586f241b2@redhat.com>
Date:   Thu, 02 Jun 2022 11:28:24 +0100
In-Reply-To: <289f5136-d2fc-1474-eb0f-521586f241b2@redhat.com> (Xiubo Li's
        message of "Thu, 2 Jun 2022 17:42:50 +0800")
Message-ID: <87a6av4awn.fsf@brahms.olymp>
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

> On 6/2/22 5:26 PM, Lu=C3=ADs Henriques wrote:
>> Xiubo Li <xiubli@redhat.com> writes:
>>
>>> On 6/2/22 12:29 AM, Lu=C3=ADs Henriques wrote:
>>>> The MDS tries to enforce a limit on the total key/values in extended
>>>> attributes.  However, this limit is enforced only if doing a synchrono=
us
>>>> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
>>>> doesn't have a chance to enforce these limits.
>>>>
>>>> This patch adds support for decoding the xattrs maximum size setting t=
hat is
>>>> distributed in the mdsmap.  Then, when setting an xattr, the kernel cl=
ient
>>>> will revert to do a synchronous operation if that maximum size is exce=
eded.
>>>>
>>>> While there, fix a dout() that would trigger a printk warning:
>>>>
>>>> [   98.718078] ------------[ cut here ]------------
>>>> [   98.719012] precision 65536 too large
>>>> [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnpri=
ntf+0x5e3/0x600
>>>> ...
>>>>
>>>> URL: https://tracker.ceph.com/issues/55725
>>>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>>> ---
>>>>    fs/ceph/mdsmap.c            | 27 +++++++++++++++++++++++----
>>>>    fs/ceph/xattr.c             | 12 ++++++++----
>>>>    include/linux/ceph/mdsmap.h |  1 +
>>>>    3 files changed, 32 insertions(+), 8 deletions(-)
>>>>
>>>> * Changes since v2
>>>>
>>>> Well, a lot has changed since v2!  Now the xattr max value setting is
>>>> obtained through the mdsmap, which needs to be decoded, and the feature
>>>> that was used in the previous revision was dropped.  The drawback is t=
hat
>>>> the MDS isn't unable to know in advance if a client is aware of this x=
attr
>>>> max value.
>>>>
>>>> * Changes since v1
>>>>
>>>> Added support for new feature bit to get the MDS max_xattr_pairs_size
>>>> setting.
>>>>
>>>> Also note that this patch relies on a patch that hasn't been merged yet
>>>> ("ceph: use correct index when encoding client supported features"),
>>>> otherwise the new feature bit won't be correctly encoded.
>>>>
>>>> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
>>>> index 30387733765d..36b2bc18ca2a 100644
>>>> --- a/fs/ceph/mdsmap.c
>>>> +++ b/fs/ceph/mdsmap.c
>>>> @@ -13,6 +13,12 @@
>>>>      #include "super.h"
>>>>    +/*
>>>> + * Maximum size of xattrs the MDS can handle per inode by default.  T=
his
>>>> + * includes the attribute name and 4+4 bytes for the key/value sizes.
>>>> + */
>>>> +#define MDS_MAX_XATTR_SIZE (1<<16) /* 64K */
>>>> +
>>>>    #define CEPH_MDS_IS_READY(i, ignore_laggy) \
>>>>    	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].lag=
gy)
>>>>    @@ -352,12 +358,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void *=
*p, void
>>>> *end, bool msgr2)
>>>>    		__decode_and_drop_type(p, end, u8, bad_ext);
>>>>    	}
>>>>    	if (mdsmap_ev >=3D 8) {
>>>> -		u32 name_len;
>>>>    		/* enabled */
>>>>    		ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
>>>> -		ceph_decode_32_safe(p, end, name_len, bad_ext);
>>>> -		ceph_decode_need(p, end, name_len, bad_ext);
>>>> -		*p +=3D name_len;
>>>> +		/* fs_name */
>>>> +		ceph_decode_skip_string(p, end, bad_ext);
>>>>    	}
>>>>    	/* damaged */
>>>>    	if (mdsmap_ev >=3D 9) {
>>>> @@ -370,6 +374,21 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, =
void *end, bool msgr2)
>>>>    	} else {
>>>>    		m->m_damaged =3D false;
>>>>    	}
>>>> +	if (mdsmap_ev >=3D 17) {
>>>> +		/* balancer */
>>>> +		ceph_decode_skip_string(p, end, bad_ext);
>>>> +		/* standby_count_wanted */
>>>> +		ceph_decode_skip_32(p, end, bad_ext);
>>>> +		/* old_max_mds */
>>>> +		ceph_decode_skip_32(p, end, bad_ext);
>>>> +		/* min_compat_client */
>>>> +		ceph_decode_skip_8(p, end, bad_ext);
>>> This is incorrect.
>>>
>>> If mdsmap_ev =3D=3D 15 the min_compat_client will be a feature_bitset_t=
 instead of
>>> int8_t.
>> Hmm... can you point me at where that's done in the code?  As usual, I'm
>> confused with that code and simply can't see that.
>>
>> Also, if that happens only when mdsmap_ev =3D=3D 15, then there's no pro=
blem
>> because that branch is only taken if it's >=3D 17.
>
> Yeah, so you should skip 32 or 32+64 bits instead here, just likes:
>
> 3536=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* version >=3D 3, feature bits */
> 3537=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_decode_32_safe(&p, end, len, bad);
> 3538=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len) {
> 3539=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ceph_decode_64_safe(&p, end, features, bad);
> 3540=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 p +=3D len - sizeof(features);
> 3541=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> For the ceph code please see:
>
> Please see https://github.com/ceph/ceph/blob/main/src/mds/MDSMap.cc#L925.

I still don't see what your saying.  From what I understand, with <=3D 15 we
used to have 'min_compat_client', which is of type 'ceph_release_t',
defined in src/common/ceph_releases.h:

enum class ceph_release_t : std::uint8_t {
...
}

Then, starting with >=3D 16 the MDS ignores this 'min_compat_client' field
(but still encodes/decodes it), and it *adds* 'required_client_features',
which is a 'feature_bitset_t' and that is decoded immediately after (see
bellow, the ceph_decode_skip_set() call).

Cheers,
--=20
Lu=C3=ADs

>>>
>>>> +		/* required_client_features */
>>>> +		ceph_decode_skip_set(p, end, 64, bad_ext);
>>>> +		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
>>>> +	} else {
>>>> +		m->m_max_xattr_size =3D MDS_MAX_XATTR_SIZE;
>>>> +	}
>>>>    bad_ext:
>>>>    	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\=
n",
>>>>    	     !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
>>>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
>>>> index 8c2dc2c762a4..67f046dac35c 100644
>>>> --- a/fs/ceph/xattr.c
>>>> +++ b/fs/ceph/xattr.c
>>>> @@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *inod=
e, const char *name,
>>>>    			flags |=3D CEPH_XATTR_REMOVE;
>>>>    	}
>>>>    -	dout("setxattr value=3D%.*s\n", (int)size, value);
>>>> +	dout("setxattr value size: %ld\n", size);
>>>>      	/* do request */
>>>>    	req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
>>>> @@ -1184,8 +1184,14 @@ int __ceph_setxattr(struct inode *inode, const =
char *name,
>>>>    	spin_lock(&ci->i_ceph_lock);
>>>>    retry:
>>>>    	issued =3D __ceph_caps_issued(ci, NULL);
>>>> -	if (ci->i_xattrs.version =3D=3D 0 || !(issued & CEPH_CAP_XATTR_EXCL))
>>>> +	required_blob_size =3D __get_required_blob_size(ci, name_len, val_le=
n);
>>>> +	if ((ci->i_xattrs.version =3D=3D 0) || !(issued & CEPH_CAP_XATTR_EXC=
L) ||
>>>> +	    (required_blob_size >=3D mdsc->mdsmap->m_max_xattr_size)) {
>>> Shouldn't it be '>' instead ?
>> Ok, I'll fix that.
>>
>>> We'd better always force to do a sync request with old ceph. Just check=
 if the
>>> mdsmap_ev < 17. It's not safe to buffer it because it maybe discarded a=
s your
>>> ceph PR does.
>> Right, that can be done.  So, I can simply set the m_max_xattr_size to '=
0'
>> if mdsmap_ev < 17.  Then, this 'if' condition will always be evaluated to
>> true because required_blob_size will be > 0.  Does that sound OK?
>
> Yeah, sounds good.
>
> -- Xiubo
>
>
>>
>> Cheers,
>

