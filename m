Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D0148C1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352346AbiALKHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:07:38 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55844
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352311AbiALKHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:07:36 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9322C3F1EC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641982055;
        bh=KdlgmtxP+gkPgxGJtnhitWm+fuJDdU9aOghdG1MKfgY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=T2ZlTOMQeLBbpqEvIsAS0hxdOdh9CPb1vb3qegnehsyJbJ9eCcC8xi+/WMuSdSGOX
         x7sUAJRTwJLFhb8bI5mZgKtpgU9qUBTyI2gQtH/cBHDa9qBNRCjlYO+xEhG1RXQUHT
         S2CWyAp3dvHsyjYD+46VK9qqSLfS3DNiQBvGcH6WiELl+l1kf8IIP7lYuupM+W9Fh/
         IBVWHv76cSDJI7bBDrYruprNn43I97VkRzbT+QhLkxRDIeccabWaq3C9VS108xCM86
         JnjXnEJE5wZJH/F8WNWyMs3+yde+joJkpDeg0XlV93pJQIS3UQmvGIcQfQABJ9fW+D
         Er+erExbCTgiQ==
Received: by mail-ed1-f71.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so1853715edz.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KdlgmtxP+gkPgxGJtnhitWm+fuJDdU9aOghdG1MKfgY=;
        b=kCPrPp9lkLRZXSrphgsMy21k8pv8mBdFPlKpZPP3y7jtpqvDyhdN6eOXlfKVwRzZES
         wLPtxXQFgM7k5JEIVM6d7kZ5kT7NPMQcR7dw2qbyq7qMFc0Z1qunj5kuvoUBt+iVNyzS
         +iWrvr+zNBTSBvRYq2G3frxtqrvgwQ1aH8+vLyHeHNY4v7PeIWD0e6i2kpsiqmwmYhpA
         8amcMhxcKrafWhSHa26OnL5Y2Vn6sOK+1rv4XTRMgEpjLyJcDBMs8dzv/ZPzyIjTSEH4
         Tt6KXNB4EnHlR/B0sg2EXjicMsv4AFJxb6151ztcsB/0VnCi9ZDcRXteDP073BVkhEqR
         TFGA==
X-Gm-Message-State: AOAM5313xa+4C3t+wI9BKTWrBhIRyPOoYWzhkzt24VwmBmYt69RKq7o7
        4CtK82xEs/l6okvUFKkELVB6eiGlSLNZL4LyQtTJK4etF3a+noEn9gXlaytCHi8ew7XZfrXLvCv
        nN7sPmO/+I31ZAxmgrS+Xz/fQTBn+2sE8IR6Psbuaeg==
X-Received: by 2002:a17:907:7da5:: with SMTP id oz37mr7398775ejc.586.1641982055126;
        Wed, 12 Jan 2022 02:07:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdUaXBJsgnJXOpWStI3VRIBs4g9c6w5851GHMpkrWcLcfgjGOZHWdQmw3wExTZW8Thm6aQ+w==
X-Received: by 2002:a17:907:7da5:: with SMTP id oz37mr7398766ejc.586.1641982054933;
        Wed, 12 Jan 2022 02:07:34 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id go35sm4302409ejc.191.2022.01.12.02.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 02:07:34 -0800 (PST)
Message-ID: <b47eba60-9d02-2901-2759-b2230087193c@canonical.com>
Date:   Wed, 12 Jan 2022 11:07:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3] nfc: st21nfca: Fix potential buffer overflows in
 EVT_TRANSACTION
Content-Language: en-US
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20211117171706.2731410-1-jordy@pwning.systems>
 <20220111164451.3232987-1-jordy@pwning.systems>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111164451.3232987-1-jordy@pwning.systems>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 17:44, Jordy Zomer wrote:
> It appears that there are some buffer overflows in EVT_TRANSACTION.
> This happens because the length parameters that are passed to memcpy
> come directly from skb->data and are not guarded in any way.
> 
> Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> ---
>  drivers/nfc/st21nfca/se.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 


Looks ok.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
