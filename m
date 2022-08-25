Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCE5A0B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiHYIWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiHYIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD78A2A85
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661415749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWsuQmDZ53RMfU7VereuhMyA9Iegsk4DOCD2DeIEmdg=;
        b=DXL4SS9YyHfdwq+aespas6a5+2ZAcjXGxXx6o+UaDtDxlzOFxQNvmzOL1rQBk4iL4GTe91
        jG/CMu7ZqzbVw3ilddg+IQHAezZ4iNNa05XZtEboKKxtsu8iLmmWoLArchICJ/vCWObOg0
        /5ULjWUi/4zJ3FyMoSCDKRxffsS0Z8A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-FgtXv_9iNqu17Cnb2GzQIw-1; Thu, 25 Aug 2022 04:22:21 -0400
X-MC-Unique: FgtXv_9iNqu17Cnb2GzQIw-1
Received: by mail-wm1-f71.google.com with SMTP id h82-20020a1c2155000000b003a64d0510d9so5639433wmh.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=gWsuQmDZ53RMfU7VereuhMyA9Iegsk4DOCD2DeIEmdg=;
        b=fJ5U0BTi9Pm1GeaNSFGk1wxhozsp+uatrWbJLsAc4KT8QPxuusLl27bUypuRAMYTTE
         ZXFaTY7Q+bbTzn2WL0sQxmWfHW9rmlzuKxMq4I307S41vDMNWbTTxEbtTv1y+Yep8XeR
         QVZxItDA6xO7aHWPL8560255sQLpzy35icAOpBzKJxrZMwul9M/lBGs56K6uaPsWNHsN
         N18OKJwnx36sj64bfAu3WqEsqiw1J2PR36zAAlhhIEY6WRz4BloithlI9ZR0vZr6WL2i
         OA0l3S8Bd2J/M1puIhTBCwRTzE5/gIeWh5tZ/A5vrEZxDajr51NkbnubgR2Uw87UdKHb
         h+6g==
X-Gm-Message-State: ACgBeo0Cna/HWaLg4JZhFoyoP19Vfd5M5vcYLh7sl+FU5Y/BvjyFKav7
        zkb69dZdtjP05XFfSXQg9bpuDZ3+czUr0/uSaAkDr6xOOeeffIRCyCnx1iyfUACDQjS1Te99UMn
        s2AN4E/csbwUy3dx/7zbY2asg
X-Received: by 2002:a05:6000:2ca:b0:225:6004:8cf1 with SMTP id o10-20020a05600002ca00b0022560048cf1mr1465540wry.477.1661415740707;
        Thu, 25 Aug 2022 01:22:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6jW+15n76wSRMHxT+rAFDODLxyVf6L/Jnd78XG/YAuheLiBF62+F5CbLL+qA9xgxWrpzIkmA==
X-Received: by 2002:a05:6000:2ca:b0:225:6004:8cf1 with SMTP id o10-20020a05600002ca00b0022560048cf1mr1465530wry.477.1661415740450;
        Thu, 25 Aug 2022 01:22:20 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c1d9300b003a6077384ecsm4753841wms.31.2022.08.25.01.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:22:19 -0700 (PDT)
Message-ID: <76d906e8-4c2b-0832-dc43-5fb49b5c6cc5@redhat.com>
Date:   Thu, 25 Aug 2022 10:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] mm: slince possible data races about pgdat->kswapd
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     muchun.song@linux.dev, linux-kernel@vger.kernel.org
References: <20220824071909.192535-1-wangkefeng.wang@huawei.com>
 <20220824071909.192535-2-wangkefeng.wang@huawei.com>
 <e5223895-6319-1911-28bf-09449ded96c9@redhat.com>
 <fe06a35b-229f-c143-0200-33dbb315f0fe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <fe06a35b-229f-c143-0200-33dbb315f0fe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.22 04:34, Kefeng Wang wrote:
> 
> On 2022/8/24 16:24, David Hildenbrand wrote:
>> On 24.08.22 09:19, Kefeng Wang wrote:
>>> The pgdat->kswapd could be accessed concurrently by kswapd_run() and
>>> kcompactd(), it don't be protected by any lock, which could leads to
>>> data races, adding READ/WRITE_ONCE() to slince it.
>> Okay, I think this patch here makes it clearer that we really just want
>> proper synchronization instead of hacking around it.
>>
>> What speaks against protecting pgdat->kswapd this using some proper
>> locking primitive?
> 
> as comments about kswapd in struct pglist_data,  pgdat->kswapd should be
> 
> protected by mem_hotplug_begin/done(), how about this way?
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 640fa76228dd..62018f35242a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1983,7 +1983,13 @@ static inline bool is_via_compact_memory(int order)
> 
>   static bool kswapd_is_running(pg_data_t *pgdat)
>   {
> -       return pgdat->kswapd && task_is_running(pgdat->kswapd);
> +       bool running;
> +
> +       mem_hotplug_begin();
> +       running = pgdat->kswapd && task_is_running(pgdat->kswapd);
> +       mem_hotplug_end();
> +
> +       return running;
>   }

I'd much rather just use a dedicated lock that does not involve memory
hotplug.


-- 
Thanks,

David / dhildenb

