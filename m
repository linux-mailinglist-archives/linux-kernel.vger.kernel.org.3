Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B1346B6E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhLGJWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:22:16 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59446
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233729AbhLGJWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:22:15 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 873B53F205
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638868724;
        bh=mbVZsPIKFmlo4NdLQ32VSh3peIplR0eL3tdmg/4c8Qc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=U6gu73HkHd2dN3Qeu+fI9ZHS1qrwFpu4j1sYz6S/nkjZKRCcgp1oWuoWxJ6qGbdW8
         FziQ64OYfT3Q7qCjvchem2rjosCAFQt4B1URQOpbsdfSbwmr867bnpLIINMjw4lh+K
         Z1iq0dbxlFHJIu+OEcbmg+leZVk15YLa6KOcUdLfygdk5PqQdStHOcSevksDDlP9TQ
         OGaZH4MCrULpJNM9eHFbriEYirgtI7DBr1GaTdVCEU71/5mxTRMixqqXU9DSjhadcf
         QyZKe6AsanRL+69smh3UaIRKGZe8Q8ndhbgww7r6bpKdduquQ874VtWRTcEjl3Wa+A
         in31+sPzOE+Gg==
Received: by mail-lf1-f71.google.com with SMTP id d26-20020ac244da000000b00417e1d212a2so5080429lfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 01:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mbVZsPIKFmlo4NdLQ32VSh3peIplR0eL3tdmg/4c8Qc=;
        b=wmKkTSpRBz7E3XUgJymcqgvLxYTxHLmoXoiPq8T2zlWxMZn24rUD8/3RZvTFncUK8y
         qGiAXWAe/dBCRvCInGg+okUeT12rb9YnkRUZy/cWXnlL6JKtwc5m7O4kHp3Wepn1hvXI
         UrNMlvqk98ze8Anh87lUytrQH/JeM5OuB69mE1f/5UQNnBNGowYikG0IZCpzTqHKssN6
         u+zHn/OODu1wRTLvinERWQ2C6IrUROqmFK0qZTUD8VBmu0wM1n4GSGVkwLzpbRPNQ+KT
         GrLeLPTh1hSbQzAS6Nhb2cSVBdbX31m9413JPRprITjMb0heVmXTdA0+smkXz4JXsIKP
         vKHQ==
X-Gm-Message-State: AOAM531GolhaRb1F3kgdDeMyf/KpfjDSWIqbg1zERRp9Aefe+Oqa6/oF
        iTKLljrVO9TIt60XyXPa3f8b5KGIK8IzR+G8pq4MyIdLceqIcdDjHJ1EiyQXJP4JSYnJzRqd+h6
        sk6P7dcoNgMiYve/IdDvw6VJ+gaI0G021cXZNKB/Ufw==
X-Received: by 2002:ac2:46c8:: with SMTP id p8mr40346935lfo.174.1638868723822;
        Tue, 07 Dec 2021 01:18:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwE/X3GbUfZYbh0b1cJH+6HgAy41W8jeJ0LU1fZHzlDTEz3mdy4mHHqcZGQE/cHscY2fRtLzA==
X-Received: by 2002:ac2:46c8:: with SMTP id p8mr40346902lfo.174.1638868723556;
        Tue, 07 Dec 2021 01:18:43 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b12sm1621027lfb.146.2021.12.07.01.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 01:18:42 -0800 (PST)
Message-ID: <78ce61a9-b345-437a-df02-49951eb3f31e@canonical.com>
Date:   Tue, 7 Dec 2021 10:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 10/11] tty: serial: samsung_tty: Support runtime PM
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20211124073419.181799-1-marcan@marcan.st>
 <20211124074625.182815-11-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211124074625.182815-11-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2021 08:46, Hector Martin wrote:
> This allows idle UART devices to be suspended using the standard
> runtime-PM framework. The logic is modeled after stm32-usart.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 93 ++++++++++++++++++++------------
>  1 file changed, 59 insertions(+), 34 deletions(-)
> 

Looks good.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>



Best regards,
Krzysztof
