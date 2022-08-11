Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A04B58F83A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiHKHSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiHKHR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:17:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0239991D26;
        Thu, 11 Aug 2022 00:17:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dc19so31898454ejb.12;
        Thu, 11 Aug 2022 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZvXY0zjdSQar1LhFoG7pMDMDb1LO+cB6QxOAhKBfXDU=;
        b=gSI8KpwlkkSDzHXILMKRZXW229dFlkJiV2CPJkHY7dsbloBjGRf2VCLmjyKnGLuqyy
         qmRq9s6Kq1tX9phrGljWE2CJzr/zedePplEqEHh5EMB/3SiW3LqYOh+Zv9/idGDzQpxG
         OaVTtj92vbJRBXZYWzd5F5aQXegSqLqLBbnfyTkut+XX1mDyb4L7BFRvNyCTCqoEQ0Mh
         f4aQIZkQmh99njq8gQFHTZJazSHkypC+dTmqj/LCjGzTnbknNinxpnrDYQ6EGQcZmElH
         CAdCIX14E2T5TAl4e8Xg2nEE+00KvifKiii0r/eFyL5YeR53lUdsv8zM2TvHGhjIjcip
         uf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZvXY0zjdSQar1LhFoG7pMDMDb1LO+cB6QxOAhKBfXDU=;
        b=RycrckYLaJvX8rrMMKHuETm2/q6Eem7IDbHoSP+iVhpvUvu1bz+BdigacbS+hsw/wX
         WXXCbDQOcfImn0/SNaCjg1lBaJUgzA9IHyPHT7kmIjPRlF5IzIiQTm8DDQvJfPsXzvLT
         LqiNAXFOkqeUj8r9EPGYlrUNkXXpJBAIoo+TWSwZLJhQz0kGXEbuQjpUeZzfA2Nn5wor
         4HjdnIHWRKHqclGH+AflS8TGb35jwfhYvxio3QQSzVRggrT5ka6RrqQwdsGk5LRMjIWL
         yE7OvpSsMsqLROkh6YWhuECUfLVnPaTqR5Fgyr57iQl385T+m4mM1uWDBSZuLCJBC3xI
         wpPg==
X-Gm-Message-State: ACgBeo2dr5Efivt59Hr0EKKZh27nr3Sh1s+W518Hh41yekU7xLWfvGqL
        uBbGnMob6VwwTO+5R5tL3+s=
X-Google-Smtp-Source: AA6agR6jA05D0FTGGwqqIlljcCn01IaIBJly6bouB0UBn8dxhhX/OGvGM2DjHIazWXdyB3RHijnylQ==
X-Received: by 2002:a17:906:228a:b0:731:3a33:326 with SMTP id p10-20020a170906228a00b007313a330326mr15283933eja.253.1660202274218;
        Thu, 11 Aug 2022 00:17:54 -0700 (PDT)
Received: from felia.fritz.box (200116b8267089004d8d56997cb46253.dip.versatel-1u1.de. [2001:16b8:2670:8900:4d8d:5699:7cb4:6253])
        by smtp.gmail.com with ESMTPSA id i22-20020a50fd16000000b0043df40e4cfdsm8674666eds.35.2022.08.11.00.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 00:17:53 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] tracing: react to error return from traceprobe_parse_event_name()
Date:   Thu, 11 Aug 2022 09:17:34 +0200
Message-Id: <20220811071734.20700-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function traceprobe_parse_event_name() may set the first two function
arguments to a non-null value and still return -EINVAL to indicate an
unsuccessful completion of the function. Hence, it is not sufficient to
just check the result of the two function arguments for being not null,
but the return value also needs to be checked.

Commit 95c104c378dc ("tracing: Auto generate event name when creating a
group of events") changed the error-return-value checking of the second
traceprobe_parse_event_name() invocation in __trace_eprobe_create() and
removed checking the return value to jump to the error handling case.

Reinstate using the return value in the error-return-value checking.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/trace/trace_eprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 4a0e9d927443..550671985fd1 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -883,7 +883,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	trace_probe_log_set_index(1);
 	sys_event = argv[1];
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
-	if (!sys_event || !sys_name) {
+	if (ret || !sys_event || !sys_name) {
 		trace_probe_log_err(0, NO_EVENT_INFO);
 		goto parse_error;
 	}
-- 
2.17.1

