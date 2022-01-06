Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F66485D27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbiAFA2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343750AbiAFA2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:28:06 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511ECC061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:28:06 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 196so943974pfw.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 16:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=teRg7ov5+cXYdE6XRTH5gl1i4HzaprIEAt7221WVaKs=;
        b=Ytd0Sg80hz2CaAGVDs+cy6OuK+Lvfp2N8GYcOPvgUc6YVumepP5BcGgITQ/Hr6KhzJ
         bhtl6kcaa9rCUHCqK3VAh/J+RoX2K9qNCaejGumyWX9jdftrKnUNXUbZq16vWdKQ/sAf
         YSZ+xT1Lo48sqXyVbuynCx/j27/QZxUF72picHXA6bU0UJSLUkOCXzxMK+OmcfbjdHPL
         nx03X1v/eM/0+UiJ0tFEgCuErmS1rnBWPnozIKZLm8fuxToFerBE27Id/7wmo9Up/67U
         9IrWMR7hDZh0m67qB299Uen8bt2K+zHg0RlnbezpSJuEC5/I2CRLs/fml5xe6tQQlkf6
         I/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=teRg7ov5+cXYdE6XRTH5gl1i4HzaprIEAt7221WVaKs=;
        b=QQQfCdMAzBX0FLj/QW1kFzNyLg9MYXDT/AC3uBbEEngcnTaP4LCAjrdMrqpCWOgw/O
         PumMjgLmUp3eSXFye+aKxiCPGMJFNpd5P76oOMdOq5ihCMMwTCnBIJeT/N8XFF3uIkCF
         vSkh9n0uT3NY0ince1ssbn4thmcCPRmfWeWFHYhNrrRTvxSdtZBFxSBFbsL8PHkRrBox
         OEqFGtFslR/rIlfCoBsCTfUj/SQNmrv23aa2En2iwGVzRDTJg61M1X1e68Et4lRm2VYy
         +tQ7r/QseFkkYDqRu9zAxOlhrtDt4JmjjpTFkJbO2HNphxkoI3TnX8gg2f0TOuBwFvTj
         9bJQ==
X-Gm-Message-State: AOAM533oyqvfJNRGCXgvf4C7y/g5L8d39i0uZTOUnO2Z0XslCJU1zEKh
        kMNhzlwER9cm+UkUd9Zp8Rdf0w==
X-Google-Smtp-Source: ABdhPJw3NRIiXeOdLj3LICN8aO0lsGARj/1EKd8e1kG8Rgph3UFjrejivAiPEHM74R+56xy3dqRbEw==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr44592443pgc.94.1641428885953;
        Wed, 05 Jan 2022 16:28:05 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id ls7sm150453pjb.11.2022.01.05.16.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 16:28:05 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5GdQ-00CDca-13; Wed, 05 Jan 2022 20:28:04 -0400
Date:   Wed, 5 Jan 2022 20:28:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        aharonl@nvidia.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        mbloch@nvidia.com, liweihang@huawei.com, liangwenpeng@huawei.com,
        yangx.jy@cn.fujitsu.com, rpearsonhpe@gmail.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Message-ID: <20220106002804.GS6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 04:07:15PM +0800, Li Zhijian wrote:
> +	while (length > 0) {
> +		va	= (u8 *)(uintptr_t)buf->addr + offset;
> +		bytes	= buf->size - offset;
> +
> +		if (bytes > length)
> +			bytes = length;
> +
> +		arch_wb_cache_pmem(va, bytes);

So why did we need to check that the va was pmem to call this?

Jason
