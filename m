Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B38D4EB51C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiC2VSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiC2VSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:18:48 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F4B1D41BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:17:04 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id f38so33778324ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1NmdHbhnl/vRItSEWqZfS578eYz0Ln76M7w3+17SBng=;
        b=nnNp2K9C0PhtBCZ9DlF+5HkNtJtSFxGCTe+rj/yzMLI7t8hiUYwTIqIX7DjUb2Ej+l
         YZJn4iEApNAcehGis3mzjUOYIlnzVRouSbGMm6iXFNxUZ+KoTMHAVElD+A4wwZmCd/B0
         eEEbLLsLZFZEcsXXT0Lo5ktPGfgsMiW2ylL9g+GOabkqDWyMZ1h1SM1Pf4lmXgs/D+7I
         gXS3N7nI5IDy0LRBZ4AehTCJ1hAF298ax1wzj0Ii9zBxM8U3GjQ0lFRhOsj8guh34ZnJ
         wCCDM9vUrfgM5TSoshOYj3qBD4m2Ny8MZNGXo+h+RQmlgcxRSkD4XP6KR3exbwSYnVXH
         m04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NmdHbhnl/vRItSEWqZfS578eYz0Ln76M7w3+17SBng=;
        b=X6XQV7oD4gK06gN8j2Gb9kZ56WeeFVfTrCxIWCkB2GJEz9NWXh5GK8PLbGC8G46DD3
         NjOKqfIDBHa7o1+0FS6kQc6p+zmxhLoe3jJNU5SHbQE5d+htIXEd1KmQgki/W0iWJwoe
         Y3qFUD+NsY5fAKTxOnwm8ZLmoZ8+7n+4+r38U6EY/zts8N5y5kYw5GyhmptZxMFHt1kz
         jxWi2Xt9/fLYEJrAu95qyU/FtKfN8b6q1iXeP/t3QYbZhzIgmT0zYAt6QE/cixTjyd7i
         L1g+JrOntj6TSPxMB8aZ21prhmRESEH3BbVXtcS556ix/nj72NefDzegJlftryC9vL+4
         LNtA==
X-Gm-Message-State: AOAM532sy4GfsTT6iP5abbw2TTYaSPbK73d73dt/5vW81yDMw55VgBlZ
        TWj7qMSYNNkk6xYQXBgylV95M7259yQOILVQUHqd1A==
X-Google-Smtp-Source: ABdhPJykJ5Ut7PIceBwZraoLzJOYrOlgWf2VUP56VuJtpRcHz881r39za7FgGIqkZzFEF9YvREaj+sXPJsynCiusvbw=
X-Received: by 2002:a25:2497:0:b0:633:c1d0:e7bb with SMTP id
 k145-20020a252497000000b00633c1d0e7bbmr30780376ybk.291.1648588623439; Tue, 29
 Mar 2022 14:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com> <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
 <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com> <20220329153114.GA58120@thinkpad>
 <71b10ce2-7b87-14d5-c8e4-3a4598c889e0@foss.st.com> <20220329173322.GC58120@thinkpad>
In-Reply-To: <20220329173322.GC58120@thinkpad>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Mar 2022 23:16:51 +0200
Message-ID: <CACRpkdaiOhMGzuWPwoRLZ05HyM8BO_-cZt4TiAqAYQvDaJA-mA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>, ulf.hansson@linaro.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Grzegorz Szymaszek <gszymaszek@short.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 7:33 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> [Yann]
> > As for Prabhakar's answer, the IDMA here is inside our IP, and not used in
> > any other IP. So I'm not sure it is really relevant to move that to another
> > dmaengine driver.
>
> Okay, I think this justification makes sense. I was worried of DMA IPs that get
> sandwiched into many peripherals like the one on Renesas platforms. It turned
> out that each subsystem has to add internal DMA support for it :/

That is a justified worry.

Qualcomm has "BAM DMA" (I think it is called?) which is added to each IP
that needs DMA. drivers/mmc/host/mmci_qcom_dml.c
It's for older Qualcomm platforms but I *think* it is actually not just used
for the MMCI, just noone ever got around to adding it to any other
peripheral? Srini do you know?

Yours,
Linus Walleij
