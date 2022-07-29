Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD619584D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiG2INx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiG2INv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:13:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4C681B09;
        Fri, 29 Jul 2022 01:13:50 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6247052F;
        Fri, 29 Jul 2022 10:13:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1659082428;
        bh=YRIDTq49blg69vXKdLfpX0vAX4yhJUUIEqTCkC3dCF4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iH9BDoIj4MLtnDRmoHH9QLBieY7XJD/z3g18DAKRD9v8nhB9im81GbhvLR9xXLbmv
         FMmfFilZSdg5XRDOeEcwD7G+paEuJw4KJimw4hnS05stHmzdlCxoqIgAr3A9ZWYEpv
         dZTTcRPxXicdbBnF0wL8NOQB/W1wqi2eUwGKGgjg=
Message-ID: <b465b09f-74c3-458f-a4be-8733dbecd699@ideasonboard.com>
Date:   Fri, 29 Jul 2022 11:13:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/8] drm/tidss: Fix clock request value for OLDI
 videoports
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jyri.sarha@iki.fi>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-8-a-bhatia1@ti.com>
 <03c77b33-271c-5cb3-fe00-cda7ff21102b@ideasonboard.com>
 <5abdc690-3b0d-0763-2a8a-30d1516c8ab0@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <5abdc690-3b0d-0763-2a8a-30d1516c8ab0@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2022 06:56, Aradhya Bhatia wrote:
> 
> On 28-Jul-22 15:35, Tomi Valkeinen wrote:
>> On 19/07/2022 11:08, Aradhya Bhatia wrote:
>>> The OLDI TX(es) require a serial clock which is 7 times the pixel clock
>>> of the display panel. When the OLDI is enabled in DSS, the pixel clock
>>> input of the corresponding videoport gets a divided-by 7 value of the
>>> requested clock.
>>>
>>> For the am625-dss, the requested clock needs to be 7 times the value.
>>>
>>> Update the clock frequency by requesting 7 times the value.
>>>
>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>> ---
>>>   drivers/gpu/drm/tidss/tidss_dispc.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c 
>>> b/drivers/gpu/drm/tidss/tidss_dispc.c
>>> index c4a5f808648f..0b9689453ee8 100644
>>> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
>>> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
>>> @@ -1326,6 +1326,16 @@ int dispc_vp_set_clk_rate(struct dispc_device 
>>> *dispc, u32 hw_videoport,
>>>       int r;
>>>       unsigned long new_rate;
>>> +    /*
>>> +     * For AM625 OLDI video ports, the requested pixel clock needs 
>>> to take into account the
>>> +     * serial clock required for the serialization of DPI signals 
>>> into LVDS signals. The
>>> +     * incoming pixel clock on the OLDI video port gets divided by 7 
>>> whenever OLDI enable bit
>>> +     * gets set.
>>> +     */
>>> +    if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI &&
>>> +        dispc->feat->subrev == DISPC_AM625)
>>> +        rate *= 7;
>>> +
>>>       r = clk_set_rate(dispc->vp_clk[hw_videoport], rate);
>>>       if (r) {
>>>           dev_err(dispc->dev, "vp%d: failed to set clk rate to %lu\n",
>>
>> The AM625 TRM seems to be missing the "DSS integration" section, even 
>> if it's referred to in three places in the TRM. Supposedly that has 
>> details about the clocking.
>>
>> Shouldn't the source clock be 3.5x when dual-link mode is used?
> There should not be.
> 
> Whenever OLDI is enabled, the clock generated from the PLL is 7 times
> the required pixel clock.
> 
> For the OLDI TXes, the clock passes through a /2 divider. This divider
> only gets activated when the dual mode has been enabled in the OLDI
> configuration. Thus the OLDI TXes get 3.5x the pixel clock in dual mode.
> 
> When the OLDI has been configured for a single mode,
> the PLL clock passes through the /2 divider without any change.
> 
>>
>> While I don't know the details, this doesn't feel correct. We're 
>> supposed to be setting the VP pixel clock here, and the serial clock 
>> would be derived from that as it's done on AM65x. Is the DT clock tree
>> wrong for AM625?
> Ideally, yes, its the pixel frequency that we are supposed to set here.
> 
> The same PLL clock (7 times the pixel frequency) passes through a /7
> clock divider. This clock divider only gets active when OLDI is enabled.
> Thus, the DSS VP clock input, only gets the actual pixel frequency that
> it needs.
> 
> Since, the /7 divider is controlled by a signal from the DSS, the driver
> needs to request 7 times more the pixel clock to accommodate for the
> divider.
> 
> In AM65X, the system FW is able to model the 7 times requirement because
> the divider is not controlled by the DSS signal. DSS signal controls a
> multiplexer which receives both PLL Clock and PLL / 7 clock.

Could you ping the TI TRM team to add the DSS integration chapter? The 
clock tree is quite important part of the TRM.

I really don't like this one much. The dispc->vp_clk[0] here is actually 
not VP clock, but a parent clock of the VP clock, so, afaics, the driver 
gets "wrong" clock from DT data and then fixes things by manually 
multiplying the requested rate. If we have to go with a driver hack like 
this, I think it needs to be clarified more with comments, in the DT 
data also.

On AM625, the first videoport is always connected to OLDI(s), and never 
goes through as DPI, right? I.e. you cannot bypass OLDI?

If so, the /7 is, in practice, always enabled, as OLDI is the only use 
case. So why not add /7 node to the DT clock data, which would allow us 
to get rid of this code?

  Tomi
