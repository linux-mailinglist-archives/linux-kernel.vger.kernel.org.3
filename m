Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5018B56BCB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiGHOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiGHOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:50:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3820610FF7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657291804; x=1688827804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=7oUj1VswY6dlFRQ4E+ASrn3hkrxe8AfoLr2tRQoMka8=;
  b=LPHHePgzBPDRD44JkprBeQ8vlKjsHwK/qXFdA3iHDz3Im6a+s13ZQGgn
   dl7189TqF2UnSnrZAYP31BWi3kwsFai6QZ73f7En2Y4rksaJ3P7Y0l5dW
   dU6nWHzQQBfHJZ7Ygh1A4yF2eMOppNR0u49locGwseme83bkrtQ78cMFo
   LifIKwGAt1+kj0zRBMdbNpXuyRq9sFrGkeSFf8By96YUnYIlLZucb0/KC
   HucMFKx9UXyaPtnwHanavYXyMmr+GfFnWMLgazntU7kX6GM/Eumun/XmS
   9pu80JJFXObtyUyRpRb0VoK7ok5H/uDnlaw9RSfjrUMa+51w5SIUo51Bq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="264075527"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="264075527"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:50:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="626723098"
Received: from yyan2-mobl2.amr.corp.intel.com (HELO [10.212.242.16]) ([10.212.242.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:50:03 -0700
Content-Type: multipart/mixed; boundary="------------9cLz13md01RHbRqOUGKisaoY"
Message-ID: <c5edb95c-3ca3-9339-47d6-6304f9bfd708@intel.com>
Date:   Fri, 8 Jul 2022 07:49:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Linux MM <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20220708003053.158480-1-namit@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220708003053.158480-1-namit@vmware.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9cLz13md01RHbRqOUGKisaoY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/22 17:30, Nadav Amit wrote:

You might want to fix the clock on the system from which you sent this.
 I was really scratching my head trying to figure out how you got this
patch out before Hugh's bug report.

> From: Nadav Amit <namit@vmware.com>
> 
> Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
> possible") introduced an optimization of skipping the flush if the TLB
> generation that is flushed (as provided in flush_tlb_info) was already
> flushed.
> 
> However, arch_tlbbatch_flush() does not provide any generation in
> flush_tlb_info. As a result, try_to_unmap_one() would not perform any
> TLB flushes.
> 
> Fix it by checking whether f->new_tlb_gen is nonzero. Zero value is
> anyhow is an invalid generation value.

It is, but the check below uses 'f->end == TLB_FLUSH_ALL' as the marker
for f->new_tlb_gen being invalid.  Being consistent seems like a good
idea on this stuff.

> In addition, add the missing unlikely() and jump to get tracing right.

There are currently five routes out of flush_tlb_func():
 * Three early returns
 * One 'goto done'
 * One implicit return

The tracing code doesn't get run for any of the early returns, but
that's intentional because they don't *actually* flush the TLB.  We
don't want to record that flush_tlb_func() flushed the TLB when it
didn't.  There's another tracepoint on the TLB_REMOTE_SEND_IPI side to
tell where the flushes were requested.

That said, I think the

	if (unlikely(local_tlb_gen == mm_tlb_gen))
		goto done;

is arguably buggy, as is the 'goto done' in this hunk:

>  arch/x86/mm/tlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index d9314cc8b81f..d81b4084bb8a 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -771,14 +771,14 @@ static void flush_tlb_func(void *info)
>  		return;
>  	}
>  
> -	if (f->new_tlb_gen <= local_tlb_gen) {
> +	if (unlikely(f->new_tlb_gen != 0 && f->new_tlb_gen <= local_tlb_gen)) {
>  		/*
>  		 * The TLB is already up to date in respect to f->new_tlb_gen.
>  		 * While the core might be still behind mm_tlb_gen, checking
>  		 * mm_tlb_gen unnecessarily would have negative caching effects
>  		 * so avoid it.
>  		 */
> -		return;
> +		goto done;
>  	}
>  
>  	/*

We might want to (eventually) think about doing something like the
attached patch to make the skipped flushes explicit in the tracing and
make the return paths out of this function more consistent.
--------------9cLz13md01RHbRqOUGKisaoY
Content-Type: text/x-patch; charset=UTF-8; name="tlbtrace.patch"
Content-Disposition: attachment; filename="tlbtrace.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3RsYi5jIGIvYXJjaC94ODYvbW0vdGxiLmMKaW5k
ZXggZDQwMGI2ZDlkMjQ2Li40NGJhNzM2MDFmNTAgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L21t
L3RsYi5jCisrKyBiL2FyY2gveDg2L21tL3RsYi5jCkBAIC03MjAsNyArNzIwLDcgQEAgdm9p
ZCBpbml0aWFsaXplX3RsYnN0YXRlX2FuZF9mbHVzaCh2b2lkKQogICogYmVjYXVzZSBhbGwg
eDg2IGZsdXNoIG9wZXJhdGlvbnMgYXJlIHNlcmlhbGl6aW5nIGFuZCB0aGUKICAqIGF0b21p
YzY0X3JlYWQgb3BlcmF0aW9uIHdvbid0IGJlIHJlb3JkZXJlZCBieSB0aGUgY29tcGlsZXIu
CiAgKi8KLXN0YXRpYyB2b2lkIGZsdXNoX3RsYl9mdW5jKHZvaWQgKmluZm8pCitzdGF0aWMg
Zmx1c2hfdGxiX2Z1bmModm9pZCAqaW5mbykKIHsKIAkvKgogCSAqIFdlIGhhdmUgdGhyZWUg
ZGlmZmVyZW50IHRsYl9nZW4gdmFsdWVzIGluIGhlcmUuICBUaGV5IGFyZToKQEAgLTczOCw2
ICs3MzgsNyBAQCBzdGF0aWMgdm9pZCBmbHVzaF90bGJfZnVuYyh2b2lkICppbmZvKQogCXU2
NCBsb2NhbF90bGJfZ2VuID0gdGhpc19jcHVfcmVhZChjcHVfdGxic3RhdGUuY3R4c1tsb2Fk
ZWRfbW1fYXNpZF0udGxiX2dlbik7CiAJYm9vbCBsb2NhbCA9IHNtcF9wcm9jZXNzb3JfaWQo
KSA9PSBmLT5pbml0aWF0aW5nX2NwdTsKIAl1bnNpZ25lZCBsb25nIG5yX2ludmFsaWRhdGUg
PSAwOworCWVudW0gdGxiX2ZsdXNoX3JlYXNvbjsKIAogCS8qIFRoaXMgY29kZSBjYW5ub3Qg
cHJlc2VudGx5IGhhbmRsZSBiZWluZyByZWVudGVyZWQuICovCiAJVk1fV0FSTl9PTighaXJx
c19kaXNhYmxlZCgpKTsKQEAgLTc0NywxMiArNzQ4LDIxIEBAIHN0YXRpYyB2b2lkIGZsdXNo
X3RsYl9mdW5jKHZvaWQgKmluZm8pCiAJCWNvdW50X3ZtX3RsYl9ldmVudChOUl9UTEJfUkVN
T1RFX0ZMVVNIX1JFQ0VJVkVEKTsKIAogCQkvKiBDYW4gb25seSBoYXBwZW4gb24gcmVtb3Rl
IENQVXMgKi8KLQkJaWYgKGYtPm1tICYmIGYtPm1tICE9IGxvYWRlZF9tbSkKLQkJCXJldHVy
bjsKKwkJaWYgKGYtPm1tICYmIGYtPm1tICE9IGxvYWRlZF9tbSkgeworCQkJZmx1c2hfcmVh
c29uID0gVExCX0ZMVVNIX1NLSVBQRUQ7CisJCQlnb3RvIGRvbmU7CisJCX0KKwkJZmx1c2hf
cmVhc29uID0gVExCX1JFTU9URV9TSE9PVERPV047CisJfSBlbHNlIGlmIChmLT5tbSA9PSBO
VUxMKSB7CisJCWZsdXNoX3JlYXNvbiA9IFRMQl9MT0NBTF9TSE9PVERPV047CisJfSBlbHNl
IHsKKwkJZmx1c2hfcmVhc29uID0gVExCX0xPQ0FMX01NX1NIT09URE9XTjsKIAl9CiAKLQlp
ZiAodW5saWtlbHkobG9hZGVkX21tID09ICZpbml0X21tKSkKLQkJcmV0dXJuOworCWlmICh1
bmxpa2VseShsb2FkZWRfbW0gPT0gJmluaXRfbW0pKSB7CisJCWZsdXNoX3JlYXNvbiA9IFRM
Ql9GTFVTSF9TS0lQUEVEOworCQlnb3RvIGRvbmU7CisJfQogCiAJVk1fV0FSTl9PTih0aGlz
X2NwdV9yZWFkKGNwdV90bGJzdGF0ZS5jdHhzW2xvYWRlZF9tbV9hc2lkXS5jdHhfaWQpICE9
CiAJCSAgIGxvYWRlZF9tbS0+Y29udGV4dC5jdHhfaWQpOwpAQCAtNzY4LDcgKzc3OCw4IEBA
IHN0YXRpYyB2b2lkIGZsdXNoX3RsYl9mdW5jKHZvaWQgKmluZm8pCiAJCSAqIElQSXMgdG8g
bGF6eSBUTEIgbW9kZSBDUFVzLgogCQkgKi8KIAkJc3dpdGNoX21tX2lycXNfb2ZmKE5VTEws
ICZpbml0X21tLCBOVUxMKTsKLQkJcmV0dXJuOworCQlmbHVzaF9yZWFzb24gPSBUTEJfRkxV
U0hfU0tJUFBFRDsKKwkJZ290byBkb25lOwogCX0KIAogCWlmICh1bmxpa2VseShsb2NhbF90
bGJfZ2VuID09IG1tX3RsYl9nZW4pKSB7CkBAIC03NzgsNiArNzg5LDcgQEAgc3RhdGljIHZv
aWQgZmx1c2hfdGxiX2Z1bmModm9pZCAqaW5mbykKIAkJICogYmUgaGFuZGxlZCBjYW4gY2F0
Y2ggdXMgYWxsIHRoZSB3YXkgdXAsIGxlYXZpbmcgbm8gd29yayBmb3IKIAkJICogdGhlIHNl
Y29uZCBmbHVzaC4KIAkJICovCisJCWZsdXNoX3JlYXNvbiA9IFRMQl9GTFVTSF9TS0lQUEVE
OwogCQlnb3RvIGRvbmU7CiAJfQogCkBAIC04NDksMTAgKzg2MSw3IEBAIHN0YXRpYyB2b2lk
IGZsdXNoX3RsYl9mdW5jKHZvaWQgKmluZm8pCiAKIAkvKiBUcmFjaW5nIGlzIGRvbmUgaW4g
YSB1bmlmaWVkIG1hbm5lciB0byByZWR1Y2UgdGhlIGNvZGUgc2l6ZSAqLwogZG9uZToKLQl0
cmFjZV90bGJfZmx1c2goIWxvY2FsID8gVExCX1JFTU9URV9TSE9PVERPV04gOgotCQkJCShm
LT5tbSA9PSBOVUxMKSA/IFRMQl9MT0NBTF9TSE9PVERPV04gOgotCQkJCQkJICBUTEJfTE9D
QUxfTU1fU0hPT1RET1dOLAotCQkJbnJfaW52YWxpZGF0ZSk7CisJdHJhY2VfdGxiX2ZsdXNo
KGZsdXNoX3JlYXNvbiwgbnJfaW52YWxpZGF0ZSk7CiB9CiAKIHN0YXRpYyBib29sIHRsYl9p
c19ub3RfbGF6eShpbnQgY3B1LCB2b2lkICpkYXRhKQo=

--------------9cLz13md01RHbRqOUGKisaoY--
