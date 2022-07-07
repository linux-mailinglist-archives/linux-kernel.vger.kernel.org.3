Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043B256AD28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiGGVDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiGGVDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:03:46 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AF3255A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:03:45 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o26so7265997qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/vlV4YXgXdARWZutT+ZlYgLGL82V0LAgwi+nbuKKJY=;
        b=MbMU7oqLKyQe8BNLlX+Ql95V6goF9xqhuyW0C46TkGbJpL3aXnv8xH7XAP7npI6x5b
         2u1U4iiU/H0t9UqYn3IJprp9Vg1rTntzjdl5uDzXnODye2nIwa4n2LRF22m7mvBaEdQR
         21+Eh24oZsPqcqPRAgGilAphhu4Rjz2V/6l2UcsYjdQFC1uJpChF7lyWXyoqPskpFJ8p
         3HJhyH/Cj+/5nGyz8fYVpNj9dHEYrND/2/XaP7kPj5MCaBkH9VXVLpCUqI5Yebk+kTo6
         MNsLuCOv4Dxbs8Waso11/QzY3qtdUSULVGPBRK3za13MNB+rzrRay9Var+7ryf7f0g/e
         s1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/vlV4YXgXdARWZutT+ZlYgLGL82V0LAgwi+nbuKKJY=;
        b=M3FiMFPG34vaBFCwNDVwuu2cPx7vet9eqMmqvdim5HLqYa3k7yVtpgnx2TActyOHYM
         TXQ57U/AT3DBHwJ98WQIoECZ8CC87r2qsHDveR/g+M61oFngf7/t1gnybMd+7D65V0zc
         ZODt3zB3RV9b4qjl69eio+hlP869QK6MaqeH5VNROSS/W++L3sW6fN1N/Xtc029DItmM
         F9Q/XlFJhWEbK/Um0o0rS2FZ4Rla7GqhXM+Etkx5fm9pKrUe6Zw6cT/i3fCwKO6GaBWS
         s3OAOsZM7IAq5jdcmGiTIhM2YxzhRKNrGtvnJd7ajpxG09W4H4rrX8zH9/VHxhMklXnu
         TZRw==
X-Gm-Message-State: AJIora+huuQkW11nfIR+5XAsXQLCaAym1TMJfa0/nl4Xn1GdyGfGdivs
        OM/5Fdnb3wicXIxSgG7csKAftpWul1XJow==
X-Google-Smtp-Source: AGRyM1uJn+5dFU3kksT1FIz2de3+kdHuV6U8QMkpJ3Yu2BXqGmf0fOooxanlADkIlF9HWJ4lMbSWQw==
X-Received: by 2002:a37:a17:0:b0:6af:a57:25c4 with SMTP id 23-20020a370a17000000b006af0a5725c4mr32643549qkk.168.1657227824450;
        Thu, 07 Jul 2022 14:03:44 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id fb10-20020a05622a480a00b00304e2e4bf1esm27314485qtb.88.2022.07.07.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 14:03:44 -0700 (PDT)
Date:   Thu, 7 Jul 2022 14:03:45 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH 1/5] lib: add find_nth(,and,andnot)_bit()
Message-ID: <YsdKMQzUFVwIaqtJ@yury-laptop>
References: <20220706182300.70862-1-yury.norov@gmail.com>
 <20220706182300.70862-2-yury.norov@gmail.com>
 <423c4368-0a1c-792c-2637-768532fc7782@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423c4368-0a1c-792c-2637-768532fc7782@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 09:25:07AM +0200, Rasmus Villemoes wrote:
