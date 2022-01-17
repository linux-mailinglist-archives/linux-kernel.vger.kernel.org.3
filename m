Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED24903FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiAQIhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiAQIhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:37:52 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F25C06161C;
        Mon, 17 Jan 2022 00:37:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 133so5925710pgb.0;
        Mon, 17 Jan 2022 00:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cb1+ziTr7tG5ItZw1HG25PJXDx+szSS4d+LEoIryOmA=;
        b=BZjziNhOpoUFCfZhUDpZifQ6ONaSDAMTiD12YPiJOcNURhXeu0kPSuPapf2COidWmG
         +DxXjY4G4NpsiE2MRdN1G0TkTkh/CFc1vEA9VqKqaeXz1P1honrxMepua4H3rX4H3zLT
         MYAxRWc9VjPVALz58iacADXS1p0ZBxyWCAP1SDhSk63AcyGsgGaGrHYQjPQ0JvXfZ0ir
         /9HCpouE5192Rxwa1iNqjCtB7jP8vAKD+9qH90qrKzbk/rszZ5QkaVsrlAAHEs/lbxVA
         zQxnUXlyvXRn4V/fcKq4Is6LPkAZSf3SnQe0VRmxHrEaR3ZQah0ctxwy/DpMdX1M+9L5
         1T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cb1+ziTr7tG5ItZw1HG25PJXDx+szSS4d+LEoIryOmA=;
        b=X/p1Z+gLbsjRrNr0w6nsRNFZWKHzSYb7SE1RNOfEJd5tI0eesRdaccMVxYqC3CTAWz
         C81b7aySD/VAv9y73LdZiKm5579tFTvXTqG0YYmOxNVovyZ239qOSC0ts2r9b6pMJmGb
         bUyRTdyXb3JPCFV08eH5rmtojZgvgcptPVRS2VxTQ/OJK+GeLZkWY65gjG2EH8Jv10hF
         Yp8YCnlucKoF8j/6N6430Ku0rd85iVYew+ThTn8mxPCf/3XUsBrv2pfCiE0QBdhu9RNV
         ZvJrpUNdt6MKtZBRm4lLEuWXnVd/KGIdpmFj4rtfnpXkjIowKUCKKuNHOFHJPkC8vCdv
         kb6A==
X-Gm-Message-State: AOAM5336uTCOi0gWbM2jmz8lmX+p1ow3cl0LdwaWR1EuEe5OF0D/sMV1
        sZkFj+cD2B6c8HuUI78HVPo=
X-Google-Smtp-Source: ABdhPJwWUwbiCLpBOkksUyk1EywkFo53vA2/zy5Pvnu7OO7lFMemDwE3effKVIABpchRHkZ7Gcke8w==
X-Received: by 2002:aa7:9155:0:b0:4bb:e7b7:73c3 with SMTP id 21-20020aa79155000000b004bbe7b773c3mr20176435pfi.62.1642408671587;
        Mon, 17 Jan 2022 00:37:51 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x12sm12245883pjq.52.2022.01.17.00.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 00:37:51 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mingo@redhat.com
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, james.clark@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] perf cpumap: remove duplicate include in cpumap.h
Date:   Mon, 17 Jan 2022 08:37:30 +0000
Message-Id: <20220117083730.863200-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Remove all but the first include of stdbool.h from cpumap.h.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 tools/perf/util/cpumap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 0d3c2006a15d..240db1da370c 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -4,7 +4,6 @@
 
 #include <stdbool.h>
 #include <stdio.h>
-#include <stdbool.h>
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
-- 
2.25.1

