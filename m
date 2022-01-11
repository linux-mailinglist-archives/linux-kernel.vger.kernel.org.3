Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1711C48BA48
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiAKV4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:56:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45312 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbiAKVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:54:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD21761835
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 21:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EBFC36AE3;
        Tue, 11 Jan 2022 21:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641938072;
        bh=2ElZUm7GetZ+TNF4a6rIglKM1ZYfRPNHb16RWnwiOa0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=D7PNvQAYUASTtBPY/hPgk3f82JTAreZIGwi/xYntKGjVXGtMDiRgPfZ50DTKDIf/f
         8zBCsOxdUdUNoOB/4+UlQSifmJXSS78PdH+PMG1skQShQyqou8i5KmGqxowb0V0vaX
         36NBnji160ici6rzXGfYFRGxXQklXGiwzY+DK226WeId9p4HtqiGa+4eY/hFaCnH8i
         GT/PGkUNDC/a4u+ZwYxdyeXy+s80Yaw/J4HLB+oC4aBbRR0jV2g3Oevh2RYRZ/YlL0
         AVEQEw9YNMa11aT6brvupk58nzZl6FPJH/q3t92mksOgpCa2GfNg7jay+YNKmu4oCW
         FlJs/Aq937wjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0286A5C0DA1; Tue, 11 Jan 2022 13:54:31 -0800 (PST)
Date:   Tue, 11 Jan 2022 13:54:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     masahiroy@kernel.org
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        caihuoqing@baidu.com, linux@dominikbrodowski.net
Subject: [PATCH] drivers/pcmcia: Fix ifdef covering yenta_pm_ops
Message-ID: <20220111215431.GA2609427@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, yenta_dev_suspend_noirq(), yenta_dev_resume_noirq(),
and yenta_pm_ops are covered by "#ifdef CONFIG_PM", which results in
compiler warnings in kernels built with CONFIG_PM_SLEEP=n and CONFIG_PM=y:

drivers/pcmcia/yenta_socket.c:1322:12: warning: ‘yenta_dev_resume_noirq’ defined but not used [-Wunused-function]
 1322 | static int yenta_dev_resume_noirq(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/pcmcia/yenta_socket.c:1303:12: warning: ‘yenta_dev_suspend_noirq’ defined but not used [-Wunused-function]
 1303 | static int yenta_dev_suspend_noirq(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~

This affects kernels built without suspend and hibernation.

Avoid these warnings by using "#ifdef CONFIG_PM_SLEEP".

Fixes: 3daaf2c7aae8 ("pcmcia: Make use of the helper macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 837877daed622..3966a6ceb1ac7 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -1299,7 +1299,7 @@ static int yenta_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return ret;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int yenta_dev_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
