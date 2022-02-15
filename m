Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4A64B76DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbiBORfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:35:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242602AbiBORfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:35:39 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFFAADFD6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:35:26 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C8436402E0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644946524;
        bh=+P9PcpKT0xdbty/hJ1bxhDi4Mvr/vrZbJ+31zABw+Os=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MbRw2Ve1X/XfWjVfW69aWnIHbQnCdkusELs8x/o/Z+j2d33oozjvjFivXBHD//Ns7
         JaPj6G7n0sUA2G31wKU1sDJTUGlOMHPyztsPg+3rpvv6YoxOEmM1llt1kEX8ne51HR
         YHFO9pgVDC1Be/XC8RAhFrgHWkvb/c5TefolV9svt8MPBKOhYV9Pe6jSWoJuDDemqs
         7GkavfZsK9MupVej/ptlO4GgD+SeYla0Az6Buq5BFzqPIcE6thnQzl/c9XMyDTX0Ly
         S1czT2KzvFqJ6UrVjw3TsafYTF3v0tL2TUnxLzPZeNeDeLP2Gaa0QKFnZGqyJAhPWr
         RpHHMLqS9Bw5A==
Received: by mail-wr1-f71.google.com with SMTP id k3-20020adfb343000000b001e463e6af20so8608365wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+P9PcpKT0xdbty/hJ1bxhDi4Mvr/vrZbJ+31zABw+Os=;
        b=ZCPpvyx3oGSF6ud5JFUmORRHnC0ydXCZb+Kcbzb0KRFQG6IfyRP+N2zVcPiZGxkIWS
         0WU3Pu2GmpXn5RN/RhtHK9nICg7YhTsDlaEomRFOzGAtCmgRMl6z2jZcBAkkKczNCbmu
         vHjMKL3Dq9r4jpkuZW12LsKnrpq9U+oPDakKteVLf45DAEPl4zU4I3NNx59i3uU/CfDp
         yh60mbpnfSzlhyOLDDwbloYtdVcSlKpo+lDLeosPGeLwGNaKU8I3rTTcegnaP7W37VJ5
         p205VeaEu6wVbsoym1eSUmb2WTjCceVTWj8tclaux+rQswfPCeYUOrsiPa6hcE7Sz0Tj
         AtSA==
X-Gm-Message-State: AOAM531zXdWYicPbbPmTBNBBYM9QPNuc45AQFLRRDRuu+iGvFq/Divji
        qzN7hneQdyKUOT/aMc1aeMSDnJDvaA1E6fu0LJIM41siQCd0b2wbL6ooS/9BiMNrhYtw/WcSmMW
        CmCA2CQTIFTKx0xa4BDatUEmeU+8QWZdpsWOMkovg4A==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr25434wrw.537.1644946524401;
        Tue, 15 Feb 2022 09:35:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHVvxLlKwb0vEtmbBdnfyiKN8+jTxOLmhaciEyPHxsyHO6/CWWCijyKhPRtdxqziX1NdO0/Q==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr25416wrw.537.1644946524266;
        Tue, 15 Feb 2022 09:35:24 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s7sm16804963wrw.71.2022.02.15.09.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:35:23 -0800 (PST)
Message-ID: <d1ce6c2b-e1f3-1c2e-a6fd-d506848b2c12@canonical.com>
Date:   Tue, 15 Feb 2022 18:35:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 25/35] iommu/mediatek: Migrate to aggregate driver
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
References: <20220127200141.1295328-1-swboyd@chromium.org>
 <20220127200141.1295328-26-swboyd@chromium.org>
 <7c517b787d1dd768372d0141f5078e3089e883cb.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <7c517b787d1dd768372d0141f5078e3089e883cb.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 12:03, Yong Wu wrote:
> On Thu, 2022-01-27 at 12:01 -0800, Stephen Boyd wrote:
>> Use an aggregate driver instead of component ops so that we can get
>> proper driver probe ordering of the aggregate device with respect to
>> all
>> the component devices that make up the aggregate device.
>>
>> Cc: Yong Wu <yong.wu@mediatek.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Rob Clark <robdclark@gmail.com>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> Cc: Saravana Kannan <saravanak@google.com>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> 
> + Krzysztof
> 
> The memory/mtk-smi.c is expected to get Ack from Krzysztof.
> 

Please resend with cc-ing me. I don't have the patch in my mailbox (wes
not on address list) and I also cannot find it in linux-arm-kernel.

Best regards,
Krzysztof
