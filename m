Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F2348C483
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353449AbiALNNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353453AbiALNMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:12:44 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D474C06175D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:12:44 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id g21so2771281qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5AixT1u0DFbgGLsjAIQY4As80hr22iv0pFnHw3t2ouQ=;
        b=JylVxGEZ9RahFuhQ8+qXMf8FutoJor3hOfEsgDMD/zv3tehovHJrGRL8YIBIafsYYU
         3NchQ5Fgw7oxSfJ48AP8uOFExtARK+8zlGW5kjK3u9cOgslXRQknHd7Us5O7n92fYVhQ
         /8x3JAFFIPssT7+VQPYIQPFkmxoE7Uc1Qbb7O2kUPkbQ/wYW/jNQz7IV/UHG1H2beYLy
         BS7DXJhSeOJk6QCAnR4zbJg3wCp0YcuGeJHwfzFx6qAQq9h7fmkmERWdYbP9pezNhOA7
         Lm7K75wkuBhryjbhxultvi+RAaVT5Idq9M2C8FpqbyIKbYFLfRLmlbIVkDJ6UDA1M9SR
         Y+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5AixT1u0DFbgGLsjAIQY4As80hr22iv0pFnHw3t2ouQ=;
        b=RbV/LOuxLSKr4/flswdoqXNQdnj3h47sGk2zRHIpThvZY6K+AdNHFQw2CW2zjNb69h
         xFdPUwqRngHrbdVAzaByRGLmlJB22ZPbMoG9I1cGXAU0EabkcJ4GUH00MJLHPmznRmzo
         zHOtFd7+/S+IemKdVUlQoTw9+0He+tNPC35cS5LurHapMHkMJmVdys4GVjktot4Mjnlf
         xgmnQ8WxK6HOqoUtjdNA6ijooL83wH+CHpMABIvJsYhTrk3u2ftdmn7elwLXHWHSBuGT
         EA8kiPJg5Yya945EmyZXRi6afm0s3naYb/9t827CpWsnbISkA/1E5fqi7MDOJf1onLUW
         ztkg==
X-Gm-Message-State: AOAM532EK5R1dm+jdkujnOzYQJol0PD2YCSwoXfbdfL1dWWUGGo3z1kN
        5BZd6vuuFU7vjx7dBObmN4YPIA==
X-Google-Smtp-Source: ABdhPJw9AM5y2mHvX9TMDhFjQIFE16cy7sHvlQa1GsGTg8oO4XKLig5keQ9bfGyvel/eu0AdnKHDig==
X-Received: by 2002:ac8:5cc1:: with SMTP id s1mr7611444qta.220.1641993163618;
        Wed, 12 Jan 2022 05:12:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h1sm8567920qta.54.2022.01.12.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 05:12:42 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n7dQg-00F1pc-Bb; Wed, 12 Jan 2022 09:12:42 -0400
Date:   Wed, 12 Jan 2022 09:12:42 -0400
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
Message-ID: <20220112131242.GL6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
 <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
 <20220106173346.GU6467@ziepe.ca>
 <daa77a81-a518-0ba1-650c-faaaef33c1ea@fujitsu.com>
 <20220110143419.GF6467@ziepe.ca>
 <56234596-cb7d-bdb2-fcfd-f1fe0f25c3e3@fujitsu.com>
 <20220111204826.GK6467@ziepe.ca>
 <f980d32d-85b7-87b5-750f-aaa728d811c8@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f980d32d-85b7-87b5-750f-aaa728d811c8@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 09:50:38AM +0000, lizhijian@fujitsu.com wrote:
> 
> 
> On 12/01/2022 04:48, Jason Gunthorpe wrote:
> > On Tue, Jan 11, 2022 at 05:34:36AM +0000, lizhijian@fujitsu.com wrote:
> >
> >> Yes, that's true. that's because only pmem has ability to persist data.
> >> So do you mean we don't need to prevent user to create/register a persistent
> >> access flag to a non-pmem MR? it would be a bit confusing if so.
> > Since these extensions seem to have a mode that is unrelated to
> > persistent memory,
> I can only agree with part of them, since the extensions also say that:
> 
> oA19-1: Responder shall successfully respond on FLUSH operation only
> after providing the placement guarantees, as specified in the packet, of
> preceding memory updates (for example: RDMA WRITE, Atomics and
> ATOMIC WRITE) towards the memory region.
> 
> it mentions *shall successfully respond on FLUSH operation only
> after providing the placement guarantees*. If users request a
> persistent placement to a non-pmem MR without errors,  from view
> of the users, they will think of their request had been *successfully responded*
> that doesn't reflect the true(data was persisted).

The "placement guarentees" should obviously be variable depending on
the type of memory being targeted.

> Further more, If we have a checking during the new MR creating/registering,
> user who registers this MR can know if the target MR supports persistent access flag.
> Then they can tell this information to the request side so that request side can
> request a valid placement type later. that is similar behavior with current librpma.

Then you can't use ATOMIC_WRITE with non-nvdimm memory, which is
nonsense

Jason
