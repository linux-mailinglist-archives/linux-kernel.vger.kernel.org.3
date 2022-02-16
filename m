Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E434B9283
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiBPUiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:38:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiBPUiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:38:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B912AEDA7;
        Wed, 16 Feb 2022 12:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CAZr9ArhphXYksCSRXhVyugFkJegaRMM9Fl5aGv+W/M=; b=XvlpqhEATsejxfxhR8Ie7y222j
        lzH+YO/rGSsW3Mw9NSj1DXsEm4l8qC4GeAQ4Vz7coHPHvhBV8VvM3rNYZ75PqQ9ZioEAjo8P/TlYP
        rWfheJ+n84yZn9gfYsIdhw5LPvJN1zNreK4SX3HFy+sS/ZquKCaNpxbPMucWLe6a74jSMxF0ogPzS
        QsGK43W4oEjy5BdT8kH1f/VkNft/fCYCm18jc8RGqz2d6B+mTc7nT6hx/LBEmB3RMqdiBxCANnLNl
        EW4TAIaS5Y4N0OO5aqtKe57bnQ+whEGIOgl9BzgyGBV3yAq97ukCOPXCNpHU6v9JVeb4YMHvxKTPf
        ny/EzStg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKR3a-008LEX-Fx; Wed, 16 Feb 2022 20:37:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v2] Docs: printk: add 'console=null|""' to admin/kernel-parameters
Date:   Wed, 16 Feb 2022 12:37:45 -0800
Message-Id: <20220216203745.980-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell about 'console=null|""' and how to use it.

It can be helpful to set (enable) CONFIG_NULL_TTY so that the ttynull
driver is available. This avoids problems with stdin/stdout/stderr of
the init process. Howevere, CONFIG_NULL_TTY cannot be enabled by default
because it can be used by mistake [see commit a91bd6223ecd ("Revert
"init/console: Use ttynull as a fallback when there is no console").]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
v2: "must be the only console=" instead of the first one. (Petr)
    Add info about CONFIG_NULL_TTY to the commit message. (Petr)

 Documentation/admin-guide/kernel-parameters.txt |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20220216.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20220216/Documentation/admin-guide/kernel-parameters.txt
@@ -724,6 +724,12 @@
 		hvc<n>	Use the hypervisor console device <n>. This is for
 			both Xen and PowerPC hypervisors.
 
+		{ null | "" }
+			Use to disable console output, i.e., to have kernel
+			console messages discarded.
+			This must be only console= string used on the
+			kernel command line.
+
 		If the device connected to the port is not a TTY but a braille
 		device, prepend "brl," before the device type, for instance
 			console=brl,ttyS0
