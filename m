Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD84D35BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiCIRV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiCIRVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:21:22 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A6CECB3A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:20:22 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CB0DC3F60F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646846418;
        bh=WpQvggAM0yElbhRsM3tZFtF/ELRn9cc4tgbsCUzDav4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=LR+EAHrNz34LGMS/5TTzKK43Qm8svRCa94grLzqEGtT1PpwiFhX1K53NvEtie0pqM
         WKjBU9Pm3aGkFCp/vnJDR0lEfE1jMEUaYFDb6WTn98S+w2Fg9gIjk+SkVSTlSWblVz
         LqRzoBgLI7hsgQXNP6H/c6Y//tQ5PaUdOjcUkFA6Hr/zVFQBL2OYXBNNUG6CsoEPoq
         YdgvpWzP1fwMGywNioZkihJ4AZ8JaVfOT0nxA+YSKJqLdRpDuFcm/oKdm75g63bm2K
         J7zTqRK9taImBuIh+ecDU2g3ZUK2Vq+vRkq5SLSCqqRHYEXmPIzXDWMqXaA5qsUGhO
         29C7i5PFTpkXA==
Received: by mail-ed1-f72.google.com with SMTP id da28-20020a056402177c00b00415ce4b20baso1628676edb.17
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WpQvggAM0yElbhRsM3tZFtF/ELRn9cc4tgbsCUzDav4=;
        b=5N0doPJnBhTs+wvSIzNzpUPVpXHFZ9VdutdKVhTNbKHkyeD/SqSayd1AH/JEUt2zZ4
         wINcEzhUiW41F7yOY5it1HQqlHyacywo7ZNpbd+7srY/EhtTdFt/ikBLoq26Xl2+AQXk
         AcONjl/yRIVi2+ggnZpexKKNA5KjjEQHbrJ232UkiCZBKZf6W7cBLK9ozonot9oECe9r
         RpE+9j4fCZYBXY/il0WWpdLZPU8sD6Zt/VsDdO6M/bKVc9Kt+5SxOWpv69dr2hjil7FR
         EfAnj0RrAotwx+t7q3v7ho1NnXuH7XLRXwjgXOxd2Yc4mtrgMca1VSbp7Wl3meNDZ2tG
         UoTQ==
X-Gm-Message-State: AOAM531WT5THCSwK4e2mbcjo/AfOv1uu4zFnCdhGqtQafiir/dXbtNlF
        Y9nxsLJ3x45a5BQreQZi1bD42iYEogwAPzlh+7iI9UfoGsMLK7w96QKl0uEcUYfkI6yJZ2DJhKU
        1vKnQ2YzhYSBWdQhtaJZHkn9Iz/7q8k0Iabmd1BwHBg==
X-Received: by 2002:a17:906:3a4f:b0:6cf:86e0:586c with SMTP id a15-20020a1709063a4f00b006cf86e0586cmr741923ejf.626.1646846417773;
        Wed, 09 Mar 2022 09:20:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwp8qV5iSHK0r0pv+Ud4p0lkvk1vU2K4nXYAjwrQ7dcKZD7+H0nUl5OJBkP+xuDINxqEXHVsQ==
X-Received: by 2002:a17:906:3a4f:b0:6cf:86e0:586c with SMTP id a15-20020a1709063a4f00b006cf86e0586cmr741909ejf.626.1646846417574;
        Wed, 09 Mar 2022 09:20:17 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm952362ejm.103.2022.03.09.09.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 09:20:17 -0800 (PST)
Message-ID: <5136e20f-4a09-35f0-72d8-11e06d52a063@canonical.com>
Date:   Wed, 9 Mar 2022 18:20:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 26/26] usb: gadget: udc: s3c2410: remove usage of list
 iterator past the loop body
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220308171818.384491-1-jakobkoschel@gmail.com>
 <20220308171818.384491-27-jakobkoschel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220308171818.384491-27-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 18:18, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable [1].
> 
> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/usb/gadget/udc/s3c2410_udc.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
