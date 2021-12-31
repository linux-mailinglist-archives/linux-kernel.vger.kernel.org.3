Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A4482213
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 06:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhLaFEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 00:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbhLaFE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 00:04:28 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDF1C061396;
        Thu, 30 Dec 2021 21:04:23 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m1so22876584pfk.8;
        Thu, 30 Dec 2021 21:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jv3w8ysID9bIetc2OrmK9ofIibDjY1UTgwH1tyTgknM=;
        b=UQik1Bm7JhtWirI+JIelxhnGBp+K+kC5f3J3KIkbaERNBoP8cj873RRDIkmWi4VxAm
         wuDuYKsF7Hv0tcJO8ZQcKScLVZGYlRaBOg5SWSsB415XYzCmR/6ksW69jt1ujH/15Nwe
         8AF2q/o69XN8XcznhFKD9hocYPnVroLcjhx5eszoRISoVoO8wTW3AY2s+oLrKbFbe3Rw
         jq9fAnqdZUvuXwM/Gups9NqUw3MdugBYV77IZI2gW8vGbiL6dOtHTY1p7QVve2VlyLwN
         /l38q01peucbO1LW0UgpKa5JZhONC4TUC9K8SMmkzq4Ut5kPpdmw33oaMLvLsqPZPSyo
         52jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jv3w8ysID9bIetc2OrmK9ofIibDjY1UTgwH1tyTgknM=;
        b=FJo/US/UX6iduHVl+oOoqBqaSyDrYsChG5zKwXNn+IEiWRxyVv/wUVehDFCmZPtfgT
         IybAZzP9bmTqphrNWuTcIgAdDepD4W/sUI4s2SZdcLsnfMV/0fZMy7VCMyG89bkhaKqc
         WymIjoOuFNt0W4B8fx4xK8uBqoxgE2uTQYLiLM1NoP0ty/2jppRQWmnFdjEpGnuMHJvu
         2NEsV2IzqWxBgcgPm4KKH6FwC0p+ZY4DTehFgSDysdYW91ZEyVATiCYoOZoOvFzHa2Wt
         rVVKtgLgfe1SDj6GxBGILcnCI89TCiktsi0CjUNv6al1KfLDt0CUd2GcUg1OVc54Tdby
         yA4Q==
X-Gm-Message-State: AOAM533gnc6vStSwcQWllYHDd93MbH3a8jcB/0zQW8WVj/adCXWuoke6
        ZXOeaGgI5AkU63B8canxA00=
X-Google-Smtp-Source: ABdhPJz/RJrMGYChq/MXzCqULBB2tzlvAn2H0bZW/JDf6Zw8jzay7WamvklxRmTY9+I/ZacKI07+dg==
X-Received: by 2002:a63:20f:: with SMTP id 15mr30710800pgc.490.1640927062455;
        Thu, 30 Dec 2021 21:04:22 -0800 (PST)
Received: from google.com ([2620:15c:202:201:ecb6:a6a9:17cc:2829])
        by smtp.gmail.com with ESMTPSA id p37sm24929343pfh.97.2021.12.30.21.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:04:21 -0800 (PST)
Date:   Thu, 30 Dec 2021 21:04:18 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     kernel@nn7.de, mjg59@srcf.ucam.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+b88c5eae27386b252bbd@syzkaller.appspotmail.com
Subject: Re: [PATCH] input: appletouch: initialize work before device
 registration
Message-ID: <Yc6PUmjd4BDctN9h@google.com>
References: <20211230141151.17300-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230141151.17300-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 05:11:51PM +0300, Pavel Skripkin wrote:
> Syzbot has reported warning in __flush_work(). This warning is caused by
> work->func == NULL, which means missing work initialization.
> 
> This may happen, since input_dev->close() calls cancel_work_sync(&dev->work),
> but dev->work initalization happens _after_ input_register_device()
> call.
> 
> So this patch moves dev->work initialization before registering input
> device
> 
> Fixes: 5a6eb676d3bc ("Input: appletouch - improve powersaving for Geyser3 devices")
> Reported-and-tested-by: syzbot+b88c5eae27386b252bbd@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>

Applied, thank you.

-- 
Dmitry
