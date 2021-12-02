Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A478A4660FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357058AbhLBJ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:59:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356778AbhLBJ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638438825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgxgjjV5OKt/bk0s3/TNw9YkhhVjmIMnypyvKB59OzE=;
        b=D1cUTcviyDo/BIalDADDstacFD7YHdJb1QeyYDKksyUvwIHgyhFIGc//1tlFS3gH0X+h4b
        +ezG6Nl8evqJa8qJ9hcuwcyb41PG8G+nkmfMKSrsVQYTr+7CAtjBv38pzXvtI5iqmBcAdr
        11JMdND/E//832jtgbztNC6TiyVpnpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-L_RGBmWUMUqZgMsQ12oZIA-1; Thu, 02 Dec 2021 04:53:42 -0500
X-MC-Unique: L_RGBmWUMUqZgMsQ12oZIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B4A34237A;
        Thu,  2 Dec 2021 09:53:41 +0000 (UTC)
Received: from xps-13.redhat.com (unknown [10.39.195.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFC1C19C46;
        Thu,  2 Dec 2021 09:53:39 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/4] HID: bigbenff: prevent null pointer dereference
Date:   Thu,  2 Dec 2021 10:53:32 +0100
Message-Id: <20211202095334.14399-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
References: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When emulating the device through uhid, there is a chance we don't have
output reports and so report_field is null.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-bigbenff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
index db6da21ade06..74ad8bf98bfd 100644
--- a/drivers/hid/hid-bigbenff.c
+++ b/drivers/hid/hid-bigbenff.c
@@ -191,7 +191,7 @@ static void bigben_worker(struct work_struct *work)
 		struct bigben_device, worker);
 	struct hid_field *report_field = bigben->report->field[0];
 
-	if (bigben->removed)
+	if (bigben->removed || !report_field)
 		return;
 
 	if (bigben->work_led) {
-- 
2.33.1

