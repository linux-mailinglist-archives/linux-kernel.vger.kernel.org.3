Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114B7557684
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiFWJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiFWJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:22:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9833E4665D;
        Thu, 23 Jun 2022 02:22:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E77946601752;
        Thu, 23 Jun 2022 10:22:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655976128;
        bh=i/BTlmTsubNTSWq020jFczUKEvkkr5DvhZf1Py61tB0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=crODGwY+qCOyn3wMI8GsirBvApMarr1J4wwSSBxQWp2QB8OwUQBJHEXz52ZEL1JS2
         7lb48NzYCObcL5mNhda4L9JQjp9JA3KmVJYm+B4K6Ebb49q/e6x9b/L1YhMLOQhi+Z
         l21pCNuaknB7I/EBm8Th4pUogO4yZcKEHWD6lLe73dFu6HQrNc1e/M62vvLrpnsU9W
         a7GrwuxT0Xlv5hG+bxzI4gABYuQSsAsT3GdrcVgvbNbjGH3K41vKAQJa7RKJ4B+72O
         wIk5+oi/cT9y7CTdLDPtMlJfjw2FEAlbCQBRPtuTPlvP6gLuJosnp/RUqK8qKomXVf
         xDbnXbvWP9L/A==
Message-ID: <460046b1-44f7-e9db-6532-44cb06e4a242@collabora.com>
Date:   Thu, 23 Jun 2022 11:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] media: mediatek: vcodec: Skip SOURCE_CHANGE & EOS events
 for stateless
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Yunfei Dong <yunfei.dong@mediatek.com>
References: <20220620063349.2754116-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220620063349.2754116-1-wenst@chromium.org>
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

Il 20/06/22 08:33, Chen-Yu Tsai ha scritto:
> The stateless decoder API does not specify the usage of SOURCE_CHANGE
> and EOF events. These events are used by stateful decoders to signal
> changes in the bitstream. They do not make sense for stateless decoders.
> 
> Do not handle subscription for these two types of events for stateless
> decoder instances. This fixes the last v4l2-compliance error:
> 
> Control ioctls:
> 		fail: v4l2-test-controls.cpp(946): have_source_change || have_eos
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: FAIL
> 
> Fixes: 8cdc3794b2e3 ("media: mtk-vcodec: vdec: support stateless API")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
