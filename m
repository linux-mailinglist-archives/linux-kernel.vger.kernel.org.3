Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C755DA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiF0MVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiF0MVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:21:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3763EBC22;
        Mon, 27 Jun 2022 05:21:36 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9B4436601692;
        Mon, 27 Jun 2022 13:21:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656332493;
        bh=ll0AAC70x8gIRC6X3Ln5rb75u7PNOK8G5e/4cbb1H7Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E5DvMsjZKeokPps3T1LLq3BO8IrN/6THedJeI7NQ4Y8RzSCr2oNpB9rZnTw9DtlBm
         hxNAzRT42jeBiiZ2Kn6OGjIJ1/1eAccJoMcR8RQ5RHq3CgyAiMLtnGtB4YkDL+2RgK
         LEluaH6g5rKybr06kpR5wfXEGHlC2/ME7o5LjYqTNdfP62TB9eNZa2AH4yU6ra0/66
         o28fiJDd4AR8MsuQ/zJgSI6eP9/ExbbQUbkNndMwiI1Yza+Mrr8RoOJCinBc3EPpxA
         6GnIHI1waCh9u58x86fvtYcvIr7dOQ2us6rxvFx7x9Y/6sF1rfclcUPUkzl95PZJTz
         w2jji8YwZvZhg==
Message-ID: <cc003570-31a6-61d8-1432-fb77d5f0f109@collabora.com>
Date:   Mon, 27 Jun 2022 14:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] Bluetooth: btmtksdio: Add in-band wakeup support
Content-Language: en-US
To:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yake Yang <yake.yang@mediatek.com>
References: <848d3d5baf23eb78411a9672b8973ae3c593db98.1656285304.git.objelf@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <848d3d5baf23eb78411a9672b8973ae3c593db98.1656285304.git.objelf@gmail.com>
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

Il 27/06/22 01:27, sean.wang@mediatek.com ha scritto:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Commit ce64b3e94919 ("Bluetooth: mt7921s: Support wake on bluetooth")
> adds the wake on bluethooth via a dedicated GPIO.
> 
> Extend the wake-on-bluetooth to use the SDIO DAT1 pin (in-band wakeup),
> when supported by the SDIO host driver.
> 
> Co-developed-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

