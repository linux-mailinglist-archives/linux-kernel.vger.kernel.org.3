Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE24C492978
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbiARPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344738AbiARPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:13:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F3C061574;
        Tue, 18 Jan 2022 07:13:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D08061256;
        Tue, 18 Jan 2022 15:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE2EC00446;
        Tue, 18 Jan 2022 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642518828;
        bh=2V5QD/NGrPrH05TztNOm6bMGndJtrFUXsz8eLtOrqwk=;
        h=Date:From:To:Cc:Subject:From;
        b=NDQP8ZdKzCNdXbBfTies5lCXfeIUCBmTz1vJ1IW8As/gSAKhVR3JvYRmpESbtlJkx
         dI98Bk9+yeDqv5x52FNY8BWO33rC2qLvroiBCQ06Gcwe9gzUflr2FEN3qxk2BISaKW
         BWmhnSyxztFHnshtCmXGEDNJ568g8K5QkJV7tPBcgdekKbqc7fvs2aJwqhKsyGubET
         dXN/kRoQ4j7cpOoGGBCmruR0XHniLbOzING7Z1jvR0KIBEYaKqunOLvb2qgZ9bhnHP
         iyQC1wixSmF0nQrXcjav9vRu2QLAfwMuwEriEycbVbEqKd5rttW5lp2FQG884ll10v
         DyGl8ANAbDNtg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8EC4040714; Tue, 18 Jan 2022 12:13:46 -0300 (-03)
Date:   Tue, 18 Jan 2022 12:13:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf machine: Use path__join() to compose a path instead
 of snprintf(dir, '/', filename)
Message-ID: <YebZKjwgfdOz0lAs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its more intention revealing, and if we're interested in the odd cases
where this may end up truncating we can do debug checks at one
centralized place.

Motivation, of all the container builds, fedora rawhide started
complaining of:

  util/machine.c: In function ‘machine__create_modules’:
  util/machine.c:1419:50: error: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size between 0 and 4095 [-Werror=format-truncation=]
   1419 |                 snprintf(path, sizeof(path), "%s/%s", dir_name, dent->d_name);
        |                                                  ^~
  In file included from /usr/include/stdio.h:894,
                   from util/branch.h:9,
                   from util/callchain.h:8,
                   from util/machine.c:7:
  In function ‘snprintf’,
      inlined from ‘maps__set_modules_path_dir’ at util/machine.c:1419:3,
      inlined from ‘machine__set_modules_path’ at util/machine.c:1473:9,
      inlined from ‘machine__create_modules’ at util/machine.c:1519:7:
  /usr/include/bits/stdio2.h:71:10: note: ‘__builtin___snprintf_chk’ output between 2 and 4352 bytes into a destination of size 4096

There are other places where we should use path__join(), but lets get rid of
this one first.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3901440aeff92652..f70ba56912d4f9f8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -16,6 +16,7 @@
 #include "map_symbol.h"
 #include "branch.h"
 #include "mem-events.h"
+#include "path.h"
 #include "srcline.h"
 #include "symbol.h"
 #include "sort.h"
@@ -1416,7 +1417,7 @@ static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, i
 		struct stat st;
 
 		/*sshfs might return bad dent->d_type, so we have to stat*/
-		snprintf(path, sizeof(path), "%s/%s", dir_name, dent->d_name);
+		path__join(path, sizeof(path), dir_name, dent->d_name);
 		if (stat(path, &st))
 			continue;
 
-- 
2.34.1

