Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5048C1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352232AbiALKHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:07:31 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55836
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349646AbiALKHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:07:30 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D2233FFDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641982049;
        bh=AFoEvp5eWcTOKPSE4vqU4Dm4wZS4JP2i5S4paCY8zig=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=DhPTLHtslM1nJL0+yJHCfEFe167fbm6XtOOvmUCTXWng6ZtSIx96BC3FHJ3hlpKwb
         JfwQd/MW4UBe6OyZYCKR1jbDp4BpIq+u50s436RHDP5prJGprVjw7+TtG5xJP2pI5K
         irA3G+aIdx0ltLgQAWHfp+Dwmc3Ddp508Zv4RW6HL6nH+3Otq6Zi7w+PgZz8WqqfFj
         4nYJHy3S2ccEdmjc9EzLt8CvV20S43L/7DvA+1gDKOdyr2DTl1++ZCqr/yMC5wHnna
         2E68zIvXQSCe9GdBZ1NUKTf+g5utqQPEd5xlbT97e9tFlnqofF/5QgPWDvLfXKZ3X+
         ezD40Hk2+TPWw==
Received: by mail-ed1-f71.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso1879533edw.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AFoEvp5eWcTOKPSE4vqU4Dm4wZS4JP2i5S4paCY8zig=;
        b=1V4S0ttwEAXOWpvzLVa8mhk5sKqS7fqK6gTDnNBLYWcKypQBFR8WesG7xa5jk3c5v7
         dtlmgx5qt98WrCKRj0kedM1ofA0Pa5YlX6FdFWwYVC5d58YGoDSwyx8iQjTUdauelEn1
         CCh1L+U2SDP09rY1yq+CVzoPzO41UlocrI5m+iVUexMi/ZcIGWEbuxDwN1mLswwK9XAU
         z91Xgq/Vwj7YTUxViMVzyrZA9jN/w5mo+bflWARIc/l7ZO16iSjf8ufja8glA4Fon/45
         WXqqV9K2KXrpbl4YYNcwYE1mFbXn9XjH/FLZ93wRnrqODqqguH5iNGbjgz5ovT+s6hx7
         hwsw==
X-Gm-Message-State: AOAM531ct5/PJb4gw8voNeo7lUMJQBzdz4G+EZms7N2ejL+/ljyZikFd
        Uw0/sFAGTa2RCXOwSu8dB1g2cuKb9PX3VHVd3gbw0BJJKasWA4AOFy6FddOCoy2XlaoIN0uqwLs
        olfAlnSld81zqo07Uy232kj1STXDt0lbmGtnG0MVgwg==
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr7252232ejg.332.1641982049156;
        Wed, 12 Jan 2022 02:07:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyb/NuTKevzN07lPwyurPSJI67fCctIz9rq4OSgNTLHT/x3rRMME7Elc/Be6y3vkmR9tseimQ==
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr7252215ejg.332.1641982048986;
        Wed, 12 Jan 2022 02:07:28 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id qf18sm2471944ejc.124.2022.01.12.02.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 02:07:28 -0800 (PST)
Message-ID: <38217570-9f19-2b04-6ed0-89f365e29d5f@canonical.com>
Date:   Wed, 12 Jan 2022 11:07:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3] nfc: st-nci: Fix potential buffer overflows in
 EVT_TRANSACTION
Content-Language: en-US
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, wengjianfeng@yulong.com
References: <20211117171554.2731340-1-jordy@pwning.systems>
 <20220111164543.3233040-1-jordy@pwning.systems>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111164543.3233040-1-jordy@pwning.systems>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 17:45, Jordy Zomer wrote:
> It appears that there are some buffer overflows in EVT_TRANSACTION.
> This happens because the length parameters that are passed to memcpy
> come directly from skb->data and are not guarded in any way.
> 
> Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> ---
>  drivers/nfc/st-nci/se.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Looks ok.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
