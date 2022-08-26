Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6902E5A32AC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343528AbiHZXdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHZXdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:33:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BEEE3C04;
        Fri, 26 Aug 2022 16:33:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z20so2933411ljq.3;
        Fri, 26 Aug 2022 16:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=5AXWR4TpQid/hNoRIKM4TMgy6TBS7PDYRLOMZ30iE3Y=;
        b=m0EkXge2NHZHTBiEIBu720vdlfOdmGev+aLGNetjKVmeeJBtcHaztiHAzT9DEfdyte
         9VlVtgsmcoYbICMRTdy5vrV/iLeV/vU8hNnqWhIksld/T8QeTuyuHYQELovZzxemM5SR
         FRLUZCMctfYPL27qqlO0I9vk4njrk6+HVpGewz3HTDSIzN3kYlMshh6ZgxOVGoSFGBpG
         GIw5uwi3vjX0D0J1qMdC1jtDHH2VB5EuyDZlK+xi/YtUEuwiFSQcwlNwW+dM/qA/Y17O
         g97ESQZBBMssND0vGBi6b7RhkD+5ae6lxZjryywENqNjsjFP/fukxKSkIXqQoKnnCjDb
         JmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5AXWR4TpQid/hNoRIKM4TMgy6TBS7PDYRLOMZ30iE3Y=;
        b=qwk/jnfF29oR6lbQEbTJf684dtYABoyezZqyJIkwiqsEc6/dYLezQ9T/K6W+g1ksfL
         Fv3ka2hh1t5DSDnWrghXbxpwylVDoLu88ILnhe04k1HdeDVylmJUenRw7jFVE/3ggkRn
         VJQuVDUCuQP3WakDJ/M7SknirQVDlD0yf8WVEO0BFSVgw0uCHAw7LUkdkT5r5Vp1vmOr
         m6YOvFdQXttZmy5qsO1/QnL/ycg54Qugm63k+OEStYBoFALyxr5xPC+PZ3LL3yWTKNJf
         /5Nxq5YjWND2VVC8T05Zml44Bq1E8rqgqWWFcN9gutMrgdyMLGF3jOpCCiPbdIw3J9NV
         dGOw==
X-Gm-Message-State: ACgBeo2Fn/y0JH+x0FABsuwTyI2HhW0fixgdlVgQStabYU5gLfdofOQ2
        hG2qdqOq4gEM5gpSbJrl4fU=
X-Google-Smtp-Source: AA6agR524STUpvZz6zOJZvL1bdxwiCFo8pCI8dMmc2ZA+xl5+SfDq2IASND7t5+tqSjN2d9V5jk55g==
X-Received: by 2002:a2e:93c8:0:b0:261:e5a7:56ed with SMTP id p8-20020a2e93c8000000b00261e5a756edmr2952397ljh.483.1661556788130;
        Fri, 26 Aug 2022 16:33:08 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id k10-20020a2eb74a000000b0025e42b981f9sm603578ljo.44.2022.08.26.16.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:33:07 -0700 (PDT)
Date:   Sat, 27 Aug 2022 02:33:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 10/11] spi: dw-apb-ssi: add generic 1.03a version
Message-ID: <20220826233305.5ugpukokzldum7y5@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-11-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-11-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:54PM +0100, Sudip Mukherjee wrote:
> From: Ben Dooks <ben.dooks@sifive.com>
> 
> Add new snps,dw-ssi-1.03a version to the bindings.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index 37c3c272407d..35aa04a85813 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -45,6 +45,7 @@ properties:
>          enum:
>            - snps,dw-apb-ssi
>            - snps,dwc-ssi-1.01a

> +          - snps,dwc-ssi-1.03a

Just add the "snps,dw-ahb-ssi" compatible string instead.

-Sergey

>        - description: Microsemi Ocelot/Jaguar2 SoC SPI Controller
>          items:
>            - enum:
> -- 
> 2.30.2
> 
