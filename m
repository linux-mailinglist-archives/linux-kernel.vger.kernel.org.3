Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17FA484367
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiADOb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:31:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234182AbiADOb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641306685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSbFiIkCa7pMhGDthWmAfMNT0dx4lGgrz3BAfDoZH5c=;
        b=JnEIsbCTr22Sa5c6cNYIhBUQ62oGMMX6jMl/cLMplqh0yvDk/5RtQx09Hk7ZdQB9K3edaE
        Z0GkrYVN33Pr+IGratkg4TbMngLrDjwuXFaPVkXhAP4dAre857JA4EwkQVDTfvP8Kp8Jy4
        BvrGyB5bxdK+upTw5enAjyIiIilNA/Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-Ga6OhM20P5-3yp9XFRLVIg-1; Tue, 04 Jan 2022 09:31:24 -0500
X-MC-Unique: Ga6OhM20P5-3yp9XFRLVIg-1
Received: by mail-wm1-f71.google.com with SMTP id x21-20020a05600c21d500b00345a25ea8cfso365008wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=PSbFiIkCa7pMhGDthWmAfMNT0dx4lGgrz3BAfDoZH5c=;
        b=Vs0b2vZlglzG4VVy9rtAssK7md0XBJv6bqN1SRqpfRCbL18lmDje/pzV77RHVy2OSN
         7ME8grFNVGVL1OtXDj/tapzB7XKcEYknZzlfZvImiBE0FsgRFnq2dh5HxXyiQzPTBVHC
         1Zcwi0jPJBRpkiuZ7TnrQvCVEFN+HsVSdhDhIC/rzEGNlHN51JrqJibA69EqerEf2Ucv
         ML2QxTxRQHu60ShGupjEuLIlDAXhUNFfzf95ZAhrJTQcyaDaq5TeEwLHAiC44PSB6ANt
         o5UEk0yRlh75S/WCcVt1Dgvcj2i32WQiQ5QPQjsnPiHNsocWXUwTHJ1pA0e/qykIRqOA
         Ltmg==
X-Gm-Message-State: AOAM533V1p0nZwsg2c8Dn0YX2BQ9C1WZ9gN2gG4YgspEomKz5c/7DEMh
        uiiiUijb2arasYFzj1wM6RUBW2hnFhkerJh/j43wZ6BVQ0CrB57ap/TLuR9AnLmEKEDdqDNPSLs
        shbT/lVZAlQZZa34mFZFEZSCt
X-Received: by 2002:a1c:2b42:: with SMTP id r63mr35437017wmr.80.1641306682489;
        Tue, 04 Jan 2022 06:31:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoD394cIAvWOPJzX1c3qieoiNBQSBerEgc05mgXT5JV6oRQFZPfL/TP84Ze3JTIZi6PiROVQ==
X-Received: by 2002:a1c:2b42:: with SMTP id r63mr35437000wmr.80.1641306682335;
        Tue, 04 Jan 2022 06:31:22 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62bd.dip0.t-ipconnect.de. [91.12.98.189])
        by smtp.gmail.com with ESMTPSA id a2sm43078904wri.17.2022.01.04.06.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 06:31:21 -0800 (PST)
Message-ID: <10ec73d4-6658-4f60-abe1-84ece53ca373@redhat.com>
Date:   Tue, 4 Jan 2022 15:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: remove Xen tmem leftovers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211224062246.1258487-1-hch@lst.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.12.21 07:22, Christoph Hellwig wrote:
> Hi all,
> 
> since the remove of the Xen tmem driver in 2019, the cleancache hooks are
> entirely unused, as are large parts of frontswap.  This series against
> linux-next (with the folio changes included) removes cleancaches, and cuts
> down frontswap to the bits actually used by zswap.
> 

Just out of curiosity, why was tmem removed from Linux (or even Xen?).
Do you have any information?

Happy to see this cleanup.

-- 
Thanks,

David / dhildenb

