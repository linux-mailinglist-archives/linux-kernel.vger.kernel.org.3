Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E94BFC06
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiBVPLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiBVPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74F2910EC54
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645542684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D2nBod7A/CBKu2+sFN1QjFvotvtMYAinvMX+52oPhA0=;
        b=fKTMLCcBUrkOYERf1gvw7bELfcwFAhsksaUgNvEWWyhNgUCNXthBN/Qx2QekpE9flLX9pC
        RH+EROEoGVDcfbVD+gV3zzfeqWcd9mJpTynD70kC5CwfAObGqwDPsv/AQk0xAGnLI/IkdN
        BcqZtg3iD0PT8hvEv4ZObt+iZiXlqi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-8dtTgZi8OwiY4wU_Hj8KFQ-1; Tue, 22 Feb 2022 10:11:18 -0500
X-MC-Unique: 8dtTgZi8OwiY4wU_Hj8KFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61B198145E7;
        Tue, 22 Feb 2022 15:11:16 +0000 (UTC)
Received: from wsfd-netdev64.ntdv.lab.eng.bos.redhat.com (wsfd-netdev64.ntdv.lab.eng.bos.redhat.com [10.19.188.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F5C3832AC;
        Tue, 22 Feb 2022 15:11:15 +0000 (UTC)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf scripting python: expose symbol offset and source information
Date:   Tue, 22 Feb 2022 10:11:10 -0500
Message-Id:  <164554263724.752731.14651017093796049736.stgit@wsfd-netdev64.ntdv.lab.eng.bos.redhat.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
v2:
 - Fixed small code nit
 - Included new features in auto generated scripts

 .../util/scripting-engines/trace-event-python.c    |   49 +++++++++++++++-----
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index e752e1f4a5f0..86a9c8614231 100644
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
@@ -443,6 +455,25 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
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
+			if (node->srcline && strcmp(":0", node->srcline)) {
+				pydict_set_item_string_decref(
+					pyelem, "sym_srcline",
+					_PyUnicode_FromString(node->srcline));
+			}
 		}
 
 		if (node->ms.map) {
@@ -520,18 +551,6 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
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
@@ -2073,7 +2092,11 @@ static int python_generate_script(struct tep_handle *pevent, const char *outfile
 
 		fprintf(ofp, "\t\tfor node in common_callchain:");
 		fprintf(ofp, "\n\t\t\tif 'sym' in node:");
-		fprintf(ofp, "\n\t\t\t\tprint(\"\\t[%%x] %%s\" %% (node['ip'], node['sym']['name']))");
+		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x] %%s%%s%%s%%s\" %% (");
+		fprintf(ofp, "\n\t\t\t\t\tnode['ip'], node['sym']['name'],");
+		fprintf(ofp, "\n\t\t\t\t\t\"+0x{:x}\".format(node['sym_off']) if 'sym_off' in node else \"\",");
+		fprintf(ofp, "\n\t\t\t\t\t\" ({})\".format(node['dso'])  if 'dso' in node else \"\",");
+		fprintf(ofp, "\n\t\t\t\t\t\" \" + node['sym_srcline'] if 'sym_srcline' in node else \"\"))");
 		fprintf(ofp, "\n\t\t\telse:");
 		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x]\" %% (node['ip']))\n\n");
 		fprintf(ofp, "\t\tprint()\n\n");

