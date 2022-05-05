Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E78D51B7AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 07:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbiEEGCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiEEGCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:02:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E0E2A714
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 22:59:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i17so3447883pla.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 22:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DJlbRmp6+3Ku7mZOSBpo5voOk3dmYpbja2k2cr+R+hY=;
        b=tVLblT2IAPVjFE0z8Er5xu6f00OzfK348X08u09cUXVLZlbXnuyhz3xL2Z6jOjcKPM
         Kx32OSLPEZH04abZ1RiAOIKklKaLeJYttPXfWGOuOVo9J4MrGMO4kVya75eo3ghwsn/I
         bkbQZHiN+M0K54v0ORt3nktwhHBTas+82T4z3dt6eSljRpRuzLhjU3+PuaJ3QdUJB2rf
         L/RabagKv/hVve7Htn8i6KmbbQ1Vrj2/qYSYBtJpxqAniqfwbjXctylEoP8dlYT6A3gD
         90Dj6FgPGZUf1byXGr8Zx0csGmPf5wLZIfdRjRBATQLeGY6V6TuGc5NfsOvAju0NtWEP
         D/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DJlbRmp6+3Ku7mZOSBpo5voOk3dmYpbja2k2cr+R+hY=;
        b=kW5WWWySgBm8ut8/Xil69KT8DEebWok4y907tv58ZOCO+ZW3DqS3gSc4qVPr7xy83L
         7O+NVtXKmRuO+gu929QhgHf8DTlJ6xgSbQjmI6p+kPMJ3xE/aj7INA04Ho/+KaaQmqH/
         BIPfre5sy66++IHlI0dpCpDlwQTZqtYXFLvjjju1ZYd5Rlc2NmKe+CJGClRGExfOtcWQ
         fMNyvqfb/AS9z8tooCKuwkml1ILD1JQBa9yFes6dReF3yWX9bYmZfR38C0DrAte49cjP
         plhvd6HfNGxJ8FPs5JwQgJzENsB+DDGJsKRQlnsmM4Fa5yugSTKDcmu6RL8EJRySWflK
         5kCA==
X-Gm-Message-State: AOAM532NPZv+h+Ex1js6wUv1fduUfMSYICtuKrU27sbyg3oq9zMVi0lG
        1KuriIv8d1xLx0rMm8uDCOQO0g==
X-Google-Smtp-Source: ABdhPJxb1nYrZgSZdrfyVf9Y3y11nFVIdrhWSc2+Xb/EcWZpTgHkBthrb4gT1LYE01+hvy8iNmyZlw==
X-Received: by 2002:a17:902:ab59:b0:15c:f4f3:7e3b with SMTP id ij25-20020a170902ab5900b0015cf4f37e3bmr26151107plb.24.1651730340773;
        Wed, 04 May 2022 22:59:00 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id x34-20020a056a000be200b005106b52a823sm86038pfu.145.2022.05.04.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 22:58:59 -0700 (PDT)
Date:   Thu, 5 May 2022 11:28:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-pm@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] opp: add config option for debug
Message-ID: <20220505055857.bqjm72qkzwcbuvuh@vireshk-i7>
References: <20220504174823.156709-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504174823.156709-1-linux@fw-web.de>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-22, 19:48, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Currently OPP debug is enabled by DEBUG_DRIVER option. This is generic
> driver debug and opp floods serial console. This is annoying if opp is
> not needed so give it an additional config-key.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/base/Kconfig | 1 +
>  drivers/opp/Kconfig  | 7 +++++++
>  drivers/opp/Makefile | 2 +-
>  3 files changed, 9 insertions(+), 1 deletion(-)

Isn't something like Dynamic Debug helpful here ?

-- 
viresh
