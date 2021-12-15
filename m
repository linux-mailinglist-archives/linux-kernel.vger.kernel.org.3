Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DFE476654
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhLOXH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhLOXH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:07:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983AEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:07:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so17037149wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCnHcoZ/R6aBaHpWmv36zx8620aXgQgPQkDtHIQ1DHA=;
        b=FUdi+s/28RzQC5rEbXov+Wj7ZfBamUGXR3MkfXiwYqzbKUKaWeNPk7vfXzOuP05QkL
         f7WV6H9XI/BSp8jradCwYWfGH+BM7kDpH3wfo3Mf5MTcTwPE5rxhlnIvf2kpQ5wouQgi
         e/1fgD0x5kalDXDfZKJi/Kb6/jL9tqv0s6y4tX6c5eWLlcMKMhnj5QlZaJ0rna/FE+Pf
         GpRXkZZCFp43IykmLwmi7c/orrPeVMQKLKzPSN4yMRCdf9sUx1tS45wuWsPcHhS/M6uP
         xi6OnfzF5lMcfl4Nu2ymWUdfo52A7OhaEk88F53mKRp1KqAoSgwhbB0Xsi+S+smTtfRT
         EKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCnHcoZ/R6aBaHpWmv36zx8620aXgQgPQkDtHIQ1DHA=;
        b=0pZjtdLNIIJQTt0FRerhLn/bTic+PHkrg3fzbYoavcpoA8866H2pDZ7p+ODmmxQfdl
         lI///ly8+U1DkRdxEiuhlOOeUkLzV1KmLe/VeKnTDMnEs5OaG7tbMCIIUj/SDdqpYxae
         q+8yf2rhS8KfqM6QbpSLAheqb9QKeATlK+oMpjvZ1Kv2wrG9q3veyxSDor6THEhf0FL5
         y9jqRp/dY8jbKWUPECZqJ0bMYGdn9sdewirwH8e0cPHG/cGPuK03WhoIrDyJL4FZqC6Y
         wCp/TdLNPoBGaKJHPjVDpQ221E0tG+EK/gsCjANppicmazcFH6+nlkTjvl2qD0bnJNgL
         WJbQ==
X-Gm-Message-State: AOAM532H4xygQ/+u36b/CG7+ObFb7t4nVsAupcoY/hP1lvYrhvdWCTEX
        bdDFmKLlMtzDbcIP47WUXe4=
X-Google-Smtp-Source: ABdhPJwgAJVU2co2FgMZfqw1L9nyV5xZ+wvhSyo4RLTTJengtVJ2KmdOCgHb9S2AhAXiqMTOKyd8gA==
X-Received: by 2002:a05:600c:a06:: with SMTP id z6mr2294235wmp.9.1639609647267;
        Wed, 15 Dec 2021 15:07:27 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id p22sm2745595wms.22.2021.12.15.15.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:07:26 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>
Subject: Re: [PATCH 1/2] mfd: rk808: add reboot support to rk808 pmic
Date:   Thu, 16 Dec 2021 00:07:25 +0100
Message-ID: <1933509.XRPO5POFnR@archbook>
In-Reply-To: <20211215213300.4778-2-linux@fw-web.de>
References: <20211215213300.4778-1-linux@fw-web.de> <20211215213300.4778-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 15. Dezember 2021 22:32:59 CET Frank Wunderlich wrote:
> From: Peter Geis <pgwipeout@gmail.com>
> 
> This adds reboot support to the rk808 pmic. This only enables if the
> rockchip,system-power-controller flag is set.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  drivers/mfd/rk808.c       | 48 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rk808.h |  2 ++
>  2 files changed, 50 insertions(+)
> 

Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Tested with a RK817, using a Quartz64 Model A with the patch applied
on top of v5.16-rc5. Poweroff works, reboot works.


