Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0C456FF01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGKKfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiGKKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:34:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF07A4CB5;
        Mon, 11 Jul 2022 02:45:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ss3so1847685ejc.11;
        Mon, 11 Jul 2022 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=Bq2HHms6AYgHYGDCtfqbJZ7y5sZjzAQdQH1EkzM9C18=;
        b=BP4Ycps/+/wZY3T+hDjZzSfcDf8B6Vcj52YP4do07cxYU/MIvWJFXARFkNKu8yzrjE
         9ruDzC5O4zeVYjPc8RL6X/zjJm8N5lHdRKrGBTqT628ldG7Wx47IMorHTVDaaoaWKHsA
         r/9bD0J8hIrnY4Kyx374fRP4LOrwTO/PuKTyEiUTpQ+sigRgDThXOxQVaK8CDgZeGZLd
         EzLOitxJzYTBLtNLg/BtRMUJDlszhJSNdVRtHcLukKkR64ZG7nrG2DJPuDa2MHwDtn41
         e7z2YM4BMdt1j1UxzzWuumbjckhOHsjTa8bkJrV2kPDs3pLvRclJTvj83jKawmytGGoV
         axsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Bq2HHms6AYgHYGDCtfqbJZ7y5sZjzAQdQH1EkzM9C18=;
        b=Zc8aA3TCW9gOs5TTsOfr9GmvzJHBVJXM7spPuUsSDJUXWpDmlsRZzHMcZAhtYmBQTo
         XHCQMsyg0MpFFcYJ2uWkins7h7w/iYrxwLf9YEx2N3hwl4N9odnvVIVfBgl/iYn4KEDL
         KyVrBwvetSxpJbvWjKmDQqLy9jW9FRTuf4YeMqLbaqyKVsvKqAba737Z59Azn4hfSxAP
         4aizZKhk5WLj7OQN0R1A92z3cfuDZdUIOmJeJyl/Vazq0uRkXp8Cz2pT+EuQYqDpAMB0
         48Z+x+NIL0WFtVgDE9Srj/XW1l67h/YFep8UL6QyZpxwL06WsZlSFs/6DLo6vFaYhY1e
         e+MA==
X-Gm-Message-State: AJIora8KwnFPVZcSCq8xSBKwU6Dm1LVsR+j0rofcK681v8wcmv/kOmtL
        /5fq63/tVFBPIYlSb6jMgVw=
X-Google-Smtp-Source: AGRyM1vYBH95BozWGJApIreWVYlsZ+VPPmSFqDn5RZ59CFWM0nvVAya69sLzRyBqmFepa7yhqyaYzg==
X-Received: by 2002:a17:907:2895:b0:72a:ed50:f0e8 with SMTP id em21-20020a170907289500b0072aed50f0e8mr17707404ejc.392.1657532731925;
        Mon, 11 Jul 2022 02:45:31 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id s20-20020a05640217d400b0043a64eee322sm4049161edy.28.2022.07.11.02.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 02:45:31 -0700 (PDT)
Message-ID: <a6cafdd0-b995-e1b5-c8ad-21cb6d935b83@gmail.com>
Date:   Mon, 11 Jul 2022 11:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH 2/2] mtd: core: find OF node for every MTD partition
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     ansuelsmth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220707163607.20729-1-zajec5@gmail.com>
 <20220707163607.20729-2-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220707163607.20729-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.07.2022 18:36, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Don't limit this feature to the "nvmem-cells". There are more cases to
> this.
> 1. Dynamic partitions may need to be handled with parsers
>     This applies to "fixed-partitions" parser and all custom ones.
> 2. Dynamic partitions can be handled with specific drivers
>     Consider "u-boot,env" as specified in the u-boot,env.yaml.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

This code needs more work, please drop this patchset for now.

