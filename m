Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABD14D2337
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350318AbiCHVWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiCHVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:22:08 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920094C791;
        Tue,  8 Mar 2022 13:21:09 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AAAE760002;
        Tue,  8 Mar 2022 21:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646774468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7AoCPZjX8EcXcmu8+pXmdmkFDbCvm0vHt0f5l1KUJE=;
        b=EfDvoJU4KgnmtozSgKvLajcx77V1MmRGLq+Lp993CBYaxypHAapvgIPojbiXMf5kd9wFwy
        1dp9zItaWM3zaHQh2OkVBwX8mBnR6WMZgsk8ju1QUNe7sVqWEoB0Qsv/E8eHpfpP6nG7ZH
        a5q0KQrNQvRwAKOpLpVNE2mG5kdZMIRLK3QdwUsfSPNBrJkFvPE8sDWb0Xa54SdWLZxD+/
        edkASdwKhi2YCqq/jB56/zbrqgct1hJVGYNcJkxpG6LSuposnbJRxu3HFDzHxS8ZNgNdie
        fHzGnmRmOL0bhBjeWHIh4aCe7CXssjsWRtOsIeRAVwhaJiPSwpry1jGzifpc8w==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Ondrej Jirman <megous@megous.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: (subset) [PATCH v10 03/18] rtc: sun6i: Fix time overflow handling
Date:   Tue,  8 Mar 2022 22:21:05 +0100
Message-Id: <164677445867.88674.16740426287923298243.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211122643.1343315-4-andre.przywara@arm.com>
References: <20220211122643.1343315-1-andre.przywara@arm.com> <20220211122643.1343315-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 12:26:28 +0000, Andre Przywara wrote:
> Using "unsigned long" for UNIX timestamps is never a good idea, and
> comparing the value of such a variable against U32_MAX does not do
> anything useful on 32-bit systems.
> 
> Use the proper time64_t type when dealing with timestamps, and avoid
> cutting down the time range unnecessarily. This also fixes the flawed
> check for the alarm time being too far into the future.
> 
> [...]

Applied, thanks!

[03/18] rtc: sun6i: Fix time overflow handling
        commit: 25c9815569cefd4f719c6c1266fe897e57642278

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
