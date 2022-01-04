Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63D24849D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiADVYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:24:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35870 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiADVYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:24:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id EF8A91F43DE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641331484;
        bh=fNOthzA/oqOjDWMc8+5brhPj9n+JoXNQ8+YI2p4wmaU=;
        h=Date:From:To:Cc:Subject:From;
        b=Mh3pmnIf7nD8nkQt4F4AaMXth63TbadsVfg5BYt8jmC7R2YgL6eNEbT8Epls1/v9f
         5+gBPgRFfj83/UwiI6nJySwcVoqonXAxIEVn3J9weBUtL3lJGmenEOcNQP8Kauqtsz
         a/QOi32OHuUsj0VSrJ7G9Qj/b7eJdm+bq6sgdZfPWt8g40yGIrv3V9XUbtJMuaLsnQ
         +7vHjz8mu9YymkbVMNzVq+UKht3T+MWGhX6hBpyf8HgCvg5jX8/bKvO7ACb0uMV5J7
         DgaSF/vwO4r8TagNIctGqqrH5aDGz0mdoCvyeC9Jk+I1hRpSsar40ji86ejeqQA9Tq
         9btyx1TQUmBxQ==
Date:   Wed, 5 Jan 2022 02:24:37 +0500
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Steve French <sfrench@samba.org>,
        "open list:COMMON INTERNET FILE SYSTEM CLIENT (CIFS)" 
        <linux-cifs@vger.kernel.org>,
        "moderated list:COMMON INTERNET FILE SYSTEM CLIENT (CIFS)" 
        <samba-technical@lists.samba.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     usama.anjum@collabora.com
Subject: [PATCH] cifs: remove unused variable ses_selected
Message-ID: <YdS7Fb/MzAy+IRyP@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ses_selected is being declared and set at several places. It is not
being used. Remove it.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/cifs/smb2pdu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 19c54b309e39..9a72c22bb189 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3790,7 +3790,7 @@ void smb2_reconnect_server(struct work_struct *work)
 	struct cifs_tcon *tcon, *tcon2;
 	struct list_head tmp_list, tmp_ses_list;
 	bool tcon_exist = false, ses_exist = false;
-	bool tcon_selected = false, ses_selected = false;
+	bool tcon_selected = false;
 	int rc;
 	bool resched = false;
 
@@ -3807,7 +3807,7 @@ void smb2_reconnect_server(struct work_struct *work)
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
 
-		tcon_selected = ses_selected = false;
+		tcon_selected = false;
 
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 			if (tcon->need_reconnect || tcon->need_reopen_files) {
@@ -3833,7 +3833,7 @@ void smb2_reconnect_server(struct work_struct *work)
 		spin_lock(&ses->chan_lock);
 		if (!tcon_selected && cifs_chan_needs_reconnect(ses, server)) {
 			list_add_tail(&ses->rlist, &tmp_ses_list);
-			ses_selected = ses_exist = true;
+			ses_exist = true;
 			ses->ses_count++;
 		}
 		spin_unlock(&ses->chan_lock);
-- 
2.30.2

