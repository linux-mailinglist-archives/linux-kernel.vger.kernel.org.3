Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF0A5471C3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 06:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350260AbiFKEKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 00:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349333AbiFKEKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 00:10:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1117C114A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 21:10:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y32so1279238lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 21:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kw7TRV3xOMpDRMX1N3uOp8oZ0RQsxX0dduWqnPe/SfA=;
        b=LYXeKAgCayDc/nJfujFDaBTqICD7A563ebLFUcySAszO1SOjZQmmraGE0qYCD8alwJ
         VzPPaaNJPudxvDmDsYJ6KhPyIoz2dqwWi19NkNVu9ZGqxAkmRm4UJ0pO5HfE0ZSYDl/P
         Blh1HPOtPxFaSjk4QrymUQ+xh4eTz2ystGy6IlOOvZZg0vLEmi2ffZaNIEJXf97bKaeg
         tP0xKymrQE3zWhM8Dt8eWHTSHHFONpmh4HePTJM8oYnqKUn0qzjWx5ZijeyHooquSpks
         mv8ZAE1+HqQq5u+DNBG6Ke6gwYwdAWfuCv9nTlVY5LaZdTDfBWuoa9gKQlbo2T1AVduV
         LUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kw7TRV3xOMpDRMX1N3uOp8oZ0RQsxX0dduWqnPe/SfA=;
        b=e/79ycl1n9oCRDWU1SxOMMz6p74INW0UJJa7pnmJNgquAW/5/vleT0QPez8Vus57uX
         OL40I46fE70dvWLvSjV7D9BIqz9uxwsQ+hMv1Ot5BDdX0YWwJ/Pn4yV5pMwg1nxnhX4L
         i/em6UpWJKLaaYzXK/H5+59DDvhEkOEn+wRdK+4UZEjBootfu8dhhWHUESjgLYhuStef
         3rSsFwPEfWDMolMRFf0SA6v6qDGZWFMk8tsQN0wd8u5H56icDMjmH1oldA0L4etY/n0d
         9nIY6A68fHbdyUHWplT/2arb35yr8DN0YwefzZ5ADOeHJRZ1pl5HKl9QNBW7A+VLiIKf
         EuQA==
X-Gm-Message-State: AOAM531ZSYQBArVepmNHsb+7cAA1mwvEpKoo2mU8oILqqSq4b9CJLOuk
        unGr7RRKuFrPaL0wZe52h4LmHg==
X-Google-Smtp-Source: ABdhPJxKz/1fL9FUfiYX1a+HOnJGWyEla1AGg4eT8rUtZca/6StxHVoxLpUcbYyVyRyYcQgR3gBSmQ==
X-Received: by 2002:a05:6512:31c3:b0:479:3c8a:b39f with SMTP id j3-20020a05651231c300b004793c8ab39fmr18530160lfe.111.1654920607427;
        Fri, 10 Jun 2022 21:10:07 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e934c000000b00255cb942318sm212291ljh.110.2022.06.10.21.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 21:10:07 -0700 (PDT)
Message-ID: <355332ef-838b-3847-5a95-de5017b0301d@openvz.org>
Date:   Sat, 11 Jun 2022 07:10:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: kmem: make mem_cgroup_from_obj() vmalloc()-safe
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Shakeel Butt <shakeelb@google.com>
References: <20220610180310.1725111-1-roman.gushchin@linux.dev>
 <YqOJBy2kHRJj/uLB@carbon>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YqOJBy2kHRJj/uLB@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 21:10, Roman Gushchin wrote:
> On Fri, Jun 10, 2022 at 11:03:10AM -0700, Roman Gushchin wrote:
>> Currently mem_cgroup_from_obj() is not working properly with objects
>> allocated using vmalloc(). It creates problems in some cases, when
>> it's called for static objects belonging to  modules or generally
>> allocated using vmalloc().
>>
>> This patch makes mem_cgroup_from_obj() safe to be called on objects
>> allocated using vmalloc().
>>
>> It also introduces mem_cgroup_from_slab_obj(), which is a faster
>> version to use in places when we know the object is either a slab
>> object or a generic slab page (e.g. when adding an object to a lru
>> list).
>>
>> Suggested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Acked-by: Shakeel Butt <shakeelb@google.com>
> 
> Andrew,
> 
> this patch is supposed to fix boot issues on arm introduced by
> the commit "net: set proper memcg for net_init hooks allocations".
> 
> But as no I don't see this commit in linux-next or any mm branches,
> so I'm not sure if it's in stable or not. So I didn't add the Fixes
> tag. If it isn't in stable yet, I'd just put the fix before the problematic
> commit.

Roman,
Andrew dropped "net: set proper memcg for net_init hooks allocations" few days ago,
but I hope he will re-apply it again after your patch.
Thank you very much for your help!

	Vasily Averin
