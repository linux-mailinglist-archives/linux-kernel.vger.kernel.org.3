Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A0F5717ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiGLLDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiGLLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C204CAF75E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657623772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aS7v9z7WJeQGcaAxEI9Fwyovjw+f4FK+VX9Xj+gNYNQ=;
        b=SJ2u8W+cxAcprlRdFq49lyek4Al+NaWFk1DeNRXfTjRtKhm0k4BfxNWSBiRxdN5oLxEUYv
        tcX96cgIofWEGXbV6ZnaxWV/rvcUojTS8VqXgXwQ/hvTSLXMlO3h8q2lyQuURmUrmssIqs
        vKT0/3e47EbQ0efQHkw/QXHezYkeOTY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404--ZLUNTGmNNuQfWI10wzqYg-1; Tue, 12 Jul 2022 07:02:51 -0400
X-MC-Unique: -ZLUNTGmNNuQfWI10wzqYg-1
Received: by mail-wr1-f71.google.com with SMTP id o1-20020adfba01000000b0021b90bd28d2so1298074wrg.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aS7v9z7WJeQGcaAxEI9Fwyovjw+f4FK+VX9Xj+gNYNQ=;
        b=tNgFTEp4CxlEJgGIDXyuQnnDzDgVQdRi021+SGSdsZH1Y+IGBd+2AnS1uuJoDbrOt2
         /XrqmIP87zw5C+qHU93aECZuqeZOFX+mJi8VjG5KRm6aEGqjHrMOkDzRQOX9xHsCQ4ul
         wam1JEgLLxI/qEaE6QSZint8EVL11lbNnCojZv78x5hv6kBnCwhtj62EUAiMjQykmMbv
         rdsE+mXxYnxT8S0/Q7SarSb49nIFPdlpuavnjL8c1gzo+nFCRXEap3tEnhZckgWKksSq
         7JHoCilNq6TmIBiIHfmJmJkfDQeUJRMTQozmGKpVpgRgG5jHva/ZojXKWfdjtAzLSV/e
         xpRg==
X-Gm-Message-State: AJIora+zmCKbDhI9j9um4xDm0pHMI9gDfRhe3AUWvBh6y6SGIVO7BABe
        Sh1uw7WCq/uJHwHaPyf+k3CdaHmydB6cBpyxeNy6Eut72zMVWZJS6PzlT1VSf78h9GsSJSOyqSP
        V8l2l4JKowZx//MfOxxV+8QI=
X-Received: by 2002:a05:6000:1789:b0:21d:7279:f455 with SMTP id e9-20020a056000178900b0021d7279f455mr21222483wrg.542.1657623770568;
        Tue, 12 Jul 2022 04:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u29djuX+5S4JFK+HM4DFjGzK4ZNfo2QRf0VkhySynRDg6oSq9PKyFQFt6LZby2DQ9GJOh64A==
X-Received: by 2002:a05:6000:1789:b0:21d:7279:f455 with SMTP id e9-20020a056000178900b0021d7279f455mr21222460wrg.542.1657623770420;
        Tue, 12 Jul 2022 04:02:50 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d634f000000b0020fcaba73bcsm8046729wrw.104.2022.07.12.04.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:02:49 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     atomlin@atomlin.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts/gdb: Ensure the absolute path is generated on initial source
Date:   Tue, 12 Jul 2022 12:02:48 +0100
Message-Id: <20220712110248.1404125-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Post 'make scripts_gdb' a symbolic link to scripts/gdb/vmlinux-gdb.py
is created. Currently 'os.path.dirname(__file__)' does not generate
the absolute path to scripts/gdb resulting in the following:

    (gdb) source vmlinux-gdb.py
    Traceback (most recent call last):
      File "scripts/gdb/vmlinux-gdb.py", line 25, in <module>
	import linux.utils
    ModuleNotFoundError: No module named 'linux'

This patch ensures that the absolute path to scripts/gdb in relation to
the given file is generated so each module can be located accordingly.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 scripts/gdb/vmlinux-gdb.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 4136dc2c59df..3e8d3669f0ce 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -13,7 +13,7 @@
 
 import os
 
-sys.path.insert(0, os.path.dirname(__file__) + "/scripts/gdb")
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + "/scripts/gdb")
 
 try:
     gdb.parse_and_eval("0")
-- 
2.34.3

