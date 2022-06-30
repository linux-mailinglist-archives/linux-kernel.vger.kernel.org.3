Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6000456155E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiF3IqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiF3Ip6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:45:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2AD1EED0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:45:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so1180035wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T/R4fFP/Nheq+mHl4LKypJiecS5mA9jxh87TsPRmo+0=;
        b=U/wrS85NDiwymHaaOof+NTLDRie83Dyy3ovzraRbnqbAq3Vays0JRxvhwp5FR5MXo9
         bhFwTH98V2evtd+fJ33F4cqj64r4dSb1QVK/ihxf9y+AkVTGLu7pSeDmltDJkTk+eGni
         x4nn2AfIZy/7KchUYW99Mxq8n7NPlWykPgfSCTsRASGk0VOJhnyKLLBn8Oa3BWP4m8ER
         hJZPVKNBF3gUELuBN8pHVfA37S2c3JA2YTHBEGRBq6XfycMHEsWXJHl6xArE4eKgneD4
         r5I3uRZ460k66k5DyYn9orvcSVLIdic/6cxqREBjChe700Owcjsp4Gzt113nSkUOJDgG
         cQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T/R4fFP/Nheq+mHl4LKypJiecS5mA9jxh87TsPRmo+0=;
        b=gkaiS/eML+vToFfUUt2T9AFWHeHXoJchRcUuJph0LKq071WhEWFhw7WecTt+sViRw4
         GPc1+W6ZuNMiNOQu2f5X9H+QgVDpNiFK71yxoZQBMs2j/BXjMJYsE5MFK/Zm2qb5cpY8
         QbkrWzRtjYgzWUDD5piAh3LViHy1WnE0ImHhHLJboW3h79rZl+kXpKJo4z3pjrTgfr1V
         m3l4B8r11bg4H3ilYkvY25Wi/laap5R+/9t+AF1BhtEQ7KoPVH9/aAV/vyPI4Td/6nhV
         VsLkjQBOw7sDiSyK32slKLs9B3E5E4LyvXqLxPm1xzIsRiVlZ3JiK12KPnANSycl3UE9
         4Qnw==
X-Gm-Message-State: AJIora8uhUnr7udo91eFZpdbCuAudzyVEmAteBgzu7LIlPG7ZBU/pAE/
        Rkms/IkRH7vO0aREFJDKOKMIMA==
X-Google-Smtp-Source: AGRyM1sG9DXk0FND1RNcYBYu5gY9BHQgnh+7wDrvh7Ambj12Yb0OvP7PCV3glYmZrszDAlKcNt4edQ==
X-Received: by 2002:a05:600c:3ba7:b0:3a1:6c19:fa8c with SMTP id n39-20020a05600c3ba700b003a16c19fa8cmr7721436wms.120.1656578755674;
        Thu, 30 Jun 2022 01:45:55 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b003a17ab4e7c8sm2107232wmq.39.2022.06.30.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 01:45:55 -0700 (PDT)
Date:   Thu, 30 Jun 2022 09:45:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <Yr1iweMUl+EUY+Q6@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <Yrmr175fsQi6ToEY@google.com>
 <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
 <YrxjTD0sJXh8cgVP@google.com>
 <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
 <Yr1YXHb3GqwZncFK@google.com>
 <CAHp75Vf1UK9Z2P1D9v_j9rsdKoDXWSvb=wJgmkvACYgwofWrxA@mail.gmail.com>
 <35c907e6-6018-d22b-1992-ffc66eb82b0e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35c907e6-6018-d22b-1992-ffc66eb82b0e@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022, Hans de Goede wrote:

> Hi,
> 
> On 6/30/22 10:07, Andy Shevchenko wrote:
> > On Thu, Jun 30, 2022 at 10:01 AM Lee Jones <lee.jones@linaro.org> wrote:
> >> On Wed, 29 Jun 2022, Andy Shevchenko wrote:
> >>> On Wed, Jun 29, 2022 at 4:36 PM Lee Jones <lee.jones@linaro.org> wrote:
> >>>> On Tue, 28 Jun 2022, Andy Shevchenko wrote:> > On Mon, Jun 27, 2022 at 02:08:39PM +0100, Lee Jones wrote:
> >>>>>> On Thu, 16 Jun 2022, Andy Shevchenko wrote:
> > 
> > ...
> > 
> >>>>>>>  drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
> >>>>>>>  drivers/mfd/intel_soc_pmic_core.h |  25 -----
> >>>>>>>  drivers/mfd/intel_soc_pmic_crc.c  | 162 ++++++++++++++++++++++++++++--
> >>>>>>>  4 files changed, 157 insertions(+), 193 deletions(-)
> >>>>>>>  delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
> >>>>>>>  delete mode 100644 drivers/mfd/intel_soc_pmic_core.h
> >>>>>>
> >>>>>> Can you submit this again with the -M flag please.
> >>>>>
> >>>>> This is done with this flag. Basically for the last several years I do my
> >>>>> submissions with that flag.
> >>>>
> >>>> Odd.  I thought -M only showed diff for the changes.
> >>>
> >>> It's exactly what happens here in this patch. What did I miss?
> >>>
> >>> Note here is not renaming, but merging contents of one file (actually
> >>> two files) into another. What you are talking about is probably -D,
> >>> but AFAIR Git (at least that time) can't catch up deleted files from
> >>> the mbox format. That's why I do not use -D for submissions.
> >>
> >> Ah yes, that's probably it then.
> >>
> >> From a quick look at the diff (I missed the 2 "--" at the end), it
> >> looked like this was a rename.  In which case -M won't do anything
> >> useful here.  I'll have to brain grep the differences instead.
> > 
> > Please do, it will be good to have this double checked.
> 
> Note that I already did a manual compare of the moved code blocks
> to check that they were not changed before giving my Reviewed-by.

Super, thanks Hans.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
