Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8746BE5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhLGPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:01:44 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41571 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbhLGPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:01:43 -0500
Received: by mail-ot1-f50.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so18359900otl.8;
        Tue, 07 Dec 2021 06:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=VgYpRv7FKDRFJkyswgOt8jfkEjY4KcUU5jFAaY5SUrw=;
        b=PxwlrWpgDFax7uetBT41rigifwzYiPf/J+9SMS0yE7eaAyMKJw3ZnevfVC03iSPzCd
         wlU0AY81Z6Y+xQpaGcPySxJDDh8oIW6oJT3JWG41QOfAIqDIZrE8OGkpj7MSZrkRmfee
         1XKHfdAEip2+p9CFClbeTnG/4jGHKoZea8oiuGoWa8cPk4TTMn8LWEyReYF+6QEzceA9
         26Il/RgH/kkxkCm2PFBMJmOlyVoDSUXC4MWv272U1NFyK6HjpnUdZ6VvgrrskXwb0sOl
         75AXKwKiTRsfiNhZGInp2+y0q3eTFZQyeR0cVxLRQ4/DyVRHfKZ/JUi302+0XEtDVQ1x
         RH1A==
X-Gm-Message-State: AOAM531Fhfkr5J9ddiflZt2yVc2Yo+HticnVAb/umnOX7Gz/XbuVOKbr
        OpEq0R9xR/uVMrBPMQskpw==
X-Google-Smtp-Source: ABdhPJxI+GdBHmtxK/QcTh3tcIy1ZwNfkubLUnPPWtqNhLRymXjSM4MMyk6de2SMgFGNU+/WHw79vA==
X-Received: by 2002:a9d:4f0b:: with SMTP id d11mr35759185otl.227.1638889092708;
        Tue, 07 Dec 2021 06:58:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m2sm2815394oop.12.2021.12.07.06.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:58:11 -0800 (PST)
Received: (nullmailer pid 5797 invoked by uid 1000);
        Tue, 07 Dec 2021 14:58:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-media@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, benjamin.gaignard@collabora.com,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hverkuil@xs4all.nl, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, cphealy@gmail.com
In-Reply-To: <20211207015446.1250854-4-aford173@gmail.com>
References: <20211207015446.1250854-1-aford173@gmail.com> <20211207015446.1250854-4-aford173@gmail.com>
Subject: Re: [RFC V2 3/6] dt-bindings: media: nxp,imx8mq-vpu: Update the bindings for G2 support
Date:   Tue, 07 Dec 2021 08:58:10 -0600
Message-Id: <1638889090.684232.5796.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 19:54:42 -0600, Adam Ford wrote:
> From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> 
> Introducing the G2 hevc video decoder requires modifications of the bindings to allow
> one node per VPU.
> 
> VPUs share one hardware control block which is provided as a phandle on
> a syscon.
> Each node has now one reg and one interrupt.
> Add a compatible for G2 hardware block: nxp,imx8mq-vpu-g2.
> 
> To be compatible with older DT the driver is still capable to use the 'ctrl'
> reg-name even if it is deprecated now.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml: properties:clock-names:oneOf: [{'const': 'g1'}, {'const': 'g2'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml: properties:interrupt-names:oneOf: [{'const': 'g1'}, {'const': 'g2'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml: properties:compatible:oneOf: [{'const': 'nxp,imx8mq-vpu-g1'}, {'const': 'nxp,imx8mq-vpu-g2'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml: ignoring, error in schema: properties: interrupt-names: oneOf
warning: no schema found in file: ./Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
Error: Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.example.dts:26.27-31 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1564457

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

