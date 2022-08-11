Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF9758F5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiHKCJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiHKCJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:09:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E84844DA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:09:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a8so16443917pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=oSA+Jof75BuedTVbt4lBoiMeV523r3pp7Ny1EC5oo3o=;
        b=w0LbbLx22MfQERbKFdETrb3ybAIxu4PakWhNX0JhVR2NfpBhq7Yqripn1YP+hcGg1G
         NHY8+4Rr6yTKcDEvaGbHrUCApwsNJdhMdkRsTVYxZXLCqcgx+obRDTd/0VoA/KsyYkgM
         xH9Y6GqYr8VN+x4u/U0KUA9lBlMnHdXIWFeh5HvCHJAjtbs/dhQ9C3BiKrDuXjx9U1nb
         Bk0ohofkrChxG8d7tGGKbx2K0azQCe1H0MYPxRZTEfFLG2WGP0lilMgvtFYTnjho35Mo
         +AEvUT3AQhyadp5mfRNM58gAtRcMxqcI1P2jRVMQ96L2Kmxs15ulMY1H9dapgPZoyLZk
         pAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oSA+Jof75BuedTVbt4lBoiMeV523r3pp7Ny1EC5oo3o=;
        b=s+qFVGYNqkgeRm6x9xrAd3ErP7ss5N45Hije0qOZUAwrGnSlsuxWfHSUW1UDNsC6uT
         7i3zbi6kpCgAKJvUTkC9BKX80WCybjDAw4hl29+TyXaA4vurreRXpSlHX0k/S0AuD1Sx
         I2LOAXmC/dH1FP4EezbEUksGSB3VYXlJEPafFo2qloNSWZLie34S7tCHEO+L9BoZjf+M
         9Q/4hRc7nJ7EuD3j7nnPWIbQX6Z5BzN+SxzIEoCtLi2uyBvkG1FiMYVeEpnxj82yKTlx
         3OvJRHHtqJbyzLfBak1OY66pbu5JFsaW28d2U8ZYgJsboH7bWxruPtFpigCGY0uBkt6P
         vP9w==
X-Gm-Message-State: ACgBeo22kJdpZUMnzn43dsZr8aauuPzhOPXlLdgKO54jZ8YjkOYvcEpR
        qcVMZqkRu/1+HhQrvboCS9id0g==
X-Google-Smtp-Source: AA6agR7pEvJYGfeI5QBU3XEAHO0I7vZXYDuMiae/XSEL7US94LL05wzxU5jq93JPbtgmd163xcYB4A==
X-Received: by 2002:a17:903:230b:b0:16f:2276:1fc4 with SMTP id d11-20020a170903230b00b0016f22761fc4mr29113456plh.172.1660183777109;
        Wed, 10 Aug 2022 19:09:37 -0700 (PDT)
Received: from [10.70.253.98] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id y27-20020aa79e1b000000b0052df34124b4sm2741760pfq.84.2022.08.10.19.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 19:09:36 -0700 (PDT)
Message-ID: <cd4983dd-8432-7f79-1066-61b6f02e99c3@bytedance.com>
Date:   Thu, 11 Aug 2022 10:09:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     corbet@lwn.net, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
 <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
 <b89155d3-9315-fefc-408b-4cf538360a1c@bytedance.com>
 <YvPN07UlaPFAdlet@cmpxchg.org> <YvPqcJh5Ffv4Yga9@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YvPqcJh5Ffv4Yga9@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/11 01:27, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 10, 2022 at 11:25:07AM -0400, Johannes Weiner wrote:
>> How about just cgroup.pressure? Too ambiguous?
>>
>> cgroup.pressure.enable sounds good to me too. Or, because it's
>> default-enabled and that likely won't change, cgroup.pressure.disable.
> 
> .disable sounds more logical but I like .enable better for some reason. As
> for just cgroup.pressure, yeah, maybe? The conundrum is that the prettiness
> order is the exact reverse of the logical order. So, I'm okay with any of
> the three.

Ok, so I would like to pick the prettiest "cgroup.pressure", it also looks more
consistent with {cpu|memory|io}.pressure.

Thanks!

