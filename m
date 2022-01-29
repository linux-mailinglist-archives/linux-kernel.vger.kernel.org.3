Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2BD4A2D48
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiA2Izb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiA2Iz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:55:28 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92368C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:55:28 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id v3so7411733pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rPu2HBvzZbtvcpRAuhqaksiaobPFCGfVbtgZjOV2Ip8=;
        b=GwqJGYZzY2Aeit3fAmxcFpmZprtOezVdhPoPc+HMwlb8qxgyftVCWWtVhtRk8BV2GP
         cJPrFtL8EBIBoSMZs+9VCqPrs39NWRWwD3RA1EwmY6EzBts6dP9rfgakyZqGllDlwml5
         ZS1YhZR7fQzp3iu1aN8If8XTIIZmFhw6cioWAWzPMrE98w0VDAq5MtXhPkZf6KCIEPhh
         aMrcfR19T4fG2LaO2vzmcYlOzg8cP1k1gjBUDRp5AJwKNbBleH6TuP4/F1icMAHdly4W
         NkO4/oDvIwnlv55m5WNPGOyT3REgfgJMi6COySUwWRNmzxMDyiOJPINrL+insmKtpq/t
         eBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rPu2HBvzZbtvcpRAuhqaksiaobPFCGfVbtgZjOV2Ip8=;
        b=RUqrVolwYprhiL+waol844Z4x6j4GSbQtU21XIN7EEJZeIT8Gr2pwpgb+I/K+86Dna
         wAxLJuBonLAut1sIvDxDtlUB1/kRALAKWPAThG9G8dnQ8rqIQ/VLgstlsm4C9Ivv+WFJ
         C02o4Lc3N800GdlWgAzR7pgQRdAa87ZL2yrFrI50rOWMrQGciOKUxrilcfY1otq7pSsa
         drG4hvikJRcWGARkH/fPjVG1rvHoTFOZgW6O9z796XQWGMXZGCkb7GqEIZ69m15HyS5a
         xSnvwE2hwmKbmDH7PkS7xHdXLTvt7V02+SXSh2KnZDCZBrM0uts8bDIKcuDIV/e0NvaX
         pfJQ==
X-Gm-Message-State: AOAM532drwttSjkI5uG3O2pRIz1I9+ezc+uSbu+0mSnuXcgoWN4+mBvP
        cwkwzjrFw9fsRuV50iJLnuE=
X-Google-Smtp-Source: ABdhPJyvtN4v7p6t49rHzgxuU3zRpGWuEsjtd+CXX+Vl41YsI+N5hGXcuVWXZVcoePR5czukYc0lng==
X-Received: by 2002:a63:ff43:: with SMTP id s3mr9544703pgk.623.1643446528129;
        Sat, 29 Jan 2022 00:55:28 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id 6sm3048349pgx.36.2022.01.29.00.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 00:55:27 -0800 (PST)
Date:   Sat, 29 Jan 2022 08:55:22 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     jwiedmann.dev@gmail.com, Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sameeh Jubran <sameehj@amazon.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ena: Do not waste napi skb cache
Message-ID: <YfUA+vdxF/S+0/SB@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220123115623.94843-1-42.hyeyoo@gmail.com>
 <YfFJuQQBLJRxIJR+@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220126075220.3d60981f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126075220.3d60981f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 07:52:20AM -0800, Jakub Kicinski wrote:
> On Wed, 26 Jan 2022 13:16:41 +0000 Hyeonggon Yoo wrote:
> > By profiling, discovered that ena device driver allocates skb by
> > build_skb() and frees by napi_skb_cache_put(). Because the driver
> > does not use napi skb cache in allocation path, napi skb cache is
> > periodically filled and flushed. This is waste of napi skb cache.
> > 
> > As ena_alloc_skb() is called only in napi, Use napi_build_skb()
> > and napi_alloc_skb() when allocating skb.
> > 
> > This patch was tested on aws a1.metal instance.
> > 
> > [ jwiedmann.dev@gmail.com: Use napi_alloc_skb() instead of
> >   netdev_alloc_skb_ip_align() to keep things consistent. ]
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> It seems you missed CCing netdev@, you'll need to repost.
> You can keep the ack from Shay.

Oh my mistake. I did it. Thanks!

Hyeonggon
