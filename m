Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93955394D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346069AbiEaQPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346025AbiEaQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:15:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07E095DCE;
        Tue, 31 May 2022 09:15:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso1484158wmn.4;
        Tue, 31 May 2022 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTwbDkRh5hDmKjnX326/H9mLZmvE5gWxqRme+WbiGTU=;
        b=Rru3PwBplI26UVmu4AXwOX9WpBcGD4aIv0VSI8ypmKBntq8oSPd9BEv9TniUq1iLvp
         YBRmDAhwsRw8pp75B5ILEfiMaxPMxFGFKGYBrb6SdwRv/QNuPZoYyxcce5ElLzRkxNYS
         PAvH8P2D8UU78DqlF9etOWjlmopXtvn1GEUjdUucWxPaWHKbHyys0MMKV6e0HLLoqF2r
         LFt+T/F5phreLYp1vMgOVXGeX8tXiA0JYKNoFZyqLbu6auPuzF943C8foHaaN0qnMqjx
         gJjP8I6Pne2uobs/BDW2AAVT39AxR7/ICC7vlZxIolKQUDFOn6MJVnfuJfovNUwZhil3
         PnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTwbDkRh5hDmKjnX326/H9mLZmvE5gWxqRme+WbiGTU=;
        b=1UoCrCW5g4CxWQov+VPeh6Jmr3GTi488Lv76DWz8KXKHQEqK1nuYM4kCPZ3fNmxlgy
         GB02MG9djRXsf4KmyAcfarO8d/JmQjk4b4saBZj6oxybkAzjqZ2BFhYcP86XdF2CdqN0
         Ks9rueCMkh+sbq5dmGJITSVI+0mT8Ezf98lQUuiHRGrWX+X30wqFq2szJi1kuEVJs5FN
         8bLpSRy92paek4jD5E2gylFUA9Pk8qA69M7MFyseUFJfceCv40wlCRZeueoSnQMVFHs8
         YUbaJYRD8RzR72VgTq9ADPgDqEgoqkgqvtuX2fIONnx28j9jVcZ11NNmV8atkcF7Dt1a
         BjPg==
X-Gm-Message-State: AOAM531SBeKSKHE+h2a6w2vgJw+BFVlyCX/NcfhP9rA3cBHfELbl+bSh
        Jqj0JVBdttfOM4x4m+VLsHSogr4bmx0sThOWhLo=
X-Google-Smtp-Source: ABdhPJw8TmZisoYJQb2SVHP2J/XSkZSzLw0bfkiAV9h8OY9eEHr/k33ODPPnsIXrdwWQH0cYw+WJ2+TymTyZCKqRUgQ=
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id
 n16-20020a7bc5d0000000b00389fe853d79mr24898741wmk.77.1654013721128; Tue, 31
 May 2022 09:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-2-konrad.dybcio@somainline.org> <20220531154631.GA25502@willie-the-truck>
In-Reply-To: <20220531154631.GA25502@willie-the-truck>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 31 May 2022 09:15:22 -0700
Message-ID: <CAF6AEGsWsHfQZnszG=NgP0BufxO-DP4LwvsAYkrz2wRhcJuOXw@mail.gmail.com>
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if specified
To:     Will Deacon <will@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Martin Botka <martin.botka@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 8:46 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, May 27, 2022 at 11:28:56PM +0200, Konrad Dybcio wrote:
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> >
> > As specified in this driver, the context banks are 0x1000 apart.
> > Problem is that sometimes the context number (our asid) does not
> > match this logic and we end up using the wrong one: this starts
> > being a problem in the case that we need to send TZ commands
> > to do anything on a specific context.
>
> I don't understand this. The ASID is a software construct, so it shouldn't
> matter what we use. If it does matter, then please can you explain why? The
> fact that the context banks are 0x1000 apart seems unrelated.

I think the connection is that mapping from ctx bank to ASID is 1:1

BR,
-R
