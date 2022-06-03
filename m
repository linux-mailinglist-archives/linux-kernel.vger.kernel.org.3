Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575F953D2C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 22:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346955AbiFCUYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 16:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbiFCUY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 16:24:26 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4843EC3;
        Fri,  3 Jun 2022 13:24:25 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id s8so6539374oib.6;
        Fri, 03 Jun 2022 13:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LpgNDBdoP6t/KspsiFUK1Wc3xwi9X5pe8MvB3spUO50=;
        b=xwLlazTijK4XX0oMev7nH79/8YriEUyxOouWex/Va5Io9PmpX7jMJEZQ4DPfeUJQ6c
         E65uBSvZzInR4/bIFQI0lCrl10LybJR6++ukfXB8GlOcRZ4KHXReUxuC7FCgb5FTB6ky
         iHAUN+Jzya1atQH9nCSr5Whws6Hxtwb/RUOuxQwkRf+amj4BdzsFzo58VH1aX6OthQym
         ld/SFjWyb/ffvZFxrQZwMyjF2Wm31dZmw+pcX/bWeEtmu6rhKn6nno2Jg5cXlL/pCXXh
         yu25iVIyG/4qyMcaJcvIa8OmB09ba5YP2PwE/56vUCrFnfVp7Wcyr1qcqbMGuiZJFmZv
         J/Ng==
X-Gm-Message-State: AOAM530iwmmGBQQo6DL9Ajb/T/wxIduUKa1/FOr6KcTOhByb5WFJYEzZ
        9cRuIILtxfJn5efe1kFtEg==
X-Google-Smtp-Source: ABdhPJyAyekreTTcq3AklohCDOmKQVGg8+La0qAOOFzpP42Wl6yg4YtE9wkVWK6Zz4dB/w01fJ63Zg==
X-Received: by 2002:a05:6808:2002:b0:32e:5e09:5201 with SMTP id q2-20020a056808200200b0032e5e095201mr1449575oiw.91.1654287864839;
        Fri, 03 Jun 2022 13:24:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r26-20020a4ad4da000000b0041b5d2f3c92sm536552oos.24.2022.06.03.13.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 13:24:24 -0700 (PDT)
Received: (nullmailer pid 846852 invoked by uid 1000);
        Fri, 03 Jun 2022 20:24:22 -0000
Date:   Fri, 3 Jun 2022 15:24:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Daniel Henrique Barboza <danielhb413@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        David Hildenbrand <david@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        devicetree@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nathan Lynch <nathanl@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] of: constify of_property_check_flags() prop
 argument
Message-ID: <20220603202422.GA845694-robh@kernel.org>
References: <20220601081801.348571-1-clement.leger@bootlin.com>
 <20220601081801.348571-2-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220601081801.348571-2-clement.leger@bootlin.com>
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

On Wed, 01 Jun 2022 10:17:58 +0200, Clément Léger wrote:
> This argument is not modified and thus can be set as const.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  include/linux/of.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

As this looks independent of the rest of the series, applied, thanks!
