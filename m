Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3943447F6A1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhLZLb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:31:59 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35768
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233273AbhLZLb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:31:58 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8AC7A3F044
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640518311;
        bh=QZ8gaL4aa27WUfVUCldWKnufxa2EsgFNh9BuKK2Jp1I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=fwwTQzuPxpuWX07x5S/p1yHEPCMODIrayMpI4kC9u1u06Qorc5RGrwRxPkKk58+4J
         UA/IrBNeUwd7KHKTqX1S8C1OS8vVneH2icjCqOHYUqLUTvX17z0llWn8QepELm8xB8
         TTQuHQFXJulAC1BSEDaUR9myiDjHxP9JditeyI82boVZ9GKL++qbOSJ/iDHwuXpkBB
         I+ktu3nKJiA02ynONVxkHvw40XSCTgSo8FcAI21zuZIRBWLMSnxYYKIoL2FePUxLD1
         3mHkVYhrNqCxiJwBfpPObzVL2kbRuMC+kWJdvT2Wdn52OafpDctGuPW8G3fDSkH5iR
         /M0xjkvwYoW+g==
Received: by mail-lj1-f197.google.com with SMTP id y4-20020a2e95c4000000b0022dbab5f69eso998972ljh.14
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QZ8gaL4aa27WUfVUCldWKnufxa2EsgFNh9BuKK2Jp1I=;
        b=avogmIhYPr75ke+rfq/NfvuY1MOxP1AOn3egJgNnrco74rTNHKdGHpQLjRpVXlGV/z
         YoIQmF1BMsS24s93QP5NKByQiQflBRcnK72ff8uQjAuNsuypgiY6v2I2xCxmITX/nuJa
         Dvoo8eTMrhAir9w/9afa8rI3YZ0n5LM+xp2FqRz24HGeoA/mNhezsOmDc4cKcDzDeCop
         UCGJdmOHUyl/22PC50HBwm44L18gU/MtNsJIqpGuZqDxvNU2Fq4iWRv9viH1THhSNG5F
         n80tWM/fk69goG0dyBHdokXElP9M8VuYgb+vw1xG+wAM4Cr0RaxDwNY/MSJiaHxvg1to
         3MAQ==
X-Gm-Message-State: AOAM531s+bziJq9sZQ5xEvwGFmCJJkwhAln6P5MmPrhxCbEapj2sGNkV
        yT8AwwNJHwqbG1V9ebR40ppaerg/Fi4p73UHvGeuOmFA0IVNP1xqBGB0joyK+RXAmCQ5IHsDlHJ
        UqugtzLSI/0awHzMAKkR/LtUyesTwWVePKhrv8XJSNQ==
X-Received: by 2002:a05:6512:3614:: with SMTP id f20mr11387111lfs.624.1640518310785;
        Sun, 26 Dec 2021 03:31:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6XdnWc2mzd4ot+1nK09YvoP13XVq+mohNXCS/Ujiw65+6pwSIMrKcTpM3t+v4IEWLpRt/vA==
X-Received: by 2002:a05:6512:3614:: with SMTP id f20mr11387098lfs.624.1640518310569;
        Sun, 26 Dec 2021 03:31:50 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f19sm1344110lfg.298.2021.12.26.03.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Dec 2021 03:31:50 -0800 (PST)
Message-ID: <2e7b0365-69c1-e680-8383-bebe3fb8e8f8@canonical.com>
Date:   Sun, 26 Dec 2021 12:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] Module Name: drivers/nfc/pn544/pn544.c fix a bug
Content-Language: en-US
To:     hrshy0629 <hongqiang601217@gmail.com>, davem@davemloft.net
Cc:     kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20211225132728.25111-1-hongqiang601217@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211225132728.25111-1-hongqiang601217@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/12/2021 14:27, hrshy0629 wrote:
>     I noticed that the same usage for API nfc_hci_send_cmd() in line 541 and line 552 of the file pn544.c.
>     And the variable r is checked on line 545 but not checked on line 552.
>     The r in line 552 should be checked.

Why 'r' should be tested and returned early in line 552? Just because
some other code has slightly similar pattern, does not mean you should
apply it everywhere blindly.

Patch title and description is not matching coding style. Please, go via
git history to find how it is being written.

Title must describe what bug exactly you fix. Use imperative mode in the
commit description. Describe what is the bug and h ow it should be fixed.

> 
> Signed-off-by: hrshy0629 <hongqiang601217@gmail.com>
> ---
>  drivers/nfc/pn544/pn544.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
> index 32a61a185142..531eda0d11a2 100644
> --- a/drivers/nfc/pn544/pn544.c
> +++ b/drivers/nfc/pn544/pn544.c
> @@ -552,6 +552,8 @@ static int pn544_hci_complete_target_discovered(struct nfc_hci_dev *hdev,
>  			r = nfc_hci_send_cmd(hdev, PN544_RF_READER_F_GATE,
>  					     PN544_RF_READER_CMD_ACTIVATE_NEXT,
>  					     uid_skb->data, uid_skb->len, NULL);
> +			if (r < 0)
> +				return r;

This looks like creating a leak, so NAK. Please provide explanation why
such error patch should be used.

>  			kfree_skb(uid_skb);


Best regards,
Krzysztof
