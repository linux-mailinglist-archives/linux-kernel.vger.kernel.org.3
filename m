Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBD15ADC43
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiIFAS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 20:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiIFAS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:18:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E439B564ED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 17:18:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o15-20020a17090a3d4f00b002004ed4d77eso4311690pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QfYqb6Pfw/hN4JPJ05FBEV50HBSGkGyPNi9iiQG7nRw=;
        b=ld4zch2mgovaLAdB8N98ih+6dYvI8qBpwLRLtjNUDXeImKkqFWB254xBhy80F0U90A
         J+yZQRYLuP0Jo0Mk4yML1TKUKTk4jEDPAOUEP0c5+yqaqhTQ7+gOhuufyatvIfqzg0BU
         d51A5BQHmMl/s8AQIKgv1IR+4ol+H/BXs6JEZtb4Swr9u9DXePXU/BvNKH7l3CIBjpu3
         /8dasrmmcoD2uYWsFEenjdP0uA9ZA4SxjaxZhym5FeSGQJkADFqbpqEmWC82AjcP9iKc
         1NfcpSGj9hkQFNFfw2zrIOCfADCzsT/D3pikpqUQo60TyPiILNt9xpxLMpKu3gGjb8Lt
         Rc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QfYqb6Pfw/hN4JPJ05FBEV50HBSGkGyPNi9iiQG7nRw=;
        b=Hwmhq98R5Fo27tFj8oPeS2zX+3OnJvR6RA9s47M0TGFlOU6QM9EwhSQ5ZyPOuocdps
         8KA48r+06ODbiLYF0E+aSBRPAMcRYFUf30g58DnKLqMRbMfr+pUTOWe7MYTzaqBPxS4R
         sJR1EXPwacmug3qwJCLP6NzHNZKnHj8D9jDXTcn3W+/A6+6mPAXXM/s9ifUzg6Cser/t
         hCTPbMbaEiobEJxQk8y4PMY0tl1rUiSH44ZGq9Ol1r94YQxTdBh26tOp4UWOrKOb6Afo
         4j21EyNjYOkGI3Y520Uc0/2shzXAY4VuSlrvrLhF/Ym1Uz5z9Pj0KLMBQzaIGb/qZrYH
         gJtQ==
X-Gm-Message-State: ACgBeo1dv38jdzblC2wrf4WdpM0p5CvVWZBiwRU5Nj898jGg7nmMsVuw
        WNAqUAk/ipFEcMuibs1WzNNg8eWMOzSi1Q==
X-Google-Smtp-Source: AA6agR6jxIENBgUBR97NH/krn8jJvwlo5786QKZ2UpSO6xuS9EB3TrYsrTPQOCKgXQVdaJ7TxrILOA==
X-Received: by 2002:a17:90a:7e87:b0:1fe:4d96:f6f6 with SMTP id j7-20020a17090a7e8700b001fe4d96f6f6mr21348991pjl.142.1662423535323;
        Mon, 05 Sep 2022 17:18:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b0016dc78d0153sm219209plg.296.2022.09.05.17.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 17:18:54 -0700 (PDT)
Message-ID: <55a2d67f-9a12-9fe6-d73b-8c3f5eb36f31@kernel.dk>
Date:   Mon, 5 Sep 2022 18:18:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: New topic branch for block + gup work?
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <86266dcc-d475-7cd4-77dc-a8ba6f11620b@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <86266dcc-d475-7cd4-77dc-a8ba6f11620b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 5:16 PM, John Hubbard wrote:
> Hi Jens,
> 
> After you suggested a topic branch [1] as a way to address the recent
> bio_map_user_iov() conflict in linux-next, I've reviewed a few more
> patchsets in mm, and am now starting to suspect that a topic branch
> would be ideal here.
> 
> Logan's "Userspace P2PDMA with O_DIRECT NVMe devices" series [2], my
> "convert most filesystems to pin_user_pages_fast()" series [3], and the
> block layer change from [1], all conflict in iov_iter*, and in
> bio_map_user_iov().
> 
> Less of an issue but still worth considering, Dan's "Fix the DAX-gup
> mistake" series [4] conflicts in gup.c, too.
> 
> Maybe:
> 
>     gup_bio
> 
> , or something like that, as a topic branch?
> 
> Everyone: thoughts, preferences here?

My suggestion would be to branch from for-6.1/block, then we can
apply the gup patches on top of that. I'd probably just call it
for-6.1/block-gup.

-- 
Jens Axboe


