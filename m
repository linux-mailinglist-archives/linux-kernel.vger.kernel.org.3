Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3049A590A19
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbiHLCC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbiHLCCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:02:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081D98A6F3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 19:02:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so6775491pjf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 19:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=11zcTWO0oljGY1EzL9LHVt+gT25nt8spTrG7rrzy6b0=;
        b=wkcZLIIiSp/Y2A22EdHaCZJlIJ7NJKDrrPjZtaw/34/f5xX4BiVJhNwQFmgoB5oNio
         aeQX+6CTD41VP+7989DBB/Wz6waXiyeq4u2Tuh5iGvK1nkWCEVqyIQhJDJ2M85XMY1Ro
         ma12Qta4X46iOjOHTYPTJj6YOjSf6nyy1+K1WMGnREAgKYgMWXDJVzVHQMgShzIDKa7B
         61gmABFK243bapmbJdH6Jce35/IrSZ9qlVwE6QLdh0SMIygADFGEJKYPupkRfif/0ijV
         KuOE5noSqV08ZMps83KvT7bAaaaHRqiHUzuVmL3nOqneCSg+U70ki58K0BCN74ZffNmp
         pF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=11zcTWO0oljGY1EzL9LHVt+gT25nt8spTrG7rrzy6b0=;
        b=Xf8de02aEl8EzJHY96GEwJ4Q/+eWDRmm7a6G9G+aHHbkcI1tSCFDDm1jmSLqln1spr
         rkS3Yy16XREPq9bsHpnJPHePO+PBxh89kT5rUg4e4jekh62KropbxdgAPHdGKL2LY2j8
         dbRnGDWwu3LIvB4pVWdSLm97HTM7/XO3ZbnqAd5+au6ugXOiJATFh5f9qHErDNHjtkwk
         ad0Lf1pnvhjNl0+z0+qQA52I1Se4x7bDfJQb0lBRCjX8uCCgtxeHHrdV1ukBrUHxilIR
         l5kWP46+r2GVcJhV2jVSwgUSN/VzFK/enpljmUyD+HZuP8v4OLc7SLUnpRpt1sKccOiR
         AIHA==
X-Gm-Message-State: ACgBeo2anNUSKmYtgMKexyyvtFw3A2aD3RGb4BPh3r+3BM2jyUqelMfq
        4geyulvFxj7osQZbNtJPKrWoUA==
X-Google-Smtp-Source: AA6agR4hL24HIbBlXyE8epaFxFk9InD4TnxjMpEp7FnokbeuHcvYc+Er5wxw6pKd0EA+3XBDpbMOCg==
X-Received: by 2002:a17:90b:1e11:b0:1f4:ee94:6236 with SMTP id pg17-20020a17090b1e1100b001f4ee946236mr1872088pjb.63.1660269744431;
        Thu, 11 Aug 2022 19:02:24 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n7-20020a056a00212700b0052d96d86836sm377745pfj.50.2022.08.11.19.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 19:02:24 -0700 (PDT)
Message-ID: <f6abeede-2681-e41e-38df-456b026e35bb@kernel.dk>
Date:   Thu, 11 Aug 2022 20:02:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] io_uring: Optimizing return value
Content-Language: en-US
To:     Zhang chunchao <chunchao@nfschina.com>, asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com
References: <20220812020000.3720-1-chunchao@nfschina.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220812020000.3720-1-chunchao@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 8:00 PM, Zhang chunchao wrote:
> Delete return value ret Initialize assignment, change return value ret
> to EOPNOTSUPP when IO_IS_URING_FOPS failed.
> 
> Signed-off-by: Zhang chunchao <chunchao@nfschina.com>
> ---
>  io_uring/io_uring.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index b54218da075c..1b56f3d1a47b 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -3859,16 +3859,17 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
>  		void __user *, arg, unsigned int, nr_args)
>  {
>  	struct io_ring_ctx *ctx;
> -	long ret = -EBADF;
> +	long ret;
>  	struct fd f;
>  
>  	f = fdget(fd);
>  	if (!f.file)
>  		return -EBADF;
>  
> -	ret = -EOPNOTSUPP;
> -	if (!io_is_uring_fops(f.file))
> +	if (!io_is_uring_fops(f.file)) {
> +		ret = -EOPNOTSUPP;
>  		goto out_fput;
> +	}
>  
>  	ctx = f.file->private_data;

As mentioned in the other reply, just do the first part. We don't need
to move the other one, I think you'll find the generated code is the
same.

I'd title the commit as "io_uring: remove useless setting of 'ret'".

-- 
Jens Axboe

