Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4791A472057
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhLMFSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhLMFSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:18:39 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24289C06173F;
        Sun, 12 Dec 2021 21:18:39 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i12so13920241pfd.6;
        Sun, 12 Dec 2021 21:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j8MT3bkEsh0Hca3gg9PSN0tPxl+LVN6OdoR1We+Kb3E=;
        b=PQevY60HDuUMpqbCUiS8t3/oUgsxrNVbrW4+tFCt4+85ZXpCb1SR7MVuGQsGB3lNuA
         HBfBOd7Q8s/X5ERSKwFrIFOEV8KjHUsyBzswne3IOPGYuAif5criPP4IWV51T0YISJPy
         DULLdz+m+QHjMFZJvQxKbFCZs1PPEG2yMRufc0XDc69JLyDnp1kjBQ6JnkaeQoIWDV6G
         +ib9csT6odujXcVGWE7CeGE8wvWofPkA1uA00wzN3KtYts+7OmX046mXVbInroPNCV2y
         yyvezn+r5wKOMPnNvfU1G3W8/Fnz2QCpAnK8jmEHwL4xDEMamXjQ3ZYqZY4WIEfY4wyP
         JRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j8MT3bkEsh0Hca3gg9PSN0tPxl+LVN6OdoR1We+Kb3E=;
        b=KInB+xyMte9vJU8qUa1+DaObRZyz1mXQTLs1R/dbEzxpmUFK80SrgOwRjYy/qGSCGg
         vfovt4qJDDJUIL25uSs2qWRY0NNVvXy+V3teu6rv7qiRYVoEvRZY7POgHrvkip6ZxArS
         m2CCVJGDd6VsEgu9sAXQUhvZK6vfNxtLS2AW2chzD8AC8jgghtoMCMB5rqPbnHErSbFq
         LGRqXDdfPclrUqqZakVW+PzAbzpLllFO1+nxfNiONk8x5X4K/GbH5Ra+kWT0qauDCWJa
         ucL6KJNsUOdrCTcgQEaRpMmcpxNGcHoscDkQ0SUsy9735EVeUwcym7Fo1eLC9rfOhf2Y
         cJwg==
X-Gm-Message-State: AOAM533yk8Nr7s39GAxUPpg9t2eitidIPkAWN3/Jr2jT8IxECL3f/ZmC
        VgF4CS3fGFKT9rBxVDJNL9hgBbrTrbQ=
X-Google-Smtp-Source: ABdhPJzdoqYNUOW2Ajwunxy/+OPhMyJySyHhdWbsKjUsdKNZspShXhE0ez4Im8fwy+lJtIy4qWcfPQ==
X-Received: by 2002:a63:8f09:: with SMTP id n9mr35034018pgd.38.1639372718566;
        Sun, 12 Dec 2021 21:18:38 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e537:8856:7d40:7c6])
        by smtp.gmail.com with ESMTPSA id f10sm5529250pjm.52.2021.12.12.21.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 21:18:37 -0800 (PST)
Date:   Sun, 12 Dec 2021 21:18:34 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>,
        Felipe Balbi <balbi@ti.com>, Rachna Patil <rachna@ti.com>,
        Wolfram Sang <wsa@kernel.org>, linux-input@vger.kernel.org,
        Jeff Lance <j-lance1@ti.com>,
        Zubair Lutfullah <zubair.lutfullah@gmail.com>,
        Vignesh R <vigneshr@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Brad Griffis <bgriffis@ti.com>
Subject: Re: [RESEND PATCH 0/3] input: touchscreen: am335x: fix and
 improvements
Message-ID: <YbbXqhSzeOwX3vUn@google.com>
References: <20211212125358.14416-1-dariobin@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212125358.14416-1-dariobin@libero.it>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 01:53:55PM +0100, Dario Binacchi wrote:
> 
> This series grew out of a touchscreen validation activity on a custom
> board. Oscilloscope measurements and driver source analysis led to these
> patches.
> 
> 
> Dario Binacchi (3):
>   input: ti_am335x_tsc: set ADCREFM for X configuration
>   input: ti_am335x_tsc: fix STEPCONFIG setup for Z2
>   input: ti_am335x_tsc: lower the X and Y sampling time
> 
>  drivers/input/touchscreen/ti_am335x_tsc.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Applied the lot, thank you.

-- 
Dmitry
