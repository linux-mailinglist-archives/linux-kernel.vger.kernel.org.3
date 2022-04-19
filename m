Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8C506C13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbiDSMQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352201AbiDSMP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BD2B205CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650370365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpFSXrBn9i8XVmZWcxjOCjor87VdZpZNStC/r8yG5AE=;
        b=Mkt2zo+1Td8hGp2LSMIQpwP6Uiovn/d3oCUQLsRDVMANcL5X7Ge6KpVI2fS1AUODQlB4Mf
        eX9nLYtdEGuM5StSUHcVwpr+8umCE8lLfrDN9E3tZniG4HcMtpQg5t3a2mpu+7mUD9+TWD
        5VTQCrQ8nGMl70vm6WDvLyTb8peNv2U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-TscDhRYuON63ykgo5MIgQQ-1; Tue, 19 Apr 2022 08:12:44 -0400
X-MC-Unique: TscDhRYuON63ykgo5MIgQQ-1
Received: by mail-wm1-f70.google.com with SMTP id g13-20020a1c4e0d000000b0038eba16aa46so1133645wmh.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=bpFSXrBn9i8XVmZWcxjOCjor87VdZpZNStC/r8yG5AE=;
        b=BCZBBUpd5pnM3Bo2YccOEWHUjnq9f55PY8CnfbzVYelkTWo+ydePBPyL7f3W94OQsv
         6GJrAvSEK9/hiRSwwOMlvWtk3S3s7KUN6GBDABtlW2gAqYFrr6QsZ/YKAs3TZF/OhcIS
         54HdhjhlN7A+W17s44aZYQQKlFrUmhK9D+5r7oLgsH6k2wNR85zoZBIDoeuzDlDrbIlx
         ZCRVhWpg47AozViI/yFRftEIt9imcYrJ4I9TDk9Q1oHO9rv4RK5ZuQRS1Hi5GLGeIBZD
         DI49KQalAzy3/zdRSeXuBqEjwUAdOZL9YzHt5fBk1XR6bTz6zom94FwBxceOscZGOeZX
         BtoQ==
X-Gm-Message-State: AOAM530oDfEsvRC7NlxlHlhmL64hmW7PJZv5JofiWjp3icv0EDgimJVW
        c8/pCKPJnwNM7Vtrrt0yC3g2OQAKtN4zITwSHwm4qkrY3uRbPHHk8CYuqc6UnqLi2lN5/yAJCEh
        YI8cY6+mALx59f24yYq1tfBw8
X-Received: by 2002:a05:600c:1e1e:b0:38e:baaa:aae0 with SMTP id ay30-20020a05600c1e1e00b0038ebaaaaae0mr15235091wmb.157.1650370362916;
        Tue, 19 Apr 2022 05:12:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/QTfXp55+8oe5vjVX8Svx2TIPDgx3b4qKD4rBNj7p2vVxT+AoJNVa0rGfqlm+fH7v+GYhnQ==
X-Received: by 2002:a05:600c:1e1e:b0:38e:baaa:aae0 with SMTP id ay30-20020a05600c1e1e00b0038ebaaaaae0mr15235068wmb.157.1650370362644;
        Tue, 19 Apr 2022 05:12:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id 9-20020a056000154900b0020a849e1c41sm9323296wry.13.2022.04.19.05.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 05:12:42 -0700 (PDT)
Message-ID: <7308d733-1e0b-7d2e-bc34-0757555d39d6@redhat.com>
Date:   Tue, 19 Apr 2022 14:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        rcampbell@nvidia.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <b57fea1e-5c9b-f47e-f565-16b54f1e8782@redhat.com>
 <1b614ac3-02c0-ec66-b51a-e9b7e1a375ad@huawei.com>
 <c901938d-efcc-6a94-bbf4-93e7f4c2ea7d@redhat.com>
 <a6707adc-6d3e-92bb-4bb3-29a6e1f350f1@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
In-Reply-To: <a6707adc-6d3e-92bb-4bb3-29a6e1f350f1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.22 14:00, Miaohe Lin wrote:
> On 2022/4/19 19:46, David Hildenbrand wrote:
> ...
>>> Do you mean that we should set the pfn to 0 for the hwpoison marker so that we can
>>> distinguish swapin error case from real hwpoison case?
>>
>> I am not sure if we really have to distinguish. However, "0" seems to
>> make sense to indicate "this is not an actual problematic PFN, the
>> information is simply no longer around due to a hardware issue.
>>
> 
> IMHO, we have to distinguish. For example, we might need to return VM_FAULT_SIGBUS
> instead of VM_FAULT_HWPOISON when user accesses the error page. Or should we simply
> return VM_FAULT_HWPOISON to simplify the handling?

Hm, you're right. In e.g., x86 do_sigbus() we would send an BUS_MCEERR_AR.

So yes, if we reuse is_hwpoison_entry() we'd have to convert to either
VM_FAULT_HWPOISON or VM_FAULT_SIGBUS.

Something like "is_error_entry()" that can further be refined to
hwpoison or swapin could make sense. But what you have here is straight
forward to me as well. Whatever you/others prefer.

Acked-by: David Hildenbrand <david@redhat.com>


NIT: I'd make the terminology make_swapin_error_entry() consistent with
SWAP_READ_ERROR and especially existing SWP_.

For example, calling the latter SWP_SWAPIN_ERROR

-- 
Thanks,

David / dhildenb

