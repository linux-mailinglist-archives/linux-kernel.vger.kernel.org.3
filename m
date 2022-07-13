Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0D057312F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiGMIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiGMIeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91585951CF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657701245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70wu6Q93ZaJ2E16t3UBga1pfNO3TIEeHSMgPe4nGST8=;
        b=eQ8D+Q8BooxIvp0jl69HdylfpWLsP6+HmRD3fZX418xEHdRXJ1Jiz2NtTMQ7RiPEYW3mqX
        j9ErNBVsYKLZRixfhGdhF90ZYvIfDSG8Su7psjXZl299/hos/uhjxEnloaxiYKGNLJwemD
        A0MVEY8tPoZa+5D1Q56BpuOzOH7Wcyo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-robtJY7NPnKg_Ll-NVblew-1; Wed, 13 Jul 2022 04:34:04 -0400
X-MC-Unique: robtJY7NPnKg_Ll-NVblew-1
Received: by mail-wr1-f70.google.com with SMTP id n10-20020a5d6b8a000000b0021da91e4a64so1632436wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=70wu6Q93ZaJ2E16t3UBga1pfNO3TIEeHSMgPe4nGST8=;
        b=xxaSP8We082F8g4t+maum7Tg71l33SXanxmkZ0NEVfj0HdN938E7eG5CgY63yluxBv
         BmojluRJ2MgGJwhZoqhCmi+LOEWLndQDxO0NpJlM76OaiNz9dU1Fy8lkdiG984SHK3zE
         nmy7bsSTogOgFHlgaXhhqR6qD7G7XuHS76ZsAEPU/QdRcsmQoGCEGaOxBEt0L0giFQiE
         IUmakG19TBUZYEvGeLvM838ymVMh5nHCde7txxEDzFCfGRewnd6Be5Y1+7vbkyfwdZVp
         l3gCJYo2mb4zYp1NXMpOXccyd7HDJ88kREwYEkdrqudQubMPuVT4MT95KtLyB0P2IAVM
         fTdg==
X-Gm-Message-State: AJIora82ON2y1vZOk7eiaGoSP+9QDEmhRBdFFloQ4hoCFlSFxiiT6mDX
        hi0tPUXYwUQqUBXKP8MHu9t6eDyVWy1PQqPR90yhSDxMh2aODy6ShqCbpvRZh1GJ1L/nGRD9xgW
        Uw0m+38QnygICrcAVWynHOX2E
X-Received: by 2002:a05:6000:1d89:b0:21d:5655:eb72 with SMTP id bk9-20020a0560001d8900b0021d5655eb72mr2100096wrb.110.1657701242850;
        Wed, 13 Jul 2022 01:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtCIhLP80A2tYuvdXzA0RPOGTN/f6RtiPwyaCk599XzqPcqPudk/ewedaZFLfdSUPbUqjUsg==
X-Received: by 2002:a05:6000:1d89:b0:21d:5655:eb72 with SMTP id bk9-20020a0560001d8900b0021d5655eb72mr2100072wrb.110.1657701242595;
        Wed, 13 Jul 2022 01:34:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5800:5009:e8d0:d95e:544d? (p200300cbc70758005009e8d0d95e544d.dip0.t-ipconnect.de. [2003:cb:c707:5800:5009:e8d0:d95e:544d])
        by smtp.gmail.com with ESMTPSA id p42-20020a05600c1daa00b0039ee51fda45sm1536275wms.2.2022.07.13.01.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 01:34:02 -0700 (PDT)
Message-ID: <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com>
Date:   Wed, 13 Jul 2022 10:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.22 16:24, Liam Howlett wrote:
> When building with C=1, the maple tree had some rcu type mismatch &
> locking mismatches in the destroy functions.  There were cosmetic only
> since this happens after the nodes are removed from the tree.
> 
> Fixes: f8acc5e9581e (Maple Tree: add new data structure)
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Sorry to say, but the fixes become hard to follow (what/where/why). :)

I guess it's time for a new series soon. Eventually it makes sense to
send the fixes as reply to the individual problematic patches. (instead
of fixes to commit ids that are not upstream)

[yes, I'll do more review soon :) ]

-- 
Thanks,

David / dhildenb

