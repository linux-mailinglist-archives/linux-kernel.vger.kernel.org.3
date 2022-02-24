Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE704C2477
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 08:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiBXHaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 02:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiBXHaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:30:00 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4088E161103
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 23:29:31 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 266C23F1B6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645687769;
        bh=1laIzS8Hrg3uRlIHve8LHSUfvPW6p3oQblY/GhVjbTE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JykxPq6nWcJ/grOCjhA+IBSwsuEPgixTBb49kidquodY6dRJ0YGXJUCZKGOD+5ALi
         ziXKvtjVOVuQVu0nLt5vwtE3uSniG7YFTFuZtiq1j2D0NGT0UWVb4C+y+8nwqJXp3T
         SIYd7kmadzNHgbHtAAkQ2Tsmc/VEkjAHROlxeiV6EKuV4FwPGpmM6XhOo0KZ9Vt3lt
         k0VJiWSmQXIMSsnPHrJXa+z1zGfXWBRVCPC/WAdA/FWWQOTn0EYFM/leHTOHMxviGc
         +V3/ORIRN7ZfUPnkzXk8aHEV25dWBiDb+uyTyxv3vCCN6LdeJwks3Y1I8dr9fm7HIa
         PeRpbXEWZN3gQ==
Received: by mail-ed1-f70.google.com with SMTP id y13-20020aa7c24d000000b00411925b7829so318538edo.22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 23:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1laIzS8Hrg3uRlIHve8LHSUfvPW6p3oQblY/GhVjbTE=;
        b=FF0HPM+5iYVEzyLXOEoq84YRIAG+Huzx+sMyhIXzpfcXHr8rheinQxL4zWEMOG3PE5
         xc9Itz8d/3d4Qkq6XkpYH4ypS8IUL33EnxwOWMr76NBRkO+JLnD+R9NQjxCLpWwB2qj/
         IO1lBC4dufaHpVnfkdZ9yHF0Zy8cb+t/J2DBie5uJmgo+2ClQl/Ju5ZmfPO6l+RncUQK
         kybT2Unk2Ep8qiN7lD25H+wAv1pXJF1MGLfOHA+GeVWEjuOuAdQd73ht5ly/ZLwuz0Dr
         bZMq6PGeMVt2nZXwQ+FfWn8hBt2eDaeromJqsauGHoondCBnZPfC364DEV1OFtDJCf06
         BhBg==
X-Gm-Message-State: AOAM5337p3x0GjSyoTmE6d5VVIoW325ZpcOJ3Cf6KrmpBcndvKp52/jv
        cY1SjXc1klt7EkiRTkhYh9TCEvjFK1q0UPFuKZujghbOTHRJXlfYW7TiCU05LIikN5Pzd/WlcL0
        s6DTtO+NegO7IXA0rECvyJ4jZ0IOtreONhlzwRejb2g==
X-Received: by 2002:a17:906:2a92:b0:6cd:4349:dc1a with SMTP id l18-20020a1709062a9200b006cd4349dc1amr1177111eje.648.1645687768816;
        Wed, 23 Feb 2022 23:29:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcQyzME5WrcWwgAuYq5z/evXLw2LeDvM6ae2sIMB9/BQkttObW5lgeyZo194lQMxlLMlPxTw==
X-Received: by 2002:a17:906:2a92:b0:6cd:4349:dc1a with SMTP id l18-20020a1709062a9200b006cd4349dc1amr1177095eje.648.1645687768567;
        Wed, 23 Feb 2022 23:29:28 -0800 (PST)
Received: from [192.168.0.127] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b4sm862553edu.105.2022.02.23.23.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 23:29:28 -0800 (PST)
Message-ID: <ec0c90b9-58a9-669f-fe4a-73e60df335d5@canonical.com>
Date:   Thu, 24 Feb 2022 08:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] ARM: dts: Update jedec,lpddr2 revision-id binding
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20220224003421.3440124-1-jwerner@chromium.org>
 <20220224003421.3440124-4-jwerner@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220224003421.3440124-4-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2022 01:34, Julius Werner wrote:
> This patch updates the tegra20-asus-tf101 device tree to replace the
> deprecated `revision-id1` binding with the new `revision-id` binding in
> its "jedec,lpddr2"-compatible node. This was the only DTS in the tree
> using this binding.
> 
> The revision-id2 (mode register 7) of this memory chip was not given in
> the existing device tree, so let's assume 0 for now until it becomes
> relevant.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  arch/arm/boot/dts/tegra20-asus-tf101.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please use scripts/get_maintainer.pl to get the list of people/lists to
CC. You skipped here Tegra maintainers, so no one would pick up this patch.

I bounced the mail to Jonathan, Thierry and linux-tegra (+Cc), so
hopefully they will get it. If not, series might need resend with proper
addresses.


Best regards,
Krzysztof
