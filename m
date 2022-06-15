Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F8654D2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346978AbiFOUo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346887AbiFOUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:44:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DB52CE18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:44:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso3098559pjh.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kUDf/u910LysDJrcuyN3NJQ4Y4LOo/h3/JlYMs8xcZ0=;
        b=BYtnYUDPQJ6Ixf9avcgIP+uzYG2NSxrzhfAlFyFdBGU7HSA+GgX4kkNkROqTmtTsBL
         2ukaFFvDBNzmeSiR6n0FADy/sMIgVhPu2yVwy6vXtvUIQv956luWNaJfQbFsQDBVprN1
         YircoRmAjfAqEQJDmuYwqWOPs5VwhzCYfBKnxcy+5J5SSoVx7rHvGsY6c1bxUpStiJz1
         idvIcPfmHg3XUaK9RI0UUlJUuodU9MkQkDAC1DWc/B7maRpZCErn/NDM3TawV5n5ilqv
         4DYY1ZslF/Cpgd/qjXBEV0jh1HIOwvtmclCb5nd9+OczNvDKZzXq5riP8/F6DqANEndR
         D9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kUDf/u910LysDJrcuyN3NJQ4Y4LOo/h3/JlYMs8xcZ0=;
        b=YL+KcyQSVeqSGXWpM9e3TIC5Xl41857Psgs0MMkgH/6EtayAIjv46A6vSa78je4Tgx
         TTEAbriCjAlYTb9paZRqbGZ3HA31Cbytss29mf280fjb+6iUQWPUq7UvhVWAQYwIkLEd
         udvSDQxlBV0CJStmdoM8UDZo1hlGGPDHqPCgPJiS6CFmy4fYf27QRdXL8j/GADlvy5ba
         t/w2kxaNcfKRbOM3Umi2O2XcyVLhnhv0mbdr4GJ484fCml0cQKR7HB0vPx3FDr/9ZZYN
         1LwAMa7GAMYHQvuRLRs0ZF5a/80rVkEMxvTni7dEiBnv6NQ80OABjlJ/0FVAgs8C0nLM
         nYLQ==
X-Gm-Message-State: AJIora/ccgVPHJ/KGqWJ65Ydo6hLdmdeTVkd6zXU3Th8JDqw58T27MIm
        oS0gA0ecwFu7bYaE1l+uPrgKrw==
X-Google-Smtp-Source: AGRyM1uNSTnvyeg3GEiWLHsF6PC5peshAuHFTefZHQqF/RDMTJXk0VYlwYjbhT6liUB6gFJmFKAgCQ==
X-Received: by 2002:a17:902:aa0c:b0:168:faa0:50a1 with SMTP id be12-20020a170902aa0c00b00168faa050a1mr1513563plb.57.1655325895802;
        Wed, 15 Jun 2022 13:44:55 -0700 (PDT)
Received: from p14s ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id c11-20020a17090a1d0b00b001e6a230c2f5sm2259207pjd.34.2022.06.15.13.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:44:54 -0700 (PDT)
Date:   Wed, 15 Jun 2022 14:44:50 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Message-ID: <20220615204450.GA1257609@p14s>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
 <DU0PR04MB941740BC9C2C5B205985CAB588AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941740BC9C2C5B205985CAB588AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:24:03AM +0000, Peng Fan wrote:
> Bjorn, Mathieu
> 
> > Subject: [PATCH V3 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
> 
> Please give a look on this patchset if possible.

Your pathset is currently 3rd from the top in my queue.  As such I will likely
get to it in the next couple of weeks but as usual, I can't make any guarantees
on that front.

Thanks,
Mathieu

> 
> Thanks,
> Peng.
> 
> > 
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > V3:
> >  Drop the dependency in V2.
> >  Tested on i.MX8QM/8MM
> >  Use 'fsl,resource-id' and 'fsl,entry-address' Per dt maintainer  Drop 'reg'
> > property Per remoteproc maintainer  Drop mcore self recovery, until we land
> > in common framework support.
> > 
> > V2:
> > 
> > https://patchwork.kernel.org/project/linux-remoteproc/cover/202203091021
> > 18.8131-1-peng.fan@oss.nxp.com/
> >  Depends on
> > https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
> >  Tested on i.MX8QXP/QM/8MP
> >  Addressed Mathieu's comments
> >  Drop V1 patch 5/9, patch 3/9 is replaced with upper dependency patchset
> > Move V1 patch 4/9 out to
> > https://patchwork.kernel.org/project/linux-remoteproc/patch/202203080657
> > 54.3355-1-peng.fan@oss.nxp.com/
> >  Update commit log
> >  Drop magic number to get entry address from device tree in patch 4/6
> > 
> > The V1 patchset:
> > https://patchwork.kernel.org/project/linux-remoteproc/patch/202201110333
> > 33.403448-4-peng.fan@oss.nxp.com/
> > 
> > Peng Fan (6):
> >   dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
> >   dt-bindings: remoteproc: imx_rproc: support i.MX8QM
> >   remoteproc: imx_rproc: support attaching to i.MX8QXP M4
> >   remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
> >   remoteproc: imx_rproc: support i.MX8QM
> >   remoteproc: imx_rproc: request mbox channel later
> > 
> >  .../bindings/remoteproc/fsl,imx-rproc.yaml    |  16 ++
> >  drivers/remoteproc/imx_rproc.c                | 222
> > +++++++++++++++++-
> >  2 files changed, 231 insertions(+), 7 deletions(-)
> > 
> > --
> > 2.25.1
> 
