Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD965821C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiG0IHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiG0IG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:06:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E44C43E6C;
        Wed, 27 Jul 2022 01:06:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A8A536601ABE;
        Wed, 27 Jul 2022 09:06:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658909211;
        bh=RAzqICOW9S1oGl5H8d7L9/J1u1cDZH2ud8LNYQY1T3M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WrVrHpB4r9Rg8ui6n1LNe1Z4aVrjsI8phcDQTTuMVB/RMeashds0PTWh1HiPCQRId
         czTMc5B5HATboRK45fyVBpH+eZXbfJDIBJs87/uNXlp8y2C3vDJN5tWycVdOP6Y+pR
         NoPv1Wx/t30Q2WFWLW34pqv6Llq2co6UmLfpHaGOtU4nxaYvhB4FoLIGCF1O8v02K0
         igcHQEoObnRB5K9M9kKMzUt+bIMrqgRXq8+cg2nj/nGsdnaUovEXBPSwXEhe4pNuLW
         gBzpL+/BO1wbcxsSZ4BHaSLl5cgxdS3mGS3LGwpXbaEsq1wa4oqiuOE+K6IebX/NDS
         Odhulc7hKDdvQ==
Message-ID: <826821ae-432b-f4cc-6b38-16be881213e6@collabora.com>
Date:   Wed, 27 Jul 2022 10:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH, v2] media: mediatek: vcodec: Add to support VP9 inner
 racing mode
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
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220727061310.2307-1-mingjia.zhang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220727061310.2307-1-mingjia.zhang@mediatek.com>
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

Il 27/07/22 08:13, Mingjia Zhang ha scritto:
> In order to reduce decoder latency, enable VP9 inner racing mode.
> Send lat trans buffer information to core when trigger lat to work,
> need not to wait until lat decode done.
> 
> Signed-off-by: mingjia zhang <mingjia.zhang@mediatek.com>

For MT8195:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
