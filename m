Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2D547D393
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245755AbhLVOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbhLVOUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:20:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC526C061401;
        Wed, 22 Dec 2021 06:20:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8248AB81CF1;
        Wed, 22 Dec 2021 14:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAB9C36AEB;
        Wed, 22 Dec 2021 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640182852;
        bh=VgxL4j+yOUkkk/vgfENOj/oZDG5YSOK8ngjyMZDyut8=;
        h=From:To:Cc:Subject:Date:From;
        b=Jr81o+Pbylb9Zl6RTIzCV+ueTnDPnNKOSiIFSoJwUrvNawpwHWZf61w9IUTvECZZa
         yFogu82GASsZQKJ/rupRax/B5p2rFJBcmFhmIx/74ZixZq9OZBIAC9raQsKLWYM9W+
         T14V0zufJmY6hraNzalXYQDv+Hl0+llPQnLYpZEERwF8NOxuEwoBbXRNRmit8Ia4Ph
         0juFIbpsXh664ZvM1jtZItdQWhJjLqxU9ofxWA2vl3k2VbeLtzWKoRLpp3f5adWtT0
         93N+WjY2rC9OH1MyArFS/d6W2fxmao5IJvVgRv1D5P8v/XNqVSRAxl2QBzSbAWRY3Z
         W1xZocEqi5r7g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1n02Tz-0007uh-TY; Wed, 22 Dec 2021 15:20:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] media: davinci: vpif: fix use-after-free on driver unbind
Date:   Wed, 22 Dec 2021 15:20:21 +0100
Message-Id: <20211222142025.30364-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scanning the tree for drivers that did not handle platform-device
registration failures properly I stumbled upon this driver, which also
failed to deregister device structures before freeing them.

Included are also some related runtime PM imbalance fixes and a printk
clean up.

Johan


Johan Hovold (4):
  media: davinci: vpif: fix unbalanced runtime PM get
  media: davinci: vpif: fix unbalanced runtime PM enable
  media: davinci: vpif: fix use-after-free on driver unbind
  media: davinci: vpif: drop probe printk

 drivers/media/platform/davinci/vpif.c | 111 +++++++++++++++++++-------
 1 file changed, 81 insertions(+), 30 deletions(-)

-- 
2.32.0

