Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D114E8290
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 18:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiCZRGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 13:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiCZRFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 13:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DBAA1B84CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648314191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQR8RjJS9udIj9TsBa8hT8U7MRFrUtkfl1FbA2elR8Y=;
        b=Wk496mND/0m56sDVGQpYJhVoevi4zEr+8clkiqtihI8gSPfoMbaPCKTv7fZb4t+TwetmSz
        SVaO0YL0DFznDowrDnGXcZU2eA6RRCBiph2LIDqj6Kw1gbXu8wdKRDj3+7R8UxI60J+DKV
        i7cGsjjuQPWLFVOxOCOxJLEMev/sArs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-omxYygBvP1aaySWGLrOFRw-1; Sat, 26 Mar 2022 13:03:09 -0400
X-MC-Unique: omxYygBvP1aaySWGLrOFRw-1
Received: by mail-qt1-f200.google.com with SMTP id a24-20020ac81098000000b002e1e06a72aeso8349428qtj.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 10:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vQR8RjJS9udIj9TsBa8hT8U7MRFrUtkfl1FbA2elR8Y=;
        b=ICogXCVLysVGsvGoP0OfEAaRgecTMSLwCBAOseFzKpjvGv2GnI3vJS+P3s9FMAstSP
         OTwAU+uguLrI9WscZUUiHV7aKTA2Lbj19BuIvIHEdefmXztC4jB3m1102NFfKmMkvDTj
         eIFqENMDiAOAVCRWzOGFKwaNWetPPDcTGYH8G7HS6kukHpNzuDGN5vVvETpccTYYrpTe
         XvSnb2xedKn5yUpTPI0TUmbFiXHQW/z1pxSnjCUwMvHdv74Ef6BukIemP9vPDaA6l+Od
         uNXZkOWa0b/cLL64WeUG61dOitWIhkWFKEvP9JW1YyR3l3J3TITh6PBAR4+t+WtPGIE3
         tFTQ==
X-Gm-Message-State: AOAM531VyYlujb1L8Sd5Ooa1Pm6nijlrcsfYZFrM1oUmSixY0Z/jpGue
        LM7AzXA0Gx5A4xChEmoJX8uj/nGNReSnTj8AFDXdClORj9zWLU+rRX/7svK9RZzGYMHeFYAR+wv
        IVc08T32/HTuMHs4+PK855VMT
X-Received: by 2002:a05:6214:252d:b0:441:58fc:9b99 with SMTP id gg13-20020a056214252d00b0044158fc9b99mr14494055qvb.92.1648314189195;
        Sat, 26 Mar 2022 10:03:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCxUwi1tgfvEUWPfrDRTyVS5dQ7qqsESoGESaEZLEpLn5lNc7tx+wiw9YKnK5EHhSOSqi8yQ==
X-Received: by 2002:a05:6214:252d:b0:441:58fc:9b99 with SMTP id gg13-20020a056214252d00b0044158fc9b99mr14494032qvb.92.1648314188842;
        Sat, 26 Mar 2022 10:03:08 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87d48000000b002e1c6faae9csm7777946qtb.28.2022.03.26.10.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 10:03:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] fpga: fpga-mgr: fix for coding style issues
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
 <20220322082202.2007321-3-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8d6100a8-4c5f-20d9-6c94-f08379e989ec@redhat.com>
Date:   Sat, 26 Mar 2022 10:03:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220322082202.2007321-3-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/22 1:21 AM, Nava kishore Manne wrote:
> fixes the below checks reported by checkpatch.pl
> Lines should not end with a '('
> Alignment should match open parenthesis

There are more than a few similar alignments to clean up in drivers/fpga

Instead of just one, in a separate patchset, clean up all of them.

Tom

>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
> 		-None.
>
>   drivers/fpga/fpga-mgr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index d49a9ce34568..a699cc8e2fa6 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -151,8 +151,8 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>   	if (!mgr->mops->initial_header_size)
>   		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
>   	else
> -		ret = fpga_mgr_write_init(
> -		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
> +		ret = fpga_mgr_write_init(mgr, info, buf,
> +					  min(mgr->mops->initial_header_size, count));
>   
>   	if (ret) {
>   		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");

