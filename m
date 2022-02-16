Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BDE4B927D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiBPUfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:35:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiBPUfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:35:13 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C22AE729
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:34:57 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w20so2870177plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TPYAVPLt3DSLrT5QHqLW9+lhJ1UDrylzHFt/SATA1Sw=;
        b=LXQuXooAbkgrzg+wzZD+VJ5ySuEv+VaIy4DsRfyqOkZHFBYZ+S7TDPHn7/hJm3FIm9
         mab9/ZhAuAy2+Zaawh/1HDRYHfckDHKEuCSQVBNTp3S6NWQKkEk+LnbShf5plOeeQJWD
         AeMW0rE6Mwun1joleXH2QYA6lN2WC+b8R/HiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TPYAVPLt3DSLrT5QHqLW9+lhJ1UDrylzHFt/SATA1Sw=;
        b=26m5RiMqLbobuk+/tDvr8LTxr5nzTyZu8JKsEyQychgaL+zMFGX9roA0rlhWoCkqWa
         Aa+ppDmQ+ur5aIRer3+niJxckyO7H3M9UGOKFoKZCjusxoGBqPc505oYu9OFrXVWjDKz
         6Ps5s4txs9rms5K4WHJZOLf9RKZAoN723pQmux/qGC93m/mTuapgvczsznI0KgtOUlo5
         0m4klBXxyDjkQdc/jLJVTra8bDAZ8UslwbHjMaoRpX1Wd3jAverPpChxcrgQXj8hGajn
         FJz6G83w2xx2VPUynmEQfT9Vi3xrnq+SFc95Kv91+mPmYpzyk/9jo+4PKE623WYvFpwB
         WopQ==
X-Gm-Message-State: AOAM533+7r+Yv1SxOsIF7AO80XGsE9mbVKCooNfdbQk8ReaM0RGrc21G
        xX9QEhlJWeCAtTsLdFHNcO4w7Q==
X-Google-Smtp-Source: ABdhPJxw5m6xEEf4zWFTXNmj0NNXcyrU2pH1NzSQVfQfjbPkoDN5tg30lfInuAbeSYuFZgQiiXlTBA==
X-Received: by 2002:a17:903:22d0:b0:14d:7bba:3746 with SMTP id y16-20020a17090322d000b0014d7bba3746mr563276plg.155.1645043696869;
        Wed, 16 Feb 2022 12:34:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b11sm18369885pfl.123.2022.02.16.12.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:34:56 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:34:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] carl9170: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202161234.15553997BA@keescook>
References: <20220216194955.GA904126@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216194955.GA904126@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:49:55PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
