Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A4058E484
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiHJBbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiHJBbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:31:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DD62AFC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:31:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ha11so13356887pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 18:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jArUS+cTDYrc34PVoRCPXKulj9z0Omh43tDAwlnBe04=;
        b=q6v8963dnNMz7nntm/3Rkm2/pPAeQvZ68R1TjZNVjNGTvgs6GYfS9Zsg888AKEaQSk
         ITgVZHKn5W6QHF1JYsP5vCpSdHO9NQlCBC2Z5DRVUMhEPNDXg+kZ4D4v7o7R2UoISGuk
         RzOKhIR3iJ5OdBOmoTcqzoJXJVZkaAJoVi2C60AsWLNwIBX4DQLI/Lc1+JVj+ynGe77J
         z88XqIDu+2Zh8WYB/nqhfbCsqsMUoAk/KkJdvBfUpJbV4K+pPcFCWz49p+pw4jUTccwn
         xp1YxVvk0IsJCEnppqbKMvnxkQirm5wazIlNeoIYMTTHBoSA25f68A+vuB+fGnT/LAwx
         0smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jArUS+cTDYrc34PVoRCPXKulj9z0Omh43tDAwlnBe04=;
        b=0OhJOf+yk8FxvII39cl+0xTQ59fHCFixRTHjJYmc4+PYIdXZrYjbgo4tsRMXDq/Nnk
         1qCARuEcFH5FrYpShhU6zAQ7KsYkHd4sVkqoteBtpkM4tp46V1vsDnIou/vq2lncNBNs
         vzR7VT1FPsMakc/vsrUApamrgE5NmhAa7vNpb56FZ06sNQESjhf31d6pZGa1xaJCVQRa
         +yoHZ/Cq+39njApeWlAP9i9CeLtzOUjjjvX/6PdgkAN+TBBItOlW9rgql10WUih6Y5le
         rSz8l1EBWmhJHnS25jOCeYKgkk03xOdQeHp2iQIQMZWkxaQpNG0qouCZfTjoKS0/5Bzs
         txQg==
X-Gm-Message-State: ACgBeo2QWOK/vFu4+eHrePxrVTeMUCUJhmz04XO8sQx9Fn3fieP7IOHr
        4quD3+6s5C6vHh9H0vfVMAZAZg==
X-Google-Smtp-Source: AA6agR7BLT3O6pJwmoNbS0ABHMXRhfGmTLSClhLCrhYSoJTn7kkIjqU4c2KyxC+3G7/tpmrYadq8gA==
X-Received: by 2002:a17:90b:3586:b0:1f4:d507:783e with SMTP id mm6-20020a17090b358600b001f4d507783emr1158932pjb.171.1660095068808;
        Tue, 09 Aug 2022 18:31:08 -0700 (PDT)
Received: from [10.4.175.112] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090a2dc100b001f21f5c81a5sm243187pjm.19.2022.08.09.18.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 18:31:08 -0700 (PDT)
Message-ID: <b89155d3-9315-fefc-408b-4cf538360a1c@bytedance.com>
Date:   Wed, 10 Aug 2022 09:30:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     hannes@cmpxchg.org, corbet@lwn.net, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
 <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
In-Reply-To: <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
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

On 2022/8/10 08:39, Chengming Zhou wrote:
> On 2022/8/10 01:48, Tejun Heo wrote:
>> Hello,
>>
>> On Mon, Aug 08, 2022 at 07:03:40PM +0800, Chengming Zhou wrote:
>>> So this patch introduce a per-cgroup PSI stats disable/re-enable
>>> interface "cgroup.psi", which is a read-write single value file that
>>> allowed values are "0" and "1", the defaults is "1" so per-cgroup
>>> PSI stats is enabled by default.
>>
>> Given that the knobs are named {cpu|memory|io}.pressure, I wonder whether
>> "cgroup.psi" is the best name. Also, it doesn't convey that it's the
>> enable/disable knob. I think it needs a better name.
> 
> Yes, "cgroup.psi" is not good. What abort "pressure.enable" or "cgroup.psi_enable"?

Doesn't look good either, what do you think of "cgroup.pressure.enable"?

Thanks.

