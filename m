Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4807A5428EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiFHIHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiFHIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:06:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B418F1CFFC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:37:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h192so11360605pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=6g4MB/2Lu7rQpbPpIMGixYDX9MXNU274v9OKdeffZbE=;
        b=pSdZVDbLtC/3kmSefKRvlaXakVXelgwC1LmIxeoggEHIPsYTM9oY+c50BbB3MN1PzZ
         ztRFxTMXCEi/LS6ReqEC+yhwuRpPNpew1aCkacxLjxR+6o8OvNELaAsWed2mu0Xy6sTg
         LSC1LWWTeG7iGZRH05OvKUo0DiKuzpZmUSR8Sh65yaCZOFYdFx9/pz9EcoYZFEEkvYHA
         0Hq4TPs+geit3UTfWCan84JbIcCbRdIQ3xXgpxpgMqodxhIEqGiSsIJmiXW2gxR0ahaw
         nZkU0vR8+nCzgHPDxKmftwe6aafPfUhZlp/pF7dQ2WCZDa2ne/pn+zPxaN9gGS6BzQ9J
         ANuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6g4MB/2Lu7rQpbPpIMGixYDX9MXNU274v9OKdeffZbE=;
        b=Qv/GNf4meQORV6bYD1aHUEp7nuzTwARUM2o6aZB6vOJVRCJGtoZ+CikGrOHzVon9jH
         EeproJy6bCLyWMbtClDdvM2NYPPe67tFMQM7oCMGtryCFM791lgVZcTMOA3CP+hDMFKK
         U2e2ea7BhWTKqGf+AE3DXWEgQYiLRv0x/Fww7cdSihTy3XVSgUomFjyyj/eyk1umFa6i
         ORtMHG25K7XskIqPBojV8IOKR0ko2+vx8q4c7iyU52unXeqqA1/Y8SODdS60vdiY22RQ
         BeX/YuiaXEGVVJ6gFmC5kqJINjajj09GQUfwneVK8DUUaQycVddNPFIX3AP1D9n8ds4y
         nzQQ==
X-Gm-Message-State: AOAM530D6HDSgLd5VD0/CsXWirz0/zHMxnwbRjQT39FzqRKVPe0F8nPV
        KUvyNCldq8gepA6ld45zT1ivhQ==
X-Google-Smtp-Source: ABdhPJxkwGanP9k5uHaWdzqLtlbIQi4vHZHZWqMwEnGtO1L9WgOz3dRcqHALXX5l8uFzidk/xR5LyQ==
X-Received: by 2002:a65:668b:0:b0:3f6:4026:97cd with SMTP id b11-20020a65668b000000b003f6402697cdmr28764470pgw.420.1654673876321;
        Wed, 08 Jun 2022 00:37:56 -0700 (PDT)
Received: from [10.71.57.194] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id s18-20020aa78d52000000b0050dc76281fdsm14134299pfe.215.2022.06.08.00.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 00:37:55 -0700 (PDT)
Message-ID: <c227453a-273b-16d4-59f8-36dd05027e51@bytedance.com>
Date:   Wed, 8 Jun 2022 15:37:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [External] Re: [PATCH v5 1/2] bpf: avoid grabbing spin_locks of
 all cpus when no free elems
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Dongdong Wang <wangdongdong.6@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20220608021050.47279-1-zhoufeng.zf@bytedance.com>
 <20220608021050.47279-2-zhoufeng.zf@bytedance.com>
 <CAADnVQ+kcONngR5mVm53KJZJOVQhR99TzZzv4KONcVY_H1rqEQ@mail.gmail.com>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <CAADnVQ+kcONngR5mVm53KJZJOVQhR99TzZzv4KONcVY_H1rqEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/6/8 上午11:39, Alexei Starovoitov 写道:
> On Tue, Jun 7, 2022 at 7:11 PM Feng zhou <zhoufeng.zf@bytedance.com> wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> This patch use head->first in pcpu_freelist_head to check freelist
>> having free or not. If having, grab spin_lock, or check next cpu's
>> freelist.
>>
>> Before patch: hash_map performance
>> ./map_perf_test 1
>> 0:hash_map_perf pre-alloc 975345 events per sec
>> 4:hash_map_perf pre-alloc 855367 events per sec
>> 12:hash_map_perf pre-alloc 860862 events per sec
>> 8:hash_map_perf pre-alloc 849561 events per sec
>> 3:hash_map_perf pre-alloc 849074 events per sec
>> 6:hash_map_perf pre-alloc 847120 events per sec
>> 10:hash_map_perf pre-alloc 845047 events per sec
>> 5:hash_map_perf pre-alloc 841266 events per sec
>> 14:hash_map_perf pre-alloc 849740 events per sec
>> 2:hash_map_perf pre-alloc 839598 events per sec
>> 9:hash_map_perf pre-alloc 838695 events per sec
>> 11:hash_map_perf pre-alloc 845390 events per sec
>> 7:hash_map_perf pre-alloc 834865 events per sec
>> 13:hash_map_perf pre-alloc 842619 events per sec
>> 1:hash_map_perf pre-alloc 804231 events per sec
>> 15:hash_map_perf pre-alloc 795314 events per sec
>>
>> hash_map the worst: no free
>> ./map_perf_test 2048
> The commit log talks about some private patch
> you've made to map_perf_test.
> Please use numbers from the bench added in the 2nd patch.
> Also trim commit log to only relevant parts.
> ftrace dumps and numbers from all cpus are too verbose
> for commit log.

Ok, will do. Thanks.

