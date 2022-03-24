Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7C4E63A4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350295AbiCXMvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiCXMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7275155762
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648126169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sezx/UQ+EqOvqVxtY+/wVmMk0cHNcnQ9Dv6I0IFtOWk=;
        b=bdTPGraOpTFPjL0LQY/Da8pnILe3MRyTlI+cGThK7iRFiAMWBAtuarLIuD+P49ElTr91mK
        zaREf36+8x6rgplxPbN+t2O94W2bpWziHnjtBHvMHE6wuwqUweZN0btoVuU+KcY5+duOrE
        wVUg570CzvAhAH94rzfeA5a8+BrRrlg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-ZuLhqR-1PYy1Wxf773SP_Q-1; Thu, 24 Mar 2022 08:49:28 -0400
X-MC-Unique: ZuLhqR-1PYy1Wxf773SP_Q-1
Received: by mail-wm1-f70.google.com with SMTP id i6-20020a05600c354600b0038be262d9d9so3987960wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Sezx/UQ+EqOvqVxtY+/wVmMk0cHNcnQ9Dv6I0IFtOWk=;
        b=qyVZMOjY+PV62D7TceBZ7TMW6ElowXVjziLmre5C0JsyusTaSDYMCHgW1s9//mJ62y
         HIFfFLuAPX0WqbCDqKqOXge2phief9cwA7M1nVleB/Gzk1Xp8UGOf026WQQHOlXGydOt
         ddNHFFLzGvx1K3MLmcXjwxp0fuQkf+guRSAWyMCTQC5ot17DSgQnbwn8arGFTR218WF5
         zMFHc/yUSMm1nT3Y3x1e9/vMQQspUa435yncq1s18StDe226DIkDCfAw3I9fp1SGrlrf
         j+dbb+i6x9U32BHRFLFxFEiZs43d9r4xEHpgxq+IMyUmHk6lIEmsC2JjLfQCP/696Aib
         9lYA==
X-Gm-Message-State: AOAM530Ze6AesBxOtU+led7/GsKSNZKaLTalbGIkXNl4KkKfBoE7wKT/
        oPxsP6A0JXo+c89qa44T2q+mDg7mpD5zyaOHwwU89BUiEpR5GogklEmSYMwgyqxsnM1omxffDwU
        MqE0BZgdLJzejdGN92V985Cvv
X-Received: by 2002:a5d:624c:0:b0:1f7:4b77:becb with SMTP id m12-20020a5d624c000000b001f74b77becbmr4406520wrv.594.1648126167106;
        Thu, 24 Mar 2022 05:49:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrmbcdS8utEDPcOUhjHZBJSzzJhICPIAie9t6e0R27aM7olxWjv+aYWwhU1fvxuOrWAlZnRg==
X-Received: by 2002:a5d:624c:0:b0:1f7:4b77:becb with SMTP id m12-20020a5d624c000000b001f74b77becbmr4406499wrv.594.1648126166817;
        Thu, 24 Mar 2022 05:49:26 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm7205134wmp.13.2022.03.24.05.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 05:49:26 -0700 (PDT)
Message-ID: <eabdd49c-d69c-91f3-c780-9bbf661f704c@redhat.com>
Date:   Thu, 24 Mar 2022 13:49:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3] mm/vmstat: add events for ksm cow
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, yang.yang29@zte.com.cn,
        ran.xiaokai@zte.com.cn, yang.shi@linux.alibaba.com,
        dave.hansen@linux.intel.com, minchan@kernel.org, saravanand@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
References: <20220324104332.2350482-1-yang.yang29@zte.com.cn>
 <Yjxn53YcdKDcV7zX@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yjxn53YcdKDcV7zX@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.22 13:45, Matthew Wilcox wrote:
> On Thu, Mar 24, 2022 at 10:43:33AM +0000, cgel.zte@gmail.com wrote:
>> +++ b/include/linux/vm_event_item.h
>> @@ -131,6 +131,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>>  		SWAP_RA_HIT,
>>  #ifdef CONFIG_KSM
>>  		KSM_SWPIN_COPY,
>> +		COW_KSM,
> 
> Shouldn't we call this KSM_COW?

I guess I proposed COW_KSM because ideally we'll have COW_ANON,
COW_ZERO, COW_OTHER, ... so it'd be under the "COW" namespace. No strong
opinion, though.


-- 
Thanks,

David / dhildenb

