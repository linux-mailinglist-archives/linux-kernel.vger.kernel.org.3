Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06E4DC030
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiCQHd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiCQHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:33:54 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FFE1C16F5;
        Thu, 17 Mar 2022 00:32:38 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id d7so6075903wrb.7;
        Thu, 17 Mar 2022 00:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=14b+YRMPF+XicziyqyS1A1J9PGyx9cOE69X038CMxDg=;
        b=mAO/q6q86OKTMLAPYODQrkUsQgH73Wml7YOQ7rBbTyDlHP2CsSh+FGB32jqvhsJuM3
         NT9C4wIzhYJa5TqRCdduv6rsZp7pVjl0id0Q420nW1ZXJzcyNrHDua1LeHTLElY8k00U
         1PThTkU3uPgV2JPRH0V86FHOwEzEYdRfS06TMciDR9vjy3Yh3Rqo4052Az6+498ijuqA
         Qz4eXUgmXgVEIg0A1Gq1H91yCPIXs6OOVkRTuIeDLvELjQ0irGJr940FAObugopyLy6d
         bpjznyax6QXgdxX/8Xyewkr8gjXLLpMhFxzwJljq8hLtX2HyCQBT7xtb6NDRNDGFk73d
         HJtg==
X-Gm-Message-State: AOAM531O5sH2z141rZsh5+F6xfSEPOGd+rRef/c0cqkLr62iKliMhfCg
        8FzMf3CkuDFQhkkFgxP8VlY=
X-Google-Smtp-Source: ABdhPJwozSkjDXV+DHyksKvHyKhiL5fDQ63iPacCt1TMgZ6CfrYaft+8e49jYXsMOYkMY2oilEVhmA==
X-Received: by 2002:a5d:498b:0:b0:203:e5d5:622c with SMTP id r11-20020a5d498b000000b00203e5d5622cmr2724473wrq.153.1647502356995;
        Thu, 17 Mar 2022 00:32:36 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id k17-20020a05600c1c9100b00386bb6e9c50sm10984171wms.45.2022.03.17.00.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 00:32:36 -0700 (PDT)
Message-ID: <cdba580f-097e-da4d-bfb4-63a7cb64ec95@kernel.org>
Date:   Thu, 17 Mar 2022 08:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ARM: JIVE: fix return value of __setup handler
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Dooks <ben-linux@fluff.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@armlinux.org.uk
References: <20220312063609.19362-1-rdunlap@infradead.org>
In-Reply-To: <20220312063609.19362-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 07:36, Randy Dunlap wrote:
> __setup() handlers should return 1 to obsolete_checksetup() in
> init/main.c to indicate that the boot option has been handled.
> A return of 0 causes the boot option/value to be listed as an Unknown
> kernel parameter and added to init's (limited) argument or environment
> strings. Also, error return codes don't mean anything to
> obsolete_checksetup() -- only non-zero (usually 1) or zero.
> So return 1 from jive_mtdset().
> 
> Fixes: 9db829f485c5 ("[ARM] JIVE: Initial machine support for Logitech Jive")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: patches@armlinux.org.uk
> ---
> KernelVersion: v5.17-rc7
> 
>  arch/arm/mach-s3c/mach-jive.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

It's too late for upcoming cycle, so I will pick it up after merge window.


Best regards,
Krzysztof
