Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAD484793
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiADSNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiADSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:12:59 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4875FC061761;
        Tue,  4 Jan 2022 10:12:59 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z3so27615580plg.8;
        Tue, 04 Jan 2022 10:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VoJ1XzenoMXIIHCTkV24ONDP6NmMrn6ozSDjV348Lb0=;
        b=ZFlSfuRPGlCQe+EmeKxKSNKGmTvhrHBeMnpHszesth2GlNd9wCtu5biKcS7H8JdUYc
         8j1UEm3LeV0+/5hRzQYCYE7cj/nTCCxtrdxahhwzbVSrIr9+XBFivDgWVhyNQKnwJ15e
         psTMarHi9K5tY85l2+apN8ugNGkdivyNE2wKZnfabC7p/vXOaplogYeD+/D5SNw8xpOS
         UqLCVTxOyLdpYcU3wwkY1AOH1xwjnELuS2loB8rR+bePQIeOnQGwa13CKgvgT69slEKS
         RRG6aWIA6dsmW6e3RFm8bXA8PEGerZtALjTTnhq/QtW37OKRtoB6Q9rNrt4iXnB7G7Im
         j/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VoJ1XzenoMXIIHCTkV24ONDP6NmMrn6ozSDjV348Lb0=;
        b=Qs9Rq13RkB3ISauIbUiKMiCgFHEBFlFF5KfIwbf6NADZQRP5gLTRju4sCFf8aN3Q7q
         p8M6oIqfeXZT2FNHVx5d478sdJGgLkZD1E4gxtZMFTly1H/GfnzTX5ZOgottojGfVHh7
         lK4HJ6BgajYmGKzQ9jykmEkSAa9PRBnsND+qx3QwWwPEKnOBHpZHN+58M1wT3uq8f8W3
         xR8hK69RkccEdPQlC7WAGQ/7TvlZllYv1um1JyIu81bBw9WlKuZMLdGEVKGyUkZBOWci
         EZBTdJHq+2HwLswDdhTycdthy3dkcZrt9s4FEUvxBN67wUaZabE+bauL1wCZ9Mwn1yUQ
         mwug==
X-Gm-Message-State: AOAM5338SpUPJXY+3ud7QyGkh7LcLTu7F+WVOUHN70KYXUBUpCgUhc9f
        obSfZnJ7oX8cks32PHSbulW2m2jHHV4=
X-Google-Smtp-Source: ABdhPJwyFgMV9YT2U9Rq99jv9Hsxeyzi6VKAS2lGsb5iQEkXlTkVLDUsqnm5AO2PRfCI+chKPNS1gA==
X-Received: by 2002:a17:902:860c:b0:149:1017:25f0 with SMTP id f12-20020a170902860c00b00149101725f0mr50041560plo.116.1641319978257;
        Tue, 04 Jan 2022 10:12:58 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m19sm34972140pfk.218.2022.01.04.10.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:12:57 -0800 (PST)
Subject: Re: [PATCH] serial: 8250_bcm7271: Fix return error code in case of
 dma_alloc_coherent() failure
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-serial@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20220104175009.7029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9f8ef75a-9743-b89e-3d6b-ca4907db2de0@gmail.com>
Date:   Tue, 4 Jan 2022 10:12:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104175009.7029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 9:50 AM, Lad Prabhakar wrote:
> In case of dma_alloc_coherent() failure return -ENOMEM instead of
> returning -EINVAL.
> 
> Fixes: c195438f1e84 ("serial: 8250_bcm7271: Propagate error codes from brcmuart_probe()")
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

The fixes tag may be a bit superfluous since this is just an error path,
but it is correct nonetheless.
-- 
Florian
