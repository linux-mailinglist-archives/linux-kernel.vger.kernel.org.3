Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A64B67DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbiBOJlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:41:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiBOJlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:41:36 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890C92608;
        Tue, 15 Feb 2022 01:41:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 399F71F424E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644918083;
        bh=yq8iJBJC4x3GV++oabST32A8rclogMDfHMgxC/dI6Yk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bJPM+pbQ2xVrL8VVd8LmIbEPyp0Lpi/YQCkn68h72V1EcuKipsmZsB+E4h2GLgPnR
         F1pnpIK5gYzRDOsVv8RUB8tC7BdroPQ0Hlro8BdXYxX4KjHnq3V06s+D51yp09xsCU
         vXR4BUZKXCojHE8TUc+w2nXHJRE1ku174kHK6TMkBgONYMuZW0GF1z0AKBUNZzs7mg
         NrlEMtfjzC2prSETr+0GKJtYOJ6tiPCk8tR+84W/nem1LRGuAILxr4V7L65ecbiaHE
         mMLIhUi9o4X7hog9f5OWjIqQKZ7B5m06IHyZIFWA1Z9HME2mjt6Ilkpu0dPLQuyCe/
         S2W2AEDvnf7Lg==
Message-ID: <15a24b12-e296-9d4e-211f-55553ac8f7da@collabora.com>
Date:   Tue, 15 Feb 2022 10:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4] media: mtk-vpu: Ensure alignment of 8 for DTCM buffer
Content-Language: en-US
To:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Courbot <acourbot@chromium.org>, kernel@collabora.com,
        dafna3@gmail.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, minghsiu.tsai@mediatek.com,
        houlong.wei@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, hverkuil@xs4all.nl
References: <20210920170408.1561-1-dafna.hirschfeld@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210920170408.1561-1-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/09/21 19:04, Dafna Hirschfeld ha scritto:
> From: Alexandre Courbot <acourbot@chromium.org>
> 
> When running memcpy_toio:
> memcpy_toio(send_obj->share_buf, buf, len);
> it was found that errors appear if len is not a multiple of 8:
> 
> [58.350841] mtk-mdp 14001000.rdma: processing failed: -22
> 
> This patch ensures the copy of a multiple of 8 size by calling
> round_up(len, 8) when copying
> 
> Fixes: e6599adfad30 ("media: mtk-vpu: avoid unaligned access to DTCM buffer.")
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

I acknowledge that this patch is getting very old and stale, but after some
testing on MT8173, we were able to verify that it is essential for MediaTek MDP
functionality, along with some other patches.

Without this one, it won't work.

Keeping this in mind, I would propose to get this one picked before it gets
completely stale and requiring a rewrite.

Cheers,
Angelo
