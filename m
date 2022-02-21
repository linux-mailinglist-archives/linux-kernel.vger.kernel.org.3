Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8B4BDC7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359292AbiBUNnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:43:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359406AbiBUNlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:41:16 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB004220EE;
        Mon, 21 Feb 2022 05:40:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A916B1F42EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645450851;
        bh=+dtEQGc+iAoSujb9RCXxGPyqsje87DXa4PQPFCuMHGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HXQCaEvDnJ7NxZe5NCiOQDyf1NUsnPaRQugb3WnTrumacN8l7UzYd0Z7qgwuQCi/U
         K39o8DEzFthVRDWbkZmBuUy7jwje8Sf20UjgI36pERPdJrJ7a2uJ+gpB3x6/VaLHJ0
         HcnVCiu13CbeyZvR+Fc4UcHMmK+NKqITtiyMlYhNNkLvDiMZaw1pOjhrinAIiHdYzJ
         gheHCJMAgj9NpiWTP/YtNzz2JZrgmL61GSvSPUJfar52RExnaEjHokOaXpj3qzwy1o
         yBwDses2tMKGUrO5CdNEdA6WdiYQAKHH/RJDbxL8hBITdzdqAUzljuhRxJNvfB1Gtk
         OLao6gKl341Ug==
Message-ID: <211bd3ca-f786-b161-6f3d-dc6b8471ffc7@collabora.com>
Date:   Mon, 21 Feb 2022 14:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 5/5] pinctrl: mediatek: common-v1: Commonize
 spec_ies_smt_set callback
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com>
 <20220210141931.291712-6-angelogioacchino.delregno@collabora.com>
 <CAGXv+5H0OkMk=1MZH3jCFSZbauJmEcgFADfDXDPf2r1wrp8wCw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5H0OkMk=1MZH3jCFSZbauJmEcgFADfDXDPf2r1wrp8wCw@mail.gmail.com>
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

Il 21/02/22 10:58, Chen-Yu Tsai ha scritto:
> On Thu, Feb 10, 2022 at 10:21 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> All of the MediaTek pinctrl drivers registering with pinctrl-mtk-common
>> that are offering a .spec_ies_smt_set() callback are declaring their
>> own function which is doing exactly the same on all drivers: calling
>> mtk_pconf_spec_set_ies_smt_range() with their struct and a simple check.
>>
>> Commonize this callback by adding the ies and smt structure pointers
>> to struct mtk_pinctrl_devdata and changing the callback signature to
>> take it.
>>
>> Removing the callback and checking for the existence of the spec_smt
>> and/or spec_ies data would allow us to staticize the function
>> mtk_pconf_spec_set_ies_smt_range(), but this solution was avoided as
>> to keep flexibility, as some SoCs may need to perform a very different
>> operation compared to what this commonized function is doing.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Hi Chen-Yu,

did you mean Reviewed-by? :-)
