Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A74DB628
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357488AbiCPQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357451AbiCPQa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:30:26 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95566C81
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:29:11 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8AF073F1FC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647448150;
        bh=N2v+uhb6zX3qIu/4G31qspdZaqAml+nzAZNzEtc/etA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=n8V76rTpZDA0UOgML91CzWpngh1J7RliDKpSueCEAee1HkJrSg5eaYg66VqiAHX+P
         RYw3hoYqGOzlNtaus2dF78MWxpud4tT82eB0UZyJLLlIdKrkIdW9PZe2L8j7Rzt08G
         UiDZ3ZtA9qIV3axmr+SAR2LypGJ3sGCqPuw5I4+HfToWQGfgLljsi1JRS+it+LBWwN
         ujOHNNfFFMULu8UA35KuSiXJyEiu+ViAzc5V4xxmaEpP4EBeQdIi3g74F4hwRKfz85
         k5StXLq02efrpMqhRU3htNfCf3fvt3H4RA1UL8dglLWXbqdv/qqQnG61vwf7SjhvBI
         eYWxd9gj4ct/A==
Received: by mail-wr1-f70.google.com with SMTP id d17-20020adfc3d1000000b00203e2ff73a6so511556wrg.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N2v+uhb6zX3qIu/4G31qspdZaqAml+nzAZNzEtc/etA=;
        b=gsm/dVPZ5xmE8rrdl7QJsICUJ2STXixUyhcoWjTphD3bBPovi9qav6VmppY6SKbl93
         MzjzBYyYsj3MXgADkaDscn+XlrvnsdJ1VaBbw2OB9uG1eoFVqrdTfneKWKTWKz5kwGAY
         ItDDsWBy3SiJsU+AAlKYNg7GSNMzr9uCBA+WLY6fAgSkAGR1YWIA8yKgYeH9y4J5yvpx
         /nlXNPexTAV84vmtJR74mxrqowtiYCvBHHiRuhWqjmc7ej8KwhTqIBFI/ytaqLgcafRj
         2ZETQ5WAYmtMiN/85ne2EdZMCZdfv9z1anIdSVCplgYwtYzRDKVmpqb3txr7upAyEm6c
         rrcQ==
X-Gm-Message-State: AOAM532Nih/HBZ6/EbwkMEOOPaNppVcI8iJBvx6SGRSp4lyvUEsMWY14
        uFJ7cuVU9rFn2CLrFBrMbPkWCfEMth5hkvLthTQ6Lj8urV8BEtb9rQb1BqbGsTpR6JC5nq3HNUI
        Dh+Nj2JhfAyguLLaG/URLFEnz7ifhI3VuP3n0jmDdTQ==
X-Received: by 2002:a05:600c:4307:b0:389:4f8f:f189 with SMTP id p7-20020a05600c430700b003894f8ff189mr411364wme.29.1647448150183;
        Wed, 16 Mar 2022 09:29:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9OmLmRwN9342eSs0rSpdNPwuT5U5YZpqt13JqKvNHusuOyOMP/yPzYO/whoeQ0Z1hRY9uBA==
X-Received: by 2002:a05:600c:4307:b0:389:4f8f:f189 with SMTP id p7-20020a05600c430700b003894f8ff189mr411352wme.29.1647448149980;
        Wed, 16 Mar 2022 09:29:09 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id f9-20020a05600c4e8900b0038c740951ebsm943239wmq.24.2022.03.16.09.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 09:29:09 -0700 (PDT)
Message-ID: <01ff2432-b8d6-3bfd-efa9-c61b1fdce19d@canonical.com>
Date:   Wed, 16 Mar 2022 17:29:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: timer: Rearrange compatible entries of
 arch timer
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
 <20220316095433.20225-2-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220316095433.20225-2-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 10:54, Kuldeep Singh wrote:
> Compatibles entries of arch timer includes few extra items and enum
> pairs which are redundant and can be simplified in a more clear, concise
> and readable way. Do it.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
>  .../devicetree/bindings/timer/arm,arch_timer.yaml    | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
