Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58217531DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiEWVey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiEWVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:34:51 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176AAFAD7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:34:48 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r3-20020a9d5cc3000000b0060ae1789875so8744310oti.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=onnXCDVFR2p0bkmrLOEm4kEGm5J7UYI9BrUeYSXAoUQ=;
        b=Tfn49lXjd54jumyNgfrzDgRV0VoOxC+tJeaBGbaDkknpbrqJZmKU43ZLBPaoe9bLcD
         cIvJHMFlKiAQCMvWcSjdNg6xu6mi9S0T3ZFarrfqA0EW2pTiQ4ar/mtX3bpJuaJgdDe7
         40BXa4mejaHLKheMyMKrWcCcuQUhKjs2FgTA14SJYIVBIY7GRCx6i+5NlZh4bkPFlOO1
         8Dr2boMmxWIX7xWXEJBYAfQPiwXbKS3IRaT/lVOOcR1nGJuXuBOB4tLsa6L8CHo0McS4
         W7VkvkqAdy+yGc8Hz7b9/uwXEBD4owhrz9/yfnQjtjc4ZH2uaMgvtl22YIFpunYpcE5j
         9V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=onnXCDVFR2p0bkmrLOEm4kEGm5J7UYI9BrUeYSXAoUQ=;
        b=PKFSVskh/E6GWJyimeBTFUSpedPmCssFnEhpfYxW4vfjpGHO0AJurdQh3+hYXAtrQy
         5RDec0TGt5/PBKtV71VbULl0SQeVpX22UhZO/vysjeSo7rRq4p/hd2hmq0RZzaYdPie8
         Q0pkDJRjadoHlXXLs1aoQLNVV7Y3lV7Ti99C91OnxILG1hh8j1P5NzHXGtPcTAZQmr36
         N16tcanWoIWOcywDyzhL4A+xzxkk+5PvvRC5/6ChxeWy2mfiqf89swzgXQz5qUwv68aK
         CBT4Ab+rDK2q5roCtTsce0X6e9PPt4bQfXGxc1tffrvm+gwrif5WD1qK68ytF1aH5FjU
         KuJg==
X-Gm-Message-State: AOAM5328P8hz9f0JY9lyYCozX/ymTGiWhOG8nkoHhCeA18mm2IXdNmx2
        5hcinE6xoxN/fT8AmkjJnb3i5g==
X-Google-Smtp-Source: ABdhPJzpV6X12N/BqQG+AHKu1RjSWPMwb8YXulMJ9dtUfKMvgDZDU8dzDBWtTuCWpQGNyq75ZYdYng==
X-Received: by 2002:a05:6830:25c2:b0:606:ed20:da5c with SMTP id d2-20020a05683025c200b00606ed20da5cmr9357393otu.234.1653341687785;
        Mon, 23 May 2022 14:34:47 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h18-20020a056830401200b0060603221278sm4353619ots.72.2022.05.23.14.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 14:34:47 -0700 (PDT)
Date:   Mon, 23 May 2022 16:34:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Trilok Soni <quic_tsoni@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        agross@kernel.org, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, robh@kernel.org, sboyd@kernel.org
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Message-ID: <Yov99WPNrGRg86sS@builder.lan>
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org>
 <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
 <02ab0276-b078-fe66-8596-fcec4378722b@somainline.org>
 <49a52870-9aab-c4bd-2077-66732f42bbba@linaro.org>
 <196459ad-704d-020c-c485-842f613ae618@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196459ad-704d-020c-c485-842f613ae618@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23 May 11:41 CDT 2022, Trilok Soni wrote:

