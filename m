Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B1E5642F9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiGBVue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGBVub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:50:31 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68359DEB1
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 14:50:30 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ay10so4690624qtb.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 14:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bKbEev7OHAYQlKgFDfwVts+bEmg1dJ3de/8MzuQghcI=;
        b=etJfnhUUQ0q5en+5UcxQgXhG4gaeT95gNNGjtEiaeRCasddGHWRQ40WHPDIo2luSr2
         Kic3ACjvB5XVaaHT6Gu715YvsVmnXq5O4mMYZ3kgYdZtWBB7q41yOUWMyUExfRzTVf3d
         1IeWgzZBxlQEqHPcR7kulfykRJNc3eZ9gvbbXzj8GlmbCbsCFRIcCHKgAwViTF65IHj6
         Ac0Zb9/Dxb7bzL9L/hBDgDakATHyiHmtYuFbCOpNewdRPTilhIsMR0awVieeQQgb9QHD
         QrBV5QZWkWdGgoVFCMwXT/h3kDhpT0TNc/H4iPfpFdXwT8F0N3i34u+ML1b4MqWuypDY
         gzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bKbEev7OHAYQlKgFDfwVts+bEmg1dJ3de/8MzuQghcI=;
        b=yXoYftpLRi7+kjn+KtxvWyP9iwo5dk+BzCaUp3Osx43eQMaubaU75NaBz5KSaoK5Pw
         dMwHR1oYbnQs6LbixmVIh7l2zew4tykdX/vRXXHrOA45Hgfh9FcWPRLzvEPeeSZFvMgd
         /6nxazNDxE6VhG1ISOiRcTTQyaxmvtmkO+apwbiNdXkL4q88KqaleEERf2qzSP2E7mm4
         1wDoS2/W9jaVSABpYpcUyuUIUIhCN0pieBovY6dVFex5JphUX/G99WhF+gDNsydyx372
         e6Argk7AqP0me31fOlVFZPc7xsWIDV0g31X7tJMVhRIEpGTy9RGZzph+53Nb4py1VDoo
         OmSw==
X-Gm-Message-State: AJIora9jd1jW/wen7Y75TjDobL06Ne3UZc0U5JziBuPWCG/tuBvT0iOy
        CcmRpVwrsG8ePPX8FjNToNfyNPlDVeI=
X-Google-Smtp-Source: AGRyM1sV1MSmjJqcIx2e2o5ww3z4v5nz9egon6SUXmkrlvX3WGugjuMBM1hYGBJ6wPnfJ6R+6dXPiQ==
X-Received: by 2002:a05:622a:178b:b0:31d:2966:98a6 with SMTP id s11-20020a05622a178b00b0031d296698a6mr16604825qtk.454.1656798629432;
        Sat, 02 Jul 2022 14:50:29 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:e838:b1c2:b125:986a])
        by smtp.gmail.com with ESMTPSA id n65-20020a37a444000000b006aee8fa79adsm19977480qke.36.2022.07.02.14.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:50:29 -0700 (PDT)
Date:   Sat, 2 Jul 2022 14:50:28 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 4/5] cpumask: Add UP optimised for_each_*_cpu versions
Message-ID: <YsC9pH54rpr/lriv@yury-laptop>
References: <cover.1656777646.git.sander@svanheule.net>
 <3a92869b902a075b97be5d1452c9c6badbbff0df.1656777646.git.sander@svanheule.net>
 <YsC9CuiLRbhMAC51@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsC9CuiLRbhMAC51@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 02:47:55PM -0700, Yury Norov wrote:
> On Sat, Jul 02, 2022 at 06:08:27PM +0200, Sander Vanheule wrote:
> > On uniprocessor builds, the following loops will always run over a mask
> > that contains one enabled CPU (cpu0):
> >     - for_each_possible_cpu
> >     - for_each_online_cpu
> >     - for_each_present_cpu
> > 
> > Provide uniprocessor-specific macros for these loops, that always run
> > exactly once.
> > 
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> 
> Acked-by: Yury Norov <yury.norov@gmail.com>

I think this patch should go before #2 to avoid possible issues while
bisecting...

> 
> > ---
> >  include/linux/cpumask.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index 7fbef41b3093..6c5b4ee000f2 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -750,9 +750,16 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
> >  /* First bits of cpu_bit_bitmap are in fact unset. */
> >  #define cpu_none_mask to_cpumask(cpu_bit_bitmap[0])
> >  
> > +#if NR_CPUS == 1
> > +/* Uniprocessor: the possible/online/present masks are always "1" */
> > +#define for_each_possible_cpu(cpu)	for ((cpu) = 0; (cpu) < 1; (cpu)++)
> > +#define for_each_online_cpu(cpu)	for ((cpu) = 0; (cpu) < 1; (cpu)++)
> > +#define for_each_present_cpu(cpu)	for ((cpu) = 0; (cpu) < 1; (cpu)++)
> > +#else
> >  #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
> >  #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
> >  #define for_each_present_cpu(cpu)  for_each_cpu((cpu), cpu_present_mask)
> > +#endif
> >  
> >  /* Wrappers for arch boot code to manipulate normally-constant masks */
> >  void init_cpu_present(const struct cpumask *src);
> > -- 
> > 2.36.1
