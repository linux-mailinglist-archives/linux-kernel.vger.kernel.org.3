Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A7647B6B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 02:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhLUBNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 20:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLUBNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 20:13:23 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 17:13:22 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id a1so11460000qtx.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 17:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ImhGZNgWQ6RSPs0/MNgkgB9bxoki7Hld1WRDVZLnPFc=;
        b=VLRYoqQphPkZHC7/mVdrVwi4JRSSX4/EcZlF/HwnA+2dvfr3EppJPZ0e75yD6cqvEi
         eOOQayG7v6CLJSO53F9A8v4Beerdugi4zsWwEkWCVp+xAlxnAkkspTMCvrUz76/T6Zs+
         fpFvNNWUkhq3CV0yI7aAkxmYtxbTVL+jvEjbZrT+D/4sT/o85ScW0wzk69lPb7ReIPAn
         eDC7+AxN83mEdK/4zPzRTGcyBGPMEaWrGVvLD0wwyUil1aii0qxF1Hty6R7Jn5cwydtA
         SNtMHDoxHQN6uHtWj9SKDLtXPDB5YielKtH/KMqWLBH+2xVv5wFuCBXfq2FxvLRwf12Q
         FL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ImhGZNgWQ6RSPs0/MNgkgB9bxoki7Hld1WRDVZLnPFc=;
        b=j4u1gk9EZVSDVRpPlwZ2WXO1ec66XH5BJnPAxIVQAyTDhgJ2yMHuPHP/VoWQPCipCP
         Pq94ODIzsSv8MOTrfrdE6n+vPZL1CYxKE/He9oI0DD07yM92zUNU0ntaxyvztz3RWj0f
         HVBLmTHlrrQnfwm50b7sGTyynqg7DlEWWRfrYHV8ml0VE1gfBW85nJVOrA5647jeKf8H
         ETzB/7Mmef4hz0kcIeGbBUfRP/j/PtyaAORfpLtIKgdke7ppg+9eeIzMQfqdu5dkXAUM
         QkpACBavof1qPULMfoj5s1qQCdx1kiJCHFpcbq+2EbKTe9d59CQ+IB1wirm23K6WiIwj
         zWWw==
X-Gm-Message-State: AOAM5313yYZ2XEY4No3saI6tXEFGByqQh/79+w7qqh0YjVICjIm1kiyf
        DEVw2l/Pzsh45c8/A1DXfMrIIg==
X-Google-Smtp-Source: ABdhPJw+4sRAzJSi3LnPVoLw1Dt7Bkx+hmVXajl3aaZlbjv5jLRVbLeuQXoICu0pNeKnjSZ3FNLWJw==
X-Received: by 2002:ac8:45d2:: with SMTP id e18mr621640qto.112.1640049202009;
        Mon, 20 Dec 2021 17:13:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b9sm15854858qtb.53.2021.12.20.17.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 17:13:21 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mzTiS-006yyf-C9; Mon, 20 Dec 2021 21:13:20 -0400
Date:   Mon, 20 Dec 2021 21:13:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>, jarkko@kernel.org,
        peterhuewe@gmx.de, linux-integrity@vger.kernel.org,
        Korrapati.Likhitha@ibm.com, pavrampu@in.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, gcwilson@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tpm: Fix kexec crash due to access to ops NULL pointer
 (powerpc)
Message-ID: <20211221011320.GM6467@ziepe.ca>
References: <20211212012804.1555661-1-stefanb@linux.ibm.com>
 <1052cd36-1b85-5d36-045f-5c5bf9f0fc4e@linux.ibm.com>
 <d9eafa8f-4006-4bc2-c09b-6b02a14c6ef3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9eafa8f-4006-4bc2-c09b-6b02a14c6ef3@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 08:05:58PM -0500, Stefan Berger wrote:

> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..4cb908349b31 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -473,15 +473,8 @@ static void tpm_del_char_device(struct tpm_chip *chip)
>         mutex_unlock(&idr_lock);
> 
>         /* Make the driver uncallable. */
> -       down_write(&chip->ops_sem);
> -       if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -               if (!tpm_chip_start(chip)) {
> -                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> -                       tpm_chip_stop(chip);
> -               }
> -       }
> -       chip->ops = NULL;
> -       up_write(&chip->ops_sem);
> +       if (chip->ops)

ops cannot be read without locking

Jason
