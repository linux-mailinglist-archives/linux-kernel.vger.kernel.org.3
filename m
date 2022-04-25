Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223250D822
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbiDYEMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiDYELT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:11:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D2A2B1B9;
        Sun, 24 Apr 2022 21:07:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d15so24209241pll.10;
        Sun, 24 Apr 2022 21:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TMIuF0We9zcIngU+b/yDWhTup1CGDWMUPgiHK4ayFFM=;
        b=JsKvZlmSjcirO852+grZpjekXVXek3nLbPvO5/IdHb3yKksMgpGAFUz47G9rA2lDro
         zpdIbgY9LIMNHj1+I3qZOX57eErFMsdznqD3+4qFq508SsCK7a3su+GvM71fzVB+YmgA
         SFrWzXLYP6UgKfcv0T4vfB+fl4VETU+n1NjWQD9sXu1iKdAFbEuU4iAQe7gmFp5/n2n5
         fifl4KH/siwe8YBVav3FZrt2RW2pG1cB+Cu+TvPoARxEnsx+Wsuh+VDiag5IpQD5b0dy
         6Aw7RiC/LfwHkwHYycVLBtyYPIqSsHC/7NspM9oMFbWtUhmH8serECmIjRqz47NGlOtD
         uu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TMIuF0We9zcIngU+b/yDWhTup1CGDWMUPgiHK4ayFFM=;
        b=uA/va8ujhElg/xea5dDrhOqPTlopuDYeys2gSgZvv6UR0v7kNApzFozBk7OidJkWVZ
         xKN676yYyAKWC2n+qZNNWCbC9+dTaw1QwvqhdCjiQ82p1mVKeAqwrCng12IFvX/nvo3h
         G6hrjvaQAsrMcv9zvbbGzeVN0rk6UeZfyx0bZYJe1+CGL/judogYbRbU7q/rSdTwewkB
         tMM4u19xYLb8l2Locb8vnz6A+ah9lJdzlax19m5CfbQJfPTiPFsc1hiyy9DZIylR8SRq
         QAv0whmlSg9UNP5aCAPnF3+gm7wEb128a1OCaL4WzKqrHZX1ho9IuAz1a/H8z39r4pUT
         mb4A==
X-Gm-Message-State: AOAM533lmgELjbu753LhZ7K7qU+s7LXm4444t6UpBagrNYPJc7fbnoFK
        InuqLr5t0NQf1tjpwsNh+0Q=
X-Google-Smtp-Source: ABdhPJyvw/bGt3qTVySgeKahYdCa2zDFc0dpbfh/kCEeIWJXe4jk3O/fefnFJkaAr6MLEGFpNdQvZg==
X-Received: by 2002:a17:902:b612:b0:158:8455:479e with SMTP id b18-20020a170902b61200b001588455479emr16715776pls.59.1650859649173;
        Sun, 24 Apr 2022 21:07:29 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id k15-20020a63ab4f000000b00381eef69bfbsm8083069pgp.3.2022.04.24.21.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 21:07:28 -0700 (PDT)
Date:   Sun, 24 Apr 2022 21:07:25 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     corbet@lwn.net, sre@kernel.org, robh+dt@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>
Subject: Re: [PATCH v6 4/5] input: misc: pm8941-pwrkey: add software key
 press debouncing support
Message-ID: <YmYefY/Rkpu/nB4D@google.com>
References: <20220422191239.6271-1-quic_amelende@quicinc.com>
 <20220422191239.6271-5-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422191239.6271-5-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:12:42PM -0700, Anjelique Melendez wrote:
> From: David Collins <collinsd@codeaurora.org>
> 
> On certain PMICs, an unexpected assertion of KPDPWR_DEB (the
> positive logic hardware debounced power key signal) may be seen
> during the falling edge of KPDPWR_N (i.e. a power key press) when
> it occurs close to the rising edge of SLEEP_CLK.  This then
> triggers a spurious KPDPWR interrupt.
> 
> Handle this issue by adding software debouncing support to ignore
> key events that occur within the hardware debounce delay after the
> most recent key release event.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>

Applied, thank you.

-- 
Dmitry
