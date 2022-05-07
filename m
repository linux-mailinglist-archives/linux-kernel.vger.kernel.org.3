Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB74B51E7E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbiEGOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbiEGOzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:55:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF37910FF4
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 07:51:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu29so17022308lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=02wpqp8xpRGu2+8JalnAVxZsm7qbiJHHSn2LDlYoYaQ=;
        b=OJC5lF5CMuih3uExbYLbioQn6rym2GPOBEXvkYU/5XM2Xds9sd42UAsNzTdWJ0dEbM
         7jB167FTrjKapqwm/vlr6k/W0zw44A/X5T18h8CuTrAr4PC/X6lPc4ZrCf0LRp8HWZjV
         DFV6Hg/9O+BtJihAYPXPZQN2raIzhxptV2Bbuzw3NB8UDjxLbgfSLbKUEV5KXWu06DF4
         gdJaBpXmFSv1cKfJ8omRIXStgJ9Xdjb9ULECamCee3FzEWRngtE28OGnPXw7YGIaq9nC
         MU5KaQTZ/wwe+UIXkxW+ov0ge0mBz9P94PT0LSouQQJN4IsWWZPJUHv0x6+Tp6RvTPSH
         q8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=02wpqp8xpRGu2+8JalnAVxZsm7qbiJHHSn2LDlYoYaQ=;
        b=fxV4D5tMN0GCyPOLwwzMCuRt0iMlM3vI/AgNCmvaEuCyLZZOmTIJJBpiPrF4a+lORE
         edqfyir1pRPlXWX720KfT3pRZ2nJtwB19aaK8JPf2eKdM5dZ+lNyJdgSxe96Jo3X/83h
         mxiuCvlmDDe3QVYmAjz/klblbDKpTT6rvxgf/psnRGizphwj9vLkptwd9g4jXpLKI9E6
         VQ9cvr4TAidPnFFROgNHjfCujr2UZ6E4zGfcYH0cqHoHYSOd3QRbofPjd8Ymzrju9WTv
         23TNlLM4bUVHDX6uhJGynMOKvLUjndDRNiggrBX7nSXG5YglL/mKtLqqBEJfvBYV4HwZ
         TKag==
X-Gm-Message-State: AOAM533k4c+wq3m0SiXkd0/muYz6BnKnQrKawcfqFLxh3UQKWsWL1rqL
        qt/M7CQKxQiFOen+4vIt8cTMtQ==
X-Google-Smtp-Source: ABdhPJz8YCKdUMsloPxVQPnCf9WLxBMwGkzZGF+Py3T38D3Bg5Bqc9L3PnmZz/ZInBANp2kavRXK2g==
X-Received: by 2002:ac2:5f84:0:b0:471:fd0f:a6e7 with SMTP id r4-20020ac25f84000000b00471fd0fa6e7mr6328314lfe.41.1651935078071;
        Sat, 07 May 2022 07:51:18 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id z4-20020a19e204000000b0047255d2117esm1136129lfg.173.2022.05.07.07.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 07:51:17 -0700 (PDT)
Message-ID: <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
Date:   Sat, 7 May 2022 17:51:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] percpu: improve percpu_alloc_percpu event trace
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kbuild-all@lists.01.org, Shakeel Butt <shakeelb@google.com>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
References: <8d627f02-183f-c4e7-7c15-77b2b438536b@openvz.org>
 <202205070420.aAhuqpYk-lkp@intel.com>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <202205070420.aAhuqpYk-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 23:38, kernel test robot wrote:
>>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>>> include/trace/events/percpu.h:11:1: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long flags @@     got restricted gfp_t [usertype] gfp_flags @@
>    include/trace/events/percpu.h:11:1: sparse:     expected unsigned long flags
>    include/trace/events/percpu.h:11:1: sparse:     got restricted gfp_t [usertype] gfp_flags
>    mm/percpu.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/percpu.h):
>>> include/trace/events/percpu.h:11:1: sparse: sparse: cast to restricted gfp_t
>>> include/trace/events/percpu.h:11:1: sparse: sparse: cast to restricted gfp_t
>>> include/trace/events/percpu.h:11:1: sparse: sparse: restricted gfp_t degrades to integer
>>> include/trace/events/percpu.h:11:1: sparse: sparse: restricted gfp_t degrades to integer
>    mm/percpu.c:2012:24: sparse: sparse: context imbalance in 'pcpu_balance_free' - unexpected unlock

The same messages are generated for any other gfp_t argument in trace events.
As far as I understand it is not a bug per se,
but trace macros lacks __force attribute in 'gfp_t'-> 'unsigned long' casts.
The same thing happens with mode_t and with some other places using __print_flags()
for __bitwise marked types.

I can make sparse happy, here and elsewhere but it requires a lot of __force attributes.
Is anyone interested in such patches, or can we silently ignore these messages?

