Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3588563A20
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiGATtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiGATtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:49:00 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B5021E12;
        Fri,  1 Jul 2022 12:49:00 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id y2so3198929ior.12;
        Fri, 01 Jul 2022 12:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vDc42dtA+UoyVWkO+4EamxSh0i4aFOrhi15gsyDqnJg=;
        b=qU/DBgnr/ilG99XDM0LPIzEkIrxuuk/X23NiFtB4wbkFq0/wVl3G25NRWeKCohy6gv
         JnxRy9nrzfwVO8AURBiVyqHogqRp3qVNz197hlKu9b7ivI3RpwNv+yszEMxAobhBXSX8
         /X76Zsn5+erEa3j+7M/luC2AR+bo56haIwabOktc57oWHpNYUdnRULBjIMCxF18VSrQy
         rHuamoO7WXjXdqb8yCbgLc66HswdAysdoOZ/V9lMn1eR6AU4SI4Xbu+vqcJ/FF/fgdBq
         qOAotCtaRbPJnzAMct9a29YaV56d8rF4p2UcWiailPzP3qiKoXf9XPg7V+aMxpqs94t8
         UwBw==
X-Gm-Message-State: AJIora94CnP4ONL6lvm/aEb5PPm0sgWcOtU37wJlkXxt0R7J+YOklJfV
        Z9Xu4ZWrnojqbRvrYqUfNQ==
X-Google-Smtp-Source: AGRyM1vPN1mKIV3eAwCq2PzkHKGU8UAPtvVrzwZCRjfaKwWrT79WKespjv7gHQ1hN7Xfrnq5EYueNQ==
X-Received: by 2002:a02:cc0c:0:b0:339:c46a:e5dd with SMTP id n12-20020a02cc0c000000b00339c46ae5ddmr9602444jap.104.1656704939352;
        Fri, 01 Jul 2022 12:48:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bg13-20020a0566383c4d00b00339edc9d877sm5834212jab.120.2022.07.01.12.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:48:59 -0700 (PDT)
Received: (nullmailer pid 1403293 invoked by uid 1000);
        Fri, 01 Jul 2022 19:48:57 -0000
Date:   Fri, 1 Jul 2022 13:48:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     miquel.raynal@bootlin.com, rtanwar@maxlinear.com, vigneshr@ti.com,
        tlanger@maxlinear.com, devicetree@vger.kernel.org, richard@nod.at,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/8] dt-bindings: mtd: intel: lgm-nand: Fix maximum
 chip select value
Message-ID: <20220701194857.GA1403235-robh@kernel.org>
References: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
 <20220629213508.1989600-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629213508.1989600-3-martin.blumenstingl@googlemail.com>
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

On Wed, 29 Jun 2022 23:35:02 +0200, Martin Blumenstingl wrote:
> The Intel LGM NAND IP only supports two chip selects: There's only two
> CS and ADDR_SEL register sets. Fix the maximum allowed chip select value
> according to the dt-bindings.
> 
> Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
