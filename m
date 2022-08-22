Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36459BA9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiHVHuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiHVHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:50:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9192A414
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:49:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z2so12759068edc.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Xt7sUJQ+aMJj9heYVbH58SruiAfLtzcBF4RZu/5f3ug=;
        b=rsY19QIao4S4MIiPcndmxJ/lUJkZ3wgbfJ6gAIwmeUjwbKR8ITGonQux7yCtKKClD+
         /OwFji4+MLFoLb9jC0j99XndeYi/bccJ+jpgNFTc0lXYBYLaAleiwPdpFUm1/rQD9Hm5
         lJ2FD4Ij183DVlHaU+nbQTYL4TBqq7iJlmS0NfCRDsk/mCJs0LDnQsvdHmAXn1YqXrTn
         7tGsT8SXdSKh9CThquNhCv28umaIkvq5evvrYsNitj9UHlU1AFG0U8yCurPDAESw4LG3
         b7joR24coTZYEcXXLGNzzpBPOLg6ZXvh6/rVGQOnA87+IWLBGtQhxgDxJHo19HF9MPg6
         JKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Xt7sUJQ+aMJj9heYVbH58SruiAfLtzcBF4RZu/5f3ug=;
        b=vxWhCkb1xvBLkupQpC+cPqYJ5Qk9lvu1Tz0p+fFd8vttwzfHVCNs3M12d2l7ndiqVE
         aG8ych+njjKbjYHlDLpO1XQWwIJZ2Z+RDdItDkmVW8EOTC1KlUG9k5SWio4rFDhQPNHe
         mbxKtnSnhlRn+eShV3ed6PSo0HaEK/uw6TL5Uk0cHkYO/rBUXHtJq0RsU/4XGW/hcgEq
         whZJ9uwel0jrgB/SfUKDbOlvbt02AQOVsyWoBGxQG3augizGDYieBXLsKQTqckfwpxNa
         hDnNFN2ETsz/bWAK277ftvMhxPu5lmNVaMyggtFF2XEalTwkei8pxXjL63esC7O6WH++
         JZzQ==
X-Gm-Message-State: ACgBeo0V0WWkNWOJ8UVYonvJmJbFAyVJ5bf+/xdd7iVmBeGiYoiGXDlU
        Bsf8dviw4k6br4B4y8rR3gTZ7A==
X-Google-Smtp-Source: AA6agR6OWI+3Yqy+/iaFOuEehpy2yEnM1di8bY439xitvmKJgJvBKjGbEJcnYOMoxDew0jloPWCZRQ==
X-Received: by 2002:aa7:cd79:0:b0:446:1fee:290e with SMTP id ca25-20020aa7cd79000000b004461fee290emr13736652edb.163.1661154597141;
        Mon, 22 Aug 2022 00:49:57 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
        by smtp.gmail.com with ESMTPSA id bi4-20020a170906a24400b0072af4af2f46sm5764857ejb.74.2022.08.22.00.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 00:49:56 -0700 (PDT)
Message-ID: <b41b5065-c012-3b3a-2980-3eba25e0a071@blackwall.org>
Date:   Mon, 22 Aug 2022 10:49:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH net v2 RESEND] net: neigh: don't call kfree_skb() under
 spin_lock_irqsave()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     den@openvz.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org
References: <20220822025346.3758558-1-yangyingliang@huawei.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220822025346.3758558-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2022 05:53, Yang Yingliang wrote:
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with interrupts being disabled. So add all skb to
> a tmp list, then free them after spin_unlock_irqrestore() at
> once.
> 
> Fixes: 66ba215cb513 ("neigh: fix possible DoS due to net iface start/stop loop")
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>   move all skb to a tmp list, then free them after spin_unlock_irqrestore().
> ---
>  net/core/neighbour.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

LGTM,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
