Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED9358F474
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiHJWjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiHJWj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:39:27 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743FF1EAD5;
        Wed, 10 Aug 2022 15:39:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m20so990236qka.12;
        Wed, 10 Aug 2022 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=r2accQL0l0oQcO1+RtOSoOwmvLgvLsVHABJZHmQ70NY=;
        b=W7kI95sxd8+M5SsCujNSv26U4nAS+DnCqctVfZBsmyJtk+XEShPbciXxDtVTtA4zb8
         IqTH1YkbZJLBH/ccPoAUBpbzYusDojmd68ynxzV1bl7yAD5r7PaYhVPxhla/8QdDc1Ck
         gQUmcpoNusMUXwaPqhv5SUo1SKEpSU8+S9HJABu2iW5WKidEPc5GbmkMaU4ZsoCUudfq
         8CcgoBn2NIKYTTiOc6f1HkljYMgj8BF549FNnBHSlvNpyqlxZMBttdWwHjZXfck1wfYk
         wCjCJ0b+WXfZHToj9hy3J0wERRnr81gh5UxIHhs4oHhVbjAFIqFHtchafb+o8QF/9N1T
         xkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=r2accQL0l0oQcO1+RtOSoOwmvLgvLsVHABJZHmQ70NY=;
        b=N4A8ir/+nIRstHsr3oE4iEYrWJij7cN72F7PxGd75oEp2x/98GqsnEWrtXbpWV4GHR
         7BJcyR5KaDHld96C3ul/hsQ6/wn+ewGJIj4B2YwU6b3qRhuj5/Qn9UEKyrOk/r+NV3A+
         tenbOQr58vX/vi3dEArZapBA+oiOtHgThN3isOs0aIo1Fbe/QMJgcYElvoRZD410MSx9
         8DgY1C86GijN8XJVmVLAkX2+EtYBqM3Vk/4cgxBgUXa2j/ruTswpgiEtmQoftdG6yAxj
         tAQqm2sxwJ7QkWaEPyw1gk4vbSE/2TsU2eLwu5KpPzLiwkzsneQF3FFUvnt0t7l5e5Zc
         ZHLA==
X-Gm-Message-State: ACgBeo2hKL/YchWpgzEU4OQemOTkFCgN47iy3DsmNHyTVlm/wPLnTMSB
        llxkPaWKsWIyCHyQfivvjWopAusG2oU=
X-Google-Smtp-Source: AA6agR7AY51SB/hVhCSu7UoHqryEZG+VbewXyuJPQVt5JAc3JUv9Rc2rEHAU6LAczTFI8jFO/rESFA==
X-Received: by 2002:a05:620a:2710:b0:6b5:bf24:10e9 with SMTP id b16-20020a05620a271000b006b5bf2410e9mr22755440qkp.28.1660171165470;
        Wed, 10 Aug 2022 15:39:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r10-20020ac85c8a000000b0031ee3449f34sm661073qta.86.2022.08.10.15.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 15:39:24 -0700 (PDT)
Message-ID: <6941e20c-e6cc-d637-4f1c-9e6b638f05a0@gmail.com>
Date:   Wed, 10 Aug 2022 15:39:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] usb: host: xhci-plat: suspend and resume clocks
Content-Language: en-US
To:     justinpopo6@gmail.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1660170455-15781-1-git-send-email-justinpopo6@gmail.com>
 <1660170455-15781-2-git-send-email-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1660170455-15781-2-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 15:27, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Introduce XHCI_SUSPEND_RESUME_CLKS quirk as a means to suspend and resume
> clocks if the hardware is capable of doing so. We assume that clocks will
> be needed if the device may wake.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
