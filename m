Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55174929A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345687AbiARP2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:28:06 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56490
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235669AbiARP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:28:05 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0C1CD3F1C6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642519684;
        bh=1OLNttQ1asKxdD9jkTevvJIOQX0Ntd1aencr/Pbi/Sk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Ns7iRb7++kzOGoqt7alD41eFuhkhDfYMun6wh7dTxs9F98bMJYAzONYAkVJMnZiYX
         K297ESSC7dSiMnYVFoWfbzN4ybPltXhyZa6eCb/++3a50B1jwCo9WVg+Waae2GF8hp
         rg6DKU5lhkY/wkCdl80ZsX+BeACPMNksWOVTZOt4c1RCf0kNNDg013xcWuBxkl0qK1
         3dyR+P9XbSoeJD4/EhfDwVeyQjWUYZ9EQpWxNuKMy+DtanMILmiCWuzj71y1AR8LcV
         iKgCvBUTTQrUtnB+SgSlWM5umU/3d1huRmTYtabWATTASfcwa/5WSszd1FCzT/jez5
         t/jPy1u73rtDA==
Received: by mail-ed1-f69.google.com with SMTP id s9-20020aa7d789000000b004021d03e2dfso7092308edq.18
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 07:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1OLNttQ1asKxdD9jkTevvJIOQX0Ntd1aencr/Pbi/Sk=;
        b=EnnFvs54Is90c/iCv28+9Kb84ftXDdAhc14apzQGP5iaRwkavIjRO6ltMvA4zD9o5z
         dizC4RGvZT4RvJRlafO7pBRilWNEurEw1p/IIFQOCowvMwVf3Jnq/7U3NojMhrRExJu9
         gNu8KVFD6HVe3N2L0hu5vfRRqHKBXmZ9OvR0bRuRh9+ohn2yQ+4W3dpbsGle9plhwDaj
         JAaVBa73fzQpBHV+OJU+5EwvzHypeWUQfL19EF4cCrmgfXhHoCMWuv3J2DULWcxNddpW
         1e/jPdV3O0cTNZm87laHNMpwg/JYrLMrHX86h6fkxC5RqUsK3RNwTiciGTtZIBV16Pdc
         t09A==
X-Gm-Message-State: AOAM532LbzFZLTbVqO77TkDm+oHmYcJlb0ywmXQ7wLuUL62rurhMrI6b
        xRWK/57LfYXnfdIXH//EMXqzqgEDMasirm/O2XkdrmNVUoYQeP09qA/lViQWoUFCaIU9iJ43aap
        byPH68pTwtmuzYU1dwLlIA1q3nCWF0hIJMYD8IUpJrA==
X-Received: by 2002:a05:6402:274e:: with SMTP id z14mr25982745edd.242.1642519683798;
        Tue, 18 Jan 2022 07:28:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygIRF9yVUauzAmFNSOP7FJ5sfUvWWzgizmrSffrYvLCHSnxw9NEINuO+ImEIkCQiDNBvlFMg==
X-Received: by 2002:a05:6402:274e:: with SMTP id z14mr25982726edd.242.1642519683665;
        Tue, 18 Jan 2022 07:28:03 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id cd6sm5424697ejb.91.2022.01.18.07.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 07:28:03 -0800 (PST)
Message-ID: <4feae128-0e15-1c80-0974-f0d535734463@canonical.com>
Date:   Tue, 18 Jan 2022 16:28:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] mtd: rawnand: omap2: Prevent invalid configuration and
 build error
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com
Cc:     vigneshr@ti.com, nm@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220118123525.8020-1-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118123525.8020-1-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 13:35, Roger Quadros wrote:
> We need to select MEMORY as well otherwise OMAP_GPMC will not be built.
> For simplicity let's select MEMORY and OMAP_GPMC unconditionally as
> this driver depends on OMAP_GPMC driver and uses symbols from there.
> 
> Fixes: dbcb124acebd ("mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/mtd/nand/raw/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
