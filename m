Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2805E571FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiGLPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiGLPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95DCBC1FFE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657641197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H3SEhwY9eW7/5EBo+MkFrnSuVtppUJZMUl0OSZBCqiw=;
        b=Tf1L/2KYgGaS5TzoMCr+Q/z3uRZ1MCA8CLHaptCIURb7fo2Y10RGQoB+pU2v5/5klfE93a
        9lqvILvXYBSnD2iyr39TcQInNpESIxcBzfoah8/k9VLOs5F8Vr2ibDPbhNS3F7WljV120l
        RJl+YI/F/y7gUWLmLxEG2YDJ8wSLTp0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-ecr_lRr9NrSunpzVOzuTCg-1; Tue, 12 Jul 2022 11:53:16 -0400
X-MC-Unique: ecr_lRr9NrSunpzVOzuTCg-1
Received: by mail-wr1-f72.google.com with SMTP id e16-20020adf9bd0000000b0021d9c17e980so1454174wrc.15
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=H3SEhwY9eW7/5EBo+MkFrnSuVtppUJZMUl0OSZBCqiw=;
        b=DcmEOrCTw+lABECyvAMZl5QMjVLlamBoZVhOE8xXl9l2bXkmJYqx+cVe8wpyTz5z8f
         rCcjz0sTRgVJQJ/WlJ7NSYQuZvCq5eaHjf+z+OjXXkofa0PRQI9Am2nrWGk0vvPkZbOq
         6btsyKtzkUy5ePHyQQlZQdGEC7qjMk6M6rqFgiL5dNC5svKXeN8m0aTGsS6zl6IB+QZS
         QC42AzLka/9URh3Np0LOyGdZ4KLt4OviIQmoPGrlwmnttHE541Ib3CiKVI5rFspu6u2f
         0SBtUuxAG0SjoaD/4Cb92QYrL5UJ+iReCSwIkRYkHZcGZ3X03smP8fIro5qcdpbQvuaR
         XPDA==
X-Gm-Message-State: AJIora89tLwes/mCtZ3VaznLkf7/9q1u4UC26bRMfVfauqXKogNRe9Lb
        yx9PDVPoI7E3kLuXlj9VXrWTGURpSV5FCPkgtOdyWis4mg/uIXeyNnaFi3h6OepInTo7EgTI1h7
        hmeNNOVdq8Zmoyhna0G8FrsN2Aeo1mEsKdAFHUXYf4+nluZknj+z21IvDDg5EC5x1iRFzP49TWq
        FN
X-Received: by 2002:a05:6000:2cc:b0:21d:76d8:1f2c with SMTP id o12-20020a05600002cc00b0021d76d81f2cmr22793949wry.471.1657641195141;
        Tue, 12 Jul 2022 08:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vhbl7ptjnlxWiWADc93FrLuLR+G3s7XzTMM2/TEMlgK4DA/k0Sj/58daJPrb8HrJ8b491rBQ==
X-Received: by 2002:a05:6000:2cc:b0:21d:76d8:1f2c with SMTP id o12-20020a05600002cc00b0021d76d81f2cmr22793921wry.471.1657641194898;
        Tue, 12 Jul 2022 08:53:14 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003a2cfb9f5basm13602384wmb.16.2022.07.12.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:53:14 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] sched/topology: Optimized copy default
 topology in sched_init_numa()
In-Reply-To: <e5eed9c9-afd4-e88c-dbee-7fef2e76043a@bytedance.com>
References: <20220627105349.80715-1-jiahao.os@bytedance.com>
 <xhsmh35fhgcww.mognet@vschneid.remote.csb>
 <e5eed9c9-afd4-e88c-dbee-7fef2e76043a@bytedance.com>
Date:   Tue, 12 Jul 2022 16:53:12 +0100
Message-ID: <xhsmhtu7m72fr.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/22 18:28, Hao Jia wrote:
> On 2022/7/4 Valentin Schneider wrote:
>>
>> It's not a very hot path but I guess this lets you shave off a bit of boot
>> time... While you're at it, you could add an early
> Thanks for your time and suggestion.
>>
>>    if (nr_node_ids == 1)
>>            return;
>>
>
> This will cause the values of sched_domains_numa_levels and
> sched_max_numa_distance to be different from before, and
> sched_domains_numa_levels may cause the return value of
> sched_numa_find_closest() to be different.
> I'm not sure if it will cause problems.
>

True, we need to be careful here, but those are all static so they get
initialized to sensible defaults (zero / NULL pointer).

sched_numa_find_closest() will return nr_cpu_ids which make sense, so I
think we can get away with an early return

>> since !NUMA systems still go through sched_init_numa() if they have a
>> kernel with CONFIG_NUMA (which should be most of them nowdays) and IIRC
>> they end up with an unused NODE topology level.
>>
>
> I'm confused why most !NUMA systems enable CONFIG_NUMA in the kernel?
> Maybe for scalability?
>

It just makes things easier on a distribution point of view - just ship a
single kernel image everyone can use, rather than N different images for N
different types of systems.

AFAIA having CONFIG_NUMA on an UMA (!NUMA) system isn't bad, it just adds
more things in the sched_domain_topology during boot time which end up
being unused.

