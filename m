Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39C046C177
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbhLGRSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhLGRSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:18:24 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E5C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:14:53 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id jo22so13687092qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wVc8LSPwSI3Fgta6L7kEkmdc/aDqjUxriE82WBGtIW0=;
        b=Rfja9PD8xnDksY1HYbcjkWT4ttEpzcj1mkWQRYEdiFZjxlZutjCEU3l+TzKeZAWZA/
         R3Hgi5Or/0X0d8myLQpzwZQAnhxm/OcfYbG+5B/66ZNNo8nbFHqD9DYlNSXtBgkDujdj
         GS0HSG3F4O5HKNUn9sTmGvZtZoUDvBg3FelKkCyTF22wHUt+fuZxsll/djq0gwdp9UES
         rKe7Ww/zz2n88os5/TA3xAj0fxq+mkd+U3+5eLTUO9k3l8BCEoBS1Bzv7RwiFY3K03FM
         XvX2OC7NgTOQWukgIns3VlWwdovpkxoyJF0F7548j2+41xs1nJaH080SGXg30oO09e0f
         Lkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVc8LSPwSI3Fgta6L7kEkmdc/aDqjUxriE82WBGtIW0=;
        b=1rkChBJKh2hotnUQ6i3INI9xZNkcTL6BvSxzZGiQ0WBNZwnOSJUH2CJbAuXI5nM9SZ
         M2LM1TuVZAoKMf8rnDsQTvyxkK83p+mhpk/Nxy6WEl6nKYK62UtwNKK8bAVV678xO6a4
         xx2WCueRFtUQjf6XOsJW6TWB7sdbS6vw0lwYceNoAwGBmr3H7XAGD01Oaoa8mvxaufvf
         /2S9fEMAdVL2L8+fsUyNUXVpfxqSXnULAiNKXdkXjkCCC2o2Qv0on6Y5aZiB8MswepPM
         Xd1hhVFRyWnHMdV1QWkw4nYAgcMMbfwz4E23Gx7Oq0e/RrNSeFJhUjVOlujz59LYiXle
         zYpA==
X-Gm-Message-State: AOAM530MuUQ5WPPEZAjIs6CpDdBfGVTnytWm192bndozMgUqL/fB+/LT
        nx4y6XtHIELtDhBG3xmWYBbOjg==
X-Google-Smtp-Source: ABdhPJw0PP90ueBnYWFUDjF76i2hMme/rVXQvmtZfOsQkyWewKl1qaIvxAAjfaYW0kFwWOh6hBhAtQ==
X-Received: by 2002:a05:6214:e65:: with SMTP id jz5mr300169qvb.103.1638897293016;
        Tue, 07 Dec 2021 09:14:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id n13sm138629qkp.19.2021.12.07.09.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:14:50 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mue3D-0005cs-LC; Tue, 07 Dec 2021 13:14:47 -0400
Date:   Tue, 7 Dec 2021 13:14:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Subject: Re: [RFC PATCH v4 0/2] RDMA/rxe: Add dma-buf support
Message-ID: <20211207171447.GA6467@ziepe.ca>
References: <20211122110817.33319-1-mie@igel.co.jp>
 <CANXvt5oB8_2sDGccSiTMqeLYGi3Vuo-6NnHJ9PGgZZMv=fnUVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXvt5oB8_2sDGccSiTMqeLYGi3Vuo-6NnHJ9PGgZZMv=fnUVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 12:51:44PM +0900, Shunsuke Mie wrote:
> Hi maintainers,
> 
> Could you please review this patch series?

Why is it RFC?

I'm confused why this is useful? 

This can't do copy from MMIO memory, so it shouldn't be compatible
with things like Gaudi - does something prevent this?

Jason
