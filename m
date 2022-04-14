Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C157C50184E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344422AbiDNQIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355764AbiDNP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:58:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B66E38BB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649951202; x=1681487202;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to;
  bh=uAhqgnl1kawPXwaAA7Oh8LVeG+sDmv9ZViRW52v9suY=;
  b=Otw2SjqIdW72+0PFmZYOKTOvXrSZgJvF+8Cs0Cn76MEomzz+R4i+CEnE
   bBeZQIAfTID4jV73PLysqbelu5JCFgEMvYUz7l/Af6RKuClvSQbRnxTkJ
   gpRJstJzKsSP4jMxp8X/NKKavd9+MMZVpk1tEDHV8/u6Z3U9aq3y2r9JH
   eYnKBPjtBUQ7DGjdTNvhKUaAxaaI60edlK12w4Im5F2j5DRNfZ0lOYlzQ
   Ct88hYsAIu9tbvnL+D37P0ydo6utCNBv5PuZh45WflJVscKSddxytrMNO
   GhMYnhtWXPEw7k9GlpYFmNKXtDgyAhpAg0m5IGDpFx2DIeDQBxtez77NM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="263137012"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="263137012"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 08:46:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="612377905"
Received: from msahoo-mobl1.amr.corp.intel.com (HELO [10.212.62.78]) ([10.212.62.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 08:46:29 -0700
Content-Type: multipart/mixed; boundary="------------LYGojPVYD6BcZ9cjMhM0heIe"
Message-ID: <d2f927c9-187a-906c-e1f3-33541b3b5a84@intel.com>
Date:   Thu, 14 Apr 2022 08:46:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.656881574@linutronix.de>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [patch 2/3] x86/fpu/xsave: Prepare for optimized compaction
In-Reply-To: <20220404104820.656881574@linutronix.de>
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------LYGojPVYD6BcZ9cjMhM0heIe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/22 05:11, Thomas Gleixner wrote:
...
> For copy_uabi_to_xstate() it's more effort when supervisor states are
> supported and active. If the user space buffer has active states which are
> not in the set of current states of the XSTATE buffer, then the buffer
> layout will change which means the supervisor states might be overwritten.
> 
> Provide a function, which moves them out of the way and invoke it before
> any of the extended features is copied from the user space buffer.

This took me a minute to sort through.  There are three kinds of state
in the kernel buffer in copy_uabi_to_xstate().

1. User state, set in hdr.features which is copied from uabi buffer
2. User state, clear in hdr.features.  Feature will be set to its init
   state because xsave->header.xfeatures is cleared.
3. Supervisor state which is preserved.

I was confused for a *moment* because the space for a #2 might be
overwritten by a #1 copy-in from userspace.  But, that only happens for
states that will end up being set to init.  No harm, no foul.

Any interest in doing something like the attached to make
copy_uabi_to_xstate() easier to read?

> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1147,10 +1147,10 @@ void __copy_xstate_to_uabi_buf(struct me
>  			pkru.pkru = pkru_val;
>  			membuf_write(&to, &pkru, sizeof(pkru));
>  		} else {
> -			copy_feature(header.xfeatures & BIT_ULL(i), &to,
> -				     __raw_xsave_addr(xsave, i),
> -				     __raw_xsave_addr(xinit, i),
> -				     xstate_sizes[i]);
> +			bool active = header.xfeatures & BIT_ULL(i);
> +			void *from = __raw_xsave_addr(active ? xsave : xinit, i);
> +
> +			membuf_write(&to, from, xstate_sizes[i]);
>  		}
>  		/*
>  		 * Keep track of the last copied state in the non-compacted
> @@ -1195,6 +1195,73 @@ static int copy_from_buffer(void *dst, u
>  	return 0;
>  }
>  
> +/*
> + * Prepare the kernel XSTATE buffer for saving the user supplied XSTATE. If
> + * the XGETBV1 based optimization is in use then the kernel buffer might
> + * not have the user supplied active features set and an eventual active
> + * supervisor state has to be moved out of the way. With optimized
> + * compaction the features which are to be stored need to be set in the
> + * XCOMP_BV field of the XSTATE header.
> + */

What does "eventual active supervisor state" mean?  Just that the state
needs to be preserved since it needs to be restored eventually?  I found
that phrase a bit confusing.

I was thinking of a comment more along these lines:

/*
 * Adjust 'fpstate' so that it can additionally store all the xfeatures
 * set in 'xuser' when optimized compaction is enabled.  All bits in
 * 'xuser' will be set in XCOMP_BV.  Supervisor state will be preserved
 * and may be moved to make room for new 'xuser' states.  User state may
 * be destroyed.
 */

> +static void xsave_adjust_xcomp(struct fpstate *fpstate, u64 xuser)
> +{
> +	struct xregs_state *xsave = &fpstate->regs.xsave;
> +	u64 xtmp, xall, xbv, xcur = xsave->header.xfeatures;
> +	int i;
> +
> +	/* Nothing to do if optimized compaction is not in use */
> +	if (!xsave_use_xgetbv1())
> +		return;

The comment makes me wonder if we need a more descriptive name for
xsave_use_xgetbv1(), like:

	if (!xsave_do_optimized_compaction())
		return;

> +	/*
> +	 * Check whether the current xstate buffer contains supervisor
> +	 * state. If not, just set the user supplied features.
> +	 */
> +	if (!(xcur & XFEATURE_MASK_SUPERVISOR_ALL)) {
> +		__xstate_init_xcomp_bv(xsave, xuser);
> +		return;
> +	}
> +
> +	/*
> +	 * Set legacy features. They are at a fixed offset and do not
> +	 * affect the layout.
> +	 */
> +	xbv = xsave->header.xcomp_bv;
> +	xbv |= xuser & (XFEATURE_MASK_FP | XFEATURE_MASK_SSE);
> +
> +	/*
> +	 * Check whether there is new extended state in the user supplied
> +	 * buffer. If not, then nothing has to be moved around.
> +	 */
> +	if (!(xuser & ~xbv)) {
> +		__xstate_init_xcomp_bv(xsave, xbv);
> +		return;
> +	}
> +
> +	/*
> +	 * No more optimizations. Set the user features and move the
> +	 * supervisor state(s). If the new user feature is past
> +	 * the supervisor state, then the loop is moving nothing.
> +	 */
> +	xtmp = xbv & XFEATURE_MASK_SUPERVISOR_ALL;
> +	xall = xbv | xuser;


I'd probably at least comment why the loop is backwards:

	/*
	 * Features are only be moved up in the buffer.  Start with
	 * high features to avoid overwriting them with a lower ones.
	 */

I know this is a very typical way to implement non-destructive moves,
but my stupid brain seems to default to assuming that for loops only go
forward.

> +	for (i = fls64(xtmp) - 1; i >= FIRST_EXTENDED_XFEATURE;
> +	     i = fls64(xtmp) - 1) {
> +		unsigned int to, from;

Is it worth a check here like:

		/* Do not move features in their init state: */
		if (!(xcur & BIT_ULL(i))) {
			xtmp &= ~BIT_ULL(i);
			continue;
		}

(probably also moving the &= around instead of copying it)

> +		from = xfeature_get_offset(xbv, i);
> +		to = xfeature_get_offset(xall, i);
> +		if (from < to) {
> +			memmove((void *)xsave + to, (void *)xsave + from,
> +				xstate_sizes[i]);
> +		} else {
> +			WARN_ON_ONCE(to < from);
> +		}
> +		xtmp &= ~BIT_ULL(i);
> +	}
> +	__xstate_init_xcomp_bv(xsave, xall);
> +}
>  
>  static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
>  			       const void __user *ubuf)
> @@ -1232,6 +1299,8 @@ static int copy_uabi_to_xstate(struct fp
>  		}
>  	}
>  
> +	xsave_adjust_xcomp(fpstate, hdr.xfeatures);
> +
>  	for (i = 0; i < XFEATURE_MAX; i++) {
>  		u64 mask = ((u64)1 << i);
>  
> --- a/arch/x86/kernel/fpu/xstate.h
> +++ b/arch/x86/kernel/fpu/xstate.h
> @@ -10,14 +10,22 @@
>  DECLARE_PER_CPU(u64, xfd_state);
>  #endif
>  
> -static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
> +static inline bool xsave_use_xgetbv1(void) { return false; }
> +
> +static inline void __xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
>  {
>  	/*
>  	 * XRSTORS requires these bits set in xcomp_bv, or it will
> -	 * trigger #GP:
> +	 * trigger #GP. It's also required for XRSTOR when the buffer
> +	 * was saved with XSAVEC in compacted format.
>  	 */
> +	xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
> +}
> +
> +static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
> +{
>  	if (cpu_feature_enabled(X86_FEATURE_XCOMPACTED))
> -		xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
> +		__xstate_init_xcomp_bv(xsave, mask);
>  }
>  
>  static inline u64 xstate_get_group_perm(bool guest)

--------------LYGojPVYD6BcZ9cjMhM0heIe
Content-Type: text/x-patch; charset=UTF-8; name="copy_uabi_to_xstate.1.patch"
Content-Disposition: attachment; filename="copy_uabi_to_xstate.1.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRlLmMgYi9hcmNoL3g4Ni9r
ZXJuZWwvZnB1L3hzdGF0ZS5jCmluZGV4IDM5ZTFjODYyNmFiOS4uOGEzMmE4Mzk4ZTFmIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jCisrKyBiL2FyY2gveDg2
L2tlcm5lbC9mcHUveHN0YXRlLmMKQEAgLTExNzgsNiArMTE3OCwxNSBAQCBzdGF0aWMgaW50
IGNvcHlfZnJvbV9idWZmZXIodm9pZCAqZHN0LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LCB1bnNp
Z25lZCBpbnQgc2l6ZSwKIH0KIAogCisvKgorICogUmVwbGFjZSBhbGwgdXNlciB4ZmVhdHVy
ZXMgd2l0aCBkYXRhIGZyb20gJ3VidWYnLiAgRmVhdHVyZXMKKyAqIG1hcmtlZCBhcyBpbml0
IGluICd1YnVmJyB3aWxsIGJlIG1hcmtlZCBhcyBpbml0IGluIHRoZSBrZXJuZWwKKyAqIGJ1
ZmZlci4gIFN1cGVydmlzb3IgeGZlYXR1cmVzIHdpbGwgYmUgcHJlc2VydmVkLgorICoKKyAq
IFJldHVybnMgMCBvbiBzdWNjZXNzLiAgTm9uLXplcm8gcmV0dXJuIGNvZGVzIGluZGljYXRl
IHRoYXQKKyAqIHRoZSBrZXJuZWwgeHNhdmUgYnVmZmVyIG1heSBoYXZlIGJlZW4gbGVmdCBp
biBhbiBpbmNvbnNpc3RlbnQKKyAqIHN0YXRlLiAgQ2FsbGVyIG11c3QgcmVzZXQgZnBzdGF0
ZSB0byByZWNvdmVyLgorICovCiBzdGF0aWMgaW50IGNvcHlfdWFiaV90b194c3RhdGUoc3Ry
dWN0IGZwc3RhdGUgKmZwc3RhdGUsIGNvbnN0IHZvaWQgKmtidWYsCiAJCQkgICAgICAgY29u
c3Qgdm9pZCBfX3VzZXIgKnVidWYpCiB7CkBAIC0xMjE0LDMwICsxMjIzLDMwIEBAIHN0YXRp
YyBpbnQgY29weV91YWJpX3RvX3hzdGF0ZShzdHJ1Y3QgZnBzdGF0ZSAqZnBzdGF0ZSwgY29u
c3Qgdm9pZCAqa2J1ZiwKIAkJfQogCX0KIAorCS8qCisJICogTGVhdmUgb25seSBzdXBlcnZp
c29yIHN0YXRlcyBpbiAneGZlYXR1cmVzJy4gIFVzZXIgeGZlYXR1cmUKKwkgKiBiaXRzIGFy
ZSBzZXQgaW4gdGhlIGxvb3AgYmVsb3cuCisJICovCisJeHNhdmUtPmhlYWRlci54ZmVhdHVy
ZXMgJj0gWEZFQVRVUkVfTUFTS19TVVBFUlZJU09SX0FMTDsKKwogCWZvciAoaSA9IDA7IGkg
PCBYRkVBVFVSRV9NQVg7IGkrKykgewogCQl1NjQgbWFzayA9ICgodTY0KTEgPDwgaSk7CisJ
CXZvaWQgKmRzdCA9IF9fcmF3X3hzYXZlX2FkZHIoeHNhdmUsIGkpOwogCi0JCWlmIChoZHIu
eGZlYXR1cmVzICYgbWFzaykgewotCQkJdm9pZCAqZHN0ID0gX19yYXdfeHNhdmVfYWRkcih4
c2F2ZSwgaSk7Ci0KLQkJCW9mZnNldCA9IHhzdGF0ZV9vZmZzZXRzW2ldOwotCQkJc2l6ZSA9
IHhzdGF0ZV9zaXplc1tpXTsKLQotCQkJaWYgKGNvcHlfZnJvbV9idWZmZXIoZHN0LCBvZmZz
ZXQsIHNpemUsIGtidWYsIHVidWYpKQotCQkJCXJldHVybiAtRUZBVUxUOworCQlpZiAoIWhk
ci54ZmVhdHVyZXMgJiBtYXNrKSB7CisJCQkvKiBGZWF0dXJlIHdhcyBtYXJrZWQgYXMgaW5p
dCBpbiB1YWJpIGJ1ZmZlcjogKi8KKwkJCXhzYXZlLT5oZWFkZXIueGZlYXR1cmVzICY9IH5t
YXNrOworCQkJY29udGludWUKIAkJfQotCX0KKwkJLyogRmVhdHVyZSB3YXMgcHJlc2VudCBp
biB1YWJpIGJ1ZmZlcjogKi8KKwkJeHNhdmUtPmhlYWRlci54ZmVhdHVyZXMgfD0gbWFzazsK
IAotCS8qCi0JICogVGhlIHN0YXRlIHRoYXQgY2FtZSBpbiBmcm9tIHVzZXJzcGFjZSB3YXMg
dXNlci1zdGF0ZSBvbmx5LgotCSAqIE1hc2sgYWxsIHRoZSB1c2VyIHN0YXRlcyBvdXQgb2Yg
J3hmZWF0dXJlcyc6Ci0JICovCi0JeHNhdmUtPmhlYWRlci54ZmVhdHVyZXMgJj0gWEZFQVRV
UkVfTUFTS19TVVBFUlZJU09SX0FMTDsKKwkJb2Zmc2V0ID0geHN0YXRlX29mZnNldHNbaV07
CisJCXNpemUgPSB4c3RhdGVfc2l6ZXNbaV07CiAKLQkvKgotCSAqIEFkZCBiYWNrIGluIHRo
ZSBmZWF0dXJlcyB0aGF0IGNhbWUgaW4gZnJvbSB1c2Vyc3BhY2U6Ci0JICovCi0JeHNhdmUt
PmhlYWRlci54ZmVhdHVyZXMgfD0gaGRyLnhmZWF0dXJlczsKKwkJaWYgKGNvcHlfZnJvbV9i
dWZmZXIoZHN0LCBvZmZzZXQsIHNpemUsIGtidWYsIHVidWYpKQorCQkJcmV0dXJuIC1FRkFV
TFQ7CisJfQogCiAJcmV0dXJuIDA7CiB9Cg==

--------------LYGojPVYD6BcZ9cjMhM0heIe--
