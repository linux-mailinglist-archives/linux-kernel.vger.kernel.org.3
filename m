Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394DE500195
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiDMWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiDMWQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:16:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACAE20B;
        Wed, 13 Apr 2022 15:14:21 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r66so3055469pgr.3;
        Wed, 13 Apr 2022 15:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OgQDc06AaabwNqvOZmx+M7xA6vS8FVswgmeGiTFEFmQ=;
        b=C/I0954RFQfeOgPPXsDSdcBq22+URv/YRu61nd8kIqommib46tUTT+kkUqguhMr/eF
         wbP4t2bAPwN+OZ4ZdSv5MhG/gqrQpPlQ/FNWxI8IhMQzwP0jDZpxLNyLHBCVC/zHy1Sq
         x6G/MnmA9w6LMJEsCqvoeSWMPUw2aClx8+n4E0UMXXtkf9BzuYKo8vljlQdHPNcn7kSU
         yKrQsZ1Vc2bqq97L1m0DDWfGhMuJpMloaYXRTgzi1u0E/vfXVFle34S0qZAN9jdO3nMo
         4xdxOfou1kusfI+sMA89/v7sjF/3py5tXrlll6qSfAMEJoyZJ5SN2FSQj+RpsPYHDQW7
         YT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OgQDc06AaabwNqvOZmx+M7xA6vS8FVswgmeGiTFEFmQ=;
        b=dhvu4uvJFO9w+7NBKbf72nKg8mv8NZH9DWszE8iPfq4XgcYCtRlzqXtBUWoM1Mplha
         ivzZgaswovSxDv3un+8DO8ABkKVdz/gjQv0RUx1I3simyiFibk1gKLLjJgrhMmFiwKK7
         n3cLdzdKBzQeI58t9X6ETyVabj1sUg+tk6E4AmLM8eaZmQUYNYN0e7DqApfuTBR2uzeY
         i2mqiXyyyVxG02ugFVmcKqXPByQVNeQYhYbv334i8pkEVXbT7YjKOIVstb4vJse7IxDr
         mIX738QeYwD2l0cbXFNEqxNFKJIu4UmnPR40qqkxn9j++HqvED8BXgBdG0gsxRQxYN9W
         Qpvg==
X-Gm-Message-State: AOAM533TQmUN8HzTY6pbja9YfBG6qlDZLAdeGhls8UhA1kCBkcn6jcux
        2REqA1XM+/mAhh3tqkdzS7o=
X-Google-Smtp-Source: ABdhPJy2YawYQEhEM5R8p5OuAttWelqENZrpl40KyZkXf46PikY9jQrnx15kgh8UD16TomdH3gXeHw==
X-Received: by 2002:a05:6a00:24c5:b0:4fa:f63a:4c3 with SMTP id d5-20020a056a0024c500b004faf63a04c3mr892965pfv.15.1649888060453;
        Wed, 13 Apr 2022 15:14:20 -0700 (PDT)
Received: from [172.30.1.44] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm79582pfc.111.2022.04.13.15.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 15:14:20 -0700 (PDT)
Message-ID: <58fde143-ee39-a429-ce22-06d0c4095de8@gmail.com>
Date:   Thu, 14 Apr 2022 07:14:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/2] soc: rockchip: power-domain: Manage resource
 conflicts with firmware
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20220406014842.2771799-1-briannorris@chromium.org>
 <CGME20220406094558epcas1p4fa0c77a5acd6b73c192f6b19136cd5f9@epcas1p4.samsung.com>
 <20220405184816.RFC.1.Ib865f199d15221eab4ff77f70bd7e9e2eb04d32f@changeid>
 <c8664eae-4a10-bd1a-8898-01b96c05331e@samsung.com>
 <CA+ASDXNx+nwVKuisMAsHEKLfd=hqBzZmhFxphcYUF=bamqN2kA@mail.gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <CA+ASDXNx+nwVKuisMAsHEKLfd=hqBzZmhFxphcYUF=bamqN2kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 22. 4. 9. 12:34, Brian Norris wrote:
> Hi Chanwoo,
> 
> On Wed, Apr 6, 2022 at 9:38 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> Instead of adding the specific function for only rockchip,
>> how about adding new function pointer (like block/unblock or start/stop and others)
>> into 'struct generic_pm_domain'? And add new pm_genpd_* function
>> to control the power domain.
> 
> I suppose that is technically possible, but I'm not sure it makes a
> ton of sense.
> 
> First, genpd doesn't seem to typically expose operations directly to
> client device drivers. It's mostly about abstract handling of the
> dependencies of "how do I power on this device?" behind the scenes of
> things like pm_runtime_*(). I guess maybe something like
> dev_pm_genpd_set_performance_state() is an approximately similar API
> though (i.e., a genpd operation exposed to client drivers)? I could
> try to go that route, if the genpd maintainers think this makes sense.
> 
> But secondly, this isn't exactly an operation on one power domain.
> It's an operation on the entire power controller. I suppose I could
> make a new domain here for the memory controller, and teach that
> domain to implicitly manipulate all the other domains provided by the
> PMU, but that feels like a fake abstraction to me.
> 
> Lastly, and perhaps least importantly: this likely would require a
> device tree binding change. So far, the memory controller hasn't had
> its own power domain. I guess one could argue that it has some
> similarities to a power domain, albeit one that is managed in firmware
> -- so maybe this is a reasonable "bug" to fix, if it really comes down
> to it.
> 
>> Because it is better to use subsystem interface.
> 
> I don't agree this is universally true. It makes sense when there are
> truly abstract concepts represented, which are likely to appear across
> multiple implementations. Or maybe if the object model is complex. But
> this operation seems very SoC-specific to me, and it's pretty simple
> to implement this way. Or, do you think this is really something that
> others will need -- pausing (and powering) a power controller so
> another entity can manage it?

Thanks for detailed reply.

I agree your thinking. If possible, just I prefer to use standard
subsystem interface. But as you commented, it is not general case
that this issue is related to all power domains. Also, there is dt
binding issue as you described.

I agree this approach. Thanks.

(snip)

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
