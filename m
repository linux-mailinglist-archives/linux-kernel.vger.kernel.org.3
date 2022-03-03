Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6B4CBA63
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiCCJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCCJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:38:19 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F46425DF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:37:31 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 639513F5FC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646300249;
        bh=WN0fHS1E3WYhaNTMIUFWDS4nw/cwGpcpJ5Ec381RmGw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=k2hQd24JScVsX1Ixeq9TUSFbK+09EuipWJSvhrcFxsesEMJRA1ua+PFjHnBkjr6OK
         /t9uIioomzQvwHGpaOqY2za575U+Mf6im8w15V5OHJ6s2ayW6MPo5IHlj5UmFhtuxP
         IsoMKSadiSeA+cj5pQ9MWWgDCt5Nbj5txVFPBAWdzxRWiuLElp4p7Jxk50ROa9AgUH
         g+nQoBihW9a2kDMYd2lfoRPjcUQao4izqdpCTqtLOCY5tlAzjqB72e8IclZAneFzao
         q1VmLxA4KNFaD5Fg8szB8m4sVgr+DN6+Rwtattize7kpHOVEOVWKHQPEh0g33SoP9j
         Mn1sC0L3WMB9Q==
Received: by mail-ed1-f70.google.com with SMTP id l14-20020a056402344e00b0041593c729adso2531680edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 01:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WN0fHS1E3WYhaNTMIUFWDS4nw/cwGpcpJ5Ec381RmGw=;
        b=OrImqawTJoBEnOYN76WytPHrwL8mGxA1uFfXPCYbYI3l13mbJTKVe5vt8CkWxYVZfa
         QrmSSKjArQy1QvFLThFhxV2rEQQXu2EZxMCMOJFd3wjGJabahP8yjeimBIZt0BoRDYmp
         wx9O8Hex77g7zwtL+t+IndKO1uDyIiy2hOgzmRRD6SWptC79GV6pQU0Cm5mGiD8wNOMz
         NgfuoJe1TgqkuVsG5pyd6zllmJ/8banlq/op7VgAFWQJZA6umvzP2F+ul/b8rlQyiLSk
         C796Ih9W2luVWuCml/RRDBhZloNDXv981yy98SuJ2JXVliDoYX6wE12fCbzizNI9Ore0
         SHFw==
X-Gm-Message-State: AOAM530fGSSgGHbyJ6Ol26StGRLndPAyw6mmDVTnwAKKQzzLqTUxhf1l
        Fm0d4I6VPav6v/o0qc5vP6Fzum0OePj977GG9U2H4B2tG3xx16lBB8VKO3Ese3ighm2N5XThxJZ
        o+1KDbdFL4b2UtmgIm+9/GW8ZrDwGslEkVJvrfkVAvQ==
X-Received: by 2002:a05:6402:d06:b0:412:eafd:8b9a with SMTP id eb6-20020a0564020d0600b00412eafd8b9amr34091221edb.278.1646300249135;
        Thu, 03 Mar 2022 01:37:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEOItBLjufIOG9pn9AcKVKBYrCqc0esYl+3bxjYohOhF8iGM2MCH5hndXuQg+/CTNrvTsxYg==
X-Received: by 2002:a05:6402:d06:b0:412:eafd:8b9a with SMTP id eb6-20020a0564020d0600b00412eafd8b9amr34091202edb.278.1646300248959;
        Thu, 03 Mar 2022 01:37:28 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709066b8200b006bbea7e566esm506462ejr.55.2022.03.03.01.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 01:37:28 -0800 (PST)
Message-ID: <77a147f9-794c-83ca-070b-fb17d665ed8f@canonical.com>
Date:   Thu, 3 Mar 2022 10:37:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk/samsung: Use of_device_get_match_data()
Content-Language: en-US
To:     cgel.zte@gmail.com, s.nawrocki@samsung.com
Cc:     tomasz.figa@gmail.com, cw00.choi@samsung.com,
        alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220303092223.2060108-1-chi.minghao@zte.com.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220303092223.2060108-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 10:22, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Where is the bug report to be credited? Where is the actual bug which
justifies usage of "Reported-by" tag (it is *only* for crediting bug
reporters)? Last time this email was invalid - why do you add invalid
emails to commit log?

NAK.

Please resend without this.

Best regards,
Krzysztof
