Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257D74C65C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiB1Jid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiB1Jia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0D915FCD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646041070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6xuI99PpvDDOODhlbvd9Uc1T3uVIjTSRXmL6hAEYXs=;
        b=b0Oecg70y75kS+Rhvfp4wLjXiM+jgIOAQeKQXWFAUHIE2q9XN8JltyOqxuwZhLhIYZ5hwD
        uJPg/dUDOCNjNr2pwJfSfeCrF/nq0XKJmJ4fY26+P8EKJfOcyX9S6OTg9mtRO7oA6bL6UD
        M6BpBjlMFiRoW4pwC1xIueCbGUTp2uI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-TN4XbT-dNRixMLFOJba1Zg-1; Mon, 28 Feb 2022 04:37:48 -0500
X-MC-Unique: TN4XbT-dNRixMLFOJba1Zg-1
Received: by mail-wr1-f71.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so1822938wrg.20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=O6xuI99PpvDDOODhlbvd9Uc1T3uVIjTSRXmL6hAEYXs=;
        b=Hy6fDCU2OMzxY2RKfAv3qhJdnkUIsDjN9JjA/eZ6t7r8/VukomWx7Qiwn6gwQPzEWP
         bypXbDbLOjyDYU+BwadvlZzxMm+7bjYqTy+m42bgJQgbSTYVmuyPzoUwtIFrIyPj8FQg
         /hUhNGT/qzWlQGm2Iq4VwbmaYR6ytLJOkaMmgXhLgtroMW17N27rpr69aRr/gK1oh7RI
         fDDNu2Btxh3/3dnPdxWdEgaBoE1xSHtfuabk6MT3dfeAMHQ4wIzU3/28iVI8lpamBsVk
         N/1SfUqDYJe+5TUrtvkzIvTUkL6rnxa5UpeIeuKOKKIQ6xWLfTPmCJi/J4GMgnqQDYWp
         QPIQ==
X-Gm-Message-State: AOAM530/XGOs7joT/OjX5wUkguRAJQV+6VyIpB+9T8iJ6JFVd4OHAZ75
        NNg0E/O5hawwWQmB7BID74aCcNHlUbHC1A+Ds//oKR+6pf2WgxsI0zRO38TAKyDz8iIDxV6GHrU
        wiSSQWz54o3IiRK32kXd+kA1y
X-Received: by 2002:a05:600c:68b:b0:380:d3e3:5bac with SMTP id a11-20020a05600c068b00b00380d3e35bacmr12725267wmn.127.1646041067484;
        Mon, 28 Feb 2022 01:37:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhW7y7soOEk6w3DJYoM93NX0XSqq5ao6PuHL/oQN6/HEeVH+4iT1S317aR4vg+JubPxFR9UQ==
X-Received: by 2002:a05:600c:68b:b0:380:d3e3:5bac with SMTP id a11-20020a05600c068b00b00380d3e35bacmr12725255wmn.127.1646041067304;
        Mon, 28 Feb 2022 01:37:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9700:f1d:e242:33b4:67f? (p200300cbc70297000f1de24233b4067f.dip0.t-ipconnect.de. [2003:cb:c702:9700:f1d:e242:33b4:67f])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm14108652wrt.63.2022.02.28.01.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:37:46 -0800 (PST)
Message-ID: <3b7c068b-ac7e-62fc-f0cd-a8dbf8642876@redhat.com>
Date:   Mon, 28 Feb 2022 10:37:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] selftests: vm: Add test for Soft-Dirty PTE bit
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, kernelci@groups.io,
        Will Deacon <will@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20220224212335.3045905-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220224212335.3045905-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.22 22:23, Muhammad Usama Anjum wrote:
> This introduces three tests:
> 1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
> check if the SD bit flipped.
> 2) Check VMA reuse: validate the VM_SOFTDIRTY usage
> 3) Check soft-dirty on huge pages
> 
> This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
> Invalidate TLB after clearing soft-dirty page state"). I was tracking the
> same issue that he fixed, and this test would have caught it.
> 

A note that madv_populate.c already contains some SOFTDIRTY tests
regarding MADV_POPULATE. Eventually we want to factor out
softdirty/pagemap handling+checks for easier reuse.


-- 
Thanks,

David / dhildenb

