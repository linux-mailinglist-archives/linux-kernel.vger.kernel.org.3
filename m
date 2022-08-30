Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18705A5FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiH3JqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiH3JqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:46:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF54192BC;
        Tue, 30 Aug 2022 02:46:10 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A63706601BF7;
        Tue, 30 Aug 2022 10:46:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661852769;
        bh=7NH/EXIiW5hWC5H9t9DQGyotstr4olgJLQgNTwzp/C0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ymye1lGrfdxigfShYYUIVvi7r95fDUhK4e4974B4iDYIAiBYxLglwM5Zx1JIudhh+
         qQd/kHqwWlthmJw7ljMkC9gtLSrrsTTWibJXUYf7yt8lwVx9bWVpkd1EAQshrwriHd
         upLDiDialsAl6zeY55Ca0LUoZtAwThFnWI48VEPIFQvVh1byuX5q6TqABk3d+0R2PV
         iJK1GEZ4Dpi26jWfpb7vHP/jWW26kAPm1aueWLW0rL8F3m1pXXF2OA5EQpF9eOYmRT
         L2hkp92qrECr6k7PggheYYrl19Vw1DtRcI5EXHRU78ZXVGPlz3zyBh8hQB1l+uf57s
         lJdiuUgwhJg2A==
Message-ID: <cb85942d-1f41-ee8c-c777-0c47336fb36c@collabora.com>
Date:   Tue, 30 Aug 2022 11:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] spi: mt7621: Use the devm_clk_get_enabled() helper to
 simplify error handling
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        broonie@kernel.org, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, neil@brown.name, blogic@openwrt.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
 <05a7fd22719008c8a905d6328aa9548ce40f2a7a.1661599671.git.christophe.jaillet@wanadoo.fr>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <05a7fd22719008c8a905d6328aa9548ce40f2a7a.1661599671.git.christophe.jaillet@wanadoo.fr>
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

Il 27/08/22 13:42, Christophe JAILLET ha scritto:
> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This helper is well suited for cases where the clock would be kept
> prepared or enabled for the whole lifetime of the driver.
> 
> This simplifies the error handling a lot.
> 
> The order between spi_unregister_controller() (in the remove function) and
> the clk_disable_unprepare() (now handle by a  managed resource) is kept
> the same.
> (see commit 46b5c4fb87ce ("spi: mt7621: Don't leak SPI master in probe
> error path") to see why it matters)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

