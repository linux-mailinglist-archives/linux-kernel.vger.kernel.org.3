Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585CC54329D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbiFHOck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241427AbiFHOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:32:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C75222A52
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:32:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so11202577wmz.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mHZcc87752dCD5EakMLSwQMgSNKMbCnC16gyyFD++5I=;
        b=iRZ0wVla5u9zp0SUCSyUiAxjH9RAE3J3FBcCkxHdsTvZIAvAoIiTfT3tGOS1jmquHP
         Enoc55DWAOCNnBOHOmwCwtXBbjlfVIHI6d3yv8fr49HgEeyDerdVlFc0Z06gG6D9H2Zc
         ynOKMPLCV8XcC63V2GeH92kmwKS4cmctokNnA27r/B7x0K8MVdJDWThBTADofYW2KKUa
         TxgX4BUGEdEdWdUi38Bw7CeqWaY27VL6grEHQPI5VPySkrXILGpvdxV0CJQlRePRGivJ
         +nc2kRpn2YpwEzoG93IWD2tGyGJzfgXAni+5vvNxb3gXzfbLcKH6SCQSOXtZzcUMxV7T
         u7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHZcc87752dCD5EakMLSwQMgSNKMbCnC16gyyFD++5I=;
        b=Ub4Uf5B16LA4FXfuFozyXoTZvUynnq9EjxzNR5W/E0H+eoN05A+6WVlIrco5W3U42q
         I9LG49vscnaDSTSxZ2v9iiAk+AYJOYYKUMA+/F8F/J+cnW7CJp0un3Ia0b6iWAOWljdf
         PcENVbT3HPlkEsfZQehq/odfi9D/rgTR1AlOwK/xtfL55c6QwGxB2qQ8LJ7XgBVR3IGK
         h597Yi1DzWvzQwFZWWpcAvpt+H7pzUYFEGGgsdvUT7h98FhQEc/U04f8xiJgFj5zRi0g
         vW2ILcu9RZ4kHvainQDL80PpaXb+X5wAxI3OvK8EmjbN/JyYcvgghFgdzaYxKd9S1sWb
         S+7Q==
X-Gm-Message-State: AOAM532yGEll3ywLSwUSudQ85Ea+ZoSM8CiENm/zWUdWz44bqYNlgYKz
        W7jutD71QCKs4R9S2IsLBfSzwUEDIvyBhRWO
X-Google-Smtp-Source: ABdhPJwXEQ4i7ZpLaMkGxRTUYH9S/yoGBN8D+OBla3n/ONr6sTpO9FmexKwaO58/OLLltjA4Tnbt+Q==
X-Received: by 2002:a05:600c:3b2a:b0:397:3e63:3db8 with SMTP id m42-20020a05600c3b2a00b003973e633db8mr62698557wms.40.1654698755974;
        Wed, 08 Jun 2022 07:32:35 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d4b8c000000b0020feb9c44c2sm21540231wrt.20.2022.06.08.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:32:35 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:32:33 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] backlight: aat2870: Use backlight helper
Message-ID: <20220608143233.l5pbopafqc4n6uwq@maple.lan>
References: <20220607190925.1134737-1-steve@sk2.org>
 <20220607190925.1134737-2-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190925.1134737-2-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:09:22PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
