Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1445052E632
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346391AbiETHYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbiETHYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:24:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41DF14ACB9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:24:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m6so8731252ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qdKh+N5pd3RacKLxyxnq7jBphDna5YoiYMrg0p2wipA=;
        b=5jgKeLMV735gNvNQvBxyWcKxrinA/LTQb+b782a1NT6dU8Hb8SwexSfGf3rr6Urfg/
         A4ulspIJhZ3yOgPJZd+EKgl0kpahqXgFG9HCgN1Wc8GjBaWrXg58cC/HpNBxipLfUVmm
         C4fRFmODcna91lSjcUnQol9cuES8Sfnijsv9sdrHJicrrtFayez6dTiUhjC7pthBoeHx
         YzHcD5rk+a4JszXIOzAp2/GDY88BpXCM9JJQ5708wwNf3+X8K7fuOM1ykSdVtKAi/wEY
         AAcr0ZK59rSxCEkQPd0o2XuJ8TO5oJrKJjaWcEdEDp+nfQDK0PNHPwv3MkelltsubHI0
         Rj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qdKh+N5pd3RacKLxyxnq7jBphDna5YoiYMrg0p2wipA=;
        b=63fiKJDWXDo46xGJYusB0QuEZrNmeO1iaXYTTVKLz9j10afXrPUsJCKsQryfRF2iT8
         XEKpa7vpGshsZ1yatjFGrG8oGXcAUrCZmWqL9EoPN2sI3uOLoF5zgJQfRoebRSD79dAR
         BMrB2fHQOyfrpu04gY3pBbwXbc2tQE9oGRm+zqu859cRncXc7EQDY5H1Brraf9jvPNR1
         ygX+F2to+VlKQiRJTEm0zfl01xb2AXAAdCQY1xba8DE9BGUpW8MtbYSfwFuH/qray0hs
         /UM1zKpX8LTBrRQ3qpSIfbRjfKXwWsEx2mMZ4kkik6I25eXF+hI635XiiWzbvGNkhyNZ
         Nfmw==
X-Gm-Message-State: AOAM532s9s0TD1lyknPeEqAj44ZQl/SVG2bqFCO6Dj9n0aB1Zlq8NeO4
        qhRSxx2tyXGyMMpF423D5cNpsA==
X-Google-Smtp-Source: ABdhPJy3pZrIblijGkkmbsPnHlT6LOpwgAE+0dEz6mmF+y0dU0RP9kZq360DQ/TaMoF+DperxoWqgA==
X-Received: by 2002:a2e:a88b:0:b0:24b:5714:213d with SMTP id m11-20020a2ea88b000000b0024b5714213dmr4795246ljq.412.1653031448051;
        Fri, 20 May 2022 00:24:08 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id n3-20020ac242c3000000b0047255d211e8sm550736lfl.279.2022.05.20.00.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 00:24:07 -0700 (PDT)
Message-ID: <740dfcb1-5c5f-6a40-0f71-65f277f976d6@openvz.org>
Date:   Fri, 20 May 2022 10:24:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/4] memcg: enable accounting for struct cgroup
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Ynv7+VG+T2y9rpdk@carbon>
 <a17be77f-dc3b-d69a-16e2-f7309959c525@openvz.org>
 <20220519165325.GA2434@blackbody.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220519165325.GA2434@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 19:53, Michal Koutný wrote:
> On Fri, May 13, 2022 at 06:52:12PM +0300, Vasily Averin <vvs@openvz.org> wrote:
>> Creating each new cgroup allocates 4Kb for struct cgroup. This is the
>> largest memory allocation in this scenario and is epecially important
>> for small VMs with 1-2 CPUs.
> 
> What do you mean by this argument?
> 
> (On bigger irons, the percpu components becomes dominant, e.g. struct
> cgroup_rstat_cpu.)

Michal, Shakeel,
thank you very much for your feedback, it helps me understand how to improve
the methodology of my accounting analyze.
I considered the general case and looked for places of maximum memory allocations.
Now I think it would be better to split all called allocations into:
- common part, called for any cgroup type (i.e. cgroup_mkdir and cgroup_create),
- per-cgroup parts,
and focus on 2 corner cases: for single CPU VMs and for "big irons".
It helps to clarify which allocations are accounting-important and which ones
can be safely ignored.

So right now I'm going to redo the calculations and hope it doesn't take long.

Thank you,
	Vasily Averin
