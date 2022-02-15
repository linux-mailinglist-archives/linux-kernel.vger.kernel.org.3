Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB114B6716
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiBOJLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:11:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiBOJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:11:11 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811ED13DDB;
        Tue, 15 Feb 2022 01:11:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 079911F433FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644916261;
        bh=tYSh/6XrWTeegQd7V8dnLWsujFi8WEje0R7EZEvEbzE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BVVMirL2QvYO1R0vzvudtTGRUSR8n9khoyveEfNxG9dxkA6wW5OQNaqozVMRtONjJ
         QgrdK7YfsM5XvB8vsbAI9duQTqAdymREGBHABXI5zW7q2sKlVTn0CSuMAUaHlVpBtc
         sWZXuiLOIUvDCVaqaBUqN+wD1dcSwUbzFJtzlz0WgueyZlul3UmF4077teU4z8B35t
         Zsy11yX5V3J0dkXVhgNOpGrItX6cz1ooV6aTWQxwSzSQLtF+0rnxeSxUCoggZX25UH
         Mi5gXodwpJAolDY/tvM8H7dcFq/kXuBFpRl86ghxFpmlSbexqHN0gSCji024KBgn1E
         cOkjL4QuQJYNg==
Message-ID: <9bbc6f3c-7fe6-0f1d-e946-b751668949fb@collabora.com>
Date:   Tue, 15 Feb 2022 10:10:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v22 5/7] soc: mediatek: SVS: add debug commands
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220127033956.24585-1-roger.lu@mediatek.com>
 <20220127033956.24585-6-roger.lu@mediatek.com>
 <0846872b-03da-ee5d-6a9d-e6c9fa754191@collabora.com>
 <eb4a903b90020e8220768e9bb674b9de477006e3.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <eb4a903b90020e8220768e9bb674b9de477006e3.camel@mediatek.com>
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

Il 15/02/22 10:08, Roger Lu ha scritto:
> Hi AngeloGioacchino,
> 
> Excuse me for the late reply.

Hi Roger,
no worries about that.

> 
> On Mon, 2022-01-31 at 12:11 +0100, AngeloGioacchino Del Regno wrote:
>> Il 27/01/22 04:39, Roger Lu ha scritto:
>>> The purpose of SVS is to help find the suitable voltages
>>> for DVFS. Therefore, if SVS bank voltages are concerned
>>> to be wrong, we can adjust SVS bank voltages by this patch.
>>>
>>> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
>>
>>
>> Hello Roger,
>> I was thinking about what this patch is adding... and I have a few
>> considerations.
>>
>> It's nice to have a debugging mechanism to read the status and dump registers,
>> as
>> that's very helpful when doing heavy debugging of the IP... but adding the
>> possibility to write a voltage offset may be very dangerous: think about the
>> case
>> in which, either for misconfiguration, or for any other reason, the debugfs
>> entry
>> that allows writing voffset becomes user-writable, or a user writes an
>> impossibly
>> high voffset.
>> In case a very low (negative) voffset is entered, the platform would crash
>> (denial
>> of service); if a very high voffset is entered, hardware damage may occur.
>>
>> For this reason, there are two proposals:
>> 1. If you want to keep the debugfs voffset write, please constrain the
>> permissible
>>      voffset to an acceptable range that at least makes it unlikely to damage
>> the HW;
>>      Moreover, since voffset write is a feature that would be used in very
>> limited
>>      debugging cases, I think that this should be implemented over a build-time
>>      configuration barrier... something like CONFIG_MTK_SVS_DEBUG_ALLOW_WRITE,
>> or
>>      similar;
>> 2. Since it's very unlikely for someone to really play that much with a
>> voltage
>>      offset during runtime, and since this looks like something very machine
>> specific
>>      (perhaps addressing board-specific quirks?), I would suggest to add this
>> as a
>>      device-tree parameter instead, such as "mediatek,svs-voffset", as it is
>> indeed
>>      possible to specify both positive or negative values in DT.
>>
>> I would prefer proposal 2, as it looks generally cleaner and way less risky.
> 
> Thanks for raising the considerations and give these great suggestions for us to
> think about. Since these voffset read/write commands are used seldomly, we
> decide to remove them for better system security.
> 

Thank you for this ack, very much appreciated.
Eager to see v23!


>>
>> Regards,
>> Angelo
> 

