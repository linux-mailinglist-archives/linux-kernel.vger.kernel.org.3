Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BAB5A836F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiHaQqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiHaQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:46:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625DCD7D12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:46:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lx1so29534058ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=c2TX4X9uyLpPzlBA8SkX7a5tu94KGH4Yf0CSb9a5La0=;
        b=gzn7AV6FF8ujOWh5fibOQxp7+QWz/iVO85IAc9S1w2Fyk1mCJS4enw4JqKzLOSs+UZ
         eWCx4pEMlFzayH4gm9OTAvX/QrFRL82yJU/pwgkhb3ZH9lOW3S8lNN/eqA66J3AXbLgb
         0HHQSO0x9uYB+FObn7BeiQQQUDiWW866y5StE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=c2TX4X9uyLpPzlBA8SkX7a5tu94KGH4Yf0CSb9a5La0=;
        b=ADuWkZ3WUgs/1pBzTZdF08QPrK758WJbnwy0ISFI9HHyyc+OesWZiMGUiXEvgJsd09
         4Bh6REX0K3qjpXc5Z+nnLVnitTbR4WQYTbD18p13m1TRBEFpT3ksaxbdK8oMAjHIlzrU
         V4yyUDMZ9eD9jUS/mZQ2pH0CVpfsVCCtJ6z+hkTOor9Gmb+jxzZUdW/F1vrsys5oxyqo
         3ZxzVWClwG4lMS06a6vNBlEw6wckrdERvWze4ub4Okk+W41zAOYiGr/4F8qyVHDcQHBT
         nXDgC3esGB3uYHskkgW6pJkW1zUkz1PL0SPk8sY5DS79mJxoeyeZhtnxQH8W+Xi0Ji2f
         63QA==
X-Gm-Message-State: ACgBeo3hSOsLBz56Hx9LOrlBwhYTkDVAEbf8q3svSwUVpdW5twvT20Pb
        G64u2mDlzADYNVTA85gUfFRMouBX6OCgl9+4
X-Google-Smtp-Source: AA6agR41K5dfHspQL3xVLe4fa62E5AgABBUDSfzf1W+WLmz81aJWiIDN/FkAECTZg+iOSAETlhpqrg==
X-Received: by 2002:a17:906:8442:b0:73d:a2fc:a87 with SMTP id e2-20020a170906844200b0073da2fc0a87mr20657460ejy.625.1661964389362;
        Wed, 31 Aug 2022 09:46:29 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0073d71b7527asm7220942ejf.151.2022.08.31.09.46.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 09:46:28 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id k17so7677199wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:46:28 -0700 (PDT)
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id
 s25-20020a7bc399000000b003a5f3fb85e0mr2629152wmj.38.1661964388324; Wed, 31
 Aug 2022 09:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <Yw8L7HTZ/dE2/o9C@xsang-OptiPlex-9020>
In-Reply-To: <Yw8L7HTZ/dE2/o9C@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Aug 2022 09:46:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgG=mttS-m2OLcnsTwia2roHR2b-DxXXG-tbDH8_cUNiA@mail.gmail.com>
Message-ID: <CAHk-=wgG=mttS-m2OLcnsTwia2roHR2b-DxXXG-tbDH8_cUNiA@mail.gmail.com>
Subject: Re: d4252071b9: fxmark.ssd_ext4_no_jnl_DWTL_54_directio.works/sec
 -26.5% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, lkp@lists.01.org,
        lkp@intel.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 12:21 AM kernel test robot
<oliver.sang@intel.com> wrote:
>
> hi, pleased be noted that we read this patch and understand it as a fix,
> also what we understand is, since the patch itself adds some memory barrier,
> some regression in block IO area is kind of expected.

Well, yes and no.

It's a memory ordering fix, but the memory ordering part is one that
should *not* have any actual impact on x86, because the addition of
smp_mb__before_atomic() should be a total no-op, and
"smp_load_acquire()" should only imply a compiler scheduling barrier.

IOW, it most definitely shouldn't cause something like this:

 > FYI, we noticed a -26.5% regression of
 >  fxmark.ssd_ext4_no_jnl_DWTL_54_directio.works/sec

because at most it should have caused tiny perturbation of the
instruction scheduling (obviously possibly register allocation, stack
spill differences and and instruction choice).

Except there was a change there that isn't just about memory ordering:

> after more internal review, we still decided to report out to share our finding
> in our tests, and for your information that how this patch could impact
> performance in some cases. please let us know if you have any concern.

Oh, it's absolutely interesting and unexpected.

And I think the cause is obvious: our "set_buffer_uptodate()" *used*
to use the BUFFER_FNS() macro, which does that bit setting
conditionally.

And while that isn't actually correct in an "atomic op" situation, it
*is* fine in the case of set_buffer_uptodate(), since if the buffer
was already uptodate, any other CPU looking at that bit will not be
caring about what *this* CPU did.

IOW, if this CPU sees the bit as having ever been uptodate before,
then any barriers are irrelevant, because they are about the original
setting of 'uptodate', not the new one.

So I think we can just do this:

  --- a/include/linux/buffer_head.h
  +++ b/include/linux/buffer_head.h
  @@ -137,12 +137,14 @@ BUFFER_FNS(Defer_Completion, defer_completion)

   static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
   {
  -     /*
  -      * make it consistent with folio_mark_uptodate
  -      * pairs with smp_load_acquire in buffer_uptodate
  -      */
  -     smp_mb__before_atomic();
  -     set_bit(BH_Uptodate, &bh->b_state);
  +     if (!test_bit(BH_Uptodate, &bh->b_state)) {
  +             /*
  +              * make it consistent with folio_mark_uptodate
  +              * pairs with smp_load_acquire in buffer_uptodate
  +              */
  +             smp_mb__before_atomic();
  +             set_bit(BH_Uptodate, &bh->b_state);
  +     }
   }

   static __always_inline void clear_buffer_uptodate(struct buffer_head *bh)

and re-introduce the original code (maybe extend that comment to talk
about this "only first up-to-date matters".

HOWEVER.

I'd love to hear if you have a clear profile change, and to see
exactly which set_buffer_uptodate() is *so* important. Honestly, I
didn't expect the buffer head functions to even really matter much any
more, with pretty much all IO being about the page cache..

                          Linus
