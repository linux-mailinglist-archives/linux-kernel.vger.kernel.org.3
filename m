Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19997507171
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345122AbiDSPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiDSPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:11:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD653A721;
        Tue, 19 Apr 2022 08:08:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AC9801F4267B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650380899;
        bh=wE87yBeheg5nImXJNHE8hDnX7SEP4mrWfxluB9Rr99Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iAOE9Sv0da11Nw5ZlOwrnD+04YO8d9pRVEOtAeTuuCzELSb0e7r/+3sVXylYRdLNQ
         2YbLQXFNhKthcsABt5iOFOH1mk+ZXJZAwIjWnWJs41gl6KEW2zt11XwvpnCSeqSdb4
         lz7nKBrFFdFl5zTztschsp8IA7iYk+v7jynLoRJYRdDxiDbMbXoK+u7MqAux3e4T1p
         VpAEml7dKCrm4ljeWeXPvYHHZq/cE/Mqo3kxN5m4EXoFNbSmB8soa7F+L76TUbdpEW
         6/PyKOYJq4yZVcSd4tK9Npksy0IzurV1FRNS0ibppcHt6wvZXZQ7eUOHQbv+fFAMka
         lb1JTfaq6WZ4Q==
Message-ID: <3591fcc1-d34a-b40a-4e78-edcf9d2ddf08@collabora.com>
Date:   Tue, 19 Apr 2022 17:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/7] clk: mediatek: Move to struct clk_hw provider
 APIs
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220419081246.2546159-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220419081246.2546159-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/04/22 10:12, Chen-Yu Tsai ha scritto:
> Hi everyone,
> 
> This is part 2 of my proposed MediaTek clk driver cleanup work [1].
> 

..snip..

> 
> The next phase of the cleanup/improvement shall be to introduce some
> variant of `struct clk_parent_data` to describe clk relationships
> efficiently.
> 
> Please have a look.
> 

Hello Chen-Yu,

I am grateful to see this series, as the MediaTek clock drivers are getting
a bit old, despite new platforms being implemented practically as we speak.

With this, you surely get that I completely agree with the proposed cleanup
and modernization of the entire MediaTek clocks infrastructure, but I think
that introducing a `struct clk_parent_data` for these drivers is, at this
point, a must, that not only fully justifies these patches, but also "makes
the point" - as the effect of that would be a performance improvement as we
would *at least* avoid lots of clk_cpy_name() in case of parent_hws, or in
case or parent_data where no .fw_name is provided (which would be the case
for most of the clocks).

That said, my advice would be to add that conversion to declaring clocks
with .hw.init.parent_data and/or .hw.init.parent_hws to this series as to
really make it complete.

Of course, if you have concerns about old platforms that you cannot test,
or for which this kind of conversion would require a huge amount of effort,
then I would go for converting as many as possible as a first step and then
leave the others for later.

I would envision MT8183, 8186, 8192, 8195 to be a good amount of first
candidates for this great effort.

Cheers,
Angelo
