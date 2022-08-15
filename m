Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926F359305D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbiHON7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiHON7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:59:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B11122B16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:59:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id jm11so4180377plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gYLMwJl3NqL1MH7BfhUrQSE5Y3rEltoe6FStUMqBxDI=;
        b=W2TsMdlSfECTGIJ58CoX+zpPXKllKXkKofGMaE0tAk68/ssCPnfEZRpUUxqagEO8IM
         g3OQuiRCNdjWxzODBmQJShRlJWcy2ZkOq0NePdgQDJDvDDDbJuoOE14/dg/gfa4FfJ2M
         MKCIpAFywB84XKT8r1n0xOzXjC2bOzMsO6TSm+G+P607uNWtZrlgZG3JwJU4AKQ/lDz6
         /iNZ5qR1tHqGOKpt5BdHRRzMBjO6Fo21W+6Aavlzxp8XKW/vZ2z6jFMlghiEUt6qvyCn
         5sYF3iqiMX0pl9F4vYkaxW9wsKMsN0JbXQCnixaNAvQT2lhf1jWiVnmZNryLGhli9Ant
         oEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gYLMwJl3NqL1MH7BfhUrQSE5Y3rEltoe6FStUMqBxDI=;
        b=19q8147WxKXA0dqpoGbMxkh8/VGHeytVpeiaKicTNecJjjiN4IkEFEh7CTy1pEBD6i
         Sa2ACUsh9hBA9sOXCKhf5N6/BcL3hURCZjLThCHii/UM7BUFE/B+MOaqQhi+SaWaTKOE
         xi18r/2RRTq6agxdm1+s4eK1hoyPubiFjZOoWlAiL6JBA7ttiLmjCTDT4l591KVvCXlE
         pHO4F8TK37lWTb1w3hU6CI+m2PnMvrK00Gol9QFwvrdUA4Dr1KJSNdSAhZvaZ9F1dcTI
         tJGOrgtJ3ak8v8kgobJbfZrHrbBfXfcMNCL+qjxFQVTprVDvM7cBxggTM/yfgSoXG1cr
         Fi7w==
X-Gm-Message-State: ACgBeo0XBbgJ5ox37CjTapybw7APpNZm3wSgGmhHALOMpqyVWaaVBP9L
        WsL09dedU0QPT2sSUfBl6zVrwg==
X-Google-Smtp-Source: AA6agR4hciO1La3ySB4NpnxnAka7c32UzQNn3TlPYUUC+HmN5100km4viSKL/BvKGHlhQ5bqS4PdyA==
X-Received: by 2002:a17:90b:388e:b0:1f5:40d4:828d with SMTP id mu14-20020a17090b388e00b001f540d4828dmr18972421pjb.31.1660571986101;
        Mon, 15 Aug 2022 06:59:46 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902c40400b0016d21697ed9sm7053629plk.48.2022.08.15.06.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:59:45 -0700 (PDT)
Message-ID: <e834147d-ff5a-9212-5458-3ba91475c21d@bytedance.com>
Date:   Mon, 15 Aug 2022 21:59:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v4 0/7] sched/fair: improve scan efficiency of SIS
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <dfcfae9c-caae-1d94-3f7d-de3d644de9e0@amd.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <dfcfae9c-caae-1d94-3f7d-de3d644de9e0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi K Prateek, thanks for your test and sorry for the late reply..

On 7/18/22 7:00 PM, K Prateek Nayak Wrote:
> Hello Abel,
> 
> We've tested the patch on a dual socket Zen3 System (2 x 64C/128T).
> 
> tl;dr
> 
> - There is a noticeable regression for Hackbench with the system
>    configured in NPS4 mode. This regression is more noticeable
>    with SIS_UTIL enabled and not as severe with SIS_PROP.
>    This regression is surprising given the patch should have
>    improved SIS Efficiency in case of fully loaded system and is
>    consistently reproducible across multiple runs and reboots.

The regression seems unexpected, I will try to reproduce with my
Intel server. While staring at the code, I found something may be
relative to the issue:

  - The cpumask_and() in select_idle_cpu() is before SIS_UTIL which
    could bail out early. So when SIS filter is enabled, lots of
    useless efforts could be made if nr_idle_scan==0 (e.g. 16groups).
    While the SIS_PROP case is different, the efforts done by the
    filter won't be all in vain, that's probably the reason why the
    regression under SIS_UTIL is more noticeable. I am working on a
    patch to optimize this.

  - If nr_idle_scan == 0 then select_idle_cpu() will bail out early,
    so it's pointless to update SIS filter which may further burden
    the overhead together with the above issue. This will be fixed
    in next version.

I will rework the whole patchset to fit the new SIS_UTIL feature.

> 
> - Apart from the above anomaly, the results look positive overall
>    with the patched kernel behaving as well as, or better than the tip.

Cheers!

> 
> [..snip..]
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Hackbench - 15 runs statistics
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> o NPS 4 - 16 groups (SIS_UTIL)
> 
> - tip
> 
> Min           : 7.35
> Max           : 12.66
> Median        : 10.60
> AMean         : 10.00
> GMean         : 9.82
> HMean         : 9.64
> AMean Stddev  : 1.88
> AMean CoefVar : 18.85 pct
> 
> - SIS_Eff
> 
> Min           : 12.32
> Max           : 18.92
> Median        : 13.82
> AMean         : 14.96	(-49.60 pct)
> GMean         : 14.80
> HMean         : 14.66
> AMean Stddev  : 2.25
> AMean CoefVar : 15.01 pct
> 
> o NPS 4 - 16 groups (SIS_PROP)
> 
> - tip
> 
> Min           : 7.04
> Max           : 8.22
> Median        : 7.49
> AMean         : 7.52
> GMean         : 7.52
> HMean         : 7.51
> AMean Stddev  : 0.29
> AMean CoefVar : 3.88 pct
> 
> - SIS_Eff
> 
> Min           : 7.04
> Max           : 9.78
> Median        : 8.16
> AMean         : 8.42	(-11.06 pct)
> GMean         : 8.39
> HMean         : 8.36
> AMean Stddev  : 0.78
> AMean CoefVar : 9.23 pct
> 
> The Hackbench regression is much more noticeable with SIS_UTIL
> enabled but only when the test machine is running in NPS4 mode.
> It is not obvious why this is happening given the patch series
> aims at improving SIS Efficiency.

The result seems to get some kind of connection with the LLC size.
I need some time to figure it out.

> 
> It would be great if you can test the series with SIS_UTIL
> enabled and SIS_PROP disabled to see if it effects any benchmark
> behavior given SIS_UTIL is the default SIS logic currently on
> the tip.

Yes, I will.

Thanks & Best Regards,
Abel
