Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304D85A0A79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiHYHlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiHYHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:41:12 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB919D8DA;
        Thu, 25 Aug 2022 00:41:11 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-334dc616f86so519543337b3.8;
        Thu, 25 Aug 2022 00:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lsPADIwuzKOCMFK6M4YgS9lTJNBP+zcjWWbReC7RB/A=;
        b=SVjQsyS7WRA2euAsVhYICssKntu9VAx0murnk8NxrIB+Y7gKyO1HtOvXYaub6Vbgk1
         ru4Q1sgm4oWX6LFcY7DoRH+Gu+WVL0qTki+K+IscPQDWFqGip3K5HUcR5id9vgxJ45hH
         7CsHCIvzYSvUtlsz7B0J+lotq0MvRcCH0tilUr+hoCdG/b6f9aM8NT5C5wNv/U+qpQiw
         W7VkSoqNPDcXWsxE3bpePlKSm2I+B0KEOH+sYS7CKzwRa6oTrWHPKu+xt5sbTK1e33KD
         vQygM3tJZ/72hpJ27bVyOF1s9fC8PPhml4iQbOKKOrcesMCnllmQWwWO1SEGJJVKHyQE
         a1SA==
X-Gm-Message-State: ACgBeo0xIC1vyeH25HLbYOMpGQVtuaBDU9Ay8k1CtEcljzvdPL76HlKN
        dhoCMmU/xpfL96NDgUrhiLLe53orm/wkmfEd4Xw=
X-Google-Smtp-Source: AA6agR5vg15i0MMWs9ercrSH/mWnOepLpvi0PrDDBVEc3AbUQzFb4ifgjMZbW0br8kxx40px9fyIq2/vvsIN+J6r9BU=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr2255530ybm.482.1661413270290; Thu, 25
 Aug 2022 00:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220812130645.14710-1-sbinding@opensource.cirrus.com> <20220825072505.316002-1-ardb@kernel.org>
In-Reply-To: <20220825072505.316002-1-ardb@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 09:40:58 +0200
Message-ID: <CAJZ5v0iyRAzx=HjWko=QJ7iXv_Ftwsx+yjnA2MuN4KVZo9wWew@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: Property: Fix type detection of unified integer
 reading functions
To:     Ard Biesheuvel <ardb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Stefan Binding <sbinding@opensource.cirrus.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 9:25 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > The current code expects the type of the value to be an integer type,
> > instead the value passed to the macro is a pointer.
> > Ensure the size comparison uses the correct pointer type to choose the
> > max value, instead of using the integer type.
> >
> > Fixes: 923044133367 ("ACPI: property: Unify integer value reading functions")
> >
> > Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> Can we get this queued up and sent out please? This is breaking some ACPI arm64
> systems, which use device properties for their MAC addresses.

It is in my queue for -rc3.

> Some grumbling about the original patch below.
>
> > ---
> >  drivers/acpi/property.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 7b3ad8ed2f4e..b1d4a8db89df 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1043,10 +1043,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
> >                               break;                                  \
> >                       }                                               \
> >                       if (__items[i].integer.value > _Generic(__val,  \
> > -                                                             u8: U8_MAX, \
> > -                                                             u16: U16_MAX, \
> > -                                                             u32: U32_MAX, \
> > -                                                             u64: U64_MAX, \
> > +                                                             u8 *: U8_MAX, \
> > +                                                             u16 *: U16_MAX, \
> > +                                                             u32 *: U32_MAX, \
> > +                                                             u64 *: U64_MAX, \
> >                                                               default: 0U)) { \
>
> Why is there a default here? Having one is what hides the fact that the patch was completely broken.

Sakari?

> >                               ret = -EOVERFLOW;                       \
> >                               break;                                  \
> >
>
> Also, I must ask: given how broken the original patch is, I suppose no testing whatsoever was done?
