Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0713F4D0A50
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbiCGVxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiCGVxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:53:33 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670431C107
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 13:52:37 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3B0DA3F79D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 21:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646689956;
        bh=avS2eWzHwYAlHNx2d4yWSoiGc/ntu1FTeA6bPKX64Gc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=UwXb6kahRIHz71CjmuWBrp+37h7dZrVUpkRmS23GBO+mpdXe70gt4qOYtakf/Gf2I
         BkQkmAEOaeOrfoG+vjyFZhK6kDmzsQgc7OzRiZos/wzzK9ViqQJw+dyMCVoYhCig3w
         33eMmE4rqNGvG33Bp6hM+cC5xodejbgbTNSwl+S7GklxO8Qrn9NafS4olc+10+f4Gd
         /czwh5e2yIDOGK51hBU6uIkL9CC49AEwx0AcgsqbfYCp0nxMKl9B/h2RhOshlymfJg
         pZXgUgmIAmF+5Ra3vwcYtTG0WprcWRbEIEhz4ucO6iC9KgIOzZLZeU8YoQejMjSjoN
         LVGEXezauqSdg==
Received: by mail-ed1-f72.google.com with SMTP id n11-20020aa7c68b000000b0041641550e11so3028285edq.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 13:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=avS2eWzHwYAlHNx2d4yWSoiGc/ntu1FTeA6bPKX64Gc=;
        b=FlOoLiDmGLO8BMU4klA44HQG1i78Z8wLAeTkjpGM2xnwAJWYuZfddElX8nxOdb/61b
         L+/DC2HuBxOgcYOP8ifWmyOWVr3fdCGUgrVscXhV1zy/JzfhpuHEj7H3Zi/JYOI2Bhgs
         SZ44IBX7LPuS2F/LMXUfYRFPlksVJntf9Y5TjVQO5wtK6uUBCpZkZyWnf375nN0LsH4l
         EkpzKK5nHTLmg02390sQKTLIu6H+EyB/cpQKQAa87y3WRZDOsNj2tXPkISr3p6UyQ3xo
         gvNPUP02qWwHTfjMHC/xdnJxoZy/vpyuKd68S0QOBPYUv66naWScpF/1WY31UrROH/H+
         vkeA==
X-Gm-Message-State: AOAM530ECtsipVmE6qrPZ/ilUV1OT83T9XyMbhzpZtyhDhT/JLFWUnlN
        5EDx5diCWrz5G/gOQbeA1HYT2h6A5u2Nugb2QjnrVuTdrGfjJLkMzxOidUSfjG8g/tuXPECMz84
        WsuYJvOdq5o2ZduhCYChi1Rh6oBNr0jVttET+EI3LEQ==
X-Received: by 2002:a05:6402:644:b0:416:4ade:54e3 with SMTP id u4-20020a056402064400b004164ade54e3mr5828298edx.222.1646689955069;
        Mon, 07 Mar 2022 13:52:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhroSgyUUiu+9iga34EIiz+zQNtDh2UNpPeDJ+/rC9xXcmLwdoBP4LNusITQji+CJ1nzOyPw==
X-Received: by 2002:a05:6402:644:b0:416:4ade:54e3 with SMTP id u4-20020a056402064400b004164ade54e3mr5828286edx.222.1646689954927;
        Mon, 07 Mar 2022 13:52:34 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id gs39-20020a1709072d2700b006d3ed4f51c6sm5289571ejc.0.2022.03.07.13.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 13:52:34 -0800 (PST)
Message-ID: <7f99b453-5510-d7f2-3d9b-b3ac3415fa62@canonical.com>
Date:   Mon, 7 Mar 2022 22:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] devfreq: mediatek: add platform data to support
 mt8186
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
 <20220307122513.11822-4-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307122513.11822-4-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 13:25, Tim Chang wrote:
> add specific platform data to support mt8186.
> 

You just added this driver in patch 2. No need to split such actions
because this is initial submission, so it can support two devices.
Squash with previous.

Best regards,
Krzysztof
