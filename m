Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039315758A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiGOAeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOAeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:34:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDDB2C666;
        Thu, 14 Jul 2022 17:34:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bp17so5453200lfb.3;
        Thu, 14 Jul 2022 17:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0rGhQNj8uyI81ckYT+VVXENe31UkgplONZDpQgE07Oc=;
        b=OJvE62rheMLYWZq+X7rgvtv16ZB7jTNFNFTOzPn3VF3TfaBbnFxZ7IcnTWLufUQ/Sq
         8vmpblIw2uB79k1hSM2nwB07SXvqn6klzDQB34zD1XTfDNtq03IT2fawwG3vB5e/UaEc
         54TuWDF5+IQ+KiUz8cQjzsG/f2QlCcOC0Axf4na2Px8iuAeSrx0AceCEDc5vaSet/QeZ
         K0EeyoPlMBA4XDc++rpu/50E7Tw/+/fbMm/1nC0+Hju6U82QQp5czw/YiB2KDZqwOg9P
         oPrxYP7pvPn3t6ypHzYdAUlaNvWOlgZEcbDwL7LSzbynJ62+TnFojVdYpekd1dp9cY8Z
         uQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rGhQNj8uyI81ckYT+VVXENe31UkgplONZDpQgE07Oc=;
        b=Zr94QWUKXnLDYfp2ux4WVZ2INFYzdd2V+za9t+b30K92g/oW5EktalwQsqnMzARkZe
         Bemcn1GcW29tdnxO8wVudBZnBDZPXFY8pPw7zwc+dmtBl86RywZiXDB26JM10jIyvc3e
         tI4sA+9bBwv0Ku+gvNRBkU+G8hKWJgVvbseL/tPZdyjhHq4z/10IIbr2f1DSDqqnGicj
         VHLb4f2s6o6a7cUU7T7pmPnjgzGSrcuGNGT1qfNJ4hN8jCF3fusAaqA+ickXRZPX4uz2
         T7HfQjMd3R8cea2mtf/rWEy8+DxAEx0Pj55FsiMb3wcUuQz+rYCwXjVUgKcWDgRMtRIe
         qaIA==
X-Gm-Message-State: AJIora9SzGgMafYOZmKrB5NJs+MSCBohDJ2/sAs4s2M165ouFfsDt8we
        1P70UczRdF5Sz/aPgmwsLnvN3jZZjvg=
X-Google-Smtp-Source: AGRyM1usyJz6kpmTfXzeczUPK2/IMjlyR5QuGEBBFmZFCHYqMZWb9dUAwwdgAB08tbdMcnN2jXnxrA==
X-Received: by 2002:a05:6512:a8b:b0:48a:14b1:e7a6 with SMTP id m11-20020a0565120a8b00b0048a14b1e7a6mr3587523lfu.634.1657845255029;
        Thu, 14 Jul 2022 17:34:15 -0700 (PDT)
Received: from pc ([104.28.230.247])
        by smtp.gmail.com with ESMTPSA id n27-20020a05651203fb00b0047fae90bfb4sm610293lfq.56.2022.07.14.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 17:34:14 -0700 (PDT)
Date:   Fri, 15 Jul 2022 03:34:09 +0300
From:   Boris Lysov <arz65xx@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Johnson Wang (=?UTF-8?B?546L6IGW6ZGr?=)" <Johnson.Wang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "Yu-Chang Wang ( =?UTF-8?B?546L54Wc5qif?=)" 
        <Yu-Chang.Wang@mediatek.com>,
        "Kuan-Hsin Lee ( =?UTF-8?B?5p2O5Yag5paw?=)" 
        <Kuan-Hsin.Lee@mediatek.com>
Subject: Re: [RFC PATCH 2/2] clk: mediatek: Add frequency hopping support
Message-ID: <20220715033409.553ce65c@pc>
In-Reply-To: <a1d36cba-a58a-326a-70dc-3578f183a249@collabora.com>
References: <20220612135414.3003-1-johnson.wang@mediatek.com>
        <20220612135414.3003-3-johnson.wang@mediatek.com>
        <ca4b9a0e-b1ca-6861-e4c0-30a8c8a5c99c@collabora.com>
        <9addc9fb0c949e921f915fcf128783393214bfde.camel@mediatek.com>
        <30e07350-ff56-a361-121e-3cb3a27643a1@collabora.com>
        <CAGXv+5F3YK51eL60-SD6pfW90xSZYoVvLXvbQ1oq+8zQmfkKwA@mail.gmail.com>
        <946e6d8fd14151277f00521e1373057a403021b0.camel@mediatek.com>
        <a1d36cba-a58a-326a-70dc-3578f183a249@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 13:04:49 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 06/07/22 15:07, Edward-JW Yang ha scritto:
