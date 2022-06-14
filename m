Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC0354AA63
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354172AbiFNHVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354086AbiFNHVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:21:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F9F31DF9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:20:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso8310903pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x3VzGr/fSHQypY+i+ztObznAHCuT0co5thLO7MdpFL0=;
        b=zzQhFHJOXlSKySb9yp1KQ1ub6zLwe6JGFCECrYPIUu1EJieVGCVAnZqJJ8aqUBwTMK
         WwiuS+k6jzu2XtIPtpM5WDZ/oKx7GWoEAVYHv3emsjnt+5071h4zc5znKs7MFr6wDE2b
         TYyH+tQcrA3/9VIkrQVhK3WVpdAP4q5tGyPZ0H08doT/RAbCrurW25CDX9dFydpMxB+y
         SUtNvsDCaf5HBgLl6pZsR+frFFzH8C51yXJo2ogUwpT43PTNU8kMtKDmCoKixBxxdIHO
         9aWtob3CUmV40bFtrxj2m9m930RV6lTcD2n2Hq9CF4f+WhYukD+LFj2tS8C8rcPqIjCc
         le0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x3VzGr/fSHQypY+i+ztObznAHCuT0co5thLO7MdpFL0=;
        b=anD55c1z77EXKcVkPu9rATr6pSJvRU0uuY0wecI7+0ZoiJQGZJd1GvJMW/aXG0Fcpz
         NIEkKo3GKyr39Hkn9sDw4NeAtSi9IomZK//kun9Dx9FQKOMK/rq1ABLZsiqr0oiPqvcx
         r0N8RwcO5l7HtzPEIQlHiulPB8ZM9la5lISkrUy5gA5X0QnAej52VHd1vnCLeZnBvSFH
         d/2vr1FCsPLA6xafeI0GD+yYsx0PfwK35afYY3meoPXD1/DBGXMN0/FVJJBCTaJErT9j
         4rrKt2aIZ/IaGmp2GGXTmf9i4gzLif8FFWZO4ErKfCWH7LKgRPG4Ff+Ssvs5tzWnibGG
         FSuA==
X-Gm-Message-State: AJIora9UD99R0LQDb7RP52tbT2KjFHx/xotg73ol6N970agR/zMrWdC7
        ZI+3vc6Hw0P+Y3iy9VINjBTpdTs/49BGOgsc
X-Google-Smtp-Source: AGRyM1tupFfevnhvE3qrqzeChNwFv1DJYZzyH0DgykcokUf98ZLv9a17HvvfC58GfIOeq4lT/zsgaw==
X-Received: by 2002:a17:90a:d104:b0:1ea:b84b:a084 with SMTP id l4-20020a17090ad10400b001eab84ba084mr3068817pju.95.1655191251044;
        Tue, 14 Jun 2022 00:20:51 -0700 (PDT)
Received: from [10.4.36.16] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id jj18-20020a170903049200b00163f36005e1sm6383907plb.42.2022.06.14.00.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 00:20:50 -0700 (PDT)
Message-ID: <13002894-edde-3163-f56b-d344147293d7@bytedance.com>
Date:   Tue, 14 Jun 2022 15:23:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [External] Re: [PATCH v4 1/2] mm/memory-failure: introduce
 "hwpoisoned-pages" entry
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
References: <20220614043830.99607-1-pizhenwei@bytedance.com>
 <20220614043830.99607-2-pizhenwei@bytedance.com>
 <20220614070934.GA1627546@hori.linux.bs1.fc.nec.co.jp>
 <66c43dac-32ac-5801-c76c-01607d68e38b@redhat.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <66c43dac-32ac-5801-c76c-01607d68e38b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/22 15:13, David Hildenbrand wrote:
> 	   &hwpoisoned_pages);
>>
>> I'm not sure how useful this interface from userspace (controlling test process
>> with this?).  Do we really need to expose this to userspace?
>>
>>
>> TBH I feel that another approach like below is more desirable:
>>
>>    - define a new flag in "enum mf_flags" (for example named MF_SW_SIMULATED),
>>    - set the flag when calling memory_failure() from the three callers
>>      mentioned above,
>>    - define a global variable (typed bool) in mm/memory_failure.c_to show that
>>      the system has experienced a real hardware memory error events.
>>    - once memory_failure() is called without MF_SW_SIMULATED, the new global
>>      bool variable is set, and afterward unpoison_memory always fails with
>>      -EOPNOTSUPP.
> 
> Exactly what I had in mind.
> 

Sure, I'll send a new version later! Thanks!

-- 
zhenwei pi
