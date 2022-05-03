Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AD8517CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 07:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiECFJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 01:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiECFJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 01:09:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2203C49B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 22:05:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e24so14416641pjt.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 22:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUR+Fzyi0wXWDRgicMjU0F6RGiNS9EhyaW4ixdRzu8Y=;
        b=LPwXhlpWKq1b0+lhNSyGJV0JJL4714gxXsCDDuPz5ivWqq5p94jBP4P1QaqC/YV7hk
         9MzrewJsaWZzlE7SG6jiXu2GGjFolaq0hhgH3OPzpaKdaIV03b5rndYTJALgBOdno2fE
         a3QZ5BuB6zna2SgaDGWgCDLGxq+q3Ms4/WnDpHc8DxKP323Y3xRUkNgHwYXSSeEcjYYc
         N+JCaBzPe+7PWIBsFAUYlO2va65IirqIB+Iq6nMT2rMaFOKd4eELBy4ZySGPOFh8oCif
         soDydPkbmykOWGVYH9YZ7HfDfy8CnoJ3unP+C3bDkRwqFVV/EohXeaW14ujE+Z0rSPHi
         d/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUR+Fzyi0wXWDRgicMjU0F6RGiNS9EhyaW4ixdRzu8Y=;
        b=GwkKQgbdoIqQvi2TjlZ0pZ/dG4ke2UB0AuHvajdEA2kVjqchczTcP23Tn7TXAbzD0x
         hCeGIZlGbWS2F0IgQD3j08PutLf+k6OSBNsR2OPhxgdxICtenCLxlMDL5rxaYmyIrFES
         uagwrOMRHFiL+uALqkU+vjqPdE2dDMs8rVCzqkFqf7rXWsEoDRRYi2Zej257eEWNXu8z
         /i3jBFZp+i5B7r8hDv8ppfd1YflGDB5PKl0FujbtuO1o7O3FaTAr3b2ODOA3EO7QFZng
         Bhrs6roFQlHSAYvG6/QCiGLPWYsQIdH4sibRkg7LdU3SqOTAjRiVAJeMejrvOouy6d88
         zYQw==
X-Gm-Message-State: AOAM530R1+87+Q9zRHrosol5JZPB6UxQNusPuvZo43sZJI/2vSvblaAo
        397THK5Syl+dbZRNRISFbKc=
X-Google-Smtp-Source: ABdhPJwhG708Pk8DgLSic/jLiIG+CXDDAmvkWy/Dbv+YFaKQ9Zn/10y0UimG67gpFHbGoq6TLnlP1Q==
X-Received: by 2002:a17:902:dac3:b0:15e:a136:b59c with SMTP id q3-20020a170902dac300b0015ea136b59cmr9146438plx.135.1651554354432;
        Mon, 02 May 2022 22:05:54 -0700 (PDT)
Received: from localhost.localdomain ([125.131.156.123])
        by smtp.gmail.com with ESMTPSA id v21-20020a17090331d500b0015e8d4eb2a6sm5502122ple.240.2022.05.02.22.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 22:05:53 -0700 (PDT)
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Wonhyuk Yang <vvghjk1234@gmail.com>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix return value of trace_pid_write()
Date:   Tue,  3 May 2022 14:05:46 +0900
Message-Id: <20220503050546.288911-1-vvghjk1234@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting set_event_pid with trailing whitespace lead to endless write
system calls like below.

    $ strace echo "123 " > /sys/kernel/debug/tracing/set_event_pid
    execve("/usr/bin/echo", ["echo", "123 "], ...) = 0
    ...
    write(1, "123 \n", 5)                   = 4
    write(1, "\n", 1)                       = 0
    write(1, "\n", 1)                       = 0
    write(1, "\n", 1)                       = 0
    write(1, "\n", 1)                       = 0
    write(1, "\n", 1)                       = 0
    ....

This is because, the result of trace_get_user's are not returned when it
read at least one pid. To fix it, update read variable even if
parser->idx == 0.

The result of applied patch is below.

    $ strace echo "123 " > /sys/kernel/debug/tracing/set_event_pid
    execve("/usr/bin/echo", ["echo", "123 "], ...) = 0
    ...
    write(1, "123 \n", 5)                   = 5
    close(1)                                = 0

Cc: Baik Song An <bsahn@etri.re.kr>
Cc: Hong Yeon Kim <kimhy@etri.re.kr>
Cc: Taeung Song <taeung@reallinux.co.kr>
Cc: linuxgeek@linuxgeek.io
Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
---
 kernel/trace/trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 124f1897fd56..a8bef684e8a3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -721,13 +721,16 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		pos = 0;
 
 		ret = trace_get_user(&parser, ubuf, cnt, &pos);
-		if (ret < 0 || !trace_parser_loaded(&parser))
+		if (ret < 0)
 			break;
 
 		read += ret;
 		ubuf += ret;
 		cnt -= ret;
 
+		if (!trace_parser_loaded(&parser))
+			break;
+
 		ret = -EINVAL;
 		if (kstrtoul(parser.buffer, 0, &val))
 			break;
@@ -753,7 +756,6 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 	if (!nr_pids) {
 		/* Cleared the list of pids */
 		trace_pid_list_free(pid_list);
-		read = ret;
 		pid_list = NULL;
 	}
 
-- 
2.30.2

