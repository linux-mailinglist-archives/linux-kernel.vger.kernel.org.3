Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6E948785A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347600AbiAGNlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbiAGNlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:41:02 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A2FC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 05:41:01 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z9so22159725edm.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 05:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1xWMzox84ooh/x8FbxrfvG4p5MAAAWHgM5SqmxnFrYA=;
        b=ki55QVTGaIkvPjw4miNywVK8IpBgwE9/wxJlYhUiqDVbVgChSFhhkVl/4fOzoHI/Eh
         I3fbG73ReEQw6Qwfymsb7DYAejTCaTjyckW6HcWsBHo/p6xSeJhzb/i2f1F4eHzEQDl5
         oc63Ot53zn4Ak6Ew6R6QYtb5dAb+8bV8x1HTQelzjCiwofGk51soUR53VdPCyHdqdwqC
         EJisxsICcm/JmE3/MqpqkePklKPda1+/+QRIo5lTichLmLWnfyeXs2+GrH4iMGGwuAHC
         7pEvaW0erHBWzIIz2+e5gcHbQFYNU+lxBSUoDV1gQvfqgTGw1tjrSEdmC3HOFXplPrG+
         IbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1xWMzox84ooh/x8FbxrfvG4p5MAAAWHgM5SqmxnFrYA=;
        b=TnVp9fbxv1uJFaJXdeosuHtcwbungwc1pUgVavPqz+QS0DRPZBZlfUYNxDDRaFqdSr
         1gR/MTbR5vG87LvFZNJKfmKXz2Bz8PVQ1BaKAPLpsKHPv+nKsDpq2ARstlYnF0bEN2qn
         NeqKPdRp6pQlvftxeeCudiHYItMyUw9ubWhQZfg5/aKGgOa4Lj3RZQuvpVBApPlrAWo/
         dp0Kz8IHGgw3OUWSCTXRtH60A5txY/LFlSXl1J3oRPzSFam7U5TFRJh6DF70uw7A0WOW
         HmQhCo7azzIoPls+R9njaDmnVAJkHF2Tc8Fo9M999j57jz8wdQILOrt/CKOq8Q815zc4
         CImg==
X-Gm-Message-State: AOAM531cjXE/w5xWcSOR9Ooo+77Mkgp+E4qJwaV/zk76rhHGJuON/XZ9
        fsr16tDRG582FwHZkGxtlnU=
X-Google-Smtp-Source: ABdhPJxPjVy6H5PJMWQNyO0yHLYRY16ttpNAMDbsUkoD3k43oeZR4VdaMLnzXjQtHCYUAUeAFutv/A==
X-Received: by 2002:a05:6402:35c2:: with SMTP id z2mr63226104edc.136.1641562860061;
        Fri, 07 Jan 2022 05:41:00 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 20sm1413896ejy.105.2022.01.07.05.40.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jan 2022 05:40:59 -0800 (PST)
Date:   Fri, 7 Jan 2022 13:40:59 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, peterz@infradead.org,
        akpm@linux-foundation.org, vbabka@suse.cz, will@kernel.org,
        linyunsheng@huawei.com, aarcange@redhat.com, feng.tang@intel.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-ID: <20220107134059.flxr2hcd6ilb6vt7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yde6hZ41agqa2zs3@casper.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 03:59:01AM +0000, Matthew Wilcox wrote:
>On Thu, Jan 06, 2022 at 11:52:54PM +0000, Wei Yang wrote:
>> FOLIO_MATCH() is used to make sure struct page and folio has identical
>> layout for the first several words.
>> 
>> The comparison of offset between page->compound_head and folio->lru is
>> more like an internal check in struct page.
>> 
>> This patch just removes it.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>No.

Hi, Matthew

Would you mind sharing some insight on this check?

-- 
Wei Yang
Help you, Help me
