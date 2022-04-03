Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8772A4F0B02
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359297AbiDCQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiDCQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:01:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52288340FA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:59:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so13070904lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KKlcn54PThq2FKahUYvLZsgWJiUdQCm2Y4kdU3bFhN4=;
        b=dpLPC2z/Esldqx70eDH/rzllBYsmWf6BYGOJq/cjhDbq7B8Hj23wMtHvTVaFHAAqBD
         q895Ga1Jm8cov5tIist9q+36g1Jjm/FS1feywqK7wDshsh0pHQ49pUmHXKBsbCVHftUB
         FZEkPUjeOecuxRIefH9/L1YaGfbjLBhTw6ZAbZNBuf0AXcMA4jUnbDwCs7NsXflUSYmp
         fFpVvg3/swKwNfXuQQXPAexy+UGLeobwtzsUjMrGWB7lElFOOmfdM6JWI26YyvyQJbSy
         k8Nvc3CqZR9bceECFFnGQEDd23rJOkipHLcTUNPTZErVIgRh/ozscBA4aDVydSsSSxq+
         d2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KKlcn54PThq2FKahUYvLZsgWJiUdQCm2Y4kdU3bFhN4=;
        b=dZsN2wadWjx0dRnANLAgF5n/8/1/36xTV79FfjI2A26209lkPBnTxfQ1AzGeDBaMzJ
         VrSlZS0VDWlVWdnzgKW0N3SNGq4lKFIidPK0TKdSszH9Nu0P+AZxSn04ZnjDg/QmIc+i
         DpaVZZo+VM87e1JkWuK+st6SN2dfF3U0k1RYpwW2GWc76Nb1msP6/fm9E6fibHxq0F26
         uRG7jVlJxG7PQYr/p4oKv3WEIkK6OHU9VM8HUOo8TRZw0Ys6Zc8MxNdGjBwdBeciDJ3+
         czE34JHs+FmBYxNMXJX46Qy/KNKoOX3/AiZsUx7AO6WmV5WsBLMNDCSVa3ASctKeBpkA
         EokQ==
X-Gm-Message-State: AOAM530vkFYpJNxxEMa4WJut3b/k2Y+P0xY1jZ22BPGzbHLBRGvuEGtj
        f9wb86y0htCZuW54OFhHBxo=
X-Google-Smtp-Source: ABdhPJzBYJwux5sXQl5VKAeCWo4U7G4PmLnSLsJM5yTssEvU2NHL4xzK8+jBz4LkfC90iPNKp2geWw==
X-Received: by 2002:a05:6512:3f86:b0:44a:f5bf:ec9a with SMTP id x6-20020a0565123f8600b0044af5bfec9amr3181456lfa.490.1649001569396;
        Sun, 03 Apr 2022 08:59:29 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id bp15-20020a056512158f00b0044a3271802asm859675lfb.17.2022.04.03.08.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 08:59:29 -0700 (PDT)
Message-ID: <ed0e9f7b-9ba9-b0c8-8261-397bf793b9b9@gmail.com>
Date:   Sun, 3 Apr 2022 18:59:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: simplify control flow
Content-Language: en-US
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <20220403155111.GA333187@euclid>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220403155111.GA333187@euclid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sevinj,

On 4/3/22 18:51, Sevinj Aghayeva wrote:
> The function iterates an index from 0 to NUM_PMKID_CACHE and returns
> the first index for which the condition is true. If no such index is
> found, the function returns -1. Current code has a complex control
> flow that obfuscates this simple task. Replace it with a loop.
> 
> Also, given the shortened function body, replace the long variable
> name psecuritypriv with a short variable name p.
> 
> Reported by checkpatch:
> 
> WARNING: else is not generally useful after a break or return
> 
> Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> ---

[code snip]

> +	for (i = 0; i < NUM_PMKID_CACHE; i++)
> +		if ((p->PMKIDList[i].bUsed) &&
> +				(!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
> +			return i;
> +	return -1;
>   }
>   
>   /*  */

Looks good, but let's not introduce new checkpatch issue:

CHECK: Alignment should match open parenthesis
#62: FILE: drivers/staging/r8188eu/core/rtw_mlme.c:1645:
+		if ((p->PMKIDList[i].bUsed) &&
+				(!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))




With regards,
Pavel Skripkin
