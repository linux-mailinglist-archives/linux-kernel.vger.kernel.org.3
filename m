Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A275045A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 00:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiDPWYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 18:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiDPWYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 18:24:23 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C919030
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650147707; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/WEy9igLdMF6qXHZ2Fu05qwd1kA31Bd9CuNUZh2kOA=;
        b=D6u9xReUm4GM9kw5rMxGs2ezpzAEIk90Li/60w5xPTaOquVxS1ZHIBuE+16ohgASdF+ZLH
        LbeN5P6T8LFemxN2dzREfB3hBq20bLwm/QnkI5IpkfpTWuWNWmb4RRQ4dtUT7weApqN5zf
        N+0Uu23laIyhyki9BSMILsbVWdUhlXk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     paul.kocialkowski@bootlin.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        jagan@amarulasolutions.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, thomas.petazzoni@bootlin.com,
        tzimmermann@suse.de
Subject: Re: [PATCH v3] drm: of: Properly try all possible cases for bridge/panel detection
Date:   Sat, 16 Apr 2022 23:21:41 +0100
Message-Id: <20220416222141.72321-1-paul@crapouillou.net>
In-Reply-To: <20220329132732.628474-1-paul.kocialkowski@bootlin.com>
References: <20220329132732.628474-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

This patch breaks the ingenic-drm driver.

It calls drm_of_find_panel_or_bridge(np, 0, i, ...) starting for i=0, until
-ENODEV is returned, which does not happen anymore.

The idea is to probe all the connected panels/bridges, should it be done
differently now?

Cheers,
-Paul
