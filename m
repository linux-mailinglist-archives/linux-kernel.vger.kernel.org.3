Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18B34D0D07
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245642AbiCHAxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiCHAxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:53:06 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E21C329B4;
        Mon,  7 Mar 2022 16:52:11 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id s207so445609oie.11;
        Mon, 07 Mar 2022 16:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=td2dQrLboBYxumnDQKShw1XpxIe3rYbrby2068uMMkU=;
        b=gitu32eHVSpYHZXU9cTbr/U2e5RJiPHWq9J9r9iBiRkDHG/1SKErsc4BUyKsKsoaDf
         UqRx0b94CDct/FrXIq2oaIv5NoS0jM2Q/hukfwRfgyoRPXQVqt2aH0iwS3eJOuZgEjMl
         stvTa+9/qW+9vwZJ+ChsKfy8M3Bqsueoa5TghQIHAbFxP0TkZnvkBkYPNsUiIlKtMYoS
         u4pIIk5rbZ7nmsgG5te5KHWXLZ6hUXjB5BVCbnDXLMYcM3m0/y1Jz1St8z7ZYabRD9kT
         1d5XJSghJ2ANQVQuIdacrT74/RmTh/A4bUdnHCOXynSHShDqdCSJG2GlKx20IuCwbojF
         A5Fg==
X-Gm-Message-State: AOAM532MQ3KKFlqYjTme4YoIH28JZACsPJUbft2lTiz9f6Ekj0cVUYjG
        Xlx7/BfVaIK6Yocd0X1WAjIBst75Dw==
X-Google-Smtp-Source: ABdhPJxSn+4z1/FosMK1XhAw6ohhDDkJ4pH6slHP5dt44vFixTof+W76bqSyA9UYoEi4proM/zVDSg==
X-Received: by 2002:a05:6808:1708:b0:2d9:a868:9883 with SMTP id bc8-20020a056808170800b002d9a8689883mr1156916oib.158.1646700730641;
        Mon, 07 Mar 2022 16:52:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dw7-20020a056870770700b000d9aa7a6d63sm6261234oab.6.2022.03.07.16.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 16:52:09 -0800 (PST)
Received: (nullmailer pid 3597630 invoked by uid 1000);
        Tue, 08 Mar 2022 00:52:08 -0000
Date:   Mon, 7 Mar 2022 18:52:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: Add optional number of additional clock
 cycles to be generated
Message-ID: <YiaouHFtlIG8nQxu@robh.at.kernel.org>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
 <6b6bad3844828c22de3acfb9e7fbac877a48d5a4.1646060734.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b6bad3844828c22de3acfb9e7fbac877a48d5a4.1646060734.git.christophe.leroy@csgroup.eu>
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

On Mon, 28 Feb 2022 16:15:45 +0100, Christophe Leroy wrote:
> Some components require a few clock cycles with chipselect off before
> or/and after the data transfer done with CS on.
> 
> Typically IDT 801034 QUAD PCM CODEC datasheet states "Note *: CCLK
> should have one cycle before CS goes low, and two cycles after
> CS goes high".
> 
> The cycles "before" are implicitely provided by all previous activity
> on the SPI bus. But the cycles "after" must be provided in order to
> achieve the SPI transfer.
> 
> In order to use that kind of component, implement a new option for
> SPI slaves in order to implement trailing clock of a given number of
> bits with ChipSelect off at the end of the transfer.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 5 +++++
>  drivers/spi/spi.c                                          | 7 +++++--
>  include/linux/spi/spi.h                                    | 1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
