Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C675B5A09A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbiHYHL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiHYHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A869D13D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661411446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQTYhaP5ZnTyiRUCghuMXgfnJiby9YFa/3gZ89MmFuY=;
        b=AnlWMQrwo8qzxtE/58edHFocemL6zTtO+EDhnjr409ZAPSso6dfNYHRS9JDr+CQRGvMFV8
        XVGBuwhSLomZzOhCTIE4tAu2GORHtYJHe7M5tcpO1lZ9HRC042T7S9a1d/coJbD5TeXu/i
        WZhuyXw3LhZpHiEwcKYb1W+yYGYOQP0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-xMrIv3yUO_2vhtO8Z2vx_w-1; Thu, 25 Aug 2022 03:10:44 -0400
X-MC-Unique: xMrIv3yUO_2vhtO8Z2vx_w-1
Received: by mail-wm1-f69.google.com with SMTP id c25-20020a05600c0ad900b003a5ebad295aso826461wmr.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=gQTYhaP5ZnTyiRUCghuMXgfnJiby9YFa/3gZ89MmFuY=;
        b=XNRYadtyGARSHkbhdo2Jfqc81egm59di3ApVyP0PWFUTbPZvuQ6KLdqxwYGLI1H2BM
         X0fW4yDJJaPncWMzYpYUm6ZE+mYopj1VDo7TQSZ0Ar1rS4u5YP9DPvs31iq8OhiGCKTi
         KwJxxoo3eV8FsLcTmeYg1IDMz+gP23pG8tYfWNI3ROwew1gYvG/2TqP4hlpV2IwB9Y5k
         HeUiPo9POr454avsHj9l+rMIw6NiVnVO1ma/Awk9HDm3mzLvUynz5FJAdbRM6w1cyiz0
         bhMS1iv+XsolthrpQUwSFLuq4sDN9Eq3yvbgTJpDMYmqSOUFYlDn07C73wgmtX/JLWN7
         7TNA==
X-Gm-Message-State: ACgBeo24nqIJjhqZYpttrJK4Ql0yZ12P+6XTN4vuPmqgfNwYInZ5eBbd
        CDDC/PIcab7mDik9JiBJBvAvmQM6SCbsOkO4BBkEijcBNv5/TVx/QxveQv3zU1beukAovold0bM
        GQ6HCr2G8MHULFL6iFSfo0MIq
X-Received: by 2002:a05:600c:1593:b0:3a6:36fc:842f with SMTP id r19-20020a05600c159300b003a636fc842fmr1338396wmf.52.1661411443555;
        Thu, 25 Aug 2022 00:10:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5XoJixQYfG32LnLM3/aYR9OzTmTQ041m8y1GB2FP9gmQ278aMA24LJl4o9WYJrTrHrm9yUsA==
X-Received: by 2002:a05:600c:1593:b0:3a6:36fc:842f with SMTP id r19-20020a05600c159300b003a636fc842fmr1338376wmf.52.1661411443252;
        Thu, 25 Aug 2022 00:10:43 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id q3-20020a05600000c300b00225285b8136sm18377611wrx.38.2022.08.25.00.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:10:42 -0700 (PDT)
Message-ID: <50703dda-bbee-7484-97ff-87d6ea75bf80@redhat.com>
Date:   Thu, 25 Aug 2022 09:10:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com> <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
 <Ywa1jp/6naTmUh42@monkey>
 <f3ee3581-5d0b-f564-7016-783a0d91fea2@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f3ee3581-5d0b-f564-7016-783a0d91fea2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +		/*
>> +		 * try_grab_page() should always succeed here, because we hold
>> +		 * the ptl lock and have verified pte_present().
>> +		 */
>> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
>> +			page = NULL;
>> +			goto out;
>> +		}
>> +	} else {
> 
> Should add FOLL_MIGRATION validation before waiting a migration entry.

We really only need FOLL_MIGRATION for KSM. As hugetlb pages cannot be
KSM pages, we don't need this.

Actually, I do have patches in the works that rip out FOLL_MIGRATION
completely by adjusting KSM code.

So let's try to not add dead code (although it would make sense for
feature completeness as is -- but then, FOLL_MIGRATION really needs to go).

-- 
Thanks,

David / dhildenb

