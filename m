Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3F5304CF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349322AbiEVRC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiEVRC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 13:02:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752233A19B;
        Sun, 22 May 2022 10:02:48 -0700 (PDT)
X-UUID: ed3bc3c69b0a480887db130046441547-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:1ddde99e-4e9c-490d-938c-8c5c580471b1,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:cbc11be3-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: ed3bc3c69b0a480887db130046441547-20220523
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1835310507; Mon, 23 May 2022 01:02:41 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 01:02:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 May 2022 01:02:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 23 May 2022 01:02:39 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <bgolaszewski@baylibre.com>, <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <ikjn@chromium.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <tinghan.shen@mediatek.com>, <weiyi.lu@mediatek.com>,
        <wenst@chromium.org>, <y.oudjana@protonmail.com>,
        <yassine.oudjana@gmail.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v2 4/4] clk: mediatek: Add drivers for MediaTek MT6735 main clock drivers
Date:   Mon, 23 May 2022 01:02:39 +0800
Message-ID: <20220522170239.18519-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <c7b98ee4-cd4f-d7b7-726d-1acd4fafd50a@collabora.com>
References: <c7b98ee4-cd4f-d7b7-726d-1acd4fafd50a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo, Yassine,

>>>
>>> I'd actually argue that macros make it less readable. While reading
>>> other drivers I had a lot of trouble figuring out which argument
>>> is which field of the struct, and had to constantly go back to the
>>> macro definitions and count arguments to find it. Having it this
>>> way, each value is labeled clearly with the field it's in. I think
>>> the tradeoff between line count and readability here is worth it.
>> 
>> It is easier for multiple developers to work together if we have a common style.
>> 
>> How do you think?
>> 
>
>In my opinion, Yassine is definitely right about this one: unrolling these macros
>will make the code more readable, even though this has the side effect of making
>it bigger in the source code form (obviously, when compiled, it's going to be the
>exact same size).
>
>I wouldn't mind getting this clock driver in without the usage of macros, as much
>as I wouldn't mind converting all of the existing drivers to open-code everything
>instead of using macros that you have to find in various headers... this practice
>was done in multiple drivers (clock or elsewhere), so I don't think that it would
>actually be a bad idea to do it here on MediaTek too, even though I'm not aware of
>any *rule* that may want us to do that: if you check across drivers/clk/*, there's
>a big split in how drivers are made, where some are using macros (davinci, renesas,
>samsung, sprd, etc), and some are not (bcm, sunxi-ng, qcom, tegra, versatile, etc),
>so it's really "do it as you wish"...
>

Thanks for the explanation and guide. I think we can do that for all MediaTek
clock driver in the future, not having two styles in MediaTek clock driver now.

>
>... *but:*
>
>Apart from that, I also don't think that it is a good idea to convert the other
>MTK clock drivers right now, as this would make the upstreaming of MediaTek clock
>drivers harder for some of the community in this moment... especially when we look
>at how many MTK SoCs are out there in the wild, and how many we have upstream:
>something like 10% of them, or less.

and thanks for considering this too.

>
>I see the huge benefit of having a bigger community around MediaTek platforms as
>that's beneficial to get a way better support and solidity for all SoCs as they
>are sharing the same drivers and same framework, and expanding the support to more
>of them will only make it better with highly valuable community contributions.
>
>
>That said, Yassine, you should've understood that you have my full support on
>unrolling these macros - but it's not time to do that yet: you definitely know
>that MediaTek clock drivers are going through a big cleanup phase which is, at
>this point, unavoidable... if we are able to get the aid of scripts (cocci and
>others), that will make our life easier in this cleanup, and will also make us
>able to perform the entire cleanup with less effort and in less overall time.
>
>With that, I'm sad but I have to support Miles' decision on this one, and I also
>have to ask you to use macros in this driver.
>
>
>I am sure - and it is my wish - to see MediaTek clock drivers open-coding stuff
>instead of using macros, but that's something for the future - which will happen
>after the more important cleanups.
>
>After all, it will be just about running "gcc -E xxxx.c" and copy-pasting the
>unrolled macros to the clock drivers, which will be pretty fast and straightforward.
>
>
>Sorry for the wall of text, by the way.

Sounds good and I want to say thank you again, I learned a lot from your post
and patches you submitted.

and I also want to say thank you to Yassine for the patch.

thanks,
Miles
>
>Cheers,
>Angelo
>
