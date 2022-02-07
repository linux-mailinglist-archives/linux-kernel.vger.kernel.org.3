Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109864AC034
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389207AbiBGNvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388363AbiBGNqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:46:50 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E7C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:46:49 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x4so3566277plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8ug9KpH6bIvmPFydrBBlGOiV1ojuh4o4EvlAVOtW+r8=;
        b=Ucb6NZccAO1goAXBmte2XO3+lvr0ZtNlsCU1niaB4QeCGfuaC+ZZ34xsjuiUZ34J8P
         /PnDKyDwwKZuyRevYLH0cVu+uCxqEht+7er+qya2op6bjdApe9jED//PHeQR5KhnvRSi
         o4CuIM7pIIeu74ADGEG1vVJsUXTxHgkEvPzxtrhogxoQg5Pgb1QV4Ds6kJhzGHEfj/Js
         X18y8WlvaeZpnMJicsHItS4pA/ToBOt7PEBsnu43DqRWFYqgaSwsjHYfF7nC2ZYrqTz+
         K3FGWynLI1LQBD2ydHoPIv4f5Q2OU5bpE28FB9kpldJ0ng8rn0wtSRR/4J+59QLHhwRw
         8fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ug9KpH6bIvmPFydrBBlGOiV1ojuh4o4EvlAVOtW+r8=;
        b=LsGTOx2ekGcWpy8owWOSivSypBUmNRlzG1WrIXyoDi3J8HtRYfaYaVB0xOUH4xOCea
         8/sRfQL9CDYPzHTRKiRxPC4PIKTVzQewj2uIXlyO9WaFMy/oMIT4t8cAuyKlBpGaLtt0
         1g24UPS0b+9A24fmBX2pTm7IPzhPXsi9HjthWislQpe94tetN0OSSKtvhznu/O055km5
         AKD6xQ8blKVflKeYFUarIw+PW0UbK+niv13MsOW4k8AsQuW9V1T99Fzvo3cfobqCx5r1
         cPmZIe0dTrlkdEE9ju7RmfyT85v5Nog6G6U5iad7nwpZN+dTsRjsjiXpcuqrnB6gr2iS
         Gq9g==
X-Gm-Message-State: AOAM530DrFs4mVdhYcGYjypmzg/FMSHMgfRKnmpa5WP3z4u/anVVX6h1
        HT8+c3yqKrNYCSH58jLHCQipFA==
X-Google-Smtp-Source: ABdhPJy9dgozjBf35cBNjjoa6rNFAeIyMjWTFI96ymPkw8SlosV4+0d7/rydA66/7FD2PEhtZhWwFA==
X-Received: by 2002:a17:90a:f414:: with SMTP id ch20mr8409368pjb.146.1644241609260;
        Mon, 07 Feb 2022 05:46:49 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 198sm8378636pgg.4.2022.02.07.05.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 05:46:48 -0800 (PST)
Subject: Re: [PATCH] io_uring: unregister eventfd while holding lock when
 freeing ring ctx
To:     Usama Arif <usama.arif@bytedance.com>, io-uring@vger.kernel.org,
        asml.silence@gmail.com, linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com, lkp@lists.01.org, lkp@intel.com,
        kernel test robot <oliver.sang@intel.com>
References: <20220207105040.2662467-1-usama.arif@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <696e49fe-3d2e-da6c-2fc6-5d69bc7a60f9@kernel.dk>
Date:   Mon, 7 Feb 2022 06:46:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220207105040.2662467-1-usama.arif@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 3:50 AM, Usama Arif wrote:
> This is because ctx->io_ev_fd is rcu_dereference_protected using
> ctx->uring_lock in io_eventfd_unregister. Not locking the function
> resulted in suspicious RCU usage reported by kernel test robot.

I'll fold this in with the change, thanks.

-- 
Jens Axboe

