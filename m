Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186834AE7AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbiBIDCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351596AbiBICtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:49:40 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67918C0401C1;
        Tue,  8 Feb 2022 18:43:50 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so892494oor.12;
        Tue, 08 Feb 2022 18:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8UkTgHS+mgwp4w2JOUl++8XSEMif+O0IMskLaUahjeo=;
        b=49Jm8VdmV2FRHV6KX/A1D8RjhIMsEARm0HZ9kMd3znKMivfENolDH/TZQaScUczN4A
         TBefSjWzmFwUXz3+5ub/XZqmW90K1hsrmPxpcZSQ4JEaSjV+c6STuNkgJAQhrPGm0wV+
         upmYAgbowX/rlhnTXc6RGXHEL7NqK6G05RiNYbbGssKY/Ke2/U/LmzQDO/ksbl2xVqHF
         Lgkb5o4zvXSMGuDYPaGPW2LFNWStZmWn9UZcd8QsCzcHgjlDoJQg+mIZOJ2Dweu080uq
         DaUdni1xIryNzH3FPMo53C99jAFRAoFA3RnvsLGN8lGQeNjwq/ITOeGe+vaPl8TDW+Kd
         cvXQ==
X-Gm-Message-State: AOAM533aWRmUy+i7xFQLWxoqeTaNgiWAv+637WLyZEAXw4uvSW2bHu6Q
        R6TGg9CrzthqucJUt1VVbuj+L1vm8A==
X-Google-Smtp-Source: ABdhPJwWrE9A5vBbeCZNjyS81I2QJrp+p1XO4NAPxKOqEzsyDqVdsnvrjzvn1Y2Eo1ZsR/2i6baE+w==
X-Received: by 2002:a05:6870:73c3:: with SMTP id a3mr260715oan.293.1644374615894;
        Tue, 08 Feb 2022 18:43:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t22sm6382076oiw.2.2022.02.08.18.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:43:34 -0800 (PST)
Received: (nullmailer pid 3510501 invoked by uid 1000);
        Wed, 09 Feb 2022 02:43:34 -0000
Date:   Tue, 8 Feb 2022 20:43:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: ab8500: Rewrite bindings in YAML
Message-ID: <YgMqVqS9MWmq++GI@robh.at.kernel.org>
References: <20220115002649.1526163-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115002649.1526163-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 01:26:49 +0100, Linus Walleij wrote:
> This rewrites the former text based AB8500 bindings in YAML.
> 
> When the AB8500 bindings were first written (in 2012) we
> were not strict on some things and node names were definitely
> not standardized.
> 
> This patch uses standard node names to most of the subnodes
> on the AB8500 and is accompanied by another patch fixing
> all the DTS files to conform to this.
> 
> The bindings are not as perfect as newly written bindings
> would be, it is a best effort to deal with the legacy.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/mfd/ab8500.txt        | 282 ----------
>  .../bindings/mfd/stericsson,ab8500.yaml       | 500 ++++++++++++++++++
>  .../bindings/mfd/stericsson,db8500-prcmu.yaml |   1 +
>  3 files changed, 501 insertions(+), 282 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/ab8500.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
