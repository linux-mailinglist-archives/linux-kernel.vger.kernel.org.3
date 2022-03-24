Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED684E5CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346762AbiCXB4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346690AbiCXB4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:56:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFD68E1B3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:54:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q11so3272899pln.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=5xFwyZQn73GiPXyq1YVWAGYDwDxTo0mcS9yr/vK3q+I=;
        b=NTjQT4wfv1bF1WAOulMAeTcwlFhQLikQjBdkuwFIwWw0ap7Gu1VhN31OpC68yYaRXb
         HPEjzKxczn7+Xte0T/GoFcGSqe4pqVmSPx6IwdV6osE4E3Q+fuEPEoReHgVp7Qo8Rcje
         QWph/9qJl6TJjpwnBf/+8zBT8meytTlh87w773WOfMR5MBmGPp6NzH/YsB5a/SZ7rJBq
         otLz8c3Ng/4k8EPWea663hnTitLwKFG8pAOtjDS+AFqJod1J2hRCUYMPRj784yIRB1SC
         3jXCgUrcSeLPznPGUqlpLj/yqvflQubEElWRdZ0LdYx+DIMcUO+d91Pw4vFJ1f4SpPzC
         GdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=5xFwyZQn73GiPXyq1YVWAGYDwDxTo0mcS9yr/vK3q+I=;
        b=zR5fKdkvg6yu5exL2BXlxw3jM/1eXddR43rDoO1+pwAxBzqC37FZxCb8mJX+R4EBz4
         9HsqwZjflC/LTJb8r6zNj+b21fth2edY9y+VVRyAB0VgdwWYPsj5PEO2iOTB4UYXXJNe
         Gp3AJNL3RdKJXgz2KK3kpyceihg/SbgoE0uf0FTPB6N/2H29toC4lv8rvn2BzYyGyNx2
         QEcEV7DhfM/B6DydMpV2fjq/gX2BHPYNwdRfJdfUEaqLJGnRsOGWtg3RyR4xa85lmNt8
         YzV0X39xJ/TEMupskjI3ir8MS0IlEOrwWdF2hPIsOKHlNDfu04yjPQJbDssiSM6LING5
         8PKQ==
X-Gm-Message-State: AOAM5336whgFD5h/by2FqIsyWvDuUxmoYEVLNtcWxgzYGNjJmTu38apK
        HprwoYBxAy/jzBctbH8YttdS0A==
X-Google-Smtp-Source: ABdhPJyU0EiCFf6aY3cb3clvbdf/wMIXSjp3NY2O+m8f80TaJNb9ba07KjhmV3v7hKT1z40jURF/tg==
X-Received: by 2002:a17:903:244d:b0:154:3bb0:7b8c with SMTP id l13-20020a170903244d00b001543bb07b8cmr3167332pls.115.1648086882238;
        Wed, 23 Mar 2022 18:54:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:38d4:55df:aed0:ee00:7944:65f6? ([2600:1700:38d4:55df:aed0:ee00:7944:65f6])
        by smtp.gmail.com with ESMTPSA id d2-20020a056a0024c200b004f6b6817549sm1151670pfv.173.2022.03.23.18.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 18:54:40 -0700 (PDT)
Message-ID: <ec6e5c54-2ff8-9af5-a25d-d99921a3da06@google.com>
Date:   Wed, 23 Mar 2022 18:54:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH 10/47] mm: asi: Support for global non-sensitive
 direct map allocations
Content-Language: en-US
From:   Junaid Shahid <junaids@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com, pjt@google.com,
        oweisse@google.com, alexandre.chartre@oracle.com,
        rppt@linux.ibm.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, luto@kernel.org,
        linux-mm@kvack.org
References: <20220223052223.1202152-1-junaids@google.com>
 <20220223052223.1202152-11-junaids@google.com>
 <YjuL80tuvUbAWWKW@casper.infradead.org>
 <3a7c3a71-0be7-261e-20b7-54b4864eedb5@google.com>
In-Reply-To: <3a7c3a71-0be7-261e-20b7-54b4864eedb5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 16:48, Junaid Shahid wrote:
> Hi Matthew,
> 
> On 3/23/22 14:06, Matthew Wilcox wrote:
>> On Tue, Feb 22, 2022 at 09:21:46PM -0800, Junaid Shahid wrote:
>>> standard ASI instances. A new page flag is also added so that when
>>> these pages are freed, they can also be unmapped from the ASI page
>>> tables.
>>
>> It's cute how you just throw this in as an aside.  Page flags are
>> in high demand and just adding them is not to be done lightly.  Is
>> there any other way of accomplishing what you want?
>>
> 
> I suppose we may be able to use page_ext instead. That certainly should be 
> feasible for the PG_local_nonsensitive flag introduced in a later patch, 
> although I am not completely sure about the PG_global_nonsensitive flag. That 
> could get slightly tricky (though likely still possible to do) in case we need 
> to allocate any non-sensitive memory before page_ext is initialized. One concern 
> with using page_ext could be the extra memory usage on large machines.
> 
> BTW is page flag scarcity an issue on 64-bit systems as well, or only 32-bit 
> systems? ASI is only supported on 64-bit systems (at least currently).
> 

One other thing that we could do to remove the need for the 
PG_global_nonsensitive flag altogether (though not the PG_local_nonsensitive 
flag) would be to always try to unmap pages from the asi_global_nonsensitive_pgd 
in free_pages(). Basically, that would mean adding a page table walk to every 
free_pages() rather than just non-sensitive free_pages(). Do you think that may 
be a better trade-off in order to avoid the flag?

Thanks,
Junaid

