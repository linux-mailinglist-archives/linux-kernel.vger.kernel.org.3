Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9444868B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbiAFRdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241861AbiAFRdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:33:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E9FC061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:33:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so9409157pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SVU9ojxKh3KV/GkNCH2U8jLzNnNx2BrytGLDVlfM2n4=;
        b=B7uhyCQuWye9aBf8yPcxb8+lyR96aaQke/GnM1Lg02NwGIbHRbmz4KClAxslwbq7U4
         Yebv3rE7W75n0qCr4B1yNF0W+BOhQUuc64tplojX1gSd1ODhjw11QN/e6aeUwDBlNx0h
         bh1dxebH0y7DIlnsUH9/9L7tptxPiYlQ+MGC44/aH55Grc/D0PciIW6R7bG7OT9T8+1j
         uQIEyqiFgMEl0bAHBBRzwMzQCbLDyUed4PqBcENUbl7LhcZXdtdaw5dkA33E7Nr4+czL
         4P4mEVEsj97UwkqlV2Xx1QadRt2QpvFJlmlsUkDyY+InxvI2q13Ja5cJoKNCGbZDOWgD
         3OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SVU9ojxKh3KV/GkNCH2U8jLzNnNx2BrytGLDVlfM2n4=;
        b=nm1O+JdQurIjM2XhIwBQa7hqtOr88wCgvN8wSgLTXETMNIePM9Stq1bY54DFlomHs7
         YpDw/79rzJq74YxJOQBTq/uC6lOU2h4juf6zOu0fhU2sA309kkQHm9TOqlunp+nbX7LF
         UlYGYu7S4J1GkgFhZr+oCM0ZrFkL3j2mq1bxqHRBPi0aSgDg7EHTvXKTFxUxeVg6d64A
         pie7AYrVWJ6kbbYloNzL/kauXKlb+1XXxKt7C2J1Hb+e+CTWf8j5mqsoWj0p9/r6x8Yw
         u+H8jMRsHi6rpsCYQ8lcHuC0q2jIB6xZ9yzIY7Y4IO5WBKm7FhP46KYSNCxuLrdmCUxp
         wiMA==
X-Gm-Message-State: AOAM533LRNFr3jx+eaFNonmMOu+X2hxDn9ojZvzk8EG7ucALRjSxJdrO
        w8vXZhZE3jHl8D0H4wOrlB+QPA==
X-Google-Smtp-Source: ABdhPJyZaTVYpO1ItL4ZGLZUkEwmwFKFW3I/igBkCy9iAG62enlQpIFkRSuiwUlPtU89+7Kwcm6jMg==
X-Received: by 2002:a17:902:8505:b0:149:ac79:d8d6 with SMTP id bj5-20020a170902850500b00149ac79d8d6mr28217912plb.170.1641490429554;
        Thu, 06 Jan 2022 09:33:49 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id ng7sm3343172pjb.41.2022.01.06.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:33:48 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5We2-00CQtq-FZ; Thu, 06 Jan 2022 13:33:46 -0400
Date:   Thu, 6 Jan 2022 13:33:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Message-ID: <20220106173346.GU6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
 <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 06:42:57AM +0000, lizhijian@fujitsu.com wrote:
> 
> 
> On 06/01/2022 08:28, Jason Gunthorpe wrote:
> > On Tue, Dec 28, 2021 at 04:07:15PM +0800, Li Zhijian wrote:
> >> +	while (length > 0) {
> >> +		va	= (u8 *)(uintptr_t)buf->addr + offset;
> >> +		bytes	= buf->size - offset;
> >> +
> >> +		if (bytes > length)
> >> +			bytes = length;
> >> +
> >> +		arch_wb_cache_pmem(va, bytes);
> > So why did we need to check that the va was pmem to call this?
> Sorry, i didn't get you.
> 
> I didn't check whether va is pmem, since only MR registered with PERSISTENCE(only pmem can
> register this access flag) can reach here.

Yes, that is what I mean, why did we need to check anything to call
this API - it should work on any CPU mapped address.

Jason
