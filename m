Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD54D5FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiCKKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiCKKpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:45:46 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B514F298
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:44:43 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ABCB43F312
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646995481;
        bh=/5MWLhD4xGT9FKI+CGPQQ/jYudzkVpDtSDj/hy41Z8E=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=XqLLCnZVMFR5K8gQEJGujDyVglx7vZI9uFi1HgHGBXdyPuSyrlRy9CfilDD4z3v7S
         pmf5cRstEPRGokALMoT1H+iXxZW3OxGG8jBaOknYSVMg8CpuZp8VI2TdI0XkG6jFxN
         n32LXZX4wZztJWiasmgnWtT65XnWko3/kdBVozknZUVRL1pAf5cUrMvJuvS5jgvd6y
         2yIkDKecbpcsZOsBTPKrM14cb16gsvP6TUcpKflkpmfg/WgqM8gQw3VJ/rGQvD68uY
         S8VUKq6eJ+RzMQjgeI5OM8pQqJoMyKia8xgj/J5kXCK45jJkEDhodut9k7SfGMDhuz
         CAvE74yKgH5ZA==
Received: by mail-ej1-f71.google.com with SMTP id q22-20020a1709064cd600b006db14922f93so4735143ejt.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=/5MWLhD4xGT9FKI+CGPQQ/jYudzkVpDtSDj/hy41Z8E=;
        b=pYOFw3a/tAXMvGcogUf/a/lEdgNk9t/uDfsEz/pJNiNqgVQ139jJBZFxJDi9duDMh5
         cE3qlGwWRN8gRzHf1r0bCTY2+WPufDaM5LmrrgzFbvbhIUGtJlp29f6BIE3i4KvPdN3n
         /7K+OK6fHM9zy2wiEJGebyk6gAxn/9q3CCvjd028+AtCLqscAv2LoPVJbzeyugo4NIC7
         NgsozYlh8hyWLe1YTtYlOYOcKzdmYWvac3ON982WV/0Uw5m5eGbOFOT2bdMVc+rvTK4B
         gSuzoz9wJvHwXPnm+jtO78vcRtdIkwm2OXXOxd/vbrC6QbGjISulGQQofZ2WjdsJBbL2
         tvCA==
X-Gm-Message-State: AOAM531PV/R3I1wjr98W5mMk7/73M151BZAPyBUS0G+GtzFiNiO5BPDX
        CP/4kOkgHnzwrd9BuZSLbGgD/ua2/dlMcW3erKv3knNFnJIrl6EfOKry7NoCiNZHa1H9rY/iMnO
        DQsk49wPQKsVwF+eH5DC8GkmCYqKUOdDhKoQkhke+Iw==
X-Received: by 2002:a50:9d47:0:b0:40f:9d3d:97b6 with SMTP id j7-20020a509d47000000b0040f9d3d97b6mr8183327edk.392.1646995480932;
        Fri, 11 Mar 2022 02:44:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdKKDMjkHKVhdTP9g7nHC6x7lNkdrI2VetCVe5vQfigm+rGX2Rr0lQn3LcUVjzh7JdHNWMOQ==
X-Received: by 2002:a50:9d47:0:b0:40f:9d3d:97b6 with SMTP id j7-20020a509d47000000b0040f9d3d97b6mr8183311edk.392.1646995480769;
        Fri, 11 Mar 2022 02:44:40 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id 5-20020a508e45000000b003fe03798eafsm3354795edx.32.2022.03.11.02.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 02:44:40 -0800 (PST)
Message-ID: <9cc6fe19-bd66-ad49-188d-e35a085de397@canonical.com>
Date:   Fri, 11 Mar 2022 11:44:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] tty: serial: samsung: Add ARTPEC-8 support
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        alim.akhtar@samsung.com, jirislaby@kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
References: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
 <20220311094515.3223023-3-vincent.whitchurch@axis.com>
 <ad94136d-f651-7e6e-b3ec-94553c4c6d3b@canonical.com>
In-Reply-To: <ad94136d-f651-7e6e-b3ec-94553c4c6d3b@canonical.com>
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

On 11/03/2022 11:42, Krzysztof Kozlowski wrote:
> On 11/03/2022 10:45, Vincent Whitchurch wrote:
>> Add support for the UART block on the ARTPEC-8 SoC.  This is closely
>> related to the variants used on the Exynos chips.  The register layout
>> is identical to Exynos850 et al but the fifo size is different (64 bytes
>> in each direction for all instances).
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>> ---
>>
>> Notes:
>>     v2:
>>     - Added Krzysztof's Reviewed-by.
>>     - Expanded commit message
>>     - Fixed fifo size
>>     - Rebased on top of Krzysztof's "minor fixes/cleanups" series.  This needed a
>>       couple of fixes for build errors.
>>     
>>     (I'm always unsure if Reviewed-by should be carried over or not if the fixes
>>     are minor.  I apologize in advance if carring it over was the wrong thing to do
>>     in this case.)
> 
> For minor fixes, usually we carry Rb tag over. It's fine.
> 

Hi Greg,

Just one note for you - this depends now on my v3 patchset here:
https://lore.kernel.org/all/20220308080919.152715-1-krzysztof.kozlowski@canonical.com/


Best regards,
Krzysztof
