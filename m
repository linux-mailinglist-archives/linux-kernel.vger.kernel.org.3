Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF664B8A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiBPNf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:35:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiBPNf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:35:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD9912AB52E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645018514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9T93yMBwuHLVmetsIOIm5pO6KhHwAkYrHBQX/7ceMw=;
        b=YUq2SVIygpWIJP6K6yfehXC5+CpXAJJDYIsL0G78Nbt0OXe4vhfCalFp6pLRizfI8Em7t6
        eKGGxGw/AWeMKwjvDId8Bkv0RrHKeVYcsACpLrVZ2YNW2Rb8wdg66qME08AvSoLzzt8XLe
        Vr/O7XFUbNzPkvpt8Rxizy3JCh4qOCo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-13UOEvIQOHmC2DyRoQbQoA-1; Wed, 16 Feb 2022 08:35:13 -0500
X-MC-Unique: 13UOEvIQOHmC2DyRoQbQoA-1
Received: by mail-ej1-f72.google.com with SMTP id m12-20020a1709062acc00b006cfc98179e2so848431eje.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G9T93yMBwuHLVmetsIOIm5pO6KhHwAkYrHBQX/7ceMw=;
        b=CzaP/bPWmZZCoicOQZcKXLjEEiHcg6KCndHdrI8PE7A4walGMQZG6mBtHqsLDYxwyt
         mXVf+qmfF7TKw5ARYP4mlWTrP+3H1t5AV39nNt8WC4dZx1U1M7ep7lpsr60bsDOjxTz4
         mugSc7LiB/bJBvrhMEYdle350UFQQ/+s4wrgYJQ01lMkw6sCYcxwonJ9+iIL1bCzbpid
         inp78oc6t+uUlAc9YvZl3A7L1oAdxhuKI0hqzKweZ0jj50vCZQG1AbR8h3TEj/WUZhK5
         V5eXVe58koS5WLgtAhVSfxDq5ctWhR/xjCGurn/d8XTlQhg1iJkax9WRHpX45QO8wwcT
         WovQ==
X-Gm-Message-State: AOAM530fLYVWMHsZSdrqrLqm4UrGLTYX1WLXnc3EIzaOrIpG+6iLJWel
        6u2n10OU0s4tWLlwOL5fGpwRaGVZ4zxXJ57JheGrV3M5A7+cqcvVU1zbC9qvk2hzipnMG1mZGHE
        IOzJ2w7VU9uEEhM/Qec8yxwFR
X-Received: by 2002:a17:906:5f96:b0:6bb:3024:9444 with SMTP id a22-20020a1709065f9600b006bb30249444mr2532981eju.298.1645018512456;
        Wed, 16 Feb 2022 05:35:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBYvQds+5YgvW96nRohBbndSrcG5IzmjDlT+RvWYFJV9kYVpohRBiVwfSqqB5r5UNO9L/MOQ==
X-Received: by 2002:a17:906:5f96:b0:6bb:3024:9444 with SMTP id a22-20020a1709065f9600b006bb30249444mr2532963eju.298.1645018512231;
        Wed, 16 Feb 2022 05:35:12 -0800 (PST)
Received: from [192.168.1.173] ([78.157.137.28])
        by smtp.gmail.com with ESMTPSA id e26sm5398696ejl.139.2022.02.16.05.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:35:11 -0800 (PST)
Subject: Re: [PATCH] x86, vmlinux.lds: Add debug option to force all data
 sections aligned
To:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>
References: <20220216082802.96054-1-feng.tang@intel.com>
From:   Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <1f0b2e18-5fad-7ef2-bbfb-d6662ecad252@redhat.com>
Date:   Wed, 16 Feb 2022 14:35:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220216082802.96054-1-feng.tang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 9:28 AM, Feng Tang wrote:
> 0day has reported many strange performance changes (regression or
> improvement), in which there was no obvious relation between the culprit
> commit and the benchmark at the first look, and it causes people to doubt
> the test itself is wrong.
> 
> Upon further check, many of these cases are caused by the change to the
> alignment of kernel text or data, as whole text/data of kernel are linked
> together, change in one domain can affect alignments of other domains.
> 
> To help quickly identifying if the strange performance change is caused
> by _data_ alignment, add a debug option to force the data sections from
> all .o files aligned on THREAD_SIZE, so that change in one domain won't
> affect other modules' data alignment.
> 
> We have used this option to check some strange kernel changes [1][2][3],
> and those performance changes were gone after enabling it, which proved
> they are data alignment related. Besides these publicly reported cases,
> recently there are other similar cases found by 0day, and this option
> has been actively used by 0Day for analyzing strange performance changes.
...
> +	.data : AT(ADDR(.data) - LOAD_OFFSET)
> +#ifdef CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED
> +	/* Use the biggest alignment of below sections */
> +	SUBALIGN(THREAD_SIZE)
> +#endif

"Align every input section to 4096 bytes" ?

This is way, way, WAY too much. The added padding will be very wasteful.

Performance differences are likely to be caused by cacheline alignment.
Factoring in an odd hardware prefetcher grabbing an additional
cacheline after every accessed one, I'd say alignment to 128 bytes
(on x86) should suffice for almost any scenario. Even 64 bytes
would almost always work fine.

The hardware prefetcher grabbing an additional cacheline was seen
adversely affecting locking performance in a structure - developers
thought two locks are not in the same cacheline, but because of
this "optimization" they effectively are, and thus they bounce
between CPUs. (1) Linker script can't help with this, since it was
struct layout issue, not section alignment issue.
(2) This "optimization" (unconditional fetch of next cacheline)
might be bad enough to warrant detecting and disabling on boot.

