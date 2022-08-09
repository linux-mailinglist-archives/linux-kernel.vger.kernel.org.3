Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657E958D6C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbiHIJvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbiHIJvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:51:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEC31EC7B;
        Tue,  9 Aug 2022 02:51:16 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C2C8481;
        Tue,  9 Aug 2022 11:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660038674;
        bh=r2sdgyuhzqotsEz/pACTyQCNacvrrwjhRBMGFPAHOqE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O7h2FKBjjAc9l33om8vVHf+MwJNoHWfqMy7RO9Hq0c8XGI00KcfLktFxoIGSyCssg
         iw5onPCppQwZFyuYL4IuWp4hdxLbNvkk6UjEUn9UgIT4Nx5zxMmT8sSVqswRQo6fCh
         Kjp3KRR3vjbv6JDpH7AUxBlju4oViuDMFnJXSn7o=
Message-ID: <ff7448fd-e50c-1c6d-ad28-ea7e555cdd24@ideasonboard.com>
Date:   Tue, 9 Aug 2022 12:51:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/8] drm/tidss: Add support for Dual Link LVDS Bus Format
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-5-a-bhatia1@ti.com>
 <f2909af1-be23-009b-ba71-34206f099473@ideasonboard.com>
 <ec8dce9b-51d6-a566-67bb-b76f6f3458d7@ideasonboard.com>
 <1f9de2d8-7507-bdc2-93c1-470c8e060586@ti.com>
 <b8fd1719-b0ec-495b-54f9-1d591ff8af9e@ideasonboard.com>
 <09682120-632a-1bfb-c0d7-034f5f076421@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <09682120-632a-1bfb-c0d7-034f5f076421@ti.com>
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

On 09/08/2022 12:06, Aradhya Bhatia wrote:

>>> Even in DT, the dss port (for OLDI) connects to the panel port's
>>> endpoint directly. Even in cases of dual link or cloning, it's only a
>>> singular remote-to-endpoint connection between the (OLDI) VP and the
>>> panel port. Hence the requirement of the properties in the earlier
>>> patches of the series.
>>
>> Sorry, I don't follow. If you use cloning, you have two TX outputs, 
>> going to two panels, right? So you need two panel DT nodes, and those 
>> would connect to two OLDI TX ports in the DSS.
>>  > Afaics the existing dual link bridge/panel drivers also use two ports
>> for the connection, so to use the dual link you need two ports in the 
>> DSS.
>>
>> I admit I'm not familiar with LVDS dual link, but it's not clear to me 
>> how you see the dual OLDI TX being used with other drivers if you have 
>> only one port. What kind of setups have you tested?
>>
> In the DTs, the OLDIs are not modeled at all. Since the DSS only has a
> single VP for OLDI, the DT dss port (for OLDI) is connected to a single
> simple-panel node for dual link, bypassing the OLDI TX in DT. I have
> this same OLDI setup and have been testing on this.

A DSS VP is a DSS internal port, whereas a port node in the DT is an 
external port. There doesn't have to be a 1:1 match between those.

The port in the DT represents some kind of "connector" to the outside 
world, which is usually a collection of pins that provide a video bus.

Here, as far as I can see, the DSS clearly has three external ports, two 
OLDI ports and one DPI port.

> I do not have a cloning display setup with me, but I have seen DT DSS
> port connected to one of 2 panel nodes while the other panel (remains as
> a companion panel to the first) without any endpoint connections. Since,
> the OLDI TXes (0 and 1), receive the same clocks and inputs from DSS
> OLDI VP, this 'method' has worked too.

This, and using simple-panel for dual link with single port connection, 
sounds like a hack.

A practical example: TI's customer wants to use AM625 and THC63LVD1024 
bridge. How does it work? THC63LVD1024 driver uses two LVDS ports for 
input, both of which are used in dual-link mode.

>>> The use of lvds helper functions does not seem feasible in this case,
>>> because even they read DT properties to determine the dual link
>>> connection and those properties need to be a part of a lvds bridge
>>> device.
>>
>> Can you elaborate a bit more why the DRM helpers couldn't be used here?
>>
> The drm_of.c helpers use DT properties to ascertain the presence of a
> dual-link connection. While there wasn't a specific helper to determine
> dual-link or not, the drivers use the odd/even pixel order helper which
> is based on the properties "dual-lvds-odd-pixels" and "dual-lvds-odd-
> pixels". If either of the properties are absent, the helper returns an
> error making the driver to use single link.
> 
> These properties are LVDS specific, but they could not be added in the
> DT because there is no OLDI TX DT node for our case.

If I'm not mistaken, those properties are in the port node, not the 
device node, and also, I believe those properties are on the sink side, 
so they wouldn't even be in the AM625 data. See, for example:

arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts

>>> I have also been considering the idea of implementing a new device
>>> driver for the OLDI TXes, not unlike the renesas' one. That way the
>>> driver could have the properties and the lvds helper functions at their
>>> disposal. I am just slightly unsure if that would allow space for any
>>> conflicts because of the shared register space.
>>
>> No, I don't think new devices are needed here.
> Okay...
> 
> I am not quite sure I understand completely what you are recommending
> the OLDI to be. It seems to me that you want the OLDI TXes to be modeled
> as nodes, right? Wouldn't that automatically require some sort of
> standalone driver arrangement for them? Or am I missing something
> important here?

No, I'm only talking about the DT port nodes. At the moment the AM65x DT 
bindings doc says that there are two ports, port@0 for OLDI and port@1 
for DPI. I'm saying AM625 needs three ports.

  Tomi
