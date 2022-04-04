Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4304F119A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbiDDJEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiDDJEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:04:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2464326DB;
        Mon,  4 Apr 2022 02:02:26 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:52e1:bbc1:ca8:7fa9] (unknown [IPv6:2a01:e0a:120:3210:52e1:bbc1:ca8:7fa9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B7F841F459F5;
        Mon,  4 Apr 2022 10:02:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649062945;
        bh=Fq1cNgcG71vKarNXb1KWa+6C35UQPBCHFFeK77y16GU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hVG0HSDA8rE5xmxrpe4VsIiBt3wsvYi6+asdDW1r+DdHlUycVaXdd3/kjxQkbEG1e
         RQx8L6oOTNzvOcDD4TNaH03l7VDseaM0l8ceVPki+QpOBXuyClPIg5ac/Q/pSRWVV0
         ZK9JGt8sKkRmo09xfGYostker5HfHvm6SuS7re2kEjKxqbDc/WV+X7nvplqSiKDL7j
         2hjZ1EZ7dWCsWX/dGFuBZmr6Y6QkkmrWx6qO5jxeCjY/746yANDLjSX0Mi04ar1ZO/
         N/KWL1f6OQERJdteXsAUNOM22dgkGMRz4k7Ivmuqo43Ehs9YuAI5hZ/1IpTw+BGE98
         SIUWJDIqvfC+Q==
Message-ID: <fa40b40d-b599-ec03-b596-57be7017d2c7@collabora.com>
Date:   Mon, 4 Apr 2022 11:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 2/8] media: Add P010 format
Content-Language: en-US
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
 <20220227144926.3006585-3-jernej.skrabec@gmail.com>
 <1b2ce01fb04f29cca58d40bd81d9f4cc46dcebf8.camel@ndufresne.ca>
 <CAAEAJfCA1ef5+KZHU4ZTJvuqdCAEUkvpDY9HTy1fp3M+0QxqPg@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAAEAJfCA1ef5+KZHU4ZTJvuqdCAEUkvpDY9HTy1fp3M+0QxqPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 04/04/2022 à 02:04, Ezequiel Garcia a écrit :
> Hi Nicolas, Benjamin,
>
> On Mon, Feb 28, 2022 at 9:48 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>> Le dimanche 27 février 2022 à 15:49 +0100, Jernej Skrabec a écrit :
>>> Add P010 format, which is commonly used for 10-bit videos.
>> There is a much more complete patch that was sent previously (with documentation
>> and all):
>>
>> https://patchwork.kernel.org/project/linux-rockchip/patch/20210618131526.566762-5-benjamin.gaignard@collabora.com/
>>
> I believe "media: Add P010 video format" should be good to go, I think
> we could merge it.
>
> I can't find it on my gmail inbox, for some reason.. can you guys
> please repost it,
> and/or reply to with a gently ping for Hans (and please Cc me on this mail) ?

I have rebased it on v5-18-rc1 tag and send it.
You should have it in your mailbox now.

Regards,
Benjamin

>
> Thanks!
> Ezequiel
