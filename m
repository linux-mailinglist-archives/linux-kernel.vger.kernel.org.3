Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5780F524713
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350344AbiELHgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351079AbiELHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41F881DA76
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652340979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQ4ujRgpzyh6ewlTgWHvwE4PWXv0qetHu9e1jhXut6g=;
        b=DL/KvTRuuC2g9e4QyQPy2UR0EzRccrUoGStF+A3K2vfU0FAZDYzOSDrWENjgLvB8dx+AgO
        HuLZAk6kVpBSFra9bdmcHXV4TvGCyf68Izmn3YnE3bnbarzCL1V2vNEPFZoYFePsk4qpsi
        0YrT64Cr0OHel6FIZmzLrh48DxhpAYU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-1gN5DpjDMPSQOlDFw5JThQ-1; Thu, 12 May 2022 03:36:18 -0400
X-MC-Unique: 1gN5DpjDMPSQOlDFw5JThQ-1
Received: by mail-wr1-f72.google.com with SMTP id ba21-20020a0560001c1500b0020ca6a45dfcso1729798wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SQ4ujRgpzyh6ewlTgWHvwE4PWXv0qetHu9e1jhXut6g=;
        b=kbYJ2vlUsU/c9neYBGq1XqE1luYD6PsRorIO0L+IzSJdI2iPGd2Kxe7CqzazgXY/XO
         yPo0zApRBYmFyfpuL3CXBZ4XTONXXUjaZFV61kSOqoIL1E1FQvsufFx58ZWjg5vq1mOW
         hV3zKHx87SgVwwRrbLAsNNXROzyizMYSv7p5azzPNBK9+atKfesndQVRBeLfsQNz2YA6
         eaMgbs4tfW0pCCVVoP+LhoBd51uLPlyIC5ndQ3T8WpdhOLnyuzHiN8BRpwF0lU1P9qVE
         eTGsgW17THfS2u06hwjaQnXhB4M4+Ij1QS+ITb34fK1yt+2ZPWWMQ552tUi8BZwIIoDJ
         pVIQ==
X-Gm-Message-State: AOAM531hMuGsKMcWRUEcWnXG5U/CpGarXGFARFBPCDM7VqCKee7X06Co
        bXEKW1TsCeP7UPFOFF4o+s34Ay2lnCCTJhZMYb8qlbM/pAJDPL11jE5YOVnFRkiNww65Q7xq9PZ
        Qbnw1xrFgTuB4v+XFhbxGhdGl
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr5504492wrr.583.1652340977092;
        Thu, 12 May 2022 00:36:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4WzSFjh9/1fr5OcChI0nWnCZFMhs6TwJW3Bp8ipC/jSMUjUw0QWNYF/O6+XQdsSUG9IbInw==
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr5504467wrr.583.1652340976871;
        Thu, 12 May 2022 00:36:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id s19-20020a1cf213000000b003942a244edfsm1850197wmc.36.2022.05.12.00.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:36:16 -0700 (PDT)
Message-ID: <ebffd794-697b-9bf1-f41b-4b2d52c100fc@redhat.com>
Date:   Thu, 12 May 2022 09:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 2/4] mm: memory_hotplug: override memmap_on_memory
 when hugetlb_free_vmemmap=on
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-3-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509062703.64249-3-songmuchun@bytedance.com>
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

On 09.05.22 08:27, Muchun Song wrote:
> Optimizing HugeTLB vmemmap pages is not compatible with allocating memmap on
> hot added memory. If "hugetlb_free_vmemmap=on" and
> memory_hotplug.memmap_on_memory" are both passed on the kernel command line,
> optimizing hugetlb pages takes precedence. 

Why?


-- 
Thanks,

David / dhildenb

