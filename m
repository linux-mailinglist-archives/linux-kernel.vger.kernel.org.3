Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C03C487F6A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiAGXeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiAGXeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:34:19 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B4EC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:34:19 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s1so6970930pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zsOgJMsBCd5wqpBIMXgbd67V4MeoViUGyDjddUD4kPU=;
        b=WeLsW8ODuu55sZfvXliZfwSV7Gi1JTHpwyKmxA9qyyxSeuO1pG9tYcekSizjBNwLnu
         fp0AuBEmd8WeUr/hkPdOOLR+YjN9M6Lavc6Boqk57K/8WNnBgBifiYiG69vvhTvBHqzq
         RSZEN5w+1UZM7ykn5RuUb1mplLWUin4ZAvsCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zsOgJMsBCd5wqpBIMXgbd67V4MeoViUGyDjddUD4kPU=;
        b=KZ9e0fjORcA2mBDigcqMsUiMZpQ6X6PmDaVtYjtiGnT2hQpzrlsZldvEikHLWLoHli
         6fea6HqluB9m+5yFs/UPwpsKriZUUGqdIRAdL56p1YK55F56aAnkd6DuVV1saIYgIBQl
         8GQHWXn0P5JH2EAUab97GDj7uJh53jQqqVWNXPzLmf1IVcZnDifS2L5vqySnO/xvAdXg
         58YJbJQXhS6NphgJi7iSysuq8JDjE38W3RR6hJM9sjROMV1G9pyA/ClrNf0KKCqH9tf7
         cHj+9rqZ2X3xQVhgAgcxmfmIHAmzxg8ZfG/KuLK9Cpl31OGzgzHiMJCpRGEE4qjzsTUL
         QLbA==
X-Gm-Message-State: AOAM530cwh219Y/61qpfhfBjEnbXKUOxSKi3WldRDzBMdDfJsa4PWq1j
        igwWezzeCiB5jRh8KV5U7qBnSw==
X-Google-Smtp-Source: ABdhPJwUhZW9byS0cPGPMcT+LQ8VGZ/UJQsfgaNdtP9C91cQngX923SsGRxxbPGbb1MRbtm6h/ANsQ==
X-Received: by 2002:a63:cd49:: with SMTP id a9mr58435443pgj.607.1641598459186;
        Fri, 07 Jan 2022 15:34:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e11sm6873pjj.49.2022.01.07.15.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:34:18 -0800 (PST)
Date:   Fri, 7 Jan 2022 15:34:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     conleylee@foxmail.com
Cc:     davem@davemloft.net, kuba@kernel.org, mripard@kernel.org,
        wens@csie.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] sun4i-emac.c: add dma support
Message-ID: <202201071532.57A08030@keescook>
References: <20211228164817.1297c1c9@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <tencent_DE05ADA53D5B084D4605BE6CB11E49EF7408@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DE05ADA53D5B084D4605BE6CB11E49EF7408@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 09:43:51AM +0800, conleylee@foxmail.com wrote:
> From: Conley Lee <conleylee@foxmail.com>
>
> Thanks for your review. Here is the new version for this patch.
>
> This patch adds support for the emac rx dma present on sun4i. The emac
> is able to move packets from rx fifo to RAM by using dma.
>
> Change since v4.
>   - rename sbk field to skb
>   - rename alloc_emac_dma_req to emac_alloc_dma_req
>   - using kzalloc(..., GPF_ATOMIC) in interrupt context to avoid
>     sleeping
>   - retry by using emac_inblk_32bit when emac_dma_inblk_32bit fails
>   - fix some code style issues
>
> Change since v5.
>   - fix some code style issue
>
> Signed-off-by: Conley Lee <conleylee@foxmail.com>
> ---
>  drivers/net/ethernet/allwinner/sun4i-emac.c | 200 ++++++++++++++++++++
>  1 file changed, 200 insertions(+)

This is causing build failures:

$ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 allmodconfig
$ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 -j... -k -s
drivers/net/ethernet/allwinner/sun4i-emac.c: In function 'emac_configure_dma':
drivers/net/ethernet/allwinner/sun4i-emac.c:922:60: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
  922 |         netdev_info(ndev, "get io resource from device: 0x%x, size = %u\n",
      |                                                           ~^
      |                                                            |                                      |                                                            unsigned int
      |                                                           %llx
  923 |                     regs->start, resource_size(regs));
      |                     ~~~~~~~~~~~
      |                         |
      |                         resource_size_t {aka long long unsigned int}
drivers/net/ethernet/allwinner/sun4i-emac.c:922:71: error: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
  922 |         netdev_info(ndev, "get io resource from device: 0x%x, size = %u\n",
      |                                                                      ~^
      |                                                                       |
      |                                                                       unsigned int
      |                                                                      %llu
  923 |                     regs->start, resource_size(regs));
      |                                  ~~~~~~~~~~~~~~~~~~~
      |                                  |
      |                                  resource_size_t {aka long long unsigned int}


--
Kees Cook
