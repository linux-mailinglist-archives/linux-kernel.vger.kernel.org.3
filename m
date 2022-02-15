Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E2E4B7A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbiBOWU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:20:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiBOWU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:20:28 -0500
X-Greylist: delayed 213 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 14:20:16 PST
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB2460DAE;
        Tue, 15 Feb 2022 14:20:16 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C600CFF803;
        Tue, 15 Feb 2022 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644963615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MY3aADxCC3BL/PohzEu0vsfChXWJVF+cjGEC42SVfc4=;
        b=YOLCaXPdXS5EuBm2Lx8VycDv2Hgn3lxbEU5NvFy3BGXi5f6FdeJOnoqQyXw4t5A0XWu1vo
        LdGKY+D9FHdhBOuAwAK8NYtrg1IMPoodgRU99gwMuXKAqUlwf7YD6UjCDHPxKtJ6bsE7vS
        aZnT7S1nN+eQibzXuoeZGPqnPlMFE5lGxyZSvljgof0bYI51/5LD+6b2ob3M41t6R3GVgS
        QUEGoT9K/fLKgDtLZxQJmaYKWJ7zk+qKBWVRHbIQyuEE2v7gzNLtcLmr61XeU4jSPqAC7+
        +ySe/syr/f6OAX10W4HnmCSbzzVi/OEnfmQmyS5NcnJb/dY5ksYgjoNIce0UGg==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Victor Erminpour <victor.erminpour@oracle.com>,
        a.zummo@towertech.it
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        trivial@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf8523: Fix GCC 12 warning
Date:   Tue, 15 Feb 2022 23:20:14 +0100
Message-Id: <164496360741.65425.10517543967622435540.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <1644453027-886-1-git-send-email-victor.erminpour@oracle.com>
References: <1644453027-886-1-git-send-email-victor.erminpour@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 16:30:27 -0800, Victor Erminpour wrote:
> When building with automatic stack variable initialization, GCC 12
> complains about variables defined outside of switch case statements.
> Move variables outside the switch, which silences warnings:
> 
> ./drivers/rtc/rtc-pcf8523.c:284:20: error: statement will never be executed [-Werror=switch-unreachable]
>   284 |                 u8 mode;
>       |
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf8523: Fix GCC 12 warning
      commit: 85bcb01f145dc32e7f88e6eebb3b5f96d3b56eb6

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
