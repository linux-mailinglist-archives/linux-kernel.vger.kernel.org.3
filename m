Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0FE464D34
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348461AbhLALuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:50:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41862 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242743AbhLALuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:50:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AFDB92170C;
        Wed,  1 Dec 2021 11:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638359207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0Xgr3F8AcRgaMByXTz2/M3wiPMGAm2672LvQChxc3Y=;
        b=GukL5xK4ZcVnw/YZTl03ABkY9kjjpNWdn2qFzNeXeJ5yAmZziF82V+fmQ4u5wBQNdsL8+o
        kTGfxuJzgS/hyklSNNifcc66FSD/SN0EYm72HYpFwAvm5b8VZONiISaPNlAPNVOMOIr9u6
        RhNzdZ22qPXzBoNjQh8s+FZFh7njRdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638359207;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0Xgr3F8AcRgaMByXTz2/M3wiPMGAm2672LvQChxc3Y=;
        b=ZavnqwOEfRiX+dQrXhU3AgHSB+MOntW9dhCpSkv7XWL5wftV0MAc9MpEuPOgHZsGtk12C8
        AYxvWQAJO6F2q+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C11C13B7E;
        Wed,  1 Dec 2021 11:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qAFcHadgp2HbDgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 01 Dec 2021 11:46:47 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     airlied@linux.ie, daniel.vetter@ffwll.ch, arnd@arndb.de,
        gregkh@linuxfoundation.org, James.Bottomley@HansenPartnership.com,
        deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/7] agp: Include "compat_ioctl.h" where necessary
Date:   Wed,  1 Dec 2021 12:46:40 +0100
Message-Id: <20211201114645.15384-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211201114645.15384-1-tzimmermann@suse.de>
References: <20211201114645.15384-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compiler warnings like

  drivers/char/agp/frontend.c:46:20: warning: no previous prototype for 'agp_find_mem_by_key' [-Wmissing-prototypes]
    46 | struct agp_memory *agp_find_mem_by_key(int key)

by including the compat_ioctl.h in the source file.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Helge Deller <deller@gmx.de>
---
 drivers/char/agp/frontend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/agp/frontend.c b/drivers/char/agp/frontend.c
index 6802a6bbf0f2..321118a9cfa5 100644
--- a/drivers/char/agp/frontend.c
+++ b/drivers/char/agp/frontend.c
@@ -39,7 +39,9 @@
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+
 #include "agp.h"
+#include "compat_ioctl.h"
 
 struct agp_front_data agp_fe;
 
-- 
2.34.0

