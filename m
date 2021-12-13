Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26364735F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbhLMUbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242877AbhLMUbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:31:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60714C061574;
        Mon, 13 Dec 2021 12:31:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8DE5CE0490;
        Mon, 13 Dec 2021 20:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF5EC34602;
        Mon, 13 Dec 2021 20:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639427478;
        bh=MNdS5hyPDD0bAGr4MACAsVJM/Ty9WT0jtvG22IWqqgI=;
        h=From:To:Cc:Subject:Date:From;
        b=epQB4ikCAyZWDY4Net45PfsB6L/kt0UuNX3B08eR5xx3Rpn0c60VXwTn/Dtg4Z7WP
         YLPXuC9kAhIncE9kjcftjliBldq8ZEATDQU9TjnLQrKwUfjRlI8rFOlcFRkz/hBj/D
         IACPkKuHPYcjvwqtmRtE7mHycybXlPxiGuI9zlxwI8cBU0rKit9nvJytvxAp31Yyx1
         jdOPL7hS0c1YxHuy/YBGJJE1aaP1k5XxTW9tXD1/teYUcww7XbE9HZ22Z1fJsJsXyk
         JXTODrUP77VT2g0A4VTS1wW+YKAPBCDNJNOUntDdCxR7oh5N4Aof/i0nt+umGs6Uod
         WZfIDL+LhVvpQ==
From:   broonie@kernel.org
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Subject: linux-next: build failure after merge of the gpio-brgl tree
Date:   Mon, 13 Dec 2021 20:31:12 +0000
Message-Id: <20211213203112.969238-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the gpio-brgl tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/tmp/next/build/drivers/gpio/gpio-bcm-kona.c:508:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
  508 | static const struct of_device_id const bcm_kona_gpio_of_match[] = {
      |                                  ^~~~~
cc1: all warnings being treated as errors

Caused by commit

  19784a059cf47b ("gpio: bcm-kona: add const to of_device_id")

I used the tree from yesterday instead.
