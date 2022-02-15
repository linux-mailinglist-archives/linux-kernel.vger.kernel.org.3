Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0B4B7A82
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiBOWgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:36:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBOWgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:36:11 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C6DF4BA;
        Tue, 15 Feb 2022 14:36:00 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 82844FF805;
        Tue, 15 Feb 2022 22:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644964558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBalxrzov6e2o+ggkJX3OhifLZtzYDKI+iOG8iH+4r8=;
        b=FlJAN/ZwqQb5nCjZP4a01Z71873HDIe0OvqJNQ1P9977sj2UI8LjQ5IHD9M+lcGqKaXtAh
        in77fdQxK66rxQtAeTWFqqrcUnJE3kILPlV1ks+KSDyVRKPS3BqEPazIFffQXCk4WBbIfI
        nLifuUKP6stDCXuwOBtguuGwRaFn6IQSMTG8L9b/852mRQb1RC/A3SFCvcJLdwrVm9snKC
        5UWTGn6VF5lTvwux0btBrxmZj281twzK0dQ9nkIFHrjzP9g3pZQZVI5QSQCU7Od9YXQGt6
        qPGqHPzp4NKza0WgP9cOhE4Tn6dnFzWAUywwkKViqmhjH7YDDCRssyUt5snVzQ==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf2127: fix bug when reading alarm registers
Date:   Tue, 15 Feb 2022 23:35:57 +0100
Message-Id: <164496455010.67358.12781580107745972027.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208162908.3182581-1-hugo@hugovil.com>
References: <20220208162908.3182581-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 11:29:07 -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The first bug is that reading the 5 alarm registers results in a read
> operation of 20 bytes. The reason is because the destination buffer is
> defined as an array of "unsigned int", and we use the sizeof()
> operator on this array to define the bulk read count.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf2127: fix bug when reading alarm registers
      commit: 73ce05302007eece23a6acb7dc124c92a2209087

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
