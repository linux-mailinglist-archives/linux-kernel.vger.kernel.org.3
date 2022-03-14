Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9373A4D8FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbiCNWox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbiCNWoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:44:46 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E28C33E23
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:43:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id j2so33933111ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBz4KR/tbzFCQ7Rg6AbL2tIN/kz8QPBlTu1AMO28qtU=;
        b=r7NNd/At5KMqFw3i9SvlUx564e3HPd17qxW7CY1V/KYHkMDg2c205EYOqfvZ+Feie0
         k78b8IkyX6wYfgmqwiJYaa+1N2M3Tc3DuQd210amcQeoZkCentBLNGI7opmuGm1zFmpo
         kXCRTEs3pkdklEykPP7O3IbVmZrH84YOUuGa9bsDHpjS94GVCLF+z1R6OdlcMcwhpKM9
         ZCEfs1XlbOpMBbRh6nRznEnzHtaiMfaHSIK4invfukZGxDmq7l6EgYHLk76Efz86Bed0
         cYcdgIHO4n6h2Ms4mnZJKpewAoUOD+al7/xMp/5P2wRBwOJ3B1tjADUlF3+iqwg3HNZE
         jjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBz4KR/tbzFCQ7Rg6AbL2tIN/kz8QPBlTu1AMO28qtU=;
        b=jdKbVJoruBr68jhHHC+NOWvMRVZ6Hn5zuXy1laaQS0GBqnRyNmvVp0xt6iTrRSlU9/
         NaTr7L0ba4e/kEeR7GWwWSx2SKdqG1nWjfu4TKBg4RI73JWII2JDaiqgq8oOwtcYiWOe
         7ArWcdVcs1ZbMoQ9mERsWvVeKvasmEXvQX64tFa9OnX39FkjRLC8ld8UfJRlKTVnFpDh
         eV1W+72Sb0i4SAwzcYaEkeNRLrOiMA0zxl0Eb66OeHMYX10pM43CA75u2RIx63hbQVUS
         0SAqGTbMlSeZ9BZxaYTH8XPWecHp8o4gmd8ZENFI9KwLFNohcIk2AdU0rpGgyUeJKq49
         TA8g==
X-Gm-Message-State: AOAM532DSZ45O8fv3rSNP+dsTuilZ21NFXPPf/KzC8eS2Pp0j//vahMI
        Fx9bPm/8s7ZpSIFTAjiGuOxvp1YZSaCBsW0BMNTRDQ==
X-Google-Smtp-Source: ABdhPJzdH5EAlui5zL/pWz9DIDbKqOBoB1cvh3rT4dgsBx/UFynGgA6bujxHdHry3cd2exdH6seuYB8+4pdVXpKfX60=
X-Received: by 2002:a25:ab64:0:b0:633:6d02:ebc8 with SMTP id
 u91-20020a25ab64000000b006336d02ebc8mr2106711ybi.492.1647297814409; Mon, 14
 Mar 2022 15:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220304135134.47827-1-yann.gautier@foss.st.com> <20220304135134.47827-2-yann.gautier@foss.st.com>
In-Reply-To: <20220304135134.47827-2-yann.gautier@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Mar 2022 23:43:22 +0100
Message-ID: <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
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

"On Fri, Mar 4, 2022 at 2:52 PM Yann Gautier <yann.gautier@foss.st.com> wrote:

> On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
> starting from revision v2 of the peripheral. But it has limitations,
> as all the buffers should be aligned on block size (except the last one).
> But this cannot be guaranteed with SDIO. We should then have a property
> to disable the support of LLI.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Actually I think this is present also on the ux500 variants. See:
commit 2253ed4b36dc876d1598c4dab5587e537ec68c34
"mmc: mmci: Support any block sizes for ux500v2 and qcom variant"

Spot the variant data "dma_power_of_2".

So whatever property you add
to the variant data (not in the device tree please) should
be added to the ux500 variants as well, it will *VERY* likely
have a problem with LLI elements not being a power of 2
as it is the ancestor of later STMicro variants.

It might actually be the reason for some annoying WiFi error
messages I have seen :/

Yours,
Linus Walleij
