Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092F95177CB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381589AbiEBUP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiEBUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:15:23 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B67647;
        Mon,  2 May 2022 13:11:54 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e9027efe6aso15306516fac.10;
        Mon, 02 May 2022 13:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iFucsA5Ez9eKEIIJxclpF6rEOIC5QyDejdPoOT0zWNw=;
        b=jd6nBI5elW5VX3iGDVuMQ3qtAGUpr34tjJuSaJEbo7wJwEljrI/DGFCql39QnMXVub
         pIXiabt051CjQ/FpRyFyzXG3nhZhEFX710qnSlP3Vm0TbuHnepYjxVRZZVAhO0m5LNv2
         F22RGNtw9qMVPM+EcCuM1H+velm5CJ5+XueovDR4+/Fb3ZE3W7AEAi8naAMdSWohD4wC
         tFS5p4m3/GZNk5PELwGFVZfZ8FvWBa/VV4FowNUSBYHicV/ngdl7geeRhyQqw98mLhjH
         WvOcELEGQWAcMEywlOjzW5e8NUDmdRwnhnxkNnoyHiFa+98lo4+s1kKXwo21rj7+EQtD
         9EyQ==
X-Gm-Message-State: AOAM533Z16nVAhRWFVPPqSxh/ITeGX4ADsQIoRAhCRS4otR5nOx4ukrd
        SbcJLfR+7/htfzfnizenIg==
X-Google-Smtp-Source: ABdhPJzJQcZp2FqEi2/8eefqdINc5i65zvwbNYjQqC/1tVbA3fFDU4sX5q2bmYR9PaLVnGwIj0xRQg==
X-Received: by 2002:a05:6870:d785:b0:d2:823a:94df with SMTP id bd5-20020a056870d78500b000d2823a94dfmr375395oab.93.1651522313182;
        Mon, 02 May 2022 13:11:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m63-20020aca5842000000b00325cda1ff9esm2696562oib.29.2022.05.02.13.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:11:52 -0700 (PDT)
Received: (nullmailer pid 1658903 invoked by uid 1000);
        Mon, 02 May 2022 20:11:51 -0000
Date:   Mon, 2 May 2022 15:11:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] crypto: atmel-sha204a: Add support for ATSHA204
 cryptochip
Message-ID: <YnA7BvqB3Y5E8O8m@robh.at.kernel.org>
References: <20220421134457.5867-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220421134457.5867-1-pali@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 15:44:57 +0200, Pali Rohár wrote:
> ATSHA204 is predecessor of ATSHA204A which supports less features and some
> of them are slightly different.
> 
> Introduce a new compatible string for ATSHA204 cryptochip "atmel,atsha204".
> 
> Current version of Linux kernel driver atmel-sha204a.c implements only hw
> random number generator which is same in both ATSHA204 and ATSHA204A
> cryptochips. So driver already supports also ATSHA204 hw generator, so just
> simply extends list of compatible strings.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 4 +++-
>  drivers/crypto/atmel-sha204a.c                         | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
