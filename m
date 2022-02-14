Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ACC4B587B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357110AbiBNR0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:26:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355492AbiBNR0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:26:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062C765405;
        Mon, 14 Feb 2022 09:26:10 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:1b99:5680:6d85:c710] (unknown [IPv6:2a01:e0a:120:3210:1b99:5680:6d85:c710])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 335041F43D7E;
        Mon, 14 Feb 2022 17:26:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644859569;
        bh=+qVRXti66mby33Bprencydv0eVQR6dDXQg3KkyOuLDQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RsEi8yZUWvyhqZU9R1uxaAH4f4/aZpmw2n/Q7SVKwrofoogQt63+kovE2zxictrlq
         aqsTFkoRMCk7VD8XTSseaGw0fKmuPQoFcFLZXXZuUEY6BS5SEfK8bydRfBh/qUQgT+
         I5wccxTJnUNPkthr///D7cOQ+gR/9wYHSNhzfuT9/kOavNwI7soRsB3iZDSZgSGjHL
         czL54STNVtGeghqxsue0XHY+euaQn3ZWutzWJzSIYv8eNHB88KoUuDSUz0w2bOwLJw
         KIhf7YMbwZXgYaX13MURhgr7Ui4jSUzDBaFeadnpZa2loHqxRQJACu45FOEOYvc0g8
         BdCUBDuPAiQQA==
Message-ID: <89812c02-d316-d561-6e6c-543a92c5bc50@collabora.com>
Date:   Mon, 14 Feb 2022 18:26:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] media: uapi: Move HEVC stateless controls out of staging
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, Alex Bee <knaerzche@gmail.com>,
        jc@kynesim.co.uk
References: <20220201123439.353854-1-benjamin.gaignard@collabora.com>
 <8038233.T7Z3S40VBb@kista> <713cee9b-c96c-119a-65be-3c289b361915@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <713cee9b-c96c-119a-65be-3c289b361915@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 14/02/2022 à 11:01, Hans Verkuil a écrit :
> Hi all,
>
> On 2/13/22 12:33, Jernej Škrabec wrote:
>> Hi Benjamin,
>>
>> CC: Alex, John
>>
>> Sorry for late response, but I've been very busy last week.
>>
>> First of all, thank you for doing this! It's about time that HEVC moves
>> forward.
>>
>> Dne torek, 01. februar 2022 ob 13:34:39 CET je Benjamin Gaignard napisal(a):
>>> The HEVC stateless 'uAPI' was staging and marked explicitly in the
>>> V4L2 specification that it will change and is unstable.
>>>
>>> Note that these control IDs were never exported as a public API,
>>> they were only defined in kernel-local headers (hevc-ctrls.h).
>>>
>>> While moving the controls out of staging they are renamed and
>>> control IDs get new numbers.
>>> Drivers (Hantro, Cedrus) and Documentation are updated accordaly.
>> accordaly -> accordingly
>>
>>> Additional structures fields has been added for RKVDEC driver usage.
>> You should do separate patch for that, preceding this one. One patch should
>> only do one thing.
>>
>> I also suggest that you add additional patch for removing bit_size field in
>> struct v4l2_ctrl_hevc_slice_params. Similar fields were already removed from
>> MPEG2 and H264 structures. Bit size can be deduced from output buffer size and
>> it doesn't hurt if bit size in Cedrus is set to bigger value than actual slice
>> bit size.
>>
>>> Hantro dedicated control is moving to hantro-media.h
>>> Since hevc-ctrls.h content has been dispatched in others file, remove it.
>>>
>>> fluster tests results on IMX8MQ is 77/147 for HEVC codec.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> Note that Cedrus still needs additional information in order to decode some
>> HEVC videos. Missing info is num_entry_point_offsets and list of all
>> entry_point_offset_minus1 (obviously, num_entry_point_offsets in size).
>>
>> I suggest that this is represented in a new control, which would use dynamic
>> array feature, written by Hans. While Cedrus supports max. 256 entries, it can
>> be much bigger in theory, but in reality, it's much smaller (like 4-8
>> entries).
> I've rebased my dynarray tree, so it is up to date again:
>
> https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=dynarray

I will cheery-pick the 3 needed patches in my next version of the RFC

Thanks,
Benjamin

>
> Regards,
>
> 	Hans
>
>> Last but not least, data_bit_offset should be better defined. Currently it
>> points right after last header bit, just like Cedrus needs it. However, there
>> is padding after that, at least 1 bit and 8 bits at most, so slice data always
>> starts from byte aligned address. It probably make sense to rework that field
>> to be byte offset, not bit, just like in VA-API. Note that RPi HEVC driver also
>> uses byte aligned address directly. Cedrus would need some kind of workaround
>> and only one that works is this one:
>> https://github.com/bootlin/libva-v4l2-request/blob/master/src/h265.c#L191-L209
>>
>> Best regards,
>> Jernej
>>
>>
