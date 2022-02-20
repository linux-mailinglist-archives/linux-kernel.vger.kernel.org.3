Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B3F4BCDAE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbiBTJbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 04:31:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiBTJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 04:31:00 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6D4C7A3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 01:30:39 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B565C4004C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 09:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645349437;
        bh=ZhlW2P314Xp7IVd+FJpw1KLggsQP1D5CsVCti6D2Xfc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=wZTOY5IaH5kq0+oFO0lKt9OSE3p72emJ+UiqiRFPamot4zo9xV+134BjzF5w8CJgi
         bsSmhJwxTMLChB8hvA6ndf1sBWtreM7KNuc5YTysseRePpsH3QcSbAYxMfH0U1GRyu
         oyhSUL4EWarmrc7iqmSIP+h6Z92lfJZoD5vPSYQvNapFf1FPLhAzhm+ge+TZ3BHzCv
         hNsoC0ssHZrC/65+hMMSYvnCNTgtGzwGkToYEE2PjptMg+8rMxYUPVgArhiSgwqtxx
         EHv0ZP/K4PViNrgmKT1FyZ4dS8bxoR8AKNhDliv67FutKcOozeWi6CqCGhPl1ut/fr
         UkmH2Oufp94OQ==
Received: by mail-wr1-f71.google.com with SMTP id q21-20020adfab15000000b001e57c9a342aso5680195wrc.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 01:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZhlW2P314Xp7IVd+FJpw1KLggsQP1D5CsVCti6D2Xfc=;
        b=IHU6B0Ebh4+Cq/5LpUcPOZNoHDBm8Jqb5J2VqlQezwgoazwcQfmvcQKdSXNF8AZrRu
         odhCf6715jXXMoeMAvxPo0tek4+605dT8KZDXcV+32HScjd3kIRLTr6QpegkW/13vRYs
         VnmsPtY9tcyNIXy8Qj8bQ6elM5yum52CkZu1llTgZvZf3ebCh8KyRBwKZEso67Vvu10o
         3lZ6yPI08jpgQGXYMGrqtsMZh+1ydobVieIXdX0Howg2NIYlEByDC+IbFYZH2/kOdSYZ
         lmPCEg8GtzrNazBs5JNkdfi91njRDEUhCi0L7okBI/A2cQC8841kRyQeX6tV4kLmrC+F
         rdrA==
X-Gm-Message-State: AOAM533/+vZq6zAwXW7xVbPrsTc9FQ3T2grct9wsi9pes09xK1KGE9Rw
        7WbKn+q6/RD997C6TxQUChH+w/jhttr+DokF3M/W/x97RFdfdcUMLhzg0RkUczlutaoNr9s7zSv
        qUwc3eBda0u6GRo6C4riNsXL7QbUaD8UtxzEQQ/W/Dg==
X-Received: by 2002:a5d:568a:0:b0:1e4:7cc8:fa6d with SMTP id f10-20020a5d568a000000b001e47cc8fa6dmr11679913wrv.48.1645349433180;
        Sun, 20 Feb 2022 01:30:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDPzoJ3r3Cf/g14eN02kggEVtqJQJJBBiuuP/xysWCL9EyAUqqQm+LFlX4Qx6fEQSqO5pRiw==
X-Received: by 2002:a5d:568a:0:b0:1e4:7cc8:fa6d with SMTP id f10-20020a5d568a000000b001e47cc8fa6dmr11679891wrv.48.1645349432988;
        Sun, 20 Feb 2022 01:30:32 -0800 (PST)
Received: from [192.168.0.117] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id x7sm39145432wro.21.2022.02.20.01.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 01:30:32 -0800 (PST)
Message-ID: <5d507fda-525e-4064-3add-0bb0cc23d016@canonical.com>
Date:   Sun, 20 Feb 2022 10:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/11] i2c: npcm: Bug fixes timeout, spurious
 interrupts
Content-Language: en-US
To:     Tyrone Ting <warp5tw@gmail.com>, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        semen.protsenko@linaro.org, yangyicong@hisilicon.com,
        wsa@kernel.org, jie.deng@intel.com, sven@svenpeter.dev,
        bence98@sch.bme.hu, christophe.leroy@csgroup.eu,
        lukas.bulwahn@gmail.com, olof@lixom.net, arnd@arndb.de,
        digetx@gmail.com, andriy.shevchenko@linux.intel.com,
        tali.perry@nuvoton.com, Avi.Fishman@nuvoton.com,
        tomer.maimon@nuvoton.com, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        kfting@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220220035321.3870-1-warp5tw@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220220035321.3870-1-warp5tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2022 04:53, Tyrone Ting wrote:
> From: Tyrone Ting <kfting@nuvoton.com>
> 
> This patchset includes the following fixes:
> 
> - Add dt-bindings description for NPCM845.
> - Bug fix for timeout calculation.
> - Better handling of spurious interrupts.
> - Fix for event type in slave mode.
> - Removal of own slave addresses [2:10].
> - Support for next gen BMC (NPCM845).
> 
> The NPCM I2C driver is tested on NPCM750 and NPCM845 evaluation boards.
> 
> Addressed comments from:
>  - Jonathan Neuschäfer : https://lkml.org/lkml/2022/2/7/670
>  - Krzysztof Kozlowski : https://lkml.org/lkml/2022/2/7/760

How did you address the ABI change comment? I still see you break the
ABI with the introduction of a new, required property.


Best regards,
Krzysztof
