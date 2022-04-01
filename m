Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F594EEBC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbiDAKsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345140AbiDAKr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CA751D7895
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648809966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xiOEHMN+N8h0zJ0SMcJZz4gaUnk1cTnEy4jqmAnZpc4=;
        b=RLk6640Bp8Dw1uWQuvzro4yvhrl+uvYAnS3nsNwdmtDdzAcRheDPrrzWdmWis9N2MBNU0i
        f37r9uvHNIVmzSpHfn+RDzRSm5jJBdQC/FlqrzPCv+iSE5ejDBd7p/4m92GmPCzlnmapsv
        JLJg7EgDNeW5z/KRElchxAtkk0R8IlE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-LvrRUDj5N8eFEazqe2cg2w-1; Fri, 01 Apr 2022 06:46:03 -0400
X-MC-Unique: LvrRUDj5N8eFEazqe2cg2w-1
Received: by mail-wm1-f72.google.com with SMTP id n21-20020a05600c4f9500b0038e3b0aa367so1979168wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xiOEHMN+N8h0zJ0SMcJZz4gaUnk1cTnEy4jqmAnZpc4=;
        b=6gFxBbFaQljiD0NWYqG5Vnoy9D/u2mSMgcjnbzU4mf7llfde3q4b2pWwedlc7ayVe4
         G3aigZBOvMpa84VJabUzzsp5wm5fmCR3U4bDKCqAcnE+e1LtciPf4d+Ypbs+1H8t/qS0
         x19nQK13SJ0zEOh9VzUEaGhVcXl48UiytCZ1RMOQGmjn3Nj21fBtT4zlhakxqSyCXzSD
         l8ZPQY0TZP/jd4KdHlIbAKhoKbYIkdMYLrrmY+rlFJTOXNABYRzwhHerENi/97iN/YDi
         0ffDCAKmajyLdLiV3Z5luCDZPlA76oY+alwhPb3EKsAPrmPiOlmTEqmZ7BUC+s+IZHz9
         Xorg==
X-Gm-Message-State: AOAM532jGvXXX2ZD2E8wN0QnNZ9UZGdvhU6k1ywZN5V4Zea8//NG6JG/
        oqphoQghmenlRgjMoIu4sXCNmdAI+p3hZV6EXuOEB0+Z0FyhdkHRtmCcoz2CYA5zrtaGr8i14Dr
        T1ZT94/CyYUp6W7YsgMgdJ3Zw
X-Received: by 2002:a05:6000:15c3:b0:204:1185:7033 with SMTP id y3-20020a05600015c300b0020411857033mr7152791wry.625.1648809961979;
        Fri, 01 Apr 2022 03:46:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxG6qdtKkHpCzK5kfgnGP3ksdgfaziO7qjWnqOtF8DYMjkpdW5H7mcAyR9Skz1fhr1WB/9Aw==
X-Received: by 2002:a05:6000:15c3:b0:204:1185:7033 with SMTP id y3-20020a05600015c300b0020411857033mr7152778wry.625.1648809961748;
        Fri, 01 Apr 2022 03:46:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:9e00:229d:4a10:2574:c6fa? (p200300cbc7069e00229d4a102574c6fa.dip0.t-ipconnect.de. [2003:cb:c706:9e00:229d:4a10:2574:c6fa])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm14215057wmb.36.2022.04.01.03.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 03:46:01 -0700 (PDT)
Message-ID: <533f85f9-82e2-bfa7-3788-4b2a668daedf@redhat.com>
Date:   Fri, 1 Apr 2022 12:46:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/2] hugetlb: Fix return value of __setup handlers
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20220401101232.2790280-1-liupeng256@huawei.com>
 <20220401101232.2790280-3-liupeng256@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220401101232.2790280-3-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.22 12:12, Peng Liu wrote:
> When __setup() return '0', using invalid option values causes the
> entire kernel boot option string to be reported as Unknown. Hugetlb
> calls __setup() and will return '0' when set invalid parameter
> string.
> 
> The following phenomenon is observed:
>  cmdline:
>   hugepagesz=1Y hugepages=1
>  dmesg:
>   HugeTLB: unsupported hugepagesz=1Y
>   HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
>   Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"
> 
> Since hugetlb will print warn or error information before return for
> invalid parameter string, just use return '1' to avoid print again.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  mm/hugetlb.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9cd746432ca9..6dde34c115c9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4131,12 +4131,11 @@ static int __init hugepages_setup(char *s)
>  	int count;
>  	unsigned long tmp;
>  	char *p = s;
> -	int ret = 1;

Adding this in #1 to remove it in #2 is a bit sub-optimal IMHO.


-- 
Thanks,

David / dhildenb

