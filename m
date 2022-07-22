Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E9257E2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiGVN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiGVN72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC870AF72F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658498347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lo6SGQXmx0XZ7ARbkws6vPSxZjv+F2D6pTsFATwYheI=;
        b=TtRiW2RTsFQDd8eB3nos88LAG0nqFP3JACuKsA65tASh+e2r/78E1UHE3ANmuTF9jvnAJ/
        NicOlI+7+gVZuoISzYDxhOuR+JblxgefLsfGR3vGDZ184htC/6cZDAClGOY0dWPOoUx1Oa
        0tqBWEhkXBa+7uRMN6nA6QQdaEVqnXw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-XI8jaRtxNjOsyfa-QJPxoA-1; Fri, 22 Jul 2022 09:59:05 -0400
X-MC-Unique: XI8jaRtxNjOsyfa-QJPxoA-1
Received: by mail-wm1-f70.google.com with SMTP id q19-20020a7bce93000000b003a3264f3de9so1918231wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Lo6SGQXmx0XZ7ARbkws6vPSxZjv+F2D6pTsFATwYheI=;
        b=TNqXc5NUZwQDKScacbMuJUT5ISNTjW7PzG2/Cv0ulPXMk3fhucn7R50UwmTxbaAEAu
         mE/rX0v3r3drubeIVrPmap1vQay6G8nd6BCnHlElmq5Sic0/9QUfYk7vNFzOV/+Z1iJC
         YMXvRRcHH5flgtIOq/QDgZbaAqBppOvhXkNW8gv3CaQzc/+wFLlyOHg+jpMHyk+rWEVH
         fPKQA0ekb+Qii3JiPnPQ1SRhZZVYK/Qz0r1XTPN20lZfC3Aje/iHT6VTvir1i5cjOBv8
         KGq41p3sX1p+t7VxSLS84d4Z5OGhPVn95RBBMucGpLBAt00sCqFFhdwz2DicjIptZ/RM
         zLpA==
X-Gm-Message-State: AJIora/Uwm9kDHuUMRkzPzzAr1VtFuPaIJyaYqdhjnlkGGn4zu77uLCR
        Ga7yQc1DSkSm8vxlJ0RQASnmHQcxgLG95YvrEEpjcvge+zovfRih9JHFwZ1C0VFqDhqGNnDQwjL
        B8h0l/OCiyuvTkcxsdbxxYQ0h
X-Received: by 2002:a05:600c:5120:b0:3a3:2ae4:fb20 with SMTP id o32-20020a05600c512000b003a32ae4fb20mr596066wms.81.1658498344670;
        Fri, 22 Jul 2022 06:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uhOwqaacXSfkLjD4scuuFNVK8E37fO4Ywor2Eut1iuhqnyL2BRE9K+6lyi6PeVntZPDETsMg==
X-Received: by 2002:a05:600c:5120:b0:3a3:2ae4:fb20 with SMTP id o32-20020a05600c512000b003a32ae4fb20mr596048wms.81.1658498344325;
        Fri, 22 Jul 2022 06:59:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6? (p200300cbc707cb00cd6b7964cc7db0e6.dip0.t-ipconnect.de. [2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c3807000000b003a3080eacb9sm5196061wma.24.2022.07.22.06.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 06:59:04 -0700 (PDT)
Message-ID: <a85537d0-d828-2049-6f8e-3272156ae1ed@redhat.com>
Date:   Fri, 22 Jul 2022 15:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-2-peterx@redhat.com>
 <e35e42ce-e942-141d-09e7-a3a7868f4abb@redhat.com>
 <Ytqrb0ffgs+tA+0n@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ytqrb0ffgs+tA+0n@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.07.22 15:51, Peter Xu wrote:
> On Fri, Jul 22, 2022 at 09:08:59AM +0200, David Hildenbrand wrote:
>> On 21.07.22 20:33, Peter Xu wrote:
>>> The check wanted to make sure when soft-dirty tracking is enabled we won't
>>> grant write bit by accident, as a page fault is needed for dirty tracking.
>>> The intention is correct but we didn't check it right because VM_SOFTDIRTY
>>> set actually means soft-dirty tracking disabled.  Fix it.
>>>
>>> There's another thing tricky about soft-dirty is that, we can't check the
>>> vma flag !(vma_flags & VM_SOFTDIRTY) directly but only check it after we
>>> checked CONFIG_MEM_SOFT_DIRTY because otherwise VM_SOFTDIRTY will be
>>> defined as zero, and !(vma_flags & VM_SOFTDIRTY) will constantly return
>>> true.  To avoid misuse, introduce a helper for checking whether vma has
>>> soft-dirty tracking enabled.
>>>
>>
>>
>> [...]
>>
>>>
>>> Here we attach a Fixes to commit 64fe24a3e05e only for easy tracking, as
>>> this patch won't apply to a tree before that point.  However the commit
>>> wasn't the source of problem, it's just that then anonymous memory will
>>> also suffer from this problem with mprotect().
>>
>> I'd remove that paragraph and also add
>>
>> Fixes: 64e455079e1b ("mm: softdirty: enable write notifications on VMAs after VM_SOFTDIRTY cleared")
>>
>> That introduced this wrong check for pagecache pages AFAIKS.
>>
>> We don't care if the patch applies before 64fe24a3e05e, if someone wants to
>> backport the fix, they can just adjust it accordingly.
> 
> IMO besides marking the culprit commit, Fixes can also provide input to
> stable trees to see whether we should try pick some patch up.  What I
> wanted to express here is we don't need to try pick this patch up before
> kernel that doesn't have 64fe24a3e05e because it won't apply.
> 
> I can attach both Fixes with the hope that it'll help in both cases if
> you're fine with it, with slight explanations.

Makes sense. Thanks!

-- 
Thanks,

David / dhildenb

