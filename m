Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B9F4BD3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiBUCgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:36:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbiBUCgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:36:42 -0500
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6023DDE0;
        Sun, 20 Feb 2022 18:36:20 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id d7so8971257ilf.8;
        Sun, 20 Feb 2022 18:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=uAgMNJsD7INE5dFmY8Xlz21D6qpjVxGcjpghogIYeNY=;
        b=sOpYOQyHf7d0eMc1NkGUQPVFs1kcE58fYg77G4AUz2TC/opa23FMEnjdLWSIYcYnlk
         nlcgNpJmDyGBhKltoPZy3ggzyggXMtFAzDO4O3zwh1jQRnV3gdZnZsETa0iWUtT6uEwt
         IkPyICIcFjV0V3LxXGB0koFMClhKqO5IWVEhd6AHCp8OFwlPtye56+990I2A7rsqGJwV
         91A7gKB4oicIrcyMrl3WS6s/qtS+7L7wNw5C3VjaPJ8xw0bm3b5xGZ1jC8YSYqiqi2zM
         dJDsp2iyW0Td85p6AGsQrpcjgXYUq6GsluPahUqzdwaRkQ1Tkf3jxXdagmE5ogcGlar4
         AMUA==
X-Gm-Message-State: AOAM532bf00PPNkIyrbgZ7l1GgQjmRzZxY4VQ3vkevEMlHcuImagbXY/
        tODgpMZMrdVPuVB2ncg/KQ==
X-Google-Smtp-Source: ABdhPJz2DfaQWNzJPUw3IqWnC9QhQKn66unhRPcWMPIvrixApoeelkVT8Tp/miCfwnh3IxQWexkAKA==
X-Received: by 2002:a92:ca0a:0:b0:2b7:bca5:63df with SMTP id j10-20020a92ca0a000000b002b7bca563dfmr14222447ils.232.1645410979730;
        Sun, 20 Feb 2022 18:36:19 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id e5sm7232198ilq.9.2022.02.20.18.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:36:19 -0800 (PST)
Received: (nullmailer pid 2041551 invoked by uid 1000);
        Mon, 21 Feb 2022 02:36:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20220220173905.14165-2-ansuelsmth@gmail.com>
References: <20220220173905.14165-1-ansuelsmth@gmail.com> <20220220173905.14165-2-ansuelsmth@gmail.com>
Subject: Re: [RFC RFT PATCH v2 1/2] dt-bindings: mtd: partitions: Document new partition-dynamic nodes
Date:   Sun, 20 Feb 2022 20:36:09 -0600
Message-Id: <1645410969.414517.2041550.nullmailer@robh.at.kernel.org>
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

On Sun, 20 Feb 2022 18:39:04 +0100, Ansuel Smith wrote:
> Document new partition-dynamic nodes used to provide an OF node for
> partition registred at runtime by parsers. This is required for nvmem
> system to declare and detect nvmem-cells.
> 
> With these special partitions, only the label is required as the parser
> will provide reg and offset of the mtd. NVMEM will use the data from the
> parser and provide the NVMEM cells declared in the DTS, "connecting" the
> dynamic partition with a static declaration of cells in them.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../mtd/partitions/partition-dynamic.yaml     | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.example.dt.yaml: partitions: '#address-cells', '#size-cells', 'art' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1595230

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

