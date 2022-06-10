Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26238546464
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbiFJKpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346972AbiFJKns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:43:48 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA162533CF;
        Fri, 10 Jun 2022 03:40:23 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 80A23100003;
        Fri, 10 Jun 2022 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654857622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPqa3snjp+V3swy+paQVl3SWlOSGmf0pkLwY6FTDI9U=;
        b=boAs/cHxD1v49A/IVeVtIuEz8fBNz17KEqTSD8TF0pb3tuwqKcx8ieyXiAvkchawghAV6Z
        PAZwqCV0PZ49VSLYs9l/wEVXJZQbf/mZhMpMTRM/w0eZnFZr0GbP1cCJvU5zhJebNZDtIl
        kx90AMeV+gMRuniOD3vAbNsbhrjHAf/rHRuYiHs+VQAQSOtjE/Q9DASLesAreXrLPNIXS6
        rop2qSp/Nok87u1iW2IvGGldHlL9pQzrqPcK8lSQDinIvuQOmGjXzZdUW0MePrVKLB6hPy
        pGiDY36c8H4pB8JHRoGFI8lNpN6NZ0+wMLtQElyftguowNu+A67z91TE8dBikQ==
Date:   Fri, 10 Jun 2022 12:40:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     "Neeli, Srinivas" <srinivas.neeli@amd.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "sgoud@xilinx.com" <sgoud@xilinx.com>,
        "shubhraj@xilinx.com" <shubhraj@xilinx.com>,
        "neelisrinivas18@gmail.com" <neelisrinivas18@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>
Subject: Re: [PATCH V6 2/2] rtc: zynqmp: Add calibration set and get support
Message-ID: <YqMfkNwAidCpYY1E@mail.local>
References: <20220609140833.1784738-1-srinivas.neeli@xilinx.com>
 <20220609140833.1784738-2-srinivas.neeli@xilinx.com>
 <87r13x28o4.fsf@dell.be.48ers.dk>
 <YqIJektBvAwOqNkA@mail.local>
 <87mtel287y.fsf@dell.be.48ers.dk>
 <BY5PR12MB40335583AD9D0527DEEFC4E093A69@BY5PR12MB4033.namprd12.prod.outlook.com>
 <87pmjgyghw.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmjgyghw.fsf@dell.be.48ers.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 12:12:11+0200, Peter Korsgaard wrote:
> >>>>> "Neeli," == Neeli, Srinivas <srinivas.neeli@amd.com> writes:
> 
> Hi,
> 
>  >> >> Where do you see that? ug1085 rev2.2 still lists:
>  >> >>
>  >> >> Programming Sequences
>  >> >> init rtc
>  >> >> 1. Write the value 0019_8231h into the calibration register, CALIB_WRITE.
>  >> >>
>  >> 
>  >> > This is a very weird value. Last time I had a look, I couldn't find an  >
>  >> explanation for it.
>  >> 
>  >> Agreed. I am not arguing that it is sensible, I just wondered where this new
>  >> value comes from?
>  >> 
>  > This information is missing in our TRM, as per the internal RTC IP
>  > design specification document, the calibration value should be crystal
>  > clock frequency minus one.
>  > For a crystal oscillator of 32.768KHz(0x8000) frequency, the calibration value will be 0x7FFF.
> 
>  > Will update TRM with the required information.
> 
> Ok, great!
> 
> Please put this change in a separate commit from the get/set logic.

I'm not sure it is worth it as it is probably being set (to the wrong
value) from your device tree anyway and the driver won't forcefully
change it in that case. The worse that can happen is that your new
boards will have the correct value.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
