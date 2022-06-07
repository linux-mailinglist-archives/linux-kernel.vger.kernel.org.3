Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E785424FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392335AbiFHAwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455626AbiFGXSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:18:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFF715436E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:20:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z17so16585946pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xACJxgm2NxMfJ63TOgMaf2wsYKKZyKH+sYO/uMTxdV8=;
        b=cnhjNgeiucBtliMvRGjPQ9KBtpnKxEuHm7F7qoURydmKKos1SsNd6oNPqrre0KQyd0
         oJtgjEwR59smODLPbgRC8GsBqT+lNY2j1sg7fNriXcw+ndQFHZsEQXiEkqNs78fush4R
         eMhMJ+LFjwo3VEdi1oew1qnd+vP2Us70VbhEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xACJxgm2NxMfJ63TOgMaf2wsYKKZyKH+sYO/uMTxdV8=;
        b=2097xf7/bIE0G2RpIqAx1+qZYsJR7vUZOrMkDhaMmK+9DQevPynw1L2Gium8jfSsUv
         eiHkt2D4lniUwS8MCBMlhWAU+INCUR5DNbzAAOhwVKYVSgidgpoeuJuadNOC+CovIkoY
         hBNE+k3y540CiwiPbINq9CpcxQq9qB5S4fwoLdMnLWyeNdBxERHTxPJyvWPGMcxx3Gmv
         4IYbKHfEk6Tp2hEcVN7DudD8kMy6ZQprq8qwkZXEPPxh3wFCPQUjhQ1yPE6MquwC8CTo
         3sbClLa0dzpWCJpNTqNIVkb1Zl8zxz2e1F/xycZDTqd09T2zc/nWR5/PyO81xVX8KJ93
         tgyA==
X-Gm-Message-State: AOAM530ac82dQ0V52zZs0HpYWK38cnnXpEZDS14R/221y2WNX8oH4TTK
        LYupOPejeQzNjSowMO7gsQ9jGg==
X-Google-Smtp-Source: ABdhPJz1N83MQjqoGWeUnm89J+Kb2P8aSo8x/0iIX66k35MM5DbderyK0bdkWVMnhV9Pr3faH31mxQ==
X-Received: by 2002:a62:6144:0:b0:51b:99a7:5164 with SMTP id v65-20020a626144000000b0051b99a75164mr31011021pfb.61.1654636853838;
        Tue, 07 Jun 2022 14:20:53 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:b689:cc5b:e6ad:930e])
        by smtp.gmail.com with ESMTPSA id je21-20020a170903265500b00163b02822bdsm12916329plb.160.2022.06.07.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:20:53 -0700 (PDT)
Date:   Tue, 7 Jun 2022 14:20:51 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.17 404/772] media: rkvdec: Stop overclocking the decoder
Message-ID: <Yp/BMw3niNfLjBVI@google.com>
References: <20220607164948.980838585@linuxfoundation.org>
 <20220607165000.914511779@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607165000.914511779@linuxfoundation.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 07, 2022 at 06:59:56PM +0200, Greg Kroah-Hartman wrote:
> From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> 
> [ Upstream commit 9998943f6dfc5d5472bfab2e38527fb6ba5e9da7 ]
> 
> While this overclock hack seems to work on some implementations
> (some ChromeBooks, RockPi4) it also causes instability on other
> implementations (notably LibreComputer Renegade, but there were more
> reports in the LibreELEC project, where this has been removed). While
> performance is indeed affected (tested with GStreamer), 4K playback
> still works as long as you don't operate in lock step and keep at
> least 1 frame ahead of time in the decode queue.
> 
> After discussion with ChromeOS members, it would seem that their
> implementation indeed used to synchronously decode each frame, so
> this hack was simply compensating for their code being less
> efficient. In my opinion, this hack should not have been included
> upstream.
> 
> Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

FWIW, I've noticed a problem that is uncovered by this patch, because
the default clock rate is not currently acceptable all the time. See my
fix here:

https://lore.kernel.org/all/20220607141535.1.Idafe043ffc94756a69426ec68872db0645c5d6e2@changeid/
[PATCH] arm64: dts: rockchip: Assign RK3399 VDU clock rate

It might be nice if $subject patch could be delayed until the fix is in
too. The 5.19 cycle is only in -rc1, after all.

(The same seems to apply for the 5.{18,15,10}.y series too.)

Brian
