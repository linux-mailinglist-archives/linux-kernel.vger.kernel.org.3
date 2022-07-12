Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764C25714F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiGLIpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiGLIpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:45:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC27A44DA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:45:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso7283003pjk.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=vmRTcATN38IxovHc4DjUAE7J63goQ3yrRauAK/eLtk8=;
        b=G3+Nad+oLl4aj0sg9qaEyCjZp/iTgAbNlDevJ6jUymxzdoNrQyx4Oo1ZZvs0Z7eAb2
         54B6aae6Sz0AsLN6+7pDSRWVQArQ1Dyat3jxuAmolfirNzwvdheVX/QDpN8426b1ig9P
         3Zh/INyHU1dW6Z8kvaQqeOsa8r7Yx7sTz6UMvzv9YfwvMJ3An2MH7HjvUkUt3cViqQDt
         QIvnV8q1/aABiRI2Y3XqPGJCTNE2I9NJX2/1ug1B6Y98A3IvMTXmUHdo5CMY5IIF2Tfq
         TxQzO48YEa3dEU6ZiQIfeb6Zu8C0mfS/AtaNtucZ0UoeKd0hpsgTWfDIFcmCNLCPGOUQ
         rLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vmRTcATN38IxovHc4DjUAE7J63goQ3yrRauAK/eLtk8=;
        b=eVcgvGqdEZT4MKkGCJsvSxyDzAD8dQk/Jim4n5bCnqrW3AP387zkq12q9FEglp/GaB
         choAaYEc36SUMbw6Q2NwPCFT5lSo38nljby14mj/AztMnv8PMTK4W035q3iFGcdIDDff
         rLtJBNFSoGPY1ESoq6F41ZnDfogGfV5LKwnPC/wIvS7vsx1WUNYloli9YxlLmzIjZzRI
         RuCdoZIAy9u30aaGYVXUCKBA2+xy+qJD1OlXmlSPi3Fq1RrQr9UZgZ3cuFNgUbsq7mbl
         P9AWq6yNvkBQL018sSO79RKQYUn3AWSRNWJCcHQ5upCpWEB1BHJXNEkSGq5npO1JKITf
         D7yQ==
X-Gm-Message-State: AJIora+xfbJ17gpC0hTNHtCbzDQxgl/KzI3p1V/i3ubVgSLVwXXQ2n/D
        YFW8lZzfyC8Xbz4VDAG02SaePw==
X-Google-Smtp-Source: AGRyM1vjmlJiaBBcCpWRMLVB2IpvdCIr3Qu93X75MDmgwAbU4LZBmiuEa4mPYnryUiJEdLl2gfrmUQ==
X-Received: by 2002:a17:90a:bd92:b0:1ef:82d8:f2b9 with SMTP id z18-20020a17090abd9200b001ef82d8f2b9mr2879763pjr.83.1657615500129;
        Tue, 12 Jul 2022 01:45:00 -0700 (PDT)
Received: from [10.85.119.42] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id e20-20020aa79814000000b00528c7ac7f27sm6169609pfl.81.2022.07.12.01.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:44:59 -0700 (PDT)
Message-ID: <d855de6c-766e-cf77-feeb-a0130052ddd4@bytedance.com>
Date:   Tue, 12 Jul 2022 16:44:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [External] Re: [PATCH] mm/compaction: fix set skip in
 fast_find_migrateblock
To:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220711123213.66068-1-zhouchuyi@bytedance.com>
 <8af11329-93d4-3bbd-fe4c-343663c00a1b@huawei.com>
From:   =?UTF-8?B?5ZGo5L+25piT?= <zhouchuyi@bytedance.com>
In-Reply-To: <8af11329-93d4-3bbd-fe4c-343663c00a1b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/7/12 上午10:26, Miaohe Lin 写道:
> Add Cc Andrew and linux-kernel email list.
> 
> On 2022/7/11 20:32, Zhou Chuyi wrote:
>> From: zhouchuyi <zhouchuyi@bytedance.com>
>>
>> When we successfully find a pageblock in fast_find_migrateblock(), the block will be set skip-flag through set_pageblock_skip(). However, when entering isolate_migratepages_block(), the whole pageblock will be skipped due to the branch 'if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages))'. Eventually we will goto isolate_abort and isolate nothing.
>> Signed-off-by: zhouchuyi <zhouchuyi@bytedance.com>
> 
> It seems we should tweak the commit log to satisfy the checkpatch.pl first.
> 
>> ---
>>   mm/compaction.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 1f89b969c..a1a2b50c8 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1852,7 +1852,6 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
>>   					pfn = cc->zone->zone_start_pfn;
>>   				cc->fast_search_fail = 0;
>>   				found_block = true;
>> -				set_pageblock_skip(freepage);
> 
> This looks like a real problem. Should we add a Fixes tag here? What's the runtime effect of it?
> 
> Thanks for your patch!
sorry for this mistakes, I'm a beginner of Linux kernel. I will fix this 
problems in v2
> 
>>   				break;
>>   			}
>>   		}
>>
> 