> > On Wed, 2022-06-29 at 16:54 +0800, Chen-Yu Tsai wrote:
> >> On Tue, Jun 28, 2022 at 6:09 PM AngeloGioacchino Del Regno
> >> <angelogioacchino.delregno@collabora.com> wrote:
> >>>
> >>> Il 24/06/22 09:12, Edward-JW Yang ha scritto:
> >>>> Hi AngeloGioacchino,
> >>>>
> >>>> Thanks for all the advices.
> >>>>
> >>>> On Mon, 2022-06-13 at 17:43 +0800, AngeloGioacchino Del Regno wrote:
> >>>>> Il 12/06/22 15:54, Johnson Wang ha scritto:
> >>>>>> Add frequency hopping support and spread spectrum clocking
> >>>>>> control for MT8186.
> >>>>>>
> >>>>>> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> >>>>>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> >>>>>
> >>>>> Before going on with the review, there's one important consideration:
> >>>>> the Frequency Hopping control is related to PLLs only (so, no other
> >>>>> clock types get in the mix).
> >>>>>
> >>>>> Checking the code, the *main* thing that we do here is initializing the
> >>>>> FHCTL by setting some registers, and we're performing the actual
> >>>>> frequency hopping operation in clk-pll, which is right but, at this
> >>>>> point, I think that the best way to proceed is to add the "FHCTL
> >>>>> superpowers" to clk-pll itself, instead of adding multiple new files
> >>>>> and devicetree bindings that are specific to the FHCTL itself.
> >>>>>
> >>>>> This would mean that the `fh-id` and `perms` params that you're setting
> >>>>> in the devicetree get transferred to clk-mt8186 (and hardcoded there),
> >>>>> as to extend the PLL declarations to include these two: that will also
> >>>>> simplify the driver so that you won't have to match names here and
> >>>>> there.
> >>>>>
> >>>>> Just an example:
> >>>>>
> >>>>>       PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x0224, 0x0230, 0,
> >>>>>
> >>>>>           PLL_AO, 0, 22, 0x0228, 24, 0, 0, 0, 0x0228, 2,
> >>>>> FHCTL_PERM_DBG_DUMP),
> >>>>>
> >>>>> Besides, there are another couple of reasons why you should do that
> >>>>> instead, of which:
> >>>>>     - The devicetree should be "generic enough", we shall not see the
> >>>>> direct value to write to the registers in there (yet, perms assigns
> >>>>> exactly that)
> >>>>>     - These values won't change on a per-device basis, I believe?
> >>>>> They're SoC-related, not board-related, right?
> >>>>>
> >>>>> In case they're board related (and/or related to TZ permissions), we
> >>>>> can always add a bool property to the apmixedsys to advertise that
> >>>>> board X needs to use an alternative permission (ex.:
> >>>>> `mediatek,secure-fhctl`).
> >>>>
> >>>> I think we should remain clk-fhctl files because FHCTL is a independent
> >>>> HW and is not a necessary component of clk-pll.
> >>>
> >>> I know what FHCTL is, but thank you anyway for the explanation, that's
> >>> appreciated. In any case, this not being a *mandatory* component doesn't
> >>> mean that when it is enabled it's not changing the way we manage the
> >>> PLLs..........
> >>>
> >>>> Frequency hopping function from FHCTL is not used to replace original
> >>>> flow of set_rate in clk-pll. They are two different ways to change PLL's
> >>>> frequency. The
> >>>
> >>> I disagree: when we want to use FHCTL, we effectively hand-over PLL
> >>> control from APMIXEDSYS to the Frequency Hopping controller - and we're
> >>> effectively replacing the set_rate() logic of clk-pll.
> > 
> > Do you mean we need to drop the current set_rate() logic (direct register
> > write) and use Frequency Hopping Controller instead?
> > 
> 
> On PLLs that are supported by the Frequency Hopping controller, yes: we should
> simply use a different .set_rate() callback in clk-pll.c, and we should return
> a failure if the FHCTL fails to set the rate - so we should *not* fall back to
> direct register writes, as on some platforms and in some conditions, using
> direct register writes (which means that we skip FHCTL), may lead to unstable
> system.
> 
> This means that we need logic such that, in mtk_clk_register_pll(), we end up
> having something like that:
> 
> if (fhctl_is_enabled(pll))
> 	init.ops = &mtk_pll_fhctl_ops;
> else
> 	init.ops = &mtk_pll_ops;

Looks like accepting my patch [1] wouldn't be a bad idea, after all.
[1] https://lists.infradead.org/pipermail/linux-mediatek/2022-May/041293.html
