Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC058DB2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiHIPeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiHIPeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:34:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E310FFC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:34:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l22so14744950wrz.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Qocc64Wb5/O8/orgwNBw6Vi4FkCmBNARdItSYBBLDN8=;
        b=XazVcvTGujYrw69IcTk0y7Fp1Wlu6Arm+7Uqsi3T0aawniRbiW0DoCAn164ru1H8Xv
         j0jEb7R/rRrNObgY7h84BTn0O80m+HTmxB6u8y4xliQ0HEjkehtbA7agrtUd9SmEyKts
         CVl5SMbpfGt/1KTFfis4Koa8x97PvVJaP+BgRo5pn3UpH4msUMIUHZ6IOw09/a/nqqpz
         MY2F4pu65PMqbAEw5Dw1EE6dsH163SRnTn0pUp87LJqPuoqRsLk9GW/ZvyumInMCOjHE
         UfuPNawkIz1cqKu7JoVRSZt6zb8KwPiE4yz7Qox8eW2yvs5p480LSVgs+ZwnWdsNF/2w
         NlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Qocc64Wb5/O8/orgwNBw6Vi4FkCmBNARdItSYBBLDN8=;
        b=bvnS5VEj/1OE4wKdwV/DhSTE228Ei6KRbvBMOZT75BCk0jIn+3jF1OmOHvZhFABujV
         Z8FGhn58EYJ45/GfaARP8nYBo6+BOLsw1W7Ny9hG0QHL8RWogfBp9GImxO/CFB0mAzWa
         qmP5yyqdIzlhooYYvgzqYDEcnYncEA76uIYoLdvTKSCZGUJNU2FuPF8c2qlbfWlYRNP0
         JCd09XnT8VDe4yNBkNw/iMAXF2P6TtbaG5xtdIkR+u5+SB4jT5AdcyUivodRoBRp6+JX
         04OPdZ1GTTOtkBfcN9XGQZ0jfDEWxP8jHMHNaelZ+hA7wKsyEIdT8DbPubQE2P3hErM0
         pEKA==
X-Gm-Message-State: ACgBeo0V5hlr6kE7JRRKakEZ73XKt5homBWpace6PWpKdj+X5l0FSccl
        YNo5+Gmcbyf5KkiIb1qvplteQoWr0OH/Og==
X-Google-Smtp-Source: AA6agR4iubbuMFbilh/betNJVGxs80lnm0wdSvpuXbctRYbzkpTm0+peYz/pbQqd7ZcxX995aTp54A==
X-Received: by 2002:a5d:5f06:0:b0:220:5a9b:578f with SMTP id cl6-20020a5d5f06000000b002205a9b578fmr13788873wrb.545.1660059237960;
        Tue, 09 Aug 2022 08:33:57 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b0021d6a520ce9sm13809467wrj.47.2022.08.09.08.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 08:33:54 -0700 (PDT)
Date:   Tue, 9 Aug 2022 16:33:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 13/28] mfd: sec: Remove #ifdef guards for PM related
 functions
Message-ID: <YvJ+YPAynhFKj5DR@google.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-14-paul@crapouillou.net>
 <a625a1b4-6ecd-79d9-3d13-f42fd5b8275c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a625a1b4-6ecd-79d9-3d13-f42fd5b8275c@linaro.org>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Aug 2022, Krzysztof Kozlowski wrote:

> On 07/08/2022 17:52, Paul Cercueil wrote:
> > Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
> > to handle the .suspend/.resume callbacks.
> > 
> > These macros allow the suspend and resume functions to be automatically
> > dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> > to use #ifdef guards.
> > 
> > The advantage is then that these functions are now always compiled
> > independently of any Kconfig option, and thanks to that bugs and
> > regressions are easier to catch.
> > 
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> The address does not work. Please don't add it to commit log.
> 
> > Cc: linux-samsung-soc@vger.kernel.org
> 
> This is also not really needed in commit log... it's just a mailing list...
> 
> I actually never understood why people want to add to commit log, so to
> something which will last 10 years, Cc-ing other folks, instead of
> adding such tags after '---'. Imagine 10 years from now:
> 
> 1. What's the point to be cced on this patch after 10 years instead of
> using maintainers file (the one in 10 years)? Why Cc-ing me in 10 years?
> If I am a maintainer of this driver in that time, I will be C-ced based
> on maintainers file. If I am not a maintainer in 10 years, why the heck
> cc-ing me based on some 10-year old commit? Just because I was a
> maintainer once, like 10 years ago?

Why would that happen?

These tags are only used during initial submission.

> 2. Or why cc-ing such people when backporting to stable?

That doesn't happen either.

> It's quite a lot of unnecessary emails which many of us won't actually
> handle later...
> 
> I sincerely admit I was once also adding such Cc-tags. But that time my
> employer was counting lines-of-patch (including commit log)... crazy, right?

Nothing wrong with adding these tags IMHO.  It's what they're for.

I use them when I'm maintaining a large amount of out-of-tree, but
to-be-upstreamed patches over several versions.  Re-applying the
recipients list can become pretty labour-some after several
iterations.

Adding them under the '---' doesn't work when the purpose of them is
to keep the recipients list in Git history.

-- 
DEPRECATED: Please use lee@kernel.org
