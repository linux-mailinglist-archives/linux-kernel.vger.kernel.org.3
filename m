Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F29524F81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355148AbiELOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355089AbiELOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:11:12 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1804C5DA14
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:11:11 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x22so4383047qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W9kUsQ7iaf/fGC1LawqMOEGN2VGRt/BHknxB+hELvo4=;
        b=hFjDqpVrBwz/QBfaAppaZ7QcUKTY9se25EC9giSUnNRazswfDuoe/WCDWe1vaOIP/k
         shnNsGxm6dDGij0iU4BbqQOUjZvu6JHmCYgVe49B8iKfKiJDFe3ub8nfAavHi34Lwv0H
         1nDBIiwanxT4DdEv+rsa8WWKYGZXNCIU+0+7GqLukfKZpR0VhP0CQF/SyR6lE9NUMhwB
         n8ml0iqKrvUv/QgfL3+WxdDbE1Qf8n8Y78tH6fHGw5+u0ALcu1Jkum9Ev+/bgIZBBi+G
         05+oqEIawAoJJ0sIVNFu3Q4ffchWqi3UBR5n5j7e/RI8cOHIIpxiAIGBiXOvqTKJjM46
         ApRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9kUsQ7iaf/fGC1LawqMOEGN2VGRt/BHknxB+hELvo4=;
        b=bPcVw108+uum7uKATwaQEudWvrjPbQneDGjFmfzr0dVts+3uj6JJTxjUSn6UvaBL+0
         WL0mZ/VlLLa9OYya0BWYOjqg3n4tY5iiGIetoiesqdIrO31GAZxRyV/lgg9nl7+140gu
         rj3lwBnMUwF5GcnA5XzxPApgydkQc228gDjrJ2qk1J/MnBNkYjFoNW6KIIBpI+btIK2I
         Eyto4gAd5zT4GcmhKqDTHSZF603GQTPghyxLgsOpZMBp+IHlf9g5WbIgDiXxscOqvCuA
         Q5T1Cnr+hjORWMie1kb1H8S/ykD55npCNhddEngI1nr9L1UkRpDeV6FtX/4vxRPQCKIm
         37kg==
X-Gm-Message-State: AOAM532uu+WiRme50HXM7lFPXLsgkG7b9/kPTXzBPNszGo4tazhdVqa4
        aAzGbvbbazCYZv2te+UWVbQcew==
X-Google-Smtp-Source: ABdhPJyBAf/ZQ2uIqaYB6JUM7gaDQ9I3a2iAIQClkmMnpO9/mU5e6WIa9Wxf47rqHjfK1yXoGD7ZeQ==
X-Received: by 2002:ac8:5ace:0:b0:2f3:ec3f:eb8c with SMTP id d14-20020ac85ace000000b002f3ec3feb8cmr10091107qtd.20.1652364669802;
        Thu, 12 May 2022 07:11:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p5-20020a05620a056500b0069fc13ce1efsm2883828qkp.32.2022.05.12.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:11:09 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1np9X2-005emx-4V; Thu, 12 May 2022 11:11:08 -0300
Date:   Thu, 12 May 2022 11:11:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Leon Romanovsky <leon@kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "open list:CXGB4 IWARP RNIC DRIVER (IW_CXGB4)" 
        <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
Subject: Re: [PATCH] RDMA: replace ternary operator with min()
Message-ID: <20220512141108.GC63055@ziepe.ca>
References: <20220512135837.41089-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512135837.41089-1-guozhengkui@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 09:58:37PM +0800, Guo Zhengkui wrote:
> Fix the following coccicheck warnings:
> 
> drivers/infiniband/sw/siw/siw_cm.c:1326:11-12: WARNING opportunity for min()
> drivers/infiniband/sw/siw/siw_cm.c:488:11-12: WARNING opportunity for min()
> drivers/infiniband/hw/cxgb4/cm.c:217:14-15: WARNING opportunity for min()
> drivers/infiniband/hw/cxgb4/cm.c:232:14-15: WARNING opportunity for min()
> 
> min() macro is defined in include/linux/minmax.h. It avoids multiple
> evaluations of the arguments when non-constant and performs strict
> type-checking.

no, these are all error return patterns, if you want to change them to
something change them to

if (error < 0)
   return error;
return 0;

Jason
