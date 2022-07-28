Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB15838BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiG1G20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiG1G2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:28:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8148E5E324;
        Wed, 27 Jul 2022 23:28:18 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A18E96D4;
        Thu, 28 Jul 2022 08:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1658989696;
        bh=oCjtC3g82Ud1cVCYqkX2EY6KFanHwbRaoqifixuKbmA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pLx7l3bs6ZKtj6EfgHKRXHtx8LpDlK0WiczliWhXNIU0zM1CdjQ7hoY+McC3SApIU
         Whu8CwSs08TDg5lRIbdifPeFplGyXlkmPsQZJdkZjRG/R3JmWMXjPq8inSfSpjjL6e
         Fxjqm2fE0ttDKEKE912kE3ThBV7hLH7HR3TQt6OU=
Message-ID: <d10cd3c6-ff3c-ee0e-9363-f0b71fe7e2c2@ideasonboard.com>
Date:   Thu, 28 Jul 2022 09:28:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/8] dt-bindings: display: ti,am65x-dss: Add port
 properties for DSS
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>
Cc:     Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Darren Etheridge <detheridge@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-2-a-bhatia1@ti.com>
 <20220720232845.GA4164694-robh@kernel.org>
 <20220722161621.p35apy5mstpgqhef@reverence>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220722161621.p35apy5mstpgqhef@reverence>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 19:16, Nishanth Menon wrote:
> On 17:28-20220720, Rob Herring wrote:
>>> On the bridge side R0->R2, G0->G1, B0->B2 would be tied to ground.
>>> The bridge sees 24bits of data,  but the lsb's are always zero.
>>
>> Unless the bridge ignores the LSBs, that's not the right way to do 16 to
>> 24 bit. The LSBs should be connected to the MSB of the color component
>> to get full color range.
> 
> I unfortunately cannot point specifics without violating NDAs, so
> will just give a broad perspective.
> 
> Correct, this is not ideal, but in certain scenarios with limited
> pins (due to iovoltage groups), we are indeed starting to see this
> kind of usage model starting to pop up. Tradeoff is in a limit on
> image quality, but that tends to be acceptable in certain lower cost
> solutions.

It doesn't require more pins. If the lowest bits are tied to ground the 
image is always a bit darker than it should, and you do not get the full 
brightness. But if you wire e.g. the red component:

SoC : Bridge
R2 ->   R0
R3 ->   R1
R4 ->   R2
R0 ->   R3
R1 ->   R4
R2 ->   R5
R3 ->   R6
R4 ->   R7

or

R4 ->   R0
R4 ->   R1
R4 ->   R2
R0 ->   R3
R1 ->   R4
R2 ->   R5
R3 ->   R6
R4 ->   R7

You'll get the full range.

  Tomi
