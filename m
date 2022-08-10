Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE058E8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiHJImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiHJIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:41:58 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848EB26AD2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:41:57 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w196so11850090oiw.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=rgM0v6CuR0mXQ84eCMTjZi0bag4Go+aeuU78z/S5TWE=;
        b=fxBoF+15zta4F7ydua0omBwrgStDS97c8Aip79X3RiwZSdg/PRLWDq3qFh0cLw9PAg
         wTIm4txd/ARCPgDiCRJw7z61d7mGBDsMnNnoZ1oRpWG6O87XjerkIRsxIB5agR9RwqnL
         Kn/4M13k+VdcIRV39In2Q1+/SA4LUWZEmldAb0nhgHYVV6cSfbECDEpGOJdg5EmFJrhE
         k4ICKFZq3BnVArfOPPxdmtKWFtnx3w9CNlBcuo+yOXBWctpqOtYbcgjNXsEGyNgGyTlm
         o1HlrTOt/GzaziagtSf/vNtywAKm5QBR5HqsfV6TA5Eb0qQ/7BHWekmRwWRxIFJt0ErV
         WKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=rgM0v6CuR0mXQ84eCMTjZi0bag4Go+aeuU78z/S5TWE=;
        b=FdHr6A/GVovjfb/T8AnuhSnV5esThAiIquc7WtIpuod+aexTa8p7ygtVrD56R35v9x
         8Da0kNMfeNSpm2uxr+VEa1jxsuaQMIxqsGjpLIL0zPlkK45QljVRtpND7gWTse8qPGZz
         19K3Ym+Mo98RRZl0YDMT3uCrHPxp8VZamPWn1bie9WyoUQe1Mkqko9ZwpgAUZR014DS6
         IXKD2VQ7XJrqS+R22TM379/IE4XTR2pqpGaG/zVjPhDEs0UILEapOm45axnX0WE2UO0M
         NinzrlF1JdHJnY/ZsLN8eGUhLpwIDNrtEUpsSxix1H1B0TMzswBw7XXNd3yy1TeyIeKO
         nLEg==
X-Gm-Message-State: ACgBeo2rntd50Ao1t68nnYoKex7L+xD1al4xkUKv/+gAIxOMqsdRgPww
        jh+dTqkvc4YQaocs8/JtX9ej7OmYE4U=
X-Google-Smtp-Source: AA6agR73RrYAOwyuLMRzsC0GI+HzSnnHblCiIhNrd0+FhfLez6O0LELWDdmguyd3DUMC8pMLxL9aSA==
X-Received: by 2002:aca:1109:0:b0:343:25d4:9b36 with SMTP id 9-20020aca1109000000b0034325d49b36mr1007225oir.0.1660120916717;
        Wed, 10 Aug 2022 01:41:56 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id q15-20020a4ae64f000000b0044565e7ab41sm553282oot.32.2022.08.10.01.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 01:41:56 -0700 (PDT)
Date:   Wed, 10 Aug 2022 01:39:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cpumask: UP optimisation fixes follow-up
Message-ID: <YvNu0HvXkseAAr7D@yury-laptop>
References: <cover.1660066581.git.sander@svanheule.net>
 <YvM6LjJCMK4ZKrxK@yury-laptop>
 <b723f2a292e92a792df95b912404e8d8e8e5e5f4.camel@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b723f2a292e92a792df95b912404e8d8e8e5e5f4.camel@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 10:18:09AM +0200, Sander Vanheule wrote:
> On Tue, 2022-08-09 at 21:55 -0700, Yury Norov wrote:
> > On Tue, Aug 09, 2022 at 07:36:32PM +0200, Sander Vanheule wrote:
> > > As an older version of the UP optimisation fixes was merged, not all
> > > review feedback has been implemented.  These patches implement the
> > > feedback received on the merged version [1], and the respin [2], for
> > > changes related to include/linux/cpumask.h and lib/cpumask.c.
> > > 
> > > [1] https://lore.kernel.org/lkml/cover.1656777646.git.sander@svanheule.net/
> > > [2] https://lore.kernel.org/lkml/cover.1659077534.git.sander@svanheule.net/
> > > 
> > > Sander Vanheule (3):
> > >   cpumask: align signatures of UP implementations
> > >   lib/cpumask: add inline cpumask_next_wrap() for UP
> > >   lib/cpumask: drop always-true preprocessor guard
> > 
> > Acked-by: Yury Norov <yury.norov@gmail.com>
> > 
> > Applying at bitmap-for-next, after some testing.
> 
> Thanks! Any chance to get this in for 6.0? I would rather avoid building cpumask.o only on 6.0, but
> otherwise I don't think anything is functionally wrong with what is currently merged.

Functionally not, but something is still wrong, right? :)

I think -rc2 would be our best option for this, because this series is
a fix to v4, and because it will let this spend some time in -next.

Are you OK with this?

Thanks,
Yury
