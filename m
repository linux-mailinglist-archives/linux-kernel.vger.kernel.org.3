Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA194BB00A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiBRDOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:14:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiBRDOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:14:17 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A9387AC;
        Thu, 17 Feb 2022 19:14:01 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id j78so2039825qke.2;
        Thu, 17 Feb 2022 19:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMGDUJYEnf9KDdTw5F3ZbgchLlVWOkkRHiagdTu86+c=;
        b=Udux+Ig0KkVmJRPjdOHpRBqKmRlc+4POrEZ9fr2FJoniv6YPK+tz05ONlp+F2DffCx
         S96TcGrQLQBl0i+v/QfLLcGGcgq3ZJH9fBG40qNmntlyr9XwQMWnexc6tafHt1J+SQuN
         YyLLNrWb6G6ivcBXGwzKTkESJtN3uEjfY+2BewS7BzIP23MM92d3a8JJzPAXNLJCmqYc
         CVWJAEb4FROjYhPACFkzhwsUzvSLYkJCIARRRo07QBL8yhzoo8IH1EcpvKc6ziYZvRx1
         7EH6NQ5GFirS2GTFhW14tLoIhmXG2hxA316k9xaP2CZQmwkF8a2G2HxzcMjuHnoHpbUq
         Xtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMGDUJYEnf9KDdTw5F3ZbgchLlVWOkkRHiagdTu86+c=;
        b=NYEStUwCehtHBm/wNyTE2rqMApSmbeIFZuet+UQGgeQza3b7Wdb7fZrjST6nM0yIEW
         +wdbuSMXqwgWTY3x6UMRZWm4Qw7JHsdWy1r5xWY0/f7H72eMpfdVYhgPlXqBFd5tbdMl
         kzoIOEUgwDXHslZSrb/h8l2F2DekUNmDSZ4Pz/6woUoYCb0YIya3fMsRBado6BPkSDl2
         9F/A3I9blDKESEwbz7TK/iU/sMsbt8DIJpbUnBwus78ZHMPwZ7lvt4qylUMuI9UlF0WB
         1WctSF6n5aVmigt6/k7UGMQIa5V/9zhMX7rQGJjmpm+YN7ygY5HXazovA9w/bxrZJCZ+
         gFWQ==
X-Gm-Message-State: AOAM5326mUopLLqf5U6NktqxZXzR2dwPTb58Z5ART6aPXQc5GCtv3OE3
        QB5dhUFPEpJNBEhr2Li8EQjlvgEvkAc=
X-Google-Smtp-Source: ABdhPJwj+30ca7Sn+dNlBPpWX9PMVTZK6EWBNHcq000s6/7Tp7rL9Sc0ItX7cjImNE680ql8A/umOA==
X-Received: by 2002:a37:a493:0:b0:46b:1df6:a85b with SMTP id n141-20020a37a493000000b0046b1df6a85bmr3459971qke.469.1645154041166;
        Thu, 17 Feb 2022 19:14:01 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m22sm21781730qkn.35.2022.02.17.19.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 19:14:00 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     mingo@redhat.com
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        atrajeev@linux.vnet.ibm.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, deng.changcheng@zte.com.cn,
        german.gomez@arm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] perf tools: Replace zero-length array with flexible-array member
Date:   Fri, 18 Feb 2022 03:13:52 +0000
Message-Id: <20220218031352.1906077-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use "flexible array members" for these cases. The older
style of one-element or zero-length arrays should no longer be used.
Reference:
https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 tools/perf/util/event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index cdd72e05fd28..320cbcd5b902 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -308,7 +308,7 @@ struct perf_synth_intel_evt {
 		};
 		u32	cfe;
 	};
-	struct perf_synth_intel_evd evd[0];
+	struct perf_synth_intel_evd evd[];
 };
 
 struct perf_synth_intel_iflag_chg {
-- 
2.25.1

