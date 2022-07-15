Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0D575D90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiGOIeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiGOIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:34:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88A29C83;
        Fri, 15 Jul 2022 01:34:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D8E96601A3F;
        Fri, 15 Jul 2022 09:34:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657874052;
        bh=GqdfRsVfLCo2VWTEZGi7k9cm/HFoOJvuQH77gu2Dunk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KDykdN7WZCR7CkUpY6NB2K+XHNXANiCEgbnbDDyNtLQO+Qv9R7uewhqvy+GEBUG+m
         zF0dpvL03LKbH0xuWIZTe0YM9siRdZPpvMPwmXml/sWj7pZgzyVIuQ7LMKvzr4B1Gy
         +o2wih/tmqc/VMear4eT7zwT5JJsM+/JmLQ9l2wbJ2C6JaK46t85ICGq3y+thP4oij
         SdAhjQoblPVlXJr9gi1X5H2A5EVGDu54+XGwNL40UItP0cinnqzLoW3mY2pFCIT2WY
         KZ8u9J1TpPTDdnJrIliFzslcKliKjGlIerzie0waovd8PpYSPUVI+jpDOeMjc7lFya
         DDOQ6Kybdxq2Q==
Message-ID: <6d8aeee4-9732-1c62-67e0-6e8f56373aa6@collabora.com>
Date:   Fri, 15 Jul 2022 10:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND] media: mediatek: vcodec: Add to support VP9 inner racing
 mode
Content-Language: en-US
To:     Mingjia Zhang <mingjia.zhang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220715064938.5812-1-mingjia.zhang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220715064938.5812-1-mingjia.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/07/22 08:49, Mingjia Zhang ha scritto:
> In order to reduce decoder latency, enable VP9 inner racing mode.
> Send lat trans buffer information to core when trigger lat to work,
> need not to wait until lat decode done.
> 
> Signed-off-by: mingjia zhang <mingjia.zhang@mediatek.com>
> ---
> CTS/GTS test pass

CTS/GTS passing is a good indication but, please, test with GStreamer (and
show the output, as well!).

Thanks,
Angelo

> ---
>   .../vcodec/vdec/vdec_vp9_req_lat_if.c         | 64 ++++++++++++-------
>   1 file changed, 40 insertions(+), 24 deletions(-)
> 
