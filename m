Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67401509BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387343AbiDUJLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387331AbiDUJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5581B22BD9;
        Thu, 21 Apr 2022 02:07:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 649651F45275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650532078;
        bh=q7E0XYrULEygpCoWTbaEgauMlG2r6aEoMPACx1vJZxI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oIE5TBnrzrghqjpm4TSR7PTB7dNpeBWr/7Q3Ecj72RH+o3zHcPL58jnTXHnQ1RIXA
         s03A8H/qYgLvjQ4nxquXduNnxKevOwn2KSOJlO9WuEkLSNvYlGN7kdHVq5c8AI3Xv7
         7wmHlJkTV1uKNWG1+Fs/0dia/jYVf6f9PfBgkxi/mfc8EhCy20eZ2OA497lmh6fkfZ
         XIGfVQV3c6lW43W2jwBjw/lkffjipZ5tB4EwMVa34mV64fBoXUmz6ZA3fHvGNPoI0s
         pfKHq77r3dPGun57eNVlM7jiBrR4ElloWCAUxJrACpMBxQ1YwVGucF9btcoLJS57L5
         xtQ/jmhwHEcGA==
Message-ID: <90ad46a5-8b67-e9ca-25df-2a7cc6110bff@collabora.com>
Date:   Thu, 21 Apr 2022 11:07:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 05/12] clk: mediatek: reset: Add reset.h
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
 <20220420130527.23200-6-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220420130527.23200-6-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> Add a new file "reset.h" to place some definitions for clock reset.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Right now, you're adding the enum mtk_reset_version and *then* you're
moving it to the new reset.h header, but does that really make sense?

I think that this series would be cleaner if you add this header from
the start, so that you place the aforementioned enumeration directly
in here...

...so we would have a commit that moves the mtk_clk_register_rst_ctrl()
function from clk-mtk.h to a newly created reset.h, mentioning in the
commit description that it's all about preparing for a coming cleanup,
then the addition of enum mtk_reset_version would be in
`clk: mediatek: reset: Merge and revise reset register function` directly
into reset.h.

Does that sound right to you?

Cheers,
Angelo

