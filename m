Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630084F5CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiDFLvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiDFLup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:50:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DC51C9454;
        Tue,  5 Apr 2022 23:54:11 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:ff63:de1f:2a77:5241] (unknown [IPv6:2a01:e0a:120:3210:ff63:de1f:2a77:5241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8091E1F44519;
        Wed,  6 Apr 2022 07:54:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649228050;
        bh=tqnMuI8tFUvTxaTXTOvtQ2qzTn9cKLNn18CehTYmq8w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hpbelg9ITQRa7aKF8ZvmRAihh+Xif2IZ1f80s4ReZW/+hjfUjbf6YDv0q+uTSAAyU
         +hp+8WaicFUXLVxHALbFU932x/O6gAmvj2w3STI3dwKIPTyEQbU63eAFAijijUcX5a
         7QQB0Ed4hvVe1vByawUjFE1muivhK0HdFyqeMdjcToNxpvOg5X90+fExd/Atfomwox
         XZS4lRr3b+/3cIbpuJgdJqsqjK55zAYRosi7aupAcwRd/Yluf91gLoLCkZzmWhfLeK
         P00ix/kzuCyg8he3Oxjp8uUq1LYP4VLO5WrBtyecAbkLYNBxowyjPZXPkQXSvLTRWR
         g/RXf+JtfVQaw==
Message-ID: <bf938b83-2b57-95b3-4bcb-f967bbb46413@collabora.com>
Date:   Wed, 6 Apr 2022 08:54:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/8] media: hantro: Add 10-bit support
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
 <b6987a9a-56af-f63f-b60a-37df141d6e89@collabora.com>
 <4386971.LvFx2qVVIh@jernej-laptop>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <4386971.LvFx2qVVIh@jernej-laptop>
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


Le 05/04/2022 à 20:40, Jernej Škrabec a écrit :
> Hi Benjamin!
>
> Dne torek, 05. april 2022 ob 18:07:41 CEST je Benjamin Gaignard napisal(a):
>> Le 27/02/2022 à 15:49, Jernej Skrabec a écrit :
>>> First two patches add 10-bit formats to UAPI, third extends filtering
>>> mechanism, fourth fixes incorrect assumption, fifth moves register
>>> configuration code to proper place, sixth and seventh enable 10-bit
>>> VP9 decoding on Allwinner H6 and last increases core frequency on
>>> Allwinner H6.
>>>
>>> I'm sending this as RFC to get some comments:
>>> 1. format definitions - are fourcc's ok? are comments/descriptions ok?
>>> 2. is extended filtering mechanism ok?
>>>
>>> I would also like if these patches are tested on some more HW.
>>> Additionally, can someone test tiled P010?
>>>
>>> Please take a look.
>> Hi Jernej,
>>
>> I have create a branch to test this series with VP9 and HEVC:
>> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/tree/10bit_imx
>> 8m Feel free to pick what I may need in it.
>>
>> That doesn't improve fluster scores, I think more dev are still needed in
>> GST before getting something fully functional.
>> Anyway I able to select P010 pixel format if the input is a 10bit bitstream.
> What kind of improvements do you expect? Actually, this series is designed to
> change nothing for platforms, where 10-bit format is not added into the list
> of supported formats. I think reasons are quite obvious. First, not every
> device may support 10-bit output. Second, as you might already figured it out,
> registers in this series are set only for legacy cores. I have no idea, what
> needs to be done for newer ones, since I don't have them. Anyway, I tested
> this with fluster and only one additional test passes, because it is the only
> one for 10-bit YUV420.

In this series you will find that I have added the registers for the new cores,
fix hevc to be able to use 10-bit, and enable that in IMX8M.

Regards,
Benjamin

>
> Best regards,
> Jernej
>
>
