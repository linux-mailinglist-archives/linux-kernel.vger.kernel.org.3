Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592FC5236AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiEKPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbiEKPEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:04:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99443CA4C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:04:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E7E401F43201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652281491;
        bh=mxWYOQgLw0CZGqfrBC0Eg5W6UfeqjHZIz/sEb1ggWik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Nxg/uwf/s7WPIv/mqp+jozD5PuYhmwbINGe5FRHRMxcP+KnVQNuJ3QzDTmviaDqqD
         qZx70JQLfTCc50DGrfLbfKAYRvjxUYlbI/SEE8s/nozlS5wO0O5+XNbQ4bA5SSOaTD
         Q9GQImxwPwHWPGK1b06syFI0xnwdQXv/oL3a6L5AGGKAyPDdHMxjpuzsPUuFB1R5T7
         6ZkaZILgBzQ87402zUxydp0SeXVMLNhpLaD8WGzlyZjtyT7dLyyEjUrCP1lHaGKvUB
         NJsDUCEe30J1S2UxJYlmIOA3sras6Q/yAMH8KN2O1vIqtBmzd9vc8x047FqS9Y50q4
         8j4pmm5l5Ktbg==
Message-ID: <20f078a8-f050-127f-b720-b5fc8c893c9c@collabora.com>
Date:   Wed, 11 May 2022 17:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5, 4/5] drm/mediatek: keep dsi as LP00 before dcs cmds
 transfer
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        rex-bc.chen@mediatek.com, jitao.shi@mediatek.com
References: <1652236596-21648-1-git-send-email-xinlei.lee@mediatek.com>
 <1652236596-21648-5-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1652236596-21648-5-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/05/22 04:36, xinlei.lee@mediatek.com ha scritto:
> From: Jitao Shi <jitao.shi@mediatek.com>
> 
> To comply with the panel sequence, hold the mipi signal to LP00 before the dcs cmds transmission,
> and pull the mipi signal high from LP00 to LP11 until the start of the dcs cmds transmission.
> The normal panel timing is :
> (1) pp1800 DC pull up
> (2) avdd & avee AC pull high
> (3) lcm_reset pull high -> pull low -> pull high
> (4) Pull MIPI signal high (LP11) -> initial code -> send video data(HS mode)
> The power-off sequence is reversed.
> If dsi is not in cmd mode, then dsi will pull the mipi signal high in the mtk_output_dsi_enable function.
> The delay in lane_ready func is the reaction time of dsi_rx after pulling up the mipi signal.
> 
> Fixes: 2dd8075d2185 ("drm/mediatek: mtk_dsi: Use the drm_panel_bridge API")
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

