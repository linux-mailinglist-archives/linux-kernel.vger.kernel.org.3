Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC749B511
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576716AbiAYN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1576645AbiAYNYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643117059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBuf2DEMMEYvXIlU2KdQGISDe09T8cEBp/JHdIeTMLU=;
        b=LuJHWuAB9y2n8wY71ac//MSYIK5Kfc6ifB8pSJhZKvONAsyeuoDeXQap0p/HZL4Sfr89bF
        lMwNv3MOlfwJgXqBoLlAP82sxJ3yieKFm9mPmNuero0BKBgFZHwsgZO0cehAc+mZHpqZll
        dVtw1uFgIlRUN2F+9oStLIJdZzVKlvk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-lydFtNizMO25DUBHDsa51A-1; Tue, 25 Jan 2022 08:24:17 -0500
X-MC-Unique: lydFtNizMO25DUBHDsa51A-1
Received: by mail-wm1-f70.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso1462020wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nBuf2DEMMEYvXIlU2KdQGISDe09T8cEBp/JHdIeTMLU=;
        b=Q5hltFBXCK41auLcW0eGpibv2E0sJ/7UVB1yokf7uc0Bwy0rON+4wsgqWg9MJd3DDb
         4hym9Hva0hAP+b+XvK9b4eUIQbtRQkYBHxF5UxjJQCaPYLNNLM+XzUeo/yKSNjl31gLR
         R5B/vWLJhXoySiQR+Geevu/A0uv4lg30KaitkidykPUbyg6/m8+GhBFk6eLxsmudI44K
         +jZmHDm3UXm06D6YMp55eVxu+tVa3ny+EQ8LOECRb3yaQJZKpSOiIXSk3T6JCimte0vw
         q46aT/zmrTw9D8HRF6gBxVGovDQ4xnUEkUp2cPf6WQyR1BfHI9cECn8jppiBQtZtW+Mt
         N1ug==
X-Gm-Message-State: AOAM532KRUBDkUfGreGMhaplJlWpbR1cSvjeow1mZLhERFJTgKNURox7
        SC8VA2Mj5K05i+ZtJqnHf9cH8bR1vWmgd/7vWRxwMYdh/CB3Ji5/XwmTI3NiKXYJR50OjbEAgnx
        qjgYtALjeFipoSYOgDaSQUKyy
X-Received: by 2002:adf:df84:: with SMTP id z4mr18355487wrl.519.1643117056637;
        Tue, 25 Jan 2022 05:24:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykX9Z09gHjcPtI7/ZjdztfQF3TWvj2kNgbHH+lViiPnjYVjMpuSFmy3f9HCngWET/i0aIKXg==
X-Received: by 2002:adf:df84:: with SMTP id z4mr18355467wrl.519.1643117056451;
        Tue, 25 Jan 2022 05:24:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8000:9797:8f:1ed9:7596? (p200300cbc70f80009797008f1ed97596.dip0.t-ipconnect.de. [2003:cb:c70f:8000:9797:8f:1ed9:7596])
        by smtp.gmail.com with ESMTPSA id 11sm368265wmx.5.2022.01.25.05.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 05:24:16 -0800 (PST)
Message-ID: <a4faeaa3-ed16-3ee8-8e1d-71bc1029e1f5@redhat.com>
Date:   Tue, 25 Jan 2022 14:24:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/balloon_compaction: make balloon page compaction
 callbacks static
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220125132221.2220-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220125132221.2220-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.22 14:22, Miaohe Lin wrote:
> Since commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
> feature"), these functions are called via balloon_aops callbacks. They're
> not called directly outside this file. So make them static and clean up
> the relevant code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

