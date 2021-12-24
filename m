Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9747347F048
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 18:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353279AbhLXRFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 12:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhLXRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 12:05:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D92C061401;
        Fri, 24 Dec 2021 09:05:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so8887694pjp.0;
        Fri, 24 Dec 2021 09:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DBgnyq+9DNsn0qFM2xOT3B8WYOlzGlfix0qN2fnTTm8=;
        b=AVPAxm/YxXTtYyjhDBMo0/D9fNf43ainvRdet07XjrZuLQUiyc8kymV/DcaMPAYan4
         aAmt6fbxuPWqv2zWxHz9ppydjnjiYpMP2Eh1kmC0FjeAYeMC++ZVh7yxDRkqoiF2hIS/
         sq3BGGrijS6fk53uNj4S9UwvnQwfeakyJM7aiFRg/9q+hKeVxFvkIhxIwsN2JEnIR096
         af0vsXcdm9RxTTvmECO9U9FkpdGTgJI7IPBf6GrBqBxvwhSgiBOPEPkEgiJabliwgQWv
         +HTslNkQudbzzrLBEBvReKteyQAXcrzCrkX6h6kdnPXfysnc0k1wfQso9fq5iD9ZImtf
         AAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DBgnyq+9DNsn0qFM2xOT3B8WYOlzGlfix0qN2fnTTm8=;
        b=VEnUpYzNVx+UQGDRTevrjGz0cU+J6H57q99M83BAur4IppBa+Vtf/eUrsVfBogmRwi
         wcVmMFxjrflX1CtVXMzgv6wJew3RsqA1gN7jt2LdP24jgJlbRmhh1LiehJ/BcGY338uw
         KylWzoc5ltvCCL277FACfnlZbCsdNuusjK69pAco4Z2Q9nw+zJGxsiH6YDNOTwtUUhET
         KfgIJV4+NI5IP9earVnhdJGqGZDTJ+8rsqw1CFNd+JQhgugrElFBnABj2uYWfStD5/S8
         qFDCcXbWC3SzQtirSt7giT/yo980NdntNKYhh2/ax62mr7h07JMkm60JpARqlbnxnHeA
         CtuA==
X-Gm-Message-State: AOAM530iI/dOgJOPnb2Mggd31UXZ5fz/Wht3AjiWGVPolOQ3Pk4jhkGU
        Ex2YvSlo+uYdws5lxE0OO2o=
X-Google-Smtp-Source: ABdhPJxHCJmxFCjR6EXakVQvD0kX8ww0wiLYVPi1L4Yh5zo6EDrNDLoRxlTKm6ZYsluWTCWJ0sQQuA==
X-Received: by 2002:a17:902:f68a:b0:148:c288:beb6 with SMTP id l10-20020a170902f68a00b00148c288beb6mr7363293plg.8.1640365530271;
        Fri, 24 Dec 2021 09:05:30 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:81cd:f5a9:7f89:a39c? ([2600:8802:b00:4a48:81cd:f5a9:7f89:a39c])
        by smtp.gmail.com with ESMTPSA id kb1sm10263433pjb.45.2021.12.24.09.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 09:05:29 -0800 (PST)
Message-ID: <c878d04d-c2a2-1edb-01fe-e163412d2d96@gmail.com>
Date:   Fri, 24 Dec 2021 09:05:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 09/10] serial: bcm63xx: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20211224142917.6966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224142917.6966-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211224142917.6966-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/24/2021 06:29, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
