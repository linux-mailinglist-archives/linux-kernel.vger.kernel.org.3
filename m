Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257F25172B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiEBPhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385863AbiEBPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:37:10 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48224BC22;
        Mon,  2 May 2022 08:33:38 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso9933172otf.12;
        Mon, 02 May 2022 08:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=SDazvwLtmD7iGR4/3qNdCTkP7LG5uBpWcYwGTxEc+2A=;
        b=YHD5arfSvMRSB5p0CPCUeYNVppo5Nu6v8jeC/A90CUU19OiT4GKPjQZOaDjvdKvN6O
         XU1DgiyS1pfiNGkSL4Ig0FvrI+1n0ccerzfljteYxsW4EJnVSPapnFhCrIX+ooB2K3Le
         Os9TuT6fGT6GBi59AAehLq2p3cafT+wHMKKIIxyMdLGiL3mqvb4iyjUwcKp1Zr+/27ci
         2K5jcMAtXGjrwKkpHE8BjeRtJi0v9nOj7x2r9Uc2eueMoOoMCqlkG3TIw+CpMXng9IAs
         IUgWnOTnOvV07bzaKHlmqgVM2+/15HKwy2rJXidc4dieUf22WtNpo7S56taVVRI8ZDDu
         9Crw==
X-Gm-Message-State: AOAM530uX1bk8lScoSsS4hHJ45DyZ0Qm9mg0d7Q+OnbaxuEu6/7ex+lH
        recJ2vNGPZZLKgNm6VSaKg==
X-Google-Smtp-Source: ABdhPJyxhjWaL+KKrChyj8rFPZzTPAip2KUS5CJwmjTl5l+jgv7N6SL8bT0V7zetu7j4JXX4QkkOKg==
X-Received: by 2002:a9d:491c:0:b0:605:c207:1f6b with SMTP id e28-20020a9d491c000000b00605c2071f6bmr4416443otf.41.1651505617521;
        Mon, 02 May 2022 08:33:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a11-20020a4a9b0b000000b0035ec65ac944sm3482696ook.16.2022.05.02.08.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 08:33:37 -0700 (PDT)
Received: (nullmailer pid 1161769 invoked by uid 1000);
        Mon, 02 May 2022 15:33:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     Joel Stanley <joel@jms.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-kernel@vger.kernel.org, Tao Ren <rentao.bupt@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
In-Reply-To: <20220502081341.203369-3-clg@kaod.org>
References: <20220502081341.203369-1-clg@kaod.org> <20220502081341.203369-3-clg@kaod.org>
Subject: Re: [PATCH v5 02/11] dt-bindings: spi: Add Aspeed SMC controllers device tree binding
Date:   Mon, 02 May 2022 10:33:29 -0500
Message-Id: <1651505609.452113.1161768.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 May 2022 10:13:32 +0200, Cédric Le Goater wrote:
> The "interrupt" property is optional because it is only necessary for
> controllers supporting DMAs (Not implemented yet in the new driver).
> 
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Tested-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Tao Ren <rentao.bupt@gmail.com>
> Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      | 82 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml:62:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 52, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 49, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 62, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml:  while scanning a block scalar
  in "<unicode string>", line 49, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 62, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml: ignoring, error parsing file
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

