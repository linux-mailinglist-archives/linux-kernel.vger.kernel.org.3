Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D82E492E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348650AbiARTjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbiARTje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:39:34 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99C0C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:39:33 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d24so218735qkk.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tLdog0n5L37y3MRWMAFNB4F/ux6HarIU0b+GSL5AL8I=;
        b=JxuUbd1edEtbcMjCPSHSeTD/CMYEQdKqj/JLXxnkn+Bkc6GbozsOmUxwYRcTFsY47V
         WslujJVSY9vZtdXObppzaJQ0XtxjM0/O6BcKQE/zLqUnX0H8LSFwCeWeCMv6fVoWagiZ
         UtOtlLdGXjCLwzJlFu1FXI8C5OfuzJPVSSbieu+2VLq4ZVapGXxYrJTLJFqeMIFy9d2Z
         k0/ON6VVV5+yE9VVVEWmaWQlbwRu5BN60dy3Gg3kukxXeKDIhZdFxFaEc4FoJa1LtbHS
         Uv158qvrSco6aI/Rx+lCeqczh5qvcETHy05zvS+uAImu/AEx1laINzofgC3XGJBKWFzn
         RXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tLdog0n5L37y3MRWMAFNB4F/ux6HarIU0b+GSL5AL8I=;
        b=6v7CeIsUm+vCYfTAf+mG/p2bdJYT7UiSDmWzQcufb+IJN3x4IH2iSxVAVITy+YtL5f
         P56e/BGpQjPsH+brAwxK+wjjWSTJ+7186VktrvVlCAFTtQvongduJ7O+Uh2E2Q9c22IA
         qii+LO04DQht9kv4SQiChia5ri9A/g9VBaXS11tY3pVS9Se91UnjSUF29XKGhIQ5/rVX
         CGF0dtvK665WkdeHSku0o0NkfETu5mtEtjwJuADdaXlm0u4y5AJKagCHmJHUv9wthDP6
         xCwtIIQ0ZsqXMNF7uR7F1clUSsT96AWN/sbQezDf/WZ7raDCh9tYiYm4Vr84kXyzNSGJ
         Mm+g==
X-Gm-Message-State: AOAM530vu5yscyaFU6h5P6f9Pm3rzBG6pneVNty/9URxWQHqZvu6XKf1
        WsjTcdfxNehjel4WabVunbtX3w==
X-Google-Smtp-Source: ABdhPJyv+GW0Uxig4OgnmrE0B7ffqMZTGZmT4aK6Hb5mU/4+tpZB5vTRrUzdANLkG2L924vH1W5P2A==
X-Received: by 2002:a37:de09:: with SMTP id h9mr18417793qkj.764.1642534772953;
        Tue, 18 Jan 2022 11:39:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a19sm431977qtx.7.2022.01.18.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:39:32 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n9uKJ-0012sn-OS; Tue, 18 Jan 2022 15:39:31 -0400
Date:   Tue, 18 Jan 2022 15:39:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tpm: vtpm_proxy: Double-check to avoid buffer overflow
Message-ID: <20220118193931.GH8034@ziepe.ca>
References: <20220118183650.3386989-1-keescook@chromium.org>
 <CAG48ez00FFW-n_Pi=+ya1xY5QuB3q2mPr8++scVe3h3ROeF_mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez00FFW-n_Pi=+ya1xY5QuB3q2mPr8++scVe3h3ROeF_mg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 08:32:43PM +0100, Jann Horn wrote:
> On Tue, Jan 18, 2022 at 7:37 PM Kees Cook <keescook@chromium.org> wrote:
> > When building with -Warray-bounds, this warning was emitted:
> >
> > In function 'memset',
> >     inlined from 'vtpm_proxy_fops_read' at drivers/char/tpm/tpm_vtpm_proxy.c:102:2:
> > ./include/linux/fortify-string.h:43:33: warning: '__builtin_memset' pointer overflow between offset 164 and size [2147483648, 4294967295]
> > [-Warray-bounds]
> >    43 | #define __underlying_memset     __builtin_memset
> >       |                                 ^
> 
> Can you explain what that compiler warning actually means, and which
> compiler it is from? Is this from a 32-bit or a 64-bit architecture?
> 
> It sounds like the compiler (GCC?) is hallucinating a codepath on
> which "len" is guaranteed to be >=2147483648, right? Why is it doing
> that? Is this some kinda side effect from the fortify code?

I agree, this looks bogus, or at least the commit message neeeds alot
more explaining.

static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)

        if (count > sizeof(proxy_dev->buffer))
            [...]
        proxy_dev->req_len = count;

Not clear how req_len can be larger than sizeof(buffer)?

Jason
