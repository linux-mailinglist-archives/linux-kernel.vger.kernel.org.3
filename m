Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E3C498201
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbiAXOYb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jan 2022 09:24:31 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:20610 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237766AbiAXOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:24:30 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-IvZlxRigNqeovbHNtBILSg-1; Mon, 24 Jan 2022 09:24:28 -0500
X-MC-Unique: IvZlxRigNqeovbHNtBILSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46E468144E1;
        Mon, 24 Jan 2022 14:24:27 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0965C798B2;
        Mon, 24 Jan 2022 14:24:25 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 2/8] rtla/utils: Fix session duration parsing
Date:   Mon, 24 Jan 2022 15:24:05 +0100
Message-Id: <5313cb92b2e0e5c1430e33922ff85dc27c642949.1643033113.git.bristot@kernel.org>
In-Reply-To: <cover.1643033113.git.bristot@kernel.org>
References: <cover.1643033113.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use gmtime to format the duration time. This avoids problems when the
system uses local time different of Pisa's Local Time.

Fixes: b1696371d865 ("rtla: Helper functions for rtla")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 1c9f0eea6166..ffaf8ec84001 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -77,11 +77,11 @@ void get_duration(time_t start_time, char *output, int output_size)
 	time_t duration;
 
 	duration = difftime(now, start_time);
-	tm_info = localtime(&duration);
+	tm_info = gmtime(&duration);
 
 	snprintf(output, output_size, "%3d %02d:%02d:%02d",
 			tm_info->tm_yday,
-			tm_info->tm_hour - 1,
+			tm_info->tm_hour,
 			tm_info->tm_min,
 			tm_info->tm_sec);
 }
-- 
2.34.1

