Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5694A86CE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbiBCOov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237556AbiBCOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643899489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=II1Fz5tzNmggtt86EVX2Z450qsChAoGg4Dx1YbBn1tA=;
        b=JF6RJXx3QBUsyF8cgwzQw9y8TR3//fWZGpIPAjqg+Jl94cU2/QvV1XA5jqyuUYXa+garrY
        7KYm0fsNiHkQ0v8qdznIerD48+q6UZNgvEEX9M1BhtO8vooFLN8NgpJWLbmOTEXlotg9Xr
        XF68ZHMlvn5okawjv68FoBGmX7T9baQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-KXvs1RxNOaumBa7NeWPmDA-1; Thu, 03 Feb 2022 09:44:46 -0500
X-MC-Unique: KXvs1RxNOaumBa7NeWPmDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDFF6101F7C2;
        Thu,  3 Feb 2022 14:44:44 +0000 (UTC)
Received: from wsfd-netdev64.ntdv.lab.eng.bos.redhat.com (wsfd-netdev64.ntdv.lab.eng.bos.redhat.com [10.19.188.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05B977D57D;
        Thu,  3 Feb 2022 14:44:43 +0000 (UTC)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf scripting python: expose symbol offset and source information
Date:   Thu,  3 Feb 2022 09:44:33 -0500
Message-Id:  <164389947295.382219.17025049915445689710.stgit@wsfd-netdev64.ntdv.lab.eng.bos.redhat.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the symbol offset to the data exported for each
call-chain entry. This can not be calculated from the script and
only the ip value, and no related mmap information.

In addition, also export the source file and line information, if
available, to avoid an external lookup if this information is needed.

Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
---
 .../util/scripting-engines/trace-event-python.c    |   42 ++++++++++++++------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index e752e1f4a5f0..0f392b4ff663 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -392,6 +392,18 @@ static const char *get_dsoname(struct map *map)
 	return dsoname;
 }
 
+static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
+{
+	unsigned long offset;
+
+	if (al->addr < sym->end)
+		offset = al->addr - sym->start;
+	else
+		offset = al->addr - al->map->start - sym->start;
+
+	return offset;
+}
+
 static PyObject *python_process_callchain(struct perf_sample *sample,
 					 struct evsel *evsel,
 					 struct addr_location *al)
@@ -443,6 +455,24 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 					_PyUnicode_FromStringAndSize(node->ms.sym->name,
 							node->ms.sym->namelen));
 			pydict_set_item_string_decref(pyelem, "sym", pysym);
+
+			if (node->ms.map) {
+				struct map *map = node->ms.map;
+				struct addr_location node_al;
+				unsigned long offset;
+
+				node_al.addr = map->map_ip(map, node->ip);
+				node_al.map  = map;
+				offset = get_offset(node->ms.sym, &node_al);
+
+				pydict_set_item_string_decref(
+					pyelem, "sym_off",
+					PyLong_FromUnsignedLongLong(offset));
+			}
+			if (node->srcline && strcmp(":0", node->srcline))
+				pydict_set_item_string_decref(
+					pyelem, "sym_srcline",
+					_PyUnicode_FromString(node->srcline));
 		}
 
 		if (node->ms.map) {
@@ -520,18 +550,6 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
 	return pylist;
 }
 
-static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
-{
-	unsigned long offset;
-
-	if (al->addr < sym->end)
-		offset = al->addr - sym->start;
-	else
-		offset = al->addr - al->map->start - sym->start;
-
-	return offset;
-}
-
 static int get_symoff(struct symbol *sym, struct addr_location *al,
 		      bool print_off, char *bf, int size)
 {

