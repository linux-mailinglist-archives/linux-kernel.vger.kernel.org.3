Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E77514657
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357163AbiD2KMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiD2KMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 737E8C664A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651226941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcaISLSLdyWZemeMh79f2GIjMvsQzaqiIyNmuSTywU4=;
        b=RAl/mCGr55rnSh2yMfAR6xn9lIbHh8138xjPMaE5w0HJhBb8fUx8kRaSvndBCpQSZ1o96a
        y+56t3jbVOIiQr8vqg6d22dzRNHoKnodPzV/t7ZeB/kBAnMmHmCfjzLfqEOjoUjIdnPq1K
        pvTRKC08TQjmyW7bHvhbQhXQWx0Q95M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-o3cV4lsMNu2nIAiahpZ9kw-1; Fri, 29 Apr 2022 06:09:00 -0400
X-MC-Unique: o3cV4lsMNu2nIAiahpZ9kw-1
Received: by mail-wr1-f71.google.com with SMTP id u26-20020adfb21a000000b0020ac48a9aa4so2891885wra.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=PcaISLSLdyWZemeMh79f2GIjMvsQzaqiIyNmuSTywU4=;
        b=kgf/sOUhTkqdMV7o1wnp2zWbDM0VV/vfKJRyjBud0Tm94jA4aMQ+ALWRdDJkMLXsAw
         sXhCBhoPJR77gwW/YXNmLAKjZsO8KRkJTQyvQusPro272vHrSXTbdMHVla6QN0nYhcJf
         DgB/nT0Eoy4Rw98KeO5CbJDlKLIQUiHV/H2ekGAWXI4P4qbp7FAXml2h64NN9C09J5H5
         NhZ4PeXcR6xo9sWTTF/Eb/Di82UuqPQlyQRZOF+AWlCmGnDS3Xtre8nFgK2+28NocLUa
         z3DMewodxf/6g6SAlg2GSSHhnvBK7uqs3PQRG3EOqavq+nhZ/6Mj6QVDnGspzatxVUi+
         htRg==
X-Gm-Message-State: AOAM531Dng9UTog1hhjWLBmu2y/5PjZ/NsKzeziV7DyqxmIP/jfMqIOR
        0AA4WIJnQWh1VNXV26HD9yvHoUB7ipPZxtYzG+Ewi6SxyxjkDx0DkdnEqa0zHt666Piy0BAE2r1
        Iy51O1kCWiw86B8JOnq/vkofK
X-Received: by 2002:a7b:c106:0:b0:394:19aa:4f91 with SMTP id w6-20020a7bc106000000b0039419aa4f91mr2509841wmi.68.1651226938838;
        Fri, 29 Apr 2022 03:08:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdv5UT/aWPCC6mSRfc6RXnUHLUBDkQjXkGiwk5zB8FkDtFXoaysLHQZZrnFGmo42uAb40yGw==
X-Received: by 2002:a7b:c106:0:b0:394:19aa:4f91 with SMTP id w6-20020a7bc106000000b0039419aa4f91mr2509816wmi.68.1651226938601;
        Fri, 29 Apr 2022 03:08:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id o30-20020adf8b9e000000b0020ae802da1fsm2318717wra.90.2022.04.29.03.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 03:08:58 -0700 (PDT)
Message-ID: <f06e4a39-39e7-44de-dbc8-dc82ead37047@redhat.com>
Date:   Fri, 29 Apr 2022 12:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 3/4] mm/migration: return errno when isolate_huge_page
 failed
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, naoya.horiguchi@nec.com
Cc:     ying.huang@intel.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220425132723.34824-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 15:27, Miaohe Lin wrote:
> We might fail to isolate huge page due to e.g. the page is under migration
> which cleared HPageMigratable. So we should return -EBUSY in this case
> rather than always return 1 which could confuse the user. Also we make
> the prototype of isolate_huge_page consistent with isolate_lru_page to
> improve the readability.
> 
> Fixes: e8db67eb0ded ("mm: migrate: move_pages() supports thp migration")

If this is a fix, what's the runtime effect of it?

You state "could confuse", which doesn't indicate an actual BUG to me.


-- 
Thanks,

David / dhildenb

