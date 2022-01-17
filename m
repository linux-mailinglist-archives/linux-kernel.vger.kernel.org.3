Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77766490364
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiAQIDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiAQIDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:03:06 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0651C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:03:05 -0800 (PST)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id AEA36292D68;
        Mon, 17 Jan 2022 09:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1642406584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9w7PulPPLRlTJVcQdu+QnSXqkryxLolbx56eUS2RH8=;
        b=gXOLTME2JjTs3VZRe1vx1jxwIInKgCKw2QbS1oo6f8z5oP8P9ZBKiMn4PALx//0XtDokTe
        aP0lvkoUzoLfCFnfCYGh7ArKp9ahfe2jSeABcCTPpHcQ65uviGkrYHsjvNSa0az+35NPtH
        S87R80QcKqiIn2UrIVI4O2aKcI0JUfKIVQLtbq1CLJsm3Ay2l6VivilTw0CWKvbP4Wqcu8
        uQD12+qwggtjFFd1kltMrkQPzhHdQdpjUabZd8zNYZFe1fIUXScXqiTFZru2rJeHK2Chsm
        XlU3jCinX1R2WAiOV9IkyITQKNkyYol7UNT/nQLKGvu7XMIQ5dRHZl9Yy/5FWw==
Message-ID: <722bbfb582ab948fd994de880e4fa98c49f8bece.camel@svanheule.net>
Subject: Re: [PATCH 2/2] clocksource/drivers: Add Realtek Otto timer driver
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        kernel test robot <lkp@intel.com>
Date:   Mon, 17 Jan 2022 09:03:02 +0100
In-Reply-To: <202201170911.q3u7GptA-lkp@intel.com>
References: <2fb4aa29e8c581f5c7e97ab7678ccb34e99e5c6e.1642369117.git.sander@svanheule.net>
         <202201170911.q3u7GptA-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-17 at 09:28 +0800, kernel test robot wrote:
>    drivers/clocksource/timer-realtek-otto.c: In function 'otto_tc_init':
>    drivers/clocksource/timer-realtek-otto.c:182:16: error: implicit
> declaration of function 'kzalloc'; did you mean 'd_alloc'? [-Werror=implicit-
> function-declaration]
>      182 |         ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
>          |                ^~~~~~~
>          |                d_alloc
> > > drivers/clocksource/timer-realtek-otto.c:182:14: warning: assignment to
> > > 'struct otto_tc_ctrl *' from 'int' makes pointer from integer without a
> > > cast [-Wint-conversion]
>      182 |         ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
>          |              ^
>    drivers/clocksource/timer-realtek-otto.c:212:9: error: implicit declaration
> of function 'kfree' [-Werror=implicit-function-declaration]
>      212 |         kfree(ctrl);
>          |         ^~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +182 drivers/clocksource/timer-realtek-otto.c
> 
>    176  
>    177  static int __init otto_tc_init(struct device_node *node)
>    178  {
>    179          struct otto_tc_ctrl *ctrl;
>    180          int err;
>    181  
>  > 182          ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);

I'll include linux/slab.h in v2.

Best,
Sander
