Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626245A6C04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiH3SXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiH3SXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:23:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30783481EB;
        Tue, 30 Aug 2022 11:23:35 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 32465481;
        Tue, 30 Aug 2022 20:23:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661883812;
        bh=uH2RujtJW24+NlHEo7Rl1VvmvbNokKsSNH3cq36NFVY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ES4RuUJSw5KwsaRB8c5Tlc/rgSwzuSVDr6e4YUcSpkaRVlh7QrQCTMlP70R+oPWC6
         ZJ3T2AmgdWAVAzpe5JCr4az83Rk5vjU1optGw7WzdkKpQ5LIaWgDGhEE1IxSvr1x4t
         +sljZmDmqSh4FCFo/8Tr7m/5o1uUdLOfVU7jYIxw=
Message-ID: <db245ada-2f2e-c65d-ef14-35ea4adda123@ideasonboard.com>
Date:   Tue, 30 Aug 2022 21:23:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs through
 DMM/TILER
Content-Language: en-US
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Yongqin Liu <yongqin.liu@linaro.org>, Andrew Davis <afd@ti.com>
Cc:     "Bajjuri, Praneeth" <praneeth@ti.com>, airlied@linux.ie,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        merlijn@wizzup.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tony@atomide.com,
        linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <5b6d3e7f-c638-fdc7-5080-44d34abed610@ideasonboard.com>
 <a3ed3a2c-86ce-1c85-e8aa-c08b54ad1a43@gmail.com>
 <CAMSo37XdZSZUHLWJj373DdtOBA9=uD8SJ7ywWCYF2pU1i4cB_g@mail.gmail.com>
 <ed4fe238-4fcd-1253-658f-18fe1e1f13b0@gmail.com>
 <CAMSo37V3U5nYng77jzSnKH73CTLhGYQJu11Q5wRt289se5nFJw@mail.gmail.com>
 <4128aed0-211a-d12a-6a86-deb4457d39f7@gmail.com>
 <CAMSo37W-DePLDP=zk-nY6FGcZuk0QzHj4=usrieyV0TNcNfbXw@mail.gmail.com>
 <da2a661e-9da0-850c-3067-8c1e8d5531bc@gmail.com>
 <CAMSo37VXNQeR0qZgzZONBwp_4z9CuUSJJJzhM7k+K39BcwvW6A@mail.gmail.com>
 <235621d0-2141-5ef9-bcd4-5c48b985b3a0@gmail.com>
 <5dc2c212-4967-ab2d-c016-f3b3a854fe32@ti.com>
 <CAMSo37W+Z2hn_wJ9At1nyJX6XnpZx9JLXJv9g6DoqoaqqjUATw@mail.gmail.com>
 <0eb026d9-faaa-68cb-cdcd-7d031acfbb03@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <0eb026d9-faaa-68cb-cdcd-7d031acfbb03@gmail.com>
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

On 30/08/2022 21:08, Ivaylo Dimitrov wrote:

>>>          flags &= ~OMAP_BO_TILED_MASK;
>>>          flags |= 0x00000008;
>>>          flags |= OMAP_BO_WC;
>>>
>>>          bo = omap_bo_new(dev, size, flags);
>>>
>>> As you can see we use 0x00000008 (OMAP_BO_MEM_CONTIG) unconditionally.
>>> This was a hack added since even non-scanout buffers sometimes need
>>> to be contiguous (video decoder surfaces), but we had no way back
> 
> Hmm, why would video decoder need linear memory? No MMU?

Not sure about this case, but many/most IPs don't have MMU. E.g. CSI-2 
or parallel capture.

>>> If you tell me what the code should look like, I can rebuild the
>>> lib and post a copy.
>>>
>>> Long term, I'd like to start using DMA-BUF Heaps for CMA memory
>>> allocations in gralloc and elsewhere, then drop out the DMM/TILER
>>> support from OMAPDRM, since it never really belonged there in
>>> the first place (being a IOMMU unrelated to the display/GPU).
>>>
> 
> Umm, how will we rotate scanout buffers then?

Didn't we discuss this earlier in this thread. Or some other thread. 
Related to VRFB... I'm not sure =).

Anyway, neither VRFB nor DMM/TILER are part of the DSS. They're part of 
the memory subsystem. They can be used without DSS being in the setup. 
Thus the code for VRFB and DMM/TILER should not be in the DSS driver.

The DSS driver should still, of course, support DMM/TILER (and maybe 
VRFB some day) in the "use" sense, i.e. so that DSS can use the 
DMM/TILER provided from another driver.

But how exactly that's to be implemented, I don't know.

  Tomi
