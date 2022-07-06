Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DADF569163
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiGFSKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiGFSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:09:55 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE3928E1D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:09:55 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c137so11651806qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h6S/EAPbHUNIbmXXj14hsIbltK0duF8Y5acVLSRIfKw=;
        b=N/tz9N/SSFLMmYTQkaNJ4CB/sp6wy/327SJpmlqKizg2sWBvXoEy9Vh2lS3aS6xaCa
         LlruG9ZOcCe9uvWdBlil1sAXdWp63Sz9I6ezEZf9LPSTlVzjfga4mD+uAlT7mqwl+YCa
         cyaIExJTh3p49QKh9Mv3MLaNm7p43+EUUvTKPzH+j4lEKbLtq+VGU32/3GS8+HGEo2I4
         jM3LmTW8JRbiSHyhrQ8tAwvFF+Y//z57gUNtLIDYxYXWK362M0fZ2SImpQTkOu6U5yM2
         t/G52UUaYu2ERcukpw/GbD46CoMzdS4QM4cUwA08LxtAugO31qDRH7K5VxI41zMvDwfx
         7ABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h6S/EAPbHUNIbmXXj14hsIbltK0duF8Y5acVLSRIfKw=;
        b=Kbceamnn/ZkjGZ5ZVZmaoA5RPcRUSLoKAIlaEZCv9kC3GNqFxTCTJoAJ/QNbLAW231
         O7pI7vP6UILFuGHsgrBpaCGaKCBfb/JV70r9mNMMcv+dPXT7BrN0a6Iu6Q7c5PiFTH85
         61kCbOudgmuxEbDg7x/wkfEGj1YAyn8YAR0bBVtVGhz4si3DspQTki23nFIuHk/1YCGN
         Cj5ffzSBlo2zsOAO9/FqBdxpy3y2C8yY0piFxiE5esrUdzZsqWUQGhsBvfSz6fudiyh/
         1c72FAGYxLRYh3+jRal+xSwgFx7YXa7uWgQMeEB/KZA9fns1BtMsPClhJx2OERHgSO7X
         7BWQ==
X-Gm-Message-State: AJIora+BxxGYZSb6kp8sB/7jRmn7EVb+dD3yfFjjkjKjg7ruN2sv3kQH
        laosCZi3/iVPA6kZRp7N04Y=
X-Google-Smtp-Source: AGRyM1vFl7hDJFPMFghBlMz/Jd+3l5fu20aimU9k0iPTh3/REAhiyl63Jo0aOq8wzu5j+wRFOZZsag==
X-Received: by 2002:a05:620a:1996:b0:6b2:59b7:2636 with SMTP id bm22-20020a05620a199600b006b259b72636mr19808413qkb.782.1657130994269;
        Wed, 06 Jul 2022 11:09:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n4-20020a05620a294400b006b24d912ab7sm16022959qkp.46.2022.07.06.11.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 11:09:53 -0700 (PDT)
Message-ID: <29684681-2f0f-e887-20d9-dddda4977512@gmail.com>
Date:   Wed, 6 Jul 2022 11:09:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ARM: module: Teach unwinder about PLTs
Content-Language: en-US
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20220706163135.53874-1-alexander.sverdlin@nokia.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220706163135.53874-1-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/22 09:31, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> "unwind: Index not found eef26358" warnings keep popping up on
> CONFIG_ARM_MODULE_PLTS-enabled systems if the PC points to a PLT veneer.
> Teach the unwinder how to deal with them, taking into account they don't
> change state of the stack or register file except loading PC.
> 
> Tested-by: Kursad Oney <kursad.oney@broadcom.com>
> Link: https://lore.kernel.org/linux-arm-kernel/20200402153845.30985-1-kursad.oney@broadcom.com/
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

I would be inclined to slap a Fixes tag to this patch so we get it back 
ported where appropriate, however it is not clear to me which specific
commit(s) we should be listing here.

Thanks Alexander!
-- 
Florian
