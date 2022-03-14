Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B7C4D8580
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbiCNMzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiCNMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:55:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DCEF0E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 05:54:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s29so5543899lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJW5UzXbWqblOUIDOicmN3LCNPHApo6s3xMdWkut47A=;
        b=XMzW+JSZ/fOOTze1SbOH4fs8ltfFQsUvsARJL3EyIkyDg8omzyfZGOhGzbEj+a9iO5
         PhX7VG4KqO2ut7qupCR4Z8fEluknej6DQQ7nG5bSEKi2yBU0i5Bp/A0OwkcqchTE4v3x
         W384QP+k37FfUJqodGEnUHJhARJXnS27uEs6F9L0CqhllCj7Cmpat2UXbNK3mEGb+UsK
         oTE1NcRtfpm0MofmOukzlyHuLBRPT5Z2oyIUuKtBYsNVenBj86zREBTjBbK/PpNLcMgq
         2UblPO09w6zgdBqzKAsD731b4OIStx4+F4IBsTCWCpGIEyjCQw6WB5JsaxXvJU9Jkbxd
         xMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJW5UzXbWqblOUIDOicmN3LCNPHApo6s3xMdWkut47A=;
        b=eXiSMbu70/MYSZmmcEwU5xf5uCMXFcb3TY0MD3ZWk3GdFC290lSTik+zitSLF//8Gl
         rjHf6co0Ksd+ybDBNF3+A7YekC92cwhZ87px0idIwaAwnZuwDyGiVOhn/4AICgjbFgfN
         ls1NSURA6012Ri3ZWOKWf4CkmOPB+EdQdhTbSKj02pEGOqQ3bUibZvmsoegzY5guc73W
         Dz9Vaj+X4SvKYm1+73Rf2hmLP9ANfz/ftrX2lvwj1kkBo1dDCGkXRJqBAP4z4PKTamWk
         6IRNFSpXOsDPsxvB3Wtzs/n6iMn50l3jAePh1knVIMXcN5XRMaOVROCGGFjT9rJpK6PQ
         vTiA==
X-Gm-Message-State: AOAM533b5LDIB7SiZEIoq6OxX0iEjr0l8Vgj1cc4mhJ9PQShIRBpDsLJ
        yS39spOI3Y80ONXBd7N1W2POz9Of2F+y2oTssAa+rg==
X-Google-Smtp-Source: ABdhPJxTOfHPAHyXeeT/OyllRH9kctADfXCNVznhH0Yy4OslxqRxOaFJxK3S5H+TSovNZQcnxfBiBNV+ZNeuBn2YiIE=
X-Received: by 2002:ac2:5f0b:0:b0:448:1e32:4531 with SMTP id
 11-20020ac25f0b000000b004481e324531mr13160298lfq.167.1647262472696; Mon, 14
 Mar 2022 05:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220314095225.53563-1-yann.gautier@foss.st.com>
 <CAPDyKFqObiC2fwZJ_0JArbVhnFZHV6bA0XJg0diwPgmRx1Bntg@mail.gmail.com> <cfeeaa0e-7d52-9267-d46f-62eb91363b60@foss.st.com>
In-Reply-To: <cfeeaa0e-7d52-9267-d46f-62eb91363b60@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Mar 2022 13:53:56 +0100
Message-ID: <CAPDyKFr86QyN1sAaYR1WhfnNg2S6j2sr5dr=bn9L69r-QfXw7w@mail.gmail.com>
Subject: Re: [PATCH RESEND] mmc: mmci: manage MMC_PM_KEEP_POWER per variant config
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 at 13:20, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 3/14/22 12:17, Ulf Hansson wrote:
> > On Mon, 14 Mar 2022 at 10:53, Yann Gautier <yann.gautier@foss.st.com> wrote:
> >>
> >> Add a disable_keep_power field in variant_data struct. The
> >> MMC_PM_KEEP_POWER flag will be enabled if disable_keep_power is not set.
> >> It is only set to true for stm32_sdmmc variants.
> >>
> >> The issue was seen on STM32MP157C-DK2 board, which embeds a wifi chip.
> >> It doesn't correctly support low power, and we need to unbind the wifi
> >> driver before a suspend sequence. But the wifi chip firmware is then
> >> lost, and the communication with SDIO fails if MMC_PM_KEEP_POWER is
> >> enabled.
> >
> > So the platform supports to maintain the power for the embedded wifi
> > chip during system suspend, but the SDIO func driver (for the WiFi
> > chip) doesn't implement its part correctly. Did I get that right?
> >
> > In that case, it sounds to me like we should try to fix the support
> > for power management in the SDIO func driver instead, no?
> > I am happy to help with guidance/review if that is needed. What SDIO
> > func driver is this about?
> >
> > Kind regards
> > Uffe
> >
>
> Hi Ulf,
>
> I blindly pushed the patch without rechecking it.
> I rephrased it in our downstream to better explain the issue:
>
> The issue was seen on STM32MP157C-DK2 board, which embeds a wifi chip.
> It doesn't correctly support low power on this board. The Wifi chip
> awaits an always-on regulator, but it was connected to v3v3 which is off
> in low-power sequence. MMC_PM_KEEP_POWER should then be disabled.
>
> If it's OK for you, I'll resend the patch with the updated commit message.

Yes, that works fine for me!

[...]

Kind regards
Uffe
