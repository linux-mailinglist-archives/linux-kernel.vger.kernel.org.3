Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1574754C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhLOI5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:57:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53950 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhLOI5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:57:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 329FD61864;
        Wed, 15 Dec 2021 08:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC9CC34605;
        Wed, 15 Dec 2021 08:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639558663;
        bh=HntY3mEjV2sgoDylOzppm0U/2ohr1I+1dvNjfHPoXIA=;
        h=From:To:Cc:Subject:Date:From;
        b=eO4JHnU06ZLrakl52LAIsmiby5xDcx+mFmts7l3v2Si1uTryJZ9Q1zYsHAT7Zdf7d
         c/vBaHAewxShhnr9CdPPc4VB6QTKHNv5R8w85rErWiiYCSm0eNgHaKqAQUhrH30S5P
         iLEVyQ6BY1I5I0DzIctGd/Frsl5TKvtemMSfhxL7Eji0i8RKEFudnQKGgnuy9lk7J6
         rgRmaACSY3OQNTaG4+uA54UAFgIKH0CJ3Wd/deYV9i7WJCoqzXlJLaMKigDVTtTgYv
         vc18Tl8jhj7Dq8p4t8TZpL1J8EDlSOJG1/CdS7rzZ4CPK1OZZZsWs+n94V34xAxOBh
         eKWaKn0eQr1xQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxQ6X-0054R9-9q; Wed, 15 Dec 2021 09:57:41 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND(2) 0/1] Ensure that HiKey 970 won't hang during boot time
Date:   Wed, 15 Dec 2021 09:57:38 +0100
Message-Id: <cover.1639558556.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Second resend attempt. Didn't get any feedback about this series yet.

During HiKey 970 boot, hundreds of clock lines are disabled, causing the device to
hang.

There are actually two issues here:

1. The clk core doesn't wait enough time for the device drivers to be probed
    before agressively disabling "unused" clocks. This was noticed at the
    drivers built as modules;
2. Several HiKey 970 gates are essencial for the device to work, but they're
    not marked as such.

The first patch fixes the clk core issue, while second one marks the mandatory
clocks as such.

Mauro Carvalho Chehab (1):
  clk: clk-hi3670: mark some clocks as CLK_IS_CRITICAL

 drivers/clk/hisilicon/clk-hi3670.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.33.1


