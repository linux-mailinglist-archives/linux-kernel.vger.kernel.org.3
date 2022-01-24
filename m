Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2194982C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiAXPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiAXPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:00:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EA9C06173B;
        Mon, 24 Jan 2022 07:00:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id p12so57104383edq.9;
        Mon, 24 Jan 2022 07:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eYnF8znj0gEjEIArTu9FBL6O8f6KN3bAysMIge/IReo=;
        b=JpgtuiUNaG0hXQx0hQsDK6Jd6kmlgrUA0jhjwb1LbSQsEvfgn/M4a4HJ9SXTUFdbnc
         TPrJ4y7tKxvx+PRRHRAC7GqhXo8jRLSbPLOXCwWkTJOhjbY9MY1E4Z+sfVgow71tPmgH
         UDaGncOD8Z/HWeWhDCNNi+T/sPxE7v3hSk7BPhIQEnsnIP8Ph6z4l4ifmkWwnPA4vE7Z
         aMhnBFE6rYOFbBXGrtDFlgoshh3ABGTUGQ2vZwdht/zqhIWTCUEskhNgYFxHdLQKwpnA
         OqRPx4O6ug7xUwRb/7E+F73QxIa2tj1bWPa087W8B6Nc1aaxbhnhfWhOGf3cCYHVt6EN
         O3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eYnF8znj0gEjEIArTu9FBL6O8f6KN3bAysMIge/IReo=;
        b=uKcPLuRYVJzjtOD/QxRS0HRt+UFx4uy8DVhRlbvNsyNCG2UpndsCTNtia1AwErf1Er
         BOx/49p+UzwU0MR3GzV0+nQuZC9wEu4vDCcWugtvQz1F3Q3CQ3TwGLuuqeSDdIkAwgck
         AQXDXPRZ4S+HSmRKyCIGLfQ6u+zngAqg4E8JSgdfL2QU8GCmSeJvWSucxKItmuYrQW7g
         xwW2QsbGByvqabBnxV5kdnml/otL5P/IxW397UhHf7msgCyyYg/+eK3JTlSE0PHNPaPW
         Uk/sIIOg0a8FOR5/dMcqck2dM20bQ+JbRXCsIryRmUWg2GHRQA99qQSK/dpqxBuTv1sR
         6cJg==
X-Gm-Message-State: AOAM532P22RsylG24MuJ4d9LXNDQ+Md5FqgDc+wp/EL/WSw16cSM2sRz
        3/QcviNhDsypXB8ITYfzH5Q43xiFo+Bj+53b
X-Google-Smtp-Source: ABdhPJydRvRWrFg0PLwwsxxd3YipOYY15nwCfbvxzG+N5HCI3gqT0eB47/xEtRJ/wkRCIxXgPOTrwg==
X-Received: by 2002:aa7:c6d8:: with SMTP id b24mr16436377eds.72.1643036420009;
        Mon, 24 Jan 2022 07:00:20 -0800 (PST)
Received: from localhost.localdomain ([39.48.153.72])
        by smtp.gmail.com with ESMTPSA id f26sm6626637eds.69.2022.01.24.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 07:00:19 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        rickyman7@gmail.com, alexey.v.bayduraev@linux.intel.com,
        adrian.hunter@intel.com, leo.yan@linaro.org, german.gomez@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        amhamza.mgc@gmail.com
Subject: [PATCH] perf session: check for null pointer before derefernce
Date:   Mon, 24 Jan 2022 20:00:01 +0500
Message-Id: <20220124150001.93145-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move null pointer check before dereferncing the variable

Addresses-Coverity: 1497622 ("Derereference before null check")

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
---
 tools/perf/util/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f19348dddd55..e1014ab62c10 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1503,11 +1503,11 @@ static int machines__deliver_event(struct machines *machines,
 			++evlist->stats.nr_unknown_id;
 			return 0;
 		}
-		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
 		if (machine == NULL) {
 			++evlist->stats.nr_unprocessable_samples;
 			return 0;
 		}
+		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
 		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
 	case PERF_RECORD_MMAP:
 		return tool->mmap(tool, event, sample, machine);
-- 
2.25.1

