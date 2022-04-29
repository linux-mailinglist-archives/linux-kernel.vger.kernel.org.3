Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94640514571
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356613AbiD2Jc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356605AbiD2Jcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2849DC44EA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651224575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QgB5yaRKGIdlayUhadpAeJYzfWS9JALUqL7mNuN6Qd8=;
        b=CAhtVp3zNbd5IpGLIyzp6OKgW4wohBslgsOsmBvRCbG4E7i4DJgbW+Ic0ZxQJE5qIsury/
        SMhLkUCeOKyRYigQUNPOjrZSfc9UWaPVxvSqaimLLvYr/HP2R/NO5wst3WUIwpcFsdtBRe
        pp7Vw6RyiRtzgRAy3Ks8ikK2sagjcNs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-MSGFfOsyNr2xevOI8XMcfA-1; Fri, 29 Apr 2022 05:29:33 -0400
X-MC-Unique: MSGFfOsyNr2xevOI8XMcfA-1
Received: by mail-wm1-f72.google.com with SMTP id t184-20020a1c46c1000000b00394209f54f1so331109wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QgB5yaRKGIdlayUhadpAeJYzfWS9JALUqL7mNuN6Qd8=;
        b=YyK44WS5ckvzIWHqmmk28a8Upc9+N9XYHMhUOxKDP+8EVGbEuLLEpENTiHKzm5A/z5
         JgHcvJzlWDxHwPt2NBoupj6G5tWjxSVTSJGLwrHEGO8oTI45FfaDi9EdwgS8amZbERfh
         EI0gBOfBOXhBXhE3m8qe1SFIIVaoSuZbUN7jn8oWpzFiF+LTyQSPvSYNdRYxHuTf3DY5
         yltkS5xuRKo2enouY6dcQIiqpgcnc2qfolQGbLguflxUSUwXX6ZleLnTgdM+0Dlo1oww
         hO1JYt99uVGfkQz3zPCbheCGKwlzRFAJMpQS1zM6Jc8MrsBcs0pUkN883g1m3tY57c4T
         k32g==
X-Gm-Message-State: AOAM533BdkuMJwPRYtecNoqgi6MhaiOAlZCT9YqlSVi07cg7sI9Lc2nI
        jgE+qKANAH5Pt0fh5bbKbhLjPdho10kApEsx0qTUcsdTYFuVUu0+djV4m1sltEoiPXv8evh5hca
        hGRttio3Maz4aawZxWrK28xLA
X-Received: by 2002:a05:600c:1e1d:b0:394:2183:e75c with SMTP id ay29-20020a05600c1e1d00b003942183e75cmr1449447wmb.203.1651224572507;
        Fri, 29 Apr 2022 02:29:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkEWzgTJZjaYtD3yVNYsqURSYJbIbWoBwBM9HWJh9gbQs/M7ikohXN+kV9+WxpKCCTka/Prw==
X-Received: by 2002:a05:600c:1e1d:b0:394:2183:e75c with SMTP id ay29-20020a05600c1e1d00b003942183e75cmr1449435wmb.203.1651224572300;
        Fri, 29 Apr 2022 02:29:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm2140400wmq.46.2022.04.29.02.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:29:31 -0700 (PDT)
Message-ID: <95216c6f-0614-cadc-d256-92a172d8b8cd@redhat.com>
Date:   Fri, 29 Apr 2022 11:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4] mm: Using for_each_online_node and node_online instead
 of open coding
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        dave@stgolabs.net, wangborong@cdjrlc.com,
        linux-ia64@vger.kernel.org, adobriyan@gmail.com
References: <20220413032915.251254-4-liupeng256@huawei.com>
 <20220429030218.644635-1-liupeng256@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220429030218.644635-1-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.22 05:02, Peng Liu wrote:
> Use more generic functions to deal with issues related to online
> nodes. The changes will make the code simplified.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

