Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0688E482D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 00:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiABXdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 18:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiABXcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 18:32:55 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9988AC061792
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 15:32:54 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 565129200BC; Mon,  3 Jan 2022 00:24:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 528F79200BB;
        Sun,  2 Jan 2022 23:24:09 +0000 (GMT)
Date:   Sun, 2 Jan 2022 23:24:09 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jean Delvare <jdelvare@suse.com>
cc:     linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH 1/2] firmware: dmi: Prevent empty board name from
 being logged
In-Reply-To: <alpine.DEB.2.21.2201020127140.56863@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2201020130590.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020127140.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems do provide DMI entries for Base Board Information, however 
the strings supplied are null, e.g:

Legacy DMI 2.0 present.
DMI: /, BIOS 4.51 PG 09/11/97

Do not log the slash along with the empty board name in that case as it 
carries no real information.  If it's important to tell an inexistent 
and an empty board name apart, then all DMI information can be retrieved 
from sysfs and/or with `dmidecode'.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/firmware/dmi_scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-macro-ide-tty/drivers/firmware/dmi_scan.c
===================================================================
--- linux-macro-ide-tty.orig/drivers/firmware/dmi_scan.c
+++ linux-macro-ide-tty/drivers/firmware/dmi_scan.c
@@ -544,7 +544,7 @@ static void __init dmi_format_ids(char *
 			    dmi_get_system_info(DMI_PRODUCT_NAME));
 
 	board = dmi_get_system_info(DMI_BOARD_NAME);
-	if (board) {
+	if (board && *board) {
 		c += scnprintf(buf + c, len - c, "/");
 		c += print_filtered(buf + c, len - c, board);
 	}
