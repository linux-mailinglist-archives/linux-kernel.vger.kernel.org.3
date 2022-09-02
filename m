Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B355AB439
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiIBOvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiIBOvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD18785BA;
        Fri,  2 Sep 2022 07:13:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kk26so4111281ejc.11;
        Fri, 02 Sep 2022 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=HkrATxSxYMCe0d7NXJjjTPjg+fttoARS4eUl41blu5w=;
        b=NduYS7PCIsDXxPfL5Br7uVDo6RJM9+ySlErZm3KCBet1l9r9TwuYska2u8fCRMcgLh
         9gk9DIwT2CfgR7fatE4fZVIUJYo+EmLf/jnHm4x1NasKUeRdh13RNA7myulovXTISfwo
         ZYVfnt8ABe656b1pt7Fb8E9f7zw7NjpOMPMj7lUv2PB5HjAri2NeRq63Bmb5SE9vPlnz
         Rz0qylx892+bw7HCiV56kkyMpUNo8l8lFoHPw8qt95ndKdKQyGYHnhzvILpVrXVt8i1C
         UjE10Te6DqlEq9YMKKWE167ORfDCWTWPLBesimByIFz2ryw59ToSpdPovCM5apRBeR7g
         MJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HkrATxSxYMCe0d7NXJjjTPjg+fttoARS4eUl41blu5w=;
        b=fufYgc7aYRs3tHQBkgC2ix6G6ctWdboVtbldxbr9fKN7IOd9DmKE2V2ttlyPTJX6L0
         VsudhkEQ1QquYzfNCVo8I+dq7qt5NKqM/3A4IaI+ao9TJlk3R6VqkWvHquRH+zxTVhK/
         1ycuk2n6CLA3Z0PSol/82Ut+rCZ3J3zcKsizTb+2Ff+ToX5LIgA9V6WqaL3Vzo0VtvAU
         sldEHoEzZoeaaRD63hIzdYfokSn6uNwMfkpf0BtknX+CK+k64TcVLOOgsfZgxBqtvXSY
         6unonbpwNmv0Gpu2k4LLzW2kjNqj3mHZu1zt3jljZYOmC4wWLG19qjy+9L/FqVSPLAh3
         wjqg==
X-Gm-Message-State: ACgBeo2GmQR+JndVmxJIDewR6FMUhGSElbw7mWXeAmJ4OAcwuMx4Z1l4
        KZjOsK6M4XaXphbBbL0c35U=
X-Google-Smtp-Source: AA6agR7LpAO/9YUwEpkixKSLf8mxhsTi6MQ1eOya0YVrrolkRNNl5OdpQemWUcoLGnp5qDqB6fulGA==
X-Received: by 2002:a17:907:3f0a:b0:730:994f:8d57 with SMTP id hq10-20020a1709073f0a00b00730994f8d57mr26794680ejc.538.1662128028496;
        Fri, 02 Sep 2022 07:13:48 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id gk1-20020a17090790c100b007420aaba67esm1320609ejb.36.2022.09.02.07.13.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2022 07:13:47 -0700 (PDT)
Subject: Re: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs through
 DMM/TILER
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Yongqin Liu <yongqin.liu@linaro.org>, Andrew Davis <afd@ti.com>
Cc:     "Bajjuri, Praneeth" <praneeth@ti.com>, airlied@linux.ie,
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
 <db245ada-2f2e-c65d-ef14-35ea4adda123@ideasonboard.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <9ba1a8a3-fd3e-7879-8f47-ec991888d5f7@gmail.com>
Date:   Fri, 2 Sep 2022 17:13:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <db245ada-2f2e-c65d-ef14-35ea4adda123@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.08.22 г. 21:23 ч., Tomi Valkeinen wrote:
> On 30/08/2022 21:08, Ivaylo Dimitrov wrote:
> 
>>>>          flags &= ~OMAP_BO_TILED_MASK;
>>>>          flags |= 0x00000008;
>>>>          flags |= OMAP_BO_WC;
>>>>
>>>>          bo = omap_bo_new(dev, size, flags);
>>>>
>>>> As you can see we use 0x00000008 (OMAP_BO_MEM_CONTIG) unconditionally.
>>>> This was a hack added since even non-scanout buffers sometimes need
>>>> to be contiguous (video decoder surfaces), but we had no way back
>>
>> Hmm, why would video decoder need linear memory? No MMU?
> 
> Not sure about this case, but many/most IPs don't have MMU. E.g. CSI-2 
> or parallel capture.
> 
>>>> If you tell me what the code should look like, I can rebuild the
>>>> lib and post a copy.
>>>>
>>>> Long term, I'd like to start using DMA-BUF Heaps for CMA memory
>>>> allocations in gralloc and elsewhere, then drop out the DMM/TILER
>>>> support from OMAPDRM, since it never really belonged there in
>>>> the first place (being a IOMMU unrelated to the display/GPU).
>>>>
>>
>> Umm, how will we rotate scanout buffers then?
> 
> Didn't we discuss this earlier in this thread. Or some other thread. 
> Related to VRFB... I'm not sure =).
> 

Yeah, I think so. VRFB is still on my list though, along with TE support 
for droid4 :).

> Anyway, neither VRFB nor DMM/TILER are part of the DSS. They're part of 
> the memory subsystem. They can be used without DSS being in the setup. 
> Thus the code for VRFB and DMM/TILER should not be in the DSS driver.
>

Makes sense.

> The DSS driver should still, of course, support DMM/TILER (and maybe 
> VRFB some day) in the "use" sense, i.e. so that DSS can use the 
> DMM/TILER provided from another driver.
> 

Ah, this is what I was missing all the time, for some reason I was left 
with the impression that userland will have to know about those details. 
Now it is clear.

> But how exactly that's to be implemented, I don't know.
> 

Seems Andrew has an idea.

Ivo

>   Tomi
