Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B109C4E1F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 05:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbiCUESp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiCUESo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:18:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E988F11434B;
        Sun, 20 Mar 2022 21:17:18 -0700 (PDT)
X-UUID: cad40b1b56664c3eb99f8211ddf061ee-20220321
X-UUID: cad40b1b56664c3eb99f8211ddf061ee-20220321
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 132751500; Mon, 21 Mar 2022 12:17:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 21 Mar 2022 12:17:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Mar 2022 12:17:15 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <robh@kernel.org>
CC:     <adrian.hunter@intel.com>, <andrew@aj.id.au>,
        <andriy.shevchenko@linux.intel.com>,
        <angelogioacchino.delregno@collabora.com>, <axe.yang@mediatek.com>,
        <chaotian.jing@mediatek.com>, <dev@lynxeye.de>,
        <devicetree@vger.kernel.org>, <ebiggers@google.com>,
        <huyue2@yulong.com>, <kwmad.kim@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <satyat@google.com>, <swboyd@chromium.org>,
        <tiantao6@hisilicon.com>, <ulf.hansson@linaro.org>,
        <wsa+renesas@sang-engineering.com>,
        <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RESEND v7 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and pinctrls properties
Date:   Mon, 21 Mar 2022 12:17:15 +0800
Message-ID: <20220321041715.8424-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1647742413.962309.2990518.nullmailer@robh.at.kernel.org>
References: <1647742413.962309.2990518.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

>My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
>yamllint warnings/errors:
>
>dtschema/dtc warnings/errors:
>/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/mtk-sd.yaml: properties:pinctrl-names: {'description': 'Should at least contain default and state_uhs. To support SDIO in-band wakeup, dat1 pin will be switched between GPIO mode and SDIO DAT1 mode, state_eint and state_dat1 are mandatory in this scenarios.', 'minItems': 2, 'maxItems': 4, 'items': [{'const': 'default'}, {'const': 'state_uhs'}, {'const': 'state_eint'}, {'const': 'state_dat1'}]} should not be valid under {'required': ['maxItems']}
>	hint: "maxItems" is not needed with an "items" list
>	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
>/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/mtk-sd.yaml: ignoring, error in schema: properties: pinctrl-names
>Documentation/devicetree/bindings/mmc/mtk-sd.example.dt.yaml:0:0: /example-0/mmc@11230000: failed to match any schema with compatible: ['mediatek,mt8173-mmc']
>
>doc reference errors (make refcheckdocs):
>
>See https://patchwork.ozlabs.org/patch/1606491
>
>This check can fail if there are any dependencies. The base for a patch
>series is generally the most recent rc1.
>
>If you already ran 'make dt_binding_check' and didn't see the above
>error(s), then make sure 'yamllint' is installed and dt-schema is up to
>date:
>
>pip3 install dtschema --upgrade
>
>Please check and re-submit.

Thanks for this check.

When I use 'make DT_CHECKER_FLAGS=-m dt_binding_check' on this patch,
the warning message does show up but the 'make DT_CHECKER_FLAGS=-m dt_binding_check'
does not exit, so I am not able to tell if any error occurs by the exit value.

Would you mind sharing the way your bot capture this error? (Do I have to grep 'error'
from the log or is there any warning-as-error flags?)

Thanks,
Miles
