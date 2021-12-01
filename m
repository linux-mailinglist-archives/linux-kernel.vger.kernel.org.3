Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A048464ED8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349574AbhLANf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:35:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54604 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349505AbhLANfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:35:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0D705CE1D69
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 13:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B39C53FCC;
        Wed,  1 Dec 2021 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638365537;
        bh=Jjj9f2URO0qy7cwTOZLcZgnVsX9BCpZo0Th7xEFkb5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLPvGj9kOb/25iE4HioskAHiKZ/WAW5HzHsImtRVjyNiW2k9GF1enhEa9bInJmUes
         H2g7Zi69RzhhGdBHZvMwE8V8QVFmQZH7uf4G9ZYm2ktAWIQwjM1tO19OlCFXgU1FAJ
         2d2awyvK6LakSsfiAhIl54eSmL84ku4WJ5it82ibrcmUd/D84PA2S9HNB0MB28IW0i
         prW39IwKmuEUQkRsJDYCyEVnmc11LwBrgLeh3LYGBabB3nWoxhSRAnWMyyHV51OkLo
         zBukiXUmb4IBRSVT91RZhNXlFIvwesqlx/rYwKODlVHJHj+qnE7OyIMRql3fwfWaYJ
         ZOPvzUZZuLdOQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1msPiI-0007s3-4f; Wed, 01 Dec 2021 14:31:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] firmware: qemu_fw_cfg: remove sysfs entries explicitly
Date:   Wed,  1 Dec 2021 14:25:28 +0100
Message-Id: <20211201132528.30025-5-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201132528.30025-1-johan@kernel.org>
References: <20211201132528.30025-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly remove the file entries from sysfs before dropping the final
reference for symmetry reasons and for consistency with the rest of the
driver.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/firmware/qemu_fw_cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index f08e056ed0ae..b436342115af 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -389,6 +389,7 @@ static void fw_cfg_sysfs_cache_cleanup(void)
 
 	list_for_each_entry_safe(entry, next, &fw_cfg_entry_cache, list) {
 		fw_cfg_sysfs_cache_delist(entry);
+		kobject_del(&entry->kobj);
 		kobject_put(&entry->kobj);
 	}
 }
-- 
2.32.0

