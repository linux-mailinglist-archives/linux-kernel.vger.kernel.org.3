Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB3562D79
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiGAIJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiGAIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:09:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C43C6EEB4;
        Fri,  1 Jul 2022 01:09:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 771496601974;
        Fri,  1 Jul 2022 09:09:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656662960;
        bh=OnFylUH2bK/KrG2ZmFByKOKEh30FKZwSBlJiuozSLKQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n1By2XTMBpyLE712pO39G21v6KPnYPSxK8Ci78ltdQBTlMSGIB8++E15d6TIyv7La
         L+5Wb90IqNQkZc2Vw1U5DnqpRkAuT6j7Y9kqE+iK5z13Jw3bcR4w3sAPOUCJcqu/o7
         MbwJUaUuI2P7eU/cvIR69YAJ7nG8ONHu56NrjOn1YTZZz4GjINxeUOB2bUYHx8VvEo
         dsGNmC+phe7Z+muDvuwcUD9ISfg6Uuvgv0bjSfnAM3ICZfdqZIYymEae/b7Yychlta
         6MCPz7DB0XfSwzGAUj7YTFRBHpGRmOO7c1fUTpZzOv8M19USxn3YJnbwUUIRIoet2h
         +xv1bry65eB/A==
Message-ID: <145d79cf-5328-7c99-3d49-d5e9eab3891c@collabora.com>
Date:   Fri, 1 Jul 2022 10:09:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v13 05/10] drm/mediatek: Add MT8195 Embedded DisplayPort
 driver
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie
Cc:     msp@baylibre.com, granquet@baylibre.com, jitao.shi@mediatek.com,
        wenst@chromium.org, ck.hu@mediatek.com, liangxu.xu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220701062808.18596-1-rex-bc.chen@mediatek.com>
 <20220701062808.18596-6-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220701062808.18596-6-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/07/22 08:28, Bo-Chen Chen ha scritto:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This patch adds a embedded displayport driver for the MediaTek mt8195 SoC.
> 
> It supports the MT8195, the embedded DisplayPort units. It offers
> DisplayPort 1.4 with up to 4 lanes.
> 
> The driver creates a child device for the phy. The child device will
> never exist without the parent being active. As they are sharing a
> register range, the parent passes a regmap pointer to the child so that
> both can work with the same register range. The phy driver sets device
> data that is read by the parent to get the phy device that can be used
> to control the phy properties.
> 
> This driver is based on an initial version by
> Jitao shi <jitao.shi@mediatek.com>
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

