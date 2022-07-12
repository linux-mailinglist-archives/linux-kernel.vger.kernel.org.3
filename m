Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4C7571C78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiGLO0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiGLO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:26:25 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F6BB93C5;
        Tue, 12 Jul 2022 07:26:16 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id p128so7985408iof.1;
        Tue, 12 Jul 2022 07:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2smug+m1Lke8wFpPEM5ppWOdoo/9ROT7QK4c9TYtB6U=;
        b=0IF9BcxGXIoEh6yGwI13UQbu0z1sKuFoLkAjY7ezSfTk1Mh/6u2sCpNIBE8v/kv2WE
         y6k2I74rZL6VShto6O0Gy5/drgvX8XVy7lujFYPE4x+pq80FM/hAV6HC5jojItRmmtmB
         Lus3JKQVQUCu8RfphiCwBMAh5voOc2hRI4XEkdaKVnA+A9tUEV993NCB7S3gxpUdnDCF
         N78UdUjSWEc+IV34r66OKumwkgVP5GO2/MWFDIfkKpGz8V7hbKrZJsgihosXyFR+pDSu
         CBUtbgsSd6eB5mjeK+v7oGwsakp/phMxD3sQd5qBWGm6XNNRtPNQPO0sYCPNJSXT5m5g
         lGxg==
X-Gm-Message-State: AJIora8OnJpToZchLuM5l7sgDBfK8ppygZWQ9aF5p59vDJ2aC2NJ2Vvy
        tRQAtEX57DPanUoQ4l+L1Q==
X-Google-Smtp-Source: AGRyM1u9UVtNz1Lq5TBvtlHE6sfHP3e+TCv3kW8PIg+n1aqq/Z1DAjz9ef1ZYwzKBGpoy+zzrudY0Q==
X-Received: by 2002:a05:6638:2688:b0:33e:abf9:908d with SMTP id o8-20020a056638268800b0033eabf9908dmr13403331jat.166.1657635975713;
        Tue, 12 Jul 2022 07:26:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id ay2-20020a5d9d82000000b00678ea668a39sm5086524iob.36.2022.07.12.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:26:15 -0700 (PDT)
Received: (nullmailer pid 1805850 invoked by uid 1000);
        Tue, 12 Jul 2022 14:26:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-kernel@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        u.kleine-koenig@pengutronix.de,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
In-Reply-To: <20220712100113.569042-4-ben.dooks@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com> <20220712100113.569042-4-ben.dooks@sifive.com>
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Date:   Tue, 12 Jul 2022 08:26:12 -0600
Message-Id: <1657635972.108769.1805849.nullmailer@robh.at.kernel.org>
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

On Tue, 12 Jul 2022 11:01:09 +0100, Ben Dooks wrote:
> The dwc pwm controller can be used in non-PCI systems, so allow
> either platform or OF based probing.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-synposys.yaml | 40 ++++++++++++++
>  drivers/pwm/Kconfig                           |  5 +-
>  drivers/pwm/pwm-dwc.c                         | 53 +++++++++++++++++++
>  3 files changed, 96 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pwm/pwm-synposys.yaml:11:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
./Documentation/devicetree/bindings/pwm/pwm-synposys.yaml:31:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

