Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7656489B50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiAJOeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiAJOeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:34:22 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C93C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 06:34:22 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id jr5so3635682qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 06:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KzYKjySaNA8gCwHGzl2FyGGW1Nu0aUpHbWQZPToIi38=;
        b=BhRvhK/w4tJaYtkJGmat1mS0fsTGROYWJEh6tPRgBZAj/SGfz0bmMMGl/5UgrbYBz6
         6jpGItoVz8qvhkKVzFxwI9gA1dAYCWIFYGhL6VcXOE/SU/wHzlO5E2hB4YlALUIrTKs7
         has8g65OJGSKuTCV3XZuwtO6msLzX7Xm0rPaI4XeM9ly4MVkDD3Zs+fw1i4tNgNBSgA6
         aXZbRJb0soxVB4kmOFHXP+aSpn/opjQjN95WPvkC4oECvAJ7eRCzqapDbJLc6kBI41HQ
         IhPRZOHr7uZvYC3MOWwoqh8Qy8mvZiSWdywAGVoOayk3np8Y94qmBIEWeilo80OTvhAN
         pY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KzYKjySaNA8gCwHGzl2FyGGW1Nu0aUpHbWQZPToIi38=;
        b=Ia+f4GCHbbn6vSqq+oJE/IA/mA4H7Yk/ybYpsRbVjk1O6D5fQeJb4DwizFt8RJTLft
         0jq/tZ/coyIk+4U+2App+8P5FyR7oUk4q0MnndZo0gSCfz4IXo2y+3/S3gN6E89ftTwH
         rlSvOqNaUPRuGk1nHyxhMZRUUucNEr8Wi2GzqWcE16ANU+C3Fq98sfQBYeToreHUvMG+
         7AY+qJ/6Jg/L9lz/oF5DRj5ipPXBBaW3l8s6GMfEcd/QJqWYvXj6IXAU5DilP+KmX3T+
         Tmh5i98+hi/ugD3JfVXgCd6Rz4JjBB4lyvPhReoD6u/9YS2TXLwKkMOjiu5zPMNrVnHq
         BJ2A==
X-Gm-Message-State: AOAM531KYBIQzihidPCk9ePsLOSnOSXH/LDtuN5gSeHXUHG0rlGZwBGq
        73+YFWgviRYNqcVCe5eeB3vbMg==
X-Google-Smtp-Source: ABdhPJwVssi4btKUH8E3kzLUaS3f99Ib3fKwcC7InqMA3lS6sRmydZeLeFDbpXNA457FvCYcbz/t8w==
X-Received: by 2002:a05:6214:301:: with SMTP id i1mr3166053qvu.7.1641825261119;
        Mon, 10 Jan 2022 06:34:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u6sm4642565qki.129.2022.01.10.06.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 06:34:20 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n6vkZ-00Do5L-Qp; Mon, 10 Jan 2022 10:34:19 -0400
Date:   Mon, 10 Jan 2022 10:34:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Message-ID: <20220110143419.GF6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
 <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
 <20220106173346.GU6467@ziepe.ca>
 <daa77a81-a518-0ba1-650c-faaaef33c1ea@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daa77a81-a518-0ba1-650c-faaaef33c1ea@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 05:45:47AM +0000, lizhijian@fujitsu.com wrote:
> Hi Jason
> 
> 
> On 07/01/2022 01:33, Jason Gunthorpe wrote:
> > On Thu, Jan 06, 2022 at 06:42:57AM +0000, lizhijian@fujitsu.com wrote:
> >>
> >> On 06/01/2022 08:28, Jason Gunthorpe wrote:
> >>> On Tue, Dec 28, 2021 at 04:07:15PM +0800, Li Zhijian wrote:
> >>>> +	while (length > 0) {
> >>>> +		va	= (u8 *)(uintptr_t)buf->addr + offset;
> >>>> +		bytes	= buf->size - offset;
> >>>> +
> >>>> +		if (bytes > length)
> >>>> +			bytes = length;
> >>>> +
> >>>> +		arch_wb_cache_pmem(va, bytes);
> >>> So why did we need to check that the va was pmem to call this?
> >> Sorry, i didn't get you.
> >>
> >> I didn't check whether va is pmem, since only MR registered with PERSISTENCE(only pmem can
> >> register this access flag) can reach here.
> > Yes, that is what I mean,
> 
> I'm not sure I understand the *check* you mentioned above.
> 
> Current code just dose something like:
> 
> if (!sanity_check())
>      return;
> if (requested_plt == PERSISTENCE)
>      va = iova_to_va(iova);
>      arch_wb_cache_pmem(va, bytes);
>      wmb;
> else if (requested_plt == GLOBAL_VISIBILITY)
>      wmb();
> 
> 
> > why did we need to check anything to call
> > this API
> As above pseudo code,  it didn't *check* anything as what you said i think.

I mean when you created the MR in the first place you checked for pmem
before even allowing the persitent access flag.

Jason