Need to add __force attribute to all entries in __def_gfpflag_names array
and add few changes into trace description, below is an example.

> vim +11 include/trace/events/percpu.h
> 
> df95e795a72289 Dennis Zhou   2017-06-19  10  
> df95e795a72289 Dennis Zhou   2017-06-19 @11  TRACE_EVENT(percpu_alloc_percpu,
> df95e795a72289 Dennis Zhou   2017-06-19  12  
> df95e795a72289 Dennis Zhou   2017-06-19  13  	TP_PROTO(bool reserved, bool is_atomic, size_t size,
> dee6876db0a7a4 Vasily Averin 2022-05-06  14  		 size_t align, void *base_addr, int off,
> dee6876db0a7a4 Vasily Averin 2022-05-06  15  		 void __percpu *ptr, size_t bytes_alloc, gfp_t gfp_flags),
> df95e795a72289 Dennis Zhou   2017-06-19  16  
> dee6876db0a7a4 Vasily Averin 2022-05-06  17  	TP_ARGS(reserved, is_atomic, size, align, base_addr, off, ptr,
> dee6876db0a7a4 Vasily Averin 2022-05-06  18  		bytes_alloc, gfp_flags),
> df95e795a72289 Dennis Zhou   2017-06-19  19  
> df95e795a72289 Dennis Zhou   2017-06-19  20  	TP_STRUCT__entry(
> df95e795a72289 Dennis Zhou   2017-06-19  21  		__field(	bool,			reserved	)
> df95e795a72289 Dennis Zhou   2017-06-19  22  		__field(	bool,			is_atomic	)
> df95e795a72289 Dennis Zhou   2017-06-19  23  		__field(	size_t,			size		)
> df95e795a72289 Dennis Zhou   2017-06-19  24  		__field(	size_t,			align		)
> df95e795a72289 Dennis Zhou   2017-06-19  25  		__field(	void *,			base_addr	)
> df95e795a72289 Dennis Zhou   2017-06-19  26  		__field(	int,			off		)
> df95e795a72289 Dennis Zhou   2017-06-19  27  		__field(	void __percpu *,	ptr		)
> dee6876db0a7a4 Vasily Averin 2022-05-06  28  		__field(	size_t,			bytes_alloc	)
> dee6876db0a7a4 Vasily Averin 2022-05-06  29  		__field(	gfp_t,			gfp_flags	)
VvS: need to replace gfp_t to unsigned long ...

> df95e795a72289 Dennis Zhou   2017-06-19  30  	),
> df95e795a72289 Dennis Zhou   2017-06-19  31  	TP_fast_assign(
> df95e795a72289 Dennis Zhou   2017-06-19  32  		__entry->reserved	= reserved;
> df95e795a72289 Dennis Zhou   2017-06-19  33  		__entry->is_atomic	= is_atomic;
> df95e795a72289 Dennis Zhou   2017-06-19  34  		__entry->size		= size;
> df95e795a72289 Dennis Zhou   2017-06-19  35  		__entry->align		= align;
> df95e795a72289 Dennis Zhou   2017-06-19  36  		__entry->base_addr	= base_addr;
> df95e795a72289 Dennis Zhou   2017-06-19  37  		__entry->off		= off;
> df95e795a72289 Dennis Zhou   2017-06-19  38  		__entry->ptr		= ptr;
> dee6876db0a7a4 Vasily Averin 2022-05-06  39  		__entry->bytes_alloc	= bytes_alloc;
> dee6876db0a7a4 Vasily Averin 2022-05-06  40  		__entry->gfp_flags	= gfp_flags;
VvS: ... and use here (__force unsigned long)

> df95e795a72289 Dennis Zhou   2017-06-19  41  	),
> df95e795a72289 Dennis Zhou   2017-06-19  42  
> dee6876db0a7a4 Vasily Averin 2022-05-06  43  	TP_printk("reserved=%d is_atomic=%d size=%zu align=%zu base_addr=%p off=%d ptr=%p bytes_alloc=%zu gfp_flags=%s",
> df95e795a72289 Dennis Zhou   2017-06-19  44  		  __entry->reserved, __entry->is_atomic,
> df95e795a72289 Dennis Zhou   2017-06-19  45  		  __entry->size, __entry->align,
> dee6876db0a7a4 Vasily Averin 2022-05-06  46  		  __entry->base_addr, __entry->off, __entry->ptr,
> dee6876db0a7a4 Vasily Averin 2022-05-06  47  		  __entry->bytes_alloc, show_gfp_flags(__entry->gfp_flags))
> df95e795a72289 Dennis Zhou   2017-06-19  48  );
> df95e795a72289 Dennis Zhou   2017-06-19  49  
 Thank you,
	Vasily Averin
