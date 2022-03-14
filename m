Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1651E4D8FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245665AbiCNWkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245654AbiCNWkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:40:04 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F15C22B29
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:38:52 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 12so19004315oix.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXkFYBEzojBY1qqCl4Kxt1AhbpSUG3Tsb0zDnLNmqZ0=;
        b=WcVdtBUaKkF+aSmgdLxPUC7etTQfErJlN9YeeS3QKG4zrBeU32ndyFXx7YQQcOwezZ
         Cokc3VIVYaYOniyJB1OY9nksQwiwSgMs9r+BRfcgRTHmu2QE3i7XJN6yAz3BZRWYOycE
         jwpygELyZo/gVDQ7EDdKoDZRjg9jKRIieAbuHYqZhdGGGlmEUCfW9fEhVYa4zNfPfZ+k
         tld4VRBVds/0c1IFje0L21JO3x9fTOIyrLGEnwoy4CiZGEuZI4FsjQYyr287oEYarFDs
         J4J22Ggs4VI9Yeohday6QNv+N2YyrW1b5JdkZAr/2bZ+vtoV0XrtecU6DEQ1Ylj8cue/
         cmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXkFYBEzojBY1qqCl4Kxt1AhbpSUG3Tsb0zDnLNmqZ0=;
        b=Ys9B/V7tgGMF8VE2UOuOMPm/NR+sAmpvFiT15opQfWwvlmmsWRTEkSzaxN4HNc/T5H
         71dh8EKMh2Ch1JOP7hiQ5mb61KZZQsgxsCcspfpxdEVzy+wz5Kzw9wGLVeFLfLUhQprv
         gXJMSNKF0sd3ElFeOBEaBWOVTAsYd/THOzoR0mOZokJhTZTjutl+8vBClEx/QHXqINbx
         Z//MxTboapjM/rNM1nrmSUMuUQzcCD5GitxaC1iKCe7DM2t1NML9IzknYDmAP3rvd+Je
         +hzkeD1iSachjxO7DFw37+JVHjtndt9MR4RD1cVAV8EmGvBTNIjnLR6mgcrkVjmlUyVR
         X72Q==
X-Gm-Message-State: AOAM530ZcrW0f0P4bsQ+lfwXVgwBK/3Jl3DHEazZu8znXasepIAHawRM
        PgiJsSQrR73pPKxlteW5ZaVebw==
X-Google-Smtp-Source: ABdhPJygsq2dL74GG22/VfljFSfGfYJUxf/rqsqC1VFczZCgSv28PIwMQkk48UaxBoaQaGnpC9LIpg==
X-Received: by 2002:aca:c44:0:b0:2da:45a4:98a2 with SMTP id i4-20020aca0c44000000b002da45a498a2mr602667oiy.220.1647297531426;
        Mon, 14 Mar 2022 15:38:51 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id bn14-20020a056808230e00b002da0c0f502esm8301688oib.24.2022.03.14.15.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 15:38:50 -0700 (PDT)
Date:   Mon, 14 Mar 2022 17:38:48 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/6] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QM
Message-ID: <Yi/D+CmHcm2/8S9B@builder.lan>
References: <20220309102118.8131-1-peng.fan@oss.nxp.com>
 <20220309102118.8131-3-peng.fan@oss.nxp.com>
 <YiqFJ+1l/h7XCQkN@robh.at.kernel.org>
 <DU0PR04MB9417A914373C466BE76729AB880C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417A914373C466BE76729AB880C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Mar 19:58 CST 2022, Peng Fan wrote:

> > Subject: Re: [PATCH V2 2/6] dt-bindings: remoteproc: imx_rproc: support
> > i.MX8QM
> > 
> > On Wed, Mar 09, 2022 at 06:21:14PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add i.MX8QM compatible
> > >
> > > There are two general purpose M4, so add reg property to indicate the
> > > id.
> > 
> > Where does the id come from? Is this just an index?
> 
> It is software use to identify which is m4_0 and which is m4_1,
> just an index.
> 

"reg" is supposed to represent some sort of identifier on the parent
bus, as such it doesn't seem to be the appropriate property to provide
an arbitrary 0 or 1 to identify which of the two m4s this is.

Regards,
Bjorn

> Thanks,
> Peng.
> 
> > 
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4
> > ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > > b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > > index f25c203dd2f9..41d366cff3cd 100644
> > > --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > > +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > > @@ -20,6 +20,7 @@ properties:
> > >        - fsl,imx8mn-cm7
> > >        - fsl,imx8mp-cm7
> > >        - fsl,imx8qxp-cm4
> > > +      - fsl,imx8qm-cm4
> > >        - fsl,imx8ulp-cm33
> > >        - fsl,imx7d-cm4
> > >        - fsl,imx7ulp-cm4
> > > @@ -68,6 +69,9 @@ properties:
> > >    power-domains:
> > >      maxItems: 8
> > >
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > >    rsrc-id:
> > >      description:
> > >        This property is to specify the resource id of the remote
> > > processor in SoC
> > > --
> > > 2.30.0
> > >
> > >
