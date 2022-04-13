Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ADE4FFDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiDMSYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiDMSYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:24:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52B8396B5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:22:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ks6so5705532ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M8MM9hNtlsb/0mGDP5Eh6d8xwozIxiEbRd1Lk53Q2x8=;
        b=AfZ4ojV7fGDgQo6baXqWP9xdlkYefBtN6ONQTTRuj8YW5P2oU0QyTcPPmn+Qxq0ZaR
         TeTnw1PMzTpBgAImuYmnFPpMiKL27rUSGi4C1ILlwrq1DJDDhrhwTB8XUkvAPNIV/4rr
         3NBCZpZ0baJ4dl5uLGHLzbuEVqwo6i07CLCYI0KDsrJNbTdBTB2DOpbJZ2aaLAF4Jcul
         mHKHI/wwctHmTYeN7OB0gqAFtNik2gp7zxAHtdodVor1kh1t8Je3eTVwBL+w1DYL5Eii
         xdb5BObNy4KVYMXF+HCCjEBgLiDEkuUxazh0123t0A+Uf1tTJHP2Ya2HzwhGZJ8ddjEV
         llcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M8MM9hNtlsb/0mGDP5Eh6d8xwozIxiEbRd1Lk53Q2x8=;
        b=YkTiDcZMwjhIo+4FoPjjEmxKlLo1VqKIsRwzl1YBJ/fCnlF5uThyca90erjGFoMgcj
         YOHNoPtty7ZA8mjp6hy5dspNvcwWt4Tji6xbuRMV7geSUXCtxlgAoOWnpS0uec1FyDHs
         Pwc7D2JUnmo4EYtNo9UhaafNOHS6kIqzMmFxapUr9Rf8n/c9m8a27GuadspG5MyCTeBI
         84XLY9xxahT1QByMpYLsyqbcl/OirXb4rL70crYqwrADkZ2KBsp+YaGZgjmVPmwbGzjB
         XFEEQy89vwuzvCmYcwspyAM3Q74AWeNRQvUGLKu0NkCtaViA4jk18grODsQlQFFKXz/m
         8low==
X-Gm-Message-State: AOAM530YdaUgbAULOqI/h0mWFRQvWnMeYUVF5+gRDJaN+/Nv89yR2bsb
        z0VU8Hp3sZfoh38wLMIzgrLMKmVSz5c=
X-Google-Smtp-Source: ABdhPJwcJwJXD3ZxALW/ZXITseVCZhS4IB+VdRINSiXel6dSLaZhXSnfpbAaUOm0d7snfmaUQfhUQg==
X-Received: by 2002:a17:907:7ea1:b0:6e8:9325:c9ce with SMTP id qb33-20020a1709077ea100b006e89325c9cemr14756806ejc.368.1649874129175;
        Wed, 13 Apr 2022 11:22:09 -0700 (PDT)
Received: from skbuf ([188.26.57.45])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b006e4b67514a1sm222798ejb.179.2022.04.13.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:22:08 -0700 (PDT)
Date:   Wed, 13 Apr 2022 21:22:07 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH v3 1/8] arm64: dts: ls1028a: Add PCIe EP nodes
Message-ID: <20220413182207.chvdbqnmmm5vbz2b@skbuf>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
 <20211214093240.23320-2-leoyang.li@nxp.com>
 <20220413163209.4pqqpyqdklhlzp5p@skbuf>
 <DU2PR04MB894975813DAC1043AAA23C5B8FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB894975813DAC1043AAA23C5B8FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 06:03:37PM +0000, Leo Li wrote:
> > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:631.23-656.5: Warning
> > (unique_unit_address): /soc/pcie@3400000: duplicate unit-address (also
> > used in node /soc/pcie-ep@3400000)
> > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:670.23-695.5: Warning
> > (unique_unit_address): /soc/pcie@3500000: duplicate unit-address (also
> > used in node /soc/pcie-ep@3500000)
> 
> This would be a common problem for all the layerscape PCIe controller.
> The controller can either work in RC mode or EP mode.  The current
> binding of the controller defined two compatibles, one for RC and one
> for EP.  Therefore the SoC dtsi will have two nodes with the same unit
> address one for EP one for RC.  Fixing this probably requires
> comprehensive updates to the binding which breaks backward
> compatibility.

So we have to live with these warnings forever now?

How are the PCIe controllers configured for RC or EP mode? Via RCW?
Is dynamic configuration possible?

Can't U-Boot detect the operating mode from the RCW and fix up the
compatible string in case the controller is in endpoint mode?
