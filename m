Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0809C4BCF69
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbiBTPc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:32:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiBTPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:32:25 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F382025EA3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:32:03 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6A4173F1CA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645371122;
        bh=mDIoi44y0rBobh+yuFyA2ajORGtPygGl0YvZuNczdWM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=lL5lgCXUTarIbYAqHNsfMnRYzhPs4UDXJ9DHSWyXkTUyTP7U67qsjq8Lkc/wa4uCz
         mXYurrMFqTKhWeBVt3G3v2VM5JimioAVqsbhFgOvGw9MNTZHqKVY+M2IoJW+qfLU8y
         LGZ1x2Wk0VzEET2rN2V4zfF0yVo1Fx1AMA7+Z0ckzbv96kMW9WHaXyNLUExHogxCkR
         s2c1ne/nOxTH87kbsJUn2R7LXeRp2QkLBZUXY9JXblB0YNUo7Qrc0V0eKCK1yNtKE6
         P7e4gDkyz9A3VTeivaPHunMIk1MmgqakB3NBTjA4HL+3kpP/9JRXGlx0SfPjAs+4ju
         9iY9Nd1zrAf9g==
Received: by mail-wm1-f70.google.com with SMTP id i30-20020a1c541e000000b0037dbf3d7efdso1603407wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mDIoi44y0rBobh+yuFyA2ajORGtPygGl0YvZuNczdWM=;
        b=S+Uyq1BvdcbWjwLQm8m6DFKBwbo+X/JnBXkfO4rDBuhj3xwKDViZXOZdUwywGXkfj6
         sstFMC8fu8JLGz1bARespHjRgNur9DVdTecrUygwehFqn/GPpRdd59H5dUs5WCG3DcTc
         /yz5fZ8kSfZ8zY2oJ/IvFGINDR1gUDAli6gUQxUOnNl2agrm2AssXAJpRX7ljYyLWisT
         sofywYC/STd4CNmpnDjL0ZupgCGgLRl/rpkLxWBOektETEJ7nx/CSiuW8BEGs/w6XOge
         otkqdFiTn+aecOi4g2dGRnHBrPBh+xS86krFMSeekMDfcOYQkyJelPknjr5+2hTXK4Ud
         WPNA==
X-Gm-Message-State: AOAM532Hf7dy+86DYDK5sLRU/InnOSTlc4SOWZ6m+ztgFaQ0sZ1VHxP+
        5tCWFCAkEXZmdNElAG4z+E8SaG8tURmlFRV1mQCf6mQ2vZsjvQEJtDoCU1sFWB3BXBtz/C5/5ki
        QGnMOrpctzcUQk4BAC9KXNyWDNqZ71E9J1rbTA08TXw==
X-Received: by 2002:a7b:c409:0:b0:34d:4775:4961 with SMTP id k9-20020a7bc409000000b0034d47754961mr17872479wmi.44.1645371121979;
        Sun, 20 Feb 2022 07:32:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyHE82bcimjw/k6+QxNFCMaeVmFPs21xBPhkFnJunp+DsUGhpb3pn7Y6EUxhrHE863aNuBCQ==
X-Received: by 2002:a7b:c409:0:b0:34d:4775:4961 with SMTP id k9-20020a7bc409000000b0034d47754961mr17872466wmi.44.1645371121847;
        Sun, 20 Feb 2022 07:32:01 -0800 (PST)
Received: from [192.168.0.117] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm5903235wmj.18.2022.02.20.07.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 07:32:01 -0800 (PST)
Message-ID: <e616815c-d5c5-5290-6a6c-f4598aac9aa1@canonical.com>
Date:   Sun, 20 Feb 2022 16:32:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] clocksource/drivers/exynos_mct: bump up mct max
 irq number
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, pankaj.dubey@samsung.com,
        m.szyprowski@samsung.com
References: <20220220133824.33837-1-alim.akhtar@samsung.com>
 <CGME20220220132640epcas5p1a523e6db151e0cb76c0edb6d32959fe5@epcas5p1.samsung.com>
 <20220220133824.33837-2-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220220133824.33837-2-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2022 14:38, Alim Akhtar wrote:
> Bump-up maximum number of MCT IRQ to match the binding
> documentation.

Would be nice to also see here comment whether there is a real case
(DTS) using more than 12, but anyway:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Best regards,
Krzysztof