> Hello Krzysztof,
> 
> On 5/23/2022 5:14 AM, Krzysztof Kozlowski wrote:
> > On 23/05/2022 14:02, Konrad Dybcio wrote:
> > > 
> > > On 23/05/2022 09:21, Krzysztof Kozlowski wrote:
> > > > On 22/05/2022 21:51, Konrad Dybcio wrote:
> > > > > Hi,
> > > > > 
> > > > > removing these properties will not bring almost any benefit (other than making
> > > > > some checks happy any saving some <200 LoC) and will make the lives of almost
> > > > > all people doing independent development for linux-on-msm harder. There are
> > > > > almost unironically like 3 people outside Linaro and QUIC who have
> > > > > non-vendor-fused development boards AND the sources to rebuild the
> > > > > bootloader on their own. Making it harder to boot is only going to
> > > > > discourage people from developing on these devices, which is already not
> > > > > that pleasant, especially with newer platforms where you have to fight with
> > > > > the oh-so-bright ideas of Android boot chain..
> > > > > 
> > > > > This only concerns devices released before sm8350, as the new ones will not
> > > > > even boot with these properties present (or at least SONY Sagami, but I
> > > > > doubt it's an isolated case), so other than completing support for older
> > > > > devices, it won't be an issue going forward, anyway. But there are give
> > > > > or take 50 locked down devices in mainline right now, and many more waiting
> > > > > to be upstreamed in various downstream close-to-mainline trees that should
> > > > > not be disregarded just because Qualcomm is far from the best at making
> > > > > their BSP software stack clean.
> > > > I actually wonder why do you need these properties for community work on
> > > > such boards? You ship kernel with one concatenated DTB and the
> > > > bootloader does not need the board-id/msm-id fields, doesn't it?
> > > 
> > > If that were the case, I would have never complained about this! It's
> > > the bootloader itself that needs it, you can see it in a "Best match
> > > [blah blah] 258/0x1000/...." log line, where it walks through the
> > > appended (or otherwise compiled into the boot.img) DTBs and looks for
> > > matches for the burnt-in msm-, board- and (on newer-older platforms)
> > > pmic-id. If it cannot find these, it refuses to boot with an Android
> > > Verified Boot red state and you get a not-so-nice "Your device has been
> > > unlocked and the boot image is not working" or something like this on
> > > your screen.
> > > 
> > > 
> > > > 
> > > > Not mentioning that in the past bootloader was actually not using these
> > > > properties at all, because it was the dtbTool who was parsing them.
> > > 
> > > Not sure when that was the case, maybe with very old arm32 bootloaders
> > > in the times before I did development on Qualcomm devices.
> > > 
> > > 
> > > >    So
> > > > in any case either your device works fine without these properties or
> > > > you have to use dtbTool, right?
> > > 
> > > To the best of my idea, wrong :( Unless the vendor modified the LK/XBL
> > > code on their own, it looks for a "best match" (but if it's not a
> > > precise match, it won't even bother trying to boot, just fyi..), meaning
> > > it tries to go through a list of SoC ID and revision pairs (msm-id),
> > > board IDs (board-id) and PMIC id+rev pairs (pmic-id) and if no match is
> > > found, it doesn't even exit the bootloader and says something like "no
> > > dtbs found".
> > 
> > This would mean that dtbTool as described in the actual patch [1] is not
> > used and bootloader ignores the table. If that's the case, the commit
> > and requirement of such complex board-foundry-pmic-compatibles should be
> > dropped. So I am getting now to what Dmitry said...
> > 
> > [1]
> > https://lore.kernel.org/all/1448062280-15406-2-git-send-email-sboyd@codeaurora.org/
> 
> 
> The link above is from 2015. Lot has changed downstream. Most of what was
> mentioned by Konrad is right. Application bootloader acts on picking on
> platform DTBO based on the platform ID plus some combinations like PMIC etc;
> These platform DTBOs gets overlay on top of SOC DTB by the Application
> bootloader.
> 
> We have moved to DTBO for all the latest targets, but I can understand that
> some old targets at upstream could be using the very old approaches.
> 
> Downstream all of the platforms including the DTBO files will need board-id
> and msm-id since we also do the compile time stitching of dtb + dtbo and
> dtbo + dtbo to generate the proper SOC DTB and PLATFORM DTBOs which gets
> flashed in the DTBO partition and follows the Android boot requirements.
> Application bootloader then picks the right Platform DTBO as mentioned above
> w/ the right SOC DTB. It gets more complicated w/ GKI new requirements every
> year (better for GKI, may not be better for upstream kernel + downstream
> bootloader combination).
> 

FWIW, this doesn't fit with the upstream model at all. In particular the
DTBO that comes with the devices are not compatible with any upstream
DTB.

As such, the first step to run an upstream DTB+kernel is to zero out the
dtbo partitions.


With the DTBO cleared, most devices (all Qualcomm reference devices) can
be booted with the dtb appended to the Image.gz, without the
qcom,{board,msm}-id. As such I would say things are working okay
currently.

Regards,
Bjorn
