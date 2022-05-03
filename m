Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048EC518C79
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbiECSkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiECSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2D5120196
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651602988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJCjU8JdJDMoZ6JiGS8DoI4ltHKw0EEf1II2eYjKnuM=;
        b=VUeZ1SZofInT1q0dLGGDtkcAkotSp4Iei+MH2B+v9hvBD6Ei03h0DfMMdsMAH2e8FSdfwT
        DEI2MZI3+jctgYF6ctKENX6fEhj/zpRuDrc+6ceUHZNrN8kWpk8AW0KO96yAWIzaYF+Ofq
        m+OriQXW9GyEU/vrVjArrwgj8qFHnf0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-7GJHkCB8PiiCOySsqTHU0Q-1; Tue, 03 May 2022 14:36:17 -0400
X-MC-Unique: 7GJHkCB8PiiCOySsqTHU0Q-1
Received: by mail-pg1-f197.google.com with SMTP id q13-20020a638c4d000000b003821725ad66so8791907pgn.23
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=fJCjU8JdJDMoZ6JiGS8DoI4ltHKw0EEf1II2eYjKnuM=;
        b=CzYSs0SckeggglbHa0vJLze89JF2KbVXecCFEUAL01DwkziyUhn/JiM+G4PFd3Bo+c
         Tiuc/QzboRhe4IoWZysCC+pnNoSRiJTnUs2FRpHmrWdi4Kr99f0cEER0w12N9Gb66iqc
         W630UqdDwbZwOlIHmwD3TIrhd4er4YPJ9JV7zQSghIbKqK9JHpjeQf/SOPFLyDvDYcc8
         OTG24hjRofIC8XDZtvqvQoprEqqlNaaQAUtcRDXkmDn4cCwIrez3tlejwnSgcNCgHFSi
         eXRrrOswPyEzm7C0zkm/bx03x1loR06Y9Jtv9PjpXkVNw+z1jTeue2YCz+pTLlnApV6e
         XK8g==
X-Gm-Message-State: AOAM531CQusU2kJ5PpGW/mhuHBkiZ7UpyheWuO16x3S13vRhdr+yx5oA
        JW6adnECiWxzlBFz0coNHep/ZqZ7ns8Z2ptrFpI513cSYyGKWivJrFZbYnkV8KkcjFxXqsuUBFg
        csOr6dasq5+LR3CMdZTSyKYgp
X-Received: by 2002:a17:902:e78e:b0:15d:29ba:77fe with SMTP id cp14-20020a170902e78e00b0015d29ba77femr17951896plb.119.1651602967843;
        Tue, 03 May 2022 11:36:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4nv0IKW7HMA4MKhMR91C6X0V3KPHdcvIk0GGNMCBLpb+uvHfY05+UexIai2OiC1Zhd4hVfg==
X-Received: by 2002:a17:902:e78e:b0:15d:29ba:77fe with SMTP id cp14-20020a170902e78e00b0015d29ba77femr17951880plb.119.1651602967566;
        Tue, 03 May 2022 11:36:07 -0700 (PDT)
Received: from [10.10.69.234] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b0050dc7628174sm6623027pfk.78.2022.05.03.11.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 11:36:06 -0700 (PDT)
Message-ID: <0fa49d1f-a05d-bdb1-df60-800ff5999d8e@redhat.com>
Date:   Tue, 3 May 2022 20:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mm/mprotect: reduce Committed_AS if memory protection is
 changed to PROT_NONE
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        liusongtang <liusongtang@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        nixiaoming@huawei.com, young.liuyang@huawei.com,
        wangkefeng@huawei.com
References: <20220426112705.3323-1-liusongtang@huawei.com>
 <20220426133401.9404190c5a5c6ff58b694c59@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220426133401.9404190c5a5c6ff58b694c59@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.22 22:34, Andrew Morton wrote:
> On Tue, 26 Apr 2022 19:27:05 +0800 liusongtang <liusongtang@huawei.com> wrote:
> 
>> If PROT_WRITE is set, the size of vm area will be added to Committed_AS.
>> However, if memory protection is changed to PROT_NONE,
>> the corresponding physical memory will not be used, but Committed_AS still
>> count the size of the PROT_NONE memory.
>>
>> This patch reduce Committed_AS and free the corresponding memory if
>> memory protection is changed to PROT_NONE.
>>
>> ...
>>
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -497,6 +497,12 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
>>  	}
>>  
>>  success:
>> +	if ((newflags & (VM_READ | VM_WRITE | VM_EXEC | VM_LOCKED | VM_ACCOUNT)) == VM_ACCOUNT) {
>> +		zap_page_range(vma, start, end - start);
>> +		newflags &= ~VM_ACCOUNT;
>> +		vm_unacct_memory((end - start) >> PAGE_SHIFT);
>> +	}
>> +
>>  	/*
>>  	 * vm_flags and vm_page_prot are protected by the mmap_lock
>>  	 * held in write mode.
> 
> Surprised.  If userspace does mprotect(addr, len.  PROT_NONE) then
> mprotect(addr, len.  PROT_READ), what is now at *addr?  Zeroes?
> 

I don't think so. I don't see any pages getting zapped at my quick test
(unless it's wrong) shows that data is maintained. Further, it could
violate POSIX semantics.

So this patch is wrong, there might have been anonymous pages populated.

-- 
Thanks,

David / dhildenb

