Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5178958A91A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiHEJ57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiHEJ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:57:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52377556
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:57:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m4so4140693ejr.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Td4g1Kh1bfrx34l0/UewmcPgD1HP9zjlky++5KBl8rw=;
        b=MsVxcm9F8W6ERzILshCCpr8HgmZ2AKHSzQ/ShS6Rzh11nmJ2jC2qh16rOmKVAh7jSN
         qRC9Q7+XMu5FUEiho+8LDX6PTDBspcxZNBfY6kOqTu9Xw+ofqsBnY1CYPa9mG0R2fvWK
         3JrAL1mmMyBkHxdEkTPwP+PoYRamjdU1Guigw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Td4g1Kh1bfrx34l0/UewmcPgD1HP9zjlky++5KBl8rw=;
        b=w0qdskdRrzh2vCvz5VTlLA0jKxl4tFCDyecYkTeZGWQ6QsVp7ZBBWsWcEBup8zVBU7
         jnMIzNIp3IX3kEC0WLTodCakgawHKOM1Ur6oHu/799Krh6ru9wHyfo7bCTaPYBRJ/q98
         Uz5ck2m+oEUEyWa4tmkdPJj4v2NauoETKID0O33B4ddAQ2VO0TT+zUDOYo0POgtm8wWR
         c6aDUSPnVtCBoocLZZlOPrzYeXLQN+9r36HYchxcrt66kmB+NNtUDEKQ1Rz7dzAqiMPt
         U9bgGE1lBoJ2QXwL9wf8IsAuNtBLMT9EAzsJy8tfrzLtB6vLCQKRJC6nqPrQM6GANwNo
         Q91w==
X-Gm-Message-State: ACgBeo06BXXZLNo4vXPxSWRPOFDnacXJXVsh3e6Pn+uD0J/Y0lRf04NS
        yh+NID59QGqT6pe3fg8RpyrwVQ==
X-Google-Smtp-Source: AA6agR6/awoYCaaW+MhRbzO2wn8SNzT6MJXkAEcUGdIJnR+2VTNEQg/Fz/9iNqBuznVDyPeQC6ji1w==
X-Received: by 2002:a17:907:2856:b0:730:86f7:4fda with SMTP id el22-20020a170907285600b0073086f74fdamr4580504ejc.689.1659693464711;
        Fri, 05 Aug 2022 02:57:44 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id f1-20020a50fe01000000b0043d5ead65a6sm1780812edt.84.2022.08.05.02.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 02:57:44 -0700 (PDT)
Message-ID: <be6ee88d-1434-8ac0-5019-c50bf34a3306@rasmusvillemoes.dk>
Date:   Fri, 5 Aug 2022 11:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] net: phy: dp83867: fix get nvmem cell fail
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Nikita Shubin <n.shubin@yadro.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220805084843.24542-1-nikita.shubin@maquefel.me>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220805084843.24542-1-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 10.48, Nikita Shubin wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> If CONFIG_NVMEM is not set of_nvmem_cell_get, of_nvmem_device_get
> functions will return ERR_PTR(-EOPNOTSUPP) and "failed to get nvmem
> cell io_impedance_ctrl" error would be reported despite "io_impedance_ctrl"
> is completely missing in Device Tree and we should use default values.
> 
> Check -EOPNOTSUPP togather with -ENOENT to avoid this situation.

Ah, sorry about that, and thanks for catching.

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
