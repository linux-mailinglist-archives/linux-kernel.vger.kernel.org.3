Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B83258E428
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 02:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiHJAjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 20:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHJAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 20:39:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A8E7822A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 17:39:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m2so12858372pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 17:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ocEP/lNDBd9drcOoXjaUPHob3Xt7j2o+0tElmpQe8kw=;
        b=C4FtFqDtCzEkv0O1zcdw15B+2OlUOBYzsJ+8jzPlnxWMk8K0WhIVNgtDISELPpkpJ2
         jYaoqwljoN9EI4J3bO4++EE1on9SLpz5WlGEUR6bgWI5RVwjrtsfPsfDxnsZwKldlCZ2
         MieUGAwNz+kZh2B6o+2nTjimIuZtE15+bOogRefCzNPBJlEUTtwiVpMlVJlUKBBf4AHa
         KKi3C61McekchJ5Hiw39yXSuof3TPXd+s2vikg6WDtxY9aSvjwNpnjTqr1Z5TR0dbv2n
         m2uCOjT7G57wfLV9G9GywDVNSq2r5MUmW8TkCl4E1Wo0y7qldg/xtiT5TyB+//x1IBHM
         QGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ocEP/lNDBd9drcOoXjaUPHob3Xt7j2o+0tElmpQe8kw=;
        b=TF3lHknjWCuq24gGUBezzAQyrJj+G89qyDN/lDXoawhF5eOS6WLpzxeTBr6ho6uDgA
         +O7ew6ls0QmqFNPaTemVh1rdkmmi5+Dw1izh+40hoodzz5W+UtmWXxQlDY3BRMK10WYD
         VhnEgmqZHctMSaMcNhT4suDh/SeglLGPG6jc8YS9HRkadjGLE/SoEccush74TjHCa1tm
         k7FLfvKpKUdQhM+4Jon+hwGetv8347tOv/555zave28RDy9ZD8Sz/uPjDQoZM8Yh0R6F
         iiLM8jpT+RF0Ycvg8T3yaP7BSMA6Vr7AYHUvqUAQr3RaRv8hnYDlEmwBxudIOfL1MJgh
         3fAA==
X-Gm-Message-State: ACgBeo0kSPCmrFCMHI/9srX1lgToNxJNSsPAv2eg8JoTeun9AVIsWJhx
        4fVyMmj2WdZ9OrItBPvTDPRj4w==
X-Google-Smtp-Source: AA6agR7zOnjNmt2AgEFDl138AXCOzdM+LOKWjhhdT+FF/dMSwHtv3sBVTmDQdaR24EyQKBLYLAnnAg==
X-Received: by 2002:a17:90b:4a50:b0:1f4:f1b9:d21f with SMTP id lb16-20020a17090b4a5000b001f4f1b9d21fmr981964pjb.185.1660091953281;
        Tue, 09 Aug 2022 17:39:13 -0700 (PDT)
Received: from [10.4.175.112] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7990a000000b0052e988c1630sm487753pff.138.2022.08.09.17.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 17:39:12 -0700 (PDT)
Message-ID: <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
Date:   Wed, 10 Aug 2022 08:39:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     hannes@cmpxchg.org, corbet@lwn.net, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YvKd6dezPM6UxfD/@slm.duckdns.org>
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

On 2022/8/10 01:48, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 08, 2022 at 07:03:40PM +0800, Chengming Zhou wrote:
>> So this patch introduce a per-cgroup PSI stats disable/re-enable
>> interface "cgroup.psi", which is a read-write single value file that
>> allowed values are "0" and "1", the defaults is "1" so per-cgroup
>> PSI stats is enabled by default.
> 
> Given that the knobs are named {cpu|memory|io}.pressure, I wonder whether
> "cgroup.psi" is the best name. Also, it doesn't convey that it's the
> enable/disable knob. I think it needs a better name.

Yes, "cgroup.psi" is not good. What abort "pressure.enable" or "cgroup.psi_enable"?

Thanks.