> On 06/07/2022 20.22, Yury Norov wrote:
> > Kernel lacks for a function that searches for Nth bit in a bitmap.
> > Usually people do it like this:
> > 	for_each_set_bit(bit, mask, size)
> > 		if (--n == 0)
> > 			return bit;
> > 
> > We can do it more efficiently, if we:
> > 1. find a word containing Nth bit, using hweight(); and
> > 2. find the bit, using a helper fns(), that works similarly to
> >    __ffs() and ffz().
> > 
> > fns() is implemented as a simple loop. For x86_64, there's PDEP instruction
> > to do that: ret = clz(pdep(1 << idx, num)). However, for large bitmaps the
> > most of improvement comes from using hweight(), so I kept fns() simple.
> > 
> > New find_nth_bit() is ~70 times faster on x86_64/kvm:
> > for_each_bit:                  7154190 ns,  16411 iterations
> > find_nth_bit:                505493126 ns,  16315 iterations
> 
> Eh, have you interchanged these somehow, otherwise this reads as
> find_nth_bit being ~70 times _slower_?

I didn't change the pr_err("find_nth_bit: ...") line in the test, and
had to edit manually when preparing the series. The numbers are fair,
it's just manual edit issue.
 
> > With all that, a family of 3 new functions is added, and used where
> > appropriate in the following patches.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/bitops.h | 19 ++++++++++
> >  include/linux/find.h   | 79 ++++++++++++++++++++++++++++++++++++++++++
> >  lib/find_bit.c         | 20 +++++++++++
> >  3 files changed, 118 insertions(+)
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index 7aaed501f768..86072cfcbe17 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -196,6 +196,25 @@ static inline unsigned long __ffs64(u64 word)
> >  	return __ffs((unsigned long)word);
> >  }
> >  
> > +/**
> > + * fns - find N'th set bit in a 64 bit word
> > + * @word: The 64 bit word
> > + * @n: Bit to find
> > + */
> > +static inline unsigned long fns(unsigned long word, unsigned int n)
> > +{
> > +	unsigned int bit;
> > +
> > +	while (word) {
> > +		bit = __ffs(word);
> > +		if (--n == 0)
> > +			return bit;
> > +		__clear_bit(bit, &word);
> > +	}
> > +
> > +	return BITS_PER_LONG;
> > +}
> 
> Urgh.  "unsigned long" is not necessarily a 64 bit word.

I'm not sure I understand your concern. The fns() returns an index
of Nth bit (0...31 or 0...63 correspondingly), or 32/64 if such bit
doesn't exit.

> And I don't
> like that the index is apparently 1-based (and that surprising API isn't
> spelled out anywhere).

Yeah... My motivation to start counting from 1 is to keep consistency
with ffs: __ffs(word) <=> fns(word, 1). So, the argument is not an
index - we are looking for the index; instead, it's an order - first,
second, third etc.

But the return value - is index, counting from 0. It looks weird, but
after some poking around, I think this is the most logical way to go.
I'll add a note in the comments for v2.

> This is also way too big to be inline IMO.

Maybe yes... I've got nothing against moving it into c-file. On the
other hand, arch/alpha/include/asm/bitops.h is full of 5-line inline
functions, just for example. Let's see what others say.

> >  #ifndef find_first_and_bit
> >  /**
> >   * find_first_and_bit - find the first set bit in both memory regions
> > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > index 1b8e4b2a9cba..7b8ad12c8cc7 100644
> > --- a/lib/find_bit.c
> > +++ b/lib/find_bit.c
> > @@ -89,6 +89,26 @@ unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
> >  EXPORT_SYMBOL(_find_first_bit);
> >  #endif
> >  
> > +unsigned long _find_nth_bit(const unsigned long *addr1, const unsigned long *addr2,
> > +				unsigned long size, unsigned long n, bool not)
> > +{
> > +	unsigned long val, idx, w;
> > +
> > +	for (idx = 0; idx * BITS_PER_LONG < size; idx++, n -= w) {
> > +		val = addr1[idx];
> > +		if (addr2)
> > +			val &= not ? ~addr2[idx] : addr2[idx];
> 
> Maybe this could be microoptimized by doing
> 
> unsigned long addr2mask = not ? ~0UL : 0UL;
> ...
> 
>   val &= (addr2[idx] ^ addr2mask);
> 
> but I don't think it'll make a difference.

I'll try.

Thanks for review!

Thanks,
Yury
