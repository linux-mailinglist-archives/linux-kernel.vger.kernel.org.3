Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A94DB630
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357510AbiCPQbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiCPQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:31:45 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD4C6C1EB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:30:30 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 851743F4CC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647448229;
        bh=x3cueeMXvXK+X1TZQd5gJyCfuHoNPJLUSHzCihz2Bfc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=scB6idR8k257z9c54W/4rc9oyFX90lSdSuqWN0E+JE1eWY6E4ncExJGFXECmlfow4
         L/PZ4bnhnyWlRYXu4jJxVgl4y59Mj9O2ygyp247/Qnf2cmxc9SGgKLhECWKVV5R6HR
         iKdwIIeT8GSJ3sRFihF5cZbZ30d+9mL5kh/fU/TyDWVChBVT+6gb51IkB4HhX6JKIt
         zihBHpTM/B1qVaGtJtmHlBLh3qO0rUNTY3eepA0Unf7ch6IUxTg6ekDxyoC8rDRe28
         pVQORRX8CppGSwENo8gaDKUpuQCOOITWvmxQ9xwzzyah9EkZjVmoaKtUvaqlY07nXu
         oJgA+al83jkRw==
Received: by mail-wm1-f70.google.com with SMTP id j42-20020a05600c1c2a00b00381febe402eso3001985wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x3cueeMXvXK+X1TZQd5gJyCfuHoNPJLUSHzCihz2Bfc=;
        b=LBwDnGzBij7Lx/ufTIcSsbi6pHtCQ2vmWKFlwgPhMnnK17Xhwc7/W2ClAidQnVwlo0
         6yvHcT2eQr40HcoO+8vwUMHGMcGQopmtqLM5F75biykBYYRebFxQnsU4Bb9S2gtDk9EX
         4j9l+k6JMKoiMnLf2jmoYl3TIvqlB8cdTZlOqphPdgWHKKOXpwieh2VVkz8kpVMsZLnA
         kL5j+xYhsgnMML0T3Iv74goO3Vby4HkgtH9mZRgZlL8NdXEItngExdxc7DIYQRsATqST
         crNQtQssuRs3Baus1/zBnHpVERhJb2WJxhZhLVYbfeZriRqmXzVP4vAkEegD6YwowNy+
         4Fgg==
X-Gm-Message-State: AOAM531bCMaNbxBaCpIwnOlNO3O1Z4xDF0Om83G/2z3meb+q6+UQpKdl
        FK2sK2q+4tNbPHJSOCt2hoUPC1WW2b98XZD1CawwLB4fmUlsrs4JgLp70kuX1QqkQ6TJKcfvora
        8xFbO8vyQ1yYchLZaUGfiIdZFi2LT/EYfykEYw5mRlw==
X-Received: by 2002:a05:6000:1ac7:b0:1f1:f9ee:7c57 with SMTP id i7-20020a0560001ac700b001f1f9ee7c57mr609213wry.52.1647448229128;
        Wed, 16 Mar 2022 09:30:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy05jy/Ex/bhrsQefj8mEouXNE6G1mYHwA8mh3BL4NRW8w8I5ZGM2wc5wk/GkP0oJTD53g8mQ==
X-Received: by 2002:a05:6000:1ac7:b0:1f1:f9ee:7c57 with SMTP id i7-20020a0560001ac700b001f1f9ee7c57mr609199wry.52.1647448228922;
        Wed, 16 Mar 2022 09:30:28 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm3169577wma.5.2022.03.16.09.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 09:30:27 -0700 (PDT)
Message-ID: <f54b0647-12ad-5861-8b8b-5d4233bb9bd2@canonical.com>
Date:   Wed, 16 Mar 2022 17:30:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] clocksource: arch_timer: Add arm,cortex-a7/15-timer
 in of_match list
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
 <20220316095433.20225-4-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220316095433.20225-4-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 10:54, Kuldeep Singh wrote:
> Few platforms such as Renesas RZ/N1D, Calxeda, Alpine etc. are using
> arm,cortex-a15-timer and arm,cortex-a7-timer entries in conjugation with
> arm,armv7-timer which are not currently defined in driver file. Add
> these entries in arch_timer_of_match list to bring them in use.
> 

This looks wrong (also Marc pointed this out) and rationale is not
sufficient. Why do you need these compatibles in the driver?

Best regards,
Krzysztof
