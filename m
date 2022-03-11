Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F634D5DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbiCKJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiCKJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:00:14 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C461BAF30
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:59:10 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B60D53F19E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646989149;
        bh=0knUq+nj9peEmS1Svs4MEOnTn+oxEzDhNDhC8HFWh70=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rGFHtxSiiXtPs+Pzh/WdGhQ8M9Zn8moC+B3YUqj54xCJlwhZHF5H47xKxAf45LsIi
         JMyNB4zNzUJV7yL060P1AuTga35RP32VCPhrvom4YMq8UiF3xax7vKGzvTj5Qe+/ud
         cYPt+9hBRLSyzReOHEkm89i38RAHTYxl+278jZWftJJSKtLfOKfi4nepnlU2kQwdUQ
         Yc431KD5izCKXtW58afY387UGu+auJt+k2gjPVvR23iyW28vh8Cm+0zxVyWIoXqw7f
         eOAImOJYdhP331mdvlldJISTq7+wX9KU/577Hm1GCDRxFKE1bfz39MJGTNcl6sZ5xF
         GdxP2vSgCUIKQ==
Received: by mail-ej1-f70.google.com with SMTP id m12-20020a1709062acc00b006cfc98179e2so4599480eje.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0knUq+nj9peEmS1Svs4MEOnTn+oxEzDhNDhC8HFWh70=;
        b=6giw6AZNPykwAnqTmGV1v3q5nQNKHNV6ZWLXcUrfo5u0ZUKrR239+zMFEouwfgVKV4
         SSLk/rusGNB4SzXdOsZ/et4z0hMilNfaNlsocr3FReFEYR1xgbNU/7feTDC8XZuq7Xkx
         N4yXiJjsjVBWhjOOkXJ3ffPAr7W+Sizpm0joBcptGeP9wTDlpkcMANQiQgGsTMUhlo+k
         4e86EuCwi5yHvs3Iykby3iJUQH0XLynpsJz8D/VcW7GgDQBTHUKk2dR47mOYHneGH909
         vUeow4sSUDV3OAhVDiiCsD9Jj0UR/fPfGNn6oIh5ynmjHywrQE4XjD9xWqNA3S8dTwMw
         iDsw==
X-Gm-Message-State: AOAM530GHuWcHk1jhGr0uHc89bmq4AyRubNpKTo7VMODgrF88jTD3VvW
        XAHBvX/YzO4PJv1pLG7WfIep62sEku77fHieW1eYC6W44NBeu9fSsWyfvYXjuto8ETptT31du4C
        xLAz2S/goYBhyY0EK06yTCznIYMfVGV3RNsnfGtagJQ==
X-Received: by 2002:a17:906:4fc2:b0:6db:718f:7b18 with SMTP id i2-20020a1709064fc200b006db718f7b18mr7304015ejw.412.1646989139043;
        Fri, 11 Mar 2022 00:58:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJ0MYmCOnRGydkzT13dr5ZvqsEe8P/UTOTbqINId0zENiFAHB5jwB73TPSN7i3f0Z42WkHBw==
X-Received: by 2002:a17:906:4fc2:b0:6db:718f:7b18 with SMTP id i2-20020a1709064fc200b006db718f7b18mr7303993ejw.412.1646989138835;
        Fri, 11 Mar 2022 00:58:58 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fq14-20020a1709069d8e00b006da650af5a9sm2680769ejc.3.2022.03.11.00.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 00:58:58 -0800 (PST)
Message-ID: <b9eb6b6b-b295-4d10-d4f2-c56461994d71@canonical.com>
Date:   Fri, 11 Mar 2022 09:58:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] ARM: dts: nuvoton: Add new device node
Content-Language: en-US
To:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, mchehab@kernel.org,
        bp@alien8.de, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20220311014245.4612-1-ctcchien@nuvoton.com>
 <20220311014245.4612-2-ctcchien@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311014245.4612-2-ctcchien@nuvoton.com>
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

On 11/03/2022 02:42, Medad CChien wrote:
>  Add NPCM memory controller device node
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---

Subject is too generic. Describe shortly what are you adding.


Best regards,
Krzysztof
