Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9293156FEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiGKKSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiGKKRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:17:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27FC3AC8;
        Mon, 11 Jul 2022 02:35:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 80BD9660198A;
        Mon, 11 Jul 2022 10:35:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657532139;
        bh=/pQoU97yz4hZOWkwVcb+ZiFvDCPudO0glpdakIglu9E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XbfSfqC0d0/CMCSy7PwUC1BrVijSWccHQPgI3Y1V8LRbLeDl/OQqQX9CSfEyeFQ7R
         cBjNSizYFLsaWfhZwHFxuSZvKl8h1AVRnryTXxkgQ5H2DBwnyG6vM0W9L3EQnrspjC
         SGYnFpmSBVfaQ/Uw30Rwm1A+eibVa0GE5befebxfFpi+QPbyZjpbSY09LtVoFjqYLx
         MoVdNQc6leAw68bgo1aFgWd5gU3bz2dM4vwaHjyO10XXyFFX4LyUEtTMQ737TC+D0J
         hVIuzRXAvi8j1HG/wr6k8vhSS5bcR5Xb/IaKa3OVPWtYCoueU8Mu0SgHQ1OgZl/tHo
         7EQVKKZjJ6myg==
Message-ID: <c0904c83-d264-41a7-3a3e-4253dfc36004@collabora.com>
Date:   Mon, 11 Jul 2022 11:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Revert "dt-bindings: usb: mtk-xhci: Make all clocks
 required"
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
References: <20220708192605.43351-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220708192605.43351-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/07/22 21:26, Nícolas F. R. A. Prado ha scritto:
> This reverts commit ebc4969ae125e65fdb563f66f4bfa7aec95f7eb4. That
> commit was supposed to make the binding better reflect the MediaTek XHCI
> hardware block by requiring all clocks to be present. But doing that
> also causes too much noise in the devicetrees, since it requires
> updating old MediaTek DTs to add clock handles for the fixed clocks, and
> going forward every new clock added to the binding would require even
> more updates.
> 
> The commit also didn't update the example to match the changes, causing
> additional warnings.
> 
> Instead let's keep the clocks optional so that old devicetrees can keep
> omitting the fixed clocks, and we'll just add the clocks as required on
> new DTs.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

