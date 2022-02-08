Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15C4AD79C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357656AbiBHLgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357021AbiBHLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:19:11 -0500
X-Greylist: delayed 91127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 03:19:10 PST
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7CAC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:19:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E6A291F40DB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644319148;
        bh=YZ4vl5dn4dGgAIbf9dSevrTrJvjW1muxZxlPq1Ez3H0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b+B+WOsCW8uf+hliLI9pK0Q1jfdIXl1UAKsX71b6kncuJjnC5hvbygSy89Hfgo3Kb
         DgJr53dAhlbPw1H/rO/I6EE1HDAV00+aUr8DqygFT4eSkvxv3VEBv0+jAPkAVarl+z
         xAmoAykC6HzAsh3t3MET8KvQNTFjUVXYYSVKm5aFdlnVqngWNmYWj6I7Y0qa0jw3Gk
         YgAohlu4E3ubs0lMjbJ9eW3Tt5f0WcWMhlo+kbDtdA03rBc8lMreQnxEhQLPJ1H6o4
         SB3cZnH5wBJ/AlsVysgzXiJSbqk6Pbnc36Ia7CTAd375DumCoVIJm0gE4/s7/QZLYM
         JdkLaHYo21Jxw==
Message-ID: <95383ff1-2696-6dac-26ab-1239b5323c8c@collabora.com>
Date:   Tue, 8 Feb 2022 12:19:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 15/31] clk: mediatek: Implement
 mtk_clk_unregister_fixed_clks() API
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-16-wenst@chromium.org>
 <752d5d00-4e05-1bd6-564f-3bce21a35713@collabora.com>
 <CAGXv+5HSLh0OgJc=EU=wvB4DaOMDLjsgJ6qnHY423d1L5+DixQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5HSLh0OgJc=EU=wvB4DaOMDLjsgJ6qnHY423d1L5+DixQ@mail.gmail.com>
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

Il 08/02/22 04:50, Chen-Yu Tsai ha scritto:
> Hi,
> 
> On Thu, Feb 3, 2022 at 5:47 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
>>> mtk_clk_register_fixed_clks(), as the name suggests, is used to register
>>> a given list of fixed rate clks. However it is lacking a counterpart
>>> unregister API.
>>>
>>> Implement said unregister API so that the various clock platform drivers
>>> can utilize it to do proper unregistration, cleanup and removal.
>>>
>>> In the header file, the register function's declaration is also
>>> reformatted to fit code style guidelines.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
>>
>> Hello Chen-Yu,
>>
>> I like this entire series, but I had to manually apply this patch (and some of
>> the other ones)...
> 
> This was based on linux-next, which already has a couple clk patches queued
> up.
> 
>> Especially for the ones that will be touching MT8195 clock drivers, can you
>> please rebase over series [1] by Chun-Jie?
> 
> I think this series supersedes the first patch in that series? As for the
> other two, I think the discussion about the bindings is ongoing, which
> might affect the third patch as well?

You're right about that - besides, the mentioned series will take a bit of time to
get merged in and this cleanup should not be waiting for all that time, as it's
very, very nice...
In any case, I don't think that the third patch from that series will be affected,
as it's a double-definition instance: the vppsys{0,1} are really defined in mmsys
and they're simply moving it around... The committer forgot to add the two
properties (the ones that he removed from mt8195-clock) to mediatek,mmsys.yaml,
I'll send a reply over that thread.

Anyway, yes, this series definitely supersedes patch 1 in that series, so,
I'm sorry for the noise, and:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> ChenYu
> 
>> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=603955
>>
>> Thanks,
>> Angelo
>>



