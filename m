Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D245927DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiHOCo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiHOCoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:44:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D42513DD6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:44:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pm17so5868413pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HMJPJaMTIMpYySj8VKHm3Gs+nJ0hbxCawAYej8HKyzk=;
        b=7wc6o7/0pvyF+CyEyEa6HPmG6W0tpqwU5s8YgEaLxbvWMc7qZSYiafB1wW2qlhd3Xn
         y4/a3UDwUhqcgvp44r8MYcGNq2jfN75AUHGbd7K07xb1BcI00EilWEZd4OCas2W2Uvwh
         RUicsZJ7Z3xr751Vy66k8XDvovGQJlSZw1vSCSmtdXEdNTaW/puM/aiiqyzvf0MqYgAV
         atM+Tw3YzbUzm3Dr9sQfTVlneVQlbDIF9+KMzemSPVMez6jtJ/Qfbdp7f3y8f+ryBtgY
         fE/eaV4RRFVAMzJCcy4dYlexI6bWbwciz/dBn0qZqA/SHZVH5SDyqp/5p2PHEJOgyWrS
         a0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HMJPJaMTIMpYySj8VKHm3Gs+nJ0hbxCawAYej8HKyzk=;
        b=51ESEEVSELZ5EkaAUEXqaUAAUy+A+GmAhmSSQeJgn5zq6ZtGmE5UXxgs+j5HQm+tH3
         jzDea3xvTwqzxdCmp6MpVNiqFZGjaNQldpoUsZRQI4ERMWuSXXLBNkAvsZL5oUTOzqjg
         bLHKFCqiJNKX7n7HNMWQkQSJah6WExfwtJlYONXbcQz44WZE8z00ej1HoGGl1WoRus2+
         bOsYqovBN1wnGoTisGm7hTX4htluvU/pE5FRn8kOfrZTk1W/BHKwLAyIFjSkGAnshI2Z
         MUqTRxOq4x71MyX62Lydzo7HKnqeUBJvosbBkDn4tYausJMW4DnY8Da4MCfOpROT5owE
         yuHQ==
X-Gm-Message-State: ACgBeo3RgXGwKy++k6MasHkdzUxbIGoX/hlJK+Wm9gc2gdfW4nQTtHJX
        nq6AmTuEWhWiUnDmRxk/62Vvuc8K6xlsygY2
X-Google-Smtp-Source: AA6agR6nVaQZY93KoXRdYAmjfLmWsZy5x7alg5yp9vK3ofPmDE/iFfEyMMsL/ZyjhssuqA2kr5Rfjg==
X-Received: by 2002:a17:90a:f418:b0:1f3:223d:4349 with SMTP id ch24-20020a17090af41800b001f3223d4349mr26239379pjb.2.1660531463009;
        Sun, 14 Aug 2022 19:44:23 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090aa79200b001ef9659d711sm3622924pjq.48.2022.08.14.19.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 19:44:22 -0700 (PDT)
Message-ID: <9a6ea177-cbf8-abb1-2077-a2db4ce308bc@bytedance.com>
Date:   Mon, 15 Aug 2022 10:44:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Content-Language: en-US
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <CADjb_WRdvKm=uJGe2zE+D6fHkuCX4i+WkrWqz1A3VXmtdKN_Tg@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CADjb_WRdvKm=uJGe2zE+D6fHkuCX4i+WkrWqz1A3VXmtdKN_Tg@mail.gmail.com>
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

Hi Chen, thanks for your testing!

On 8/10/22 9:50 PM, Chen Yu Wrote:
> On Tue, Jul 12, 2022 at 4:45 PM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> When SIS_UTIL is enabled, SIS domain scan will be skipped if
>> the LLC is overloaded. Since the overloaded status is checked
>> in the load balancing at LLC level, the interval is llc_size
>> miliseconds. The duration might be long enough to affect the
>> overall system throughput if idle cores are out of reach in
>> SIS domain scan.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>
> Tested schbench and netperf on latest 5.19 vanilla, it seems that there
> is latency performance improvement when the load is low in schbench,
> and no performance difference on netperf.
> 
>   ./report.py -b 5.19.0+ -c 5.19.0-skip-sis-util+ -t schbench
> 
> schbench
> ========
> case            load    baseline(std%) compare%( std%)
> normal          mthread-1 1.00 (  0.00) +7.69 (  0.00)
> normal          mthread-2 1.00 (  0.00) +13.24 (  0.00)
> normal          mthread-4 1.00 (  0.00) -5.88 (  0.00)
> normal          mthread-8 1.00 (  0.00) -0.25 (  0.00)
> 
> 
> ./report.py -b 5.19.0+ -c 5.19.0-skip-sis-util+ -t netperf
> netperf
> =======
> case            load    baseline(std%) compare%( std%)
> TCP_RR          thread-28 1.00 (  0.62) +0.15 (  0.55)
> TCP_RR          thread-56 1.00 (  0.42) -0.26 (  0.40)
> TCP_RR          thread-84 1.00 (  0.29) +0.39 (  0.29)
> TCP_RR          thread-112 1.00 (  0.22) +0.44 (  0.23)
> TCP_RR          thread-140 1.00 (  0.17) +0.33 (  0.18)
> TCP_RR          thread-168 1.00 (  0.17) +0.19 (  0.16)
> TCP_RR          thread-196 1.00 ( 13.65) -0.62 ( 14.83)
> TCP_RR          thread-224 1.00 (  9.80) -0.65 (  9.67)
> UDP_RR          thread-28 1.00 (  0.89) +0.92 (  0.81)
> UDP_RR          thread-56 1.00 (  0.78) +0.38 (  0.73)
> UDP_RR          thread-84 1.00 ( 14.03) +0.78 ( 16.85)
> UDP_RR          thread-112 1.00 ( 12.26) -0.42 ( 11.95)
> UDP_RR          thread-140 1.00 (  9.86) -0.89 (  6.93)
> UDP_RR          thread-168 1.00 ( 11.62) -0.82 (  8.80)
> UDP_RR          thread-196 1.00 ( 19.47) +0.42 ( 16.50)
> UDP_RR          thread-224 1.00 ( 18.68) +0.72 ( 18.50)
> 
> 
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> 
