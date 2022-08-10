Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A424858EF00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiHJPKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiHJPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:09:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D775FD9;
        Wed, 10 Aug 2022 08:09:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e13so19434529edj.12;
        Wed, 10 Aug 2022 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=f/VOOq8lXSlkiTFVM32cY0BcJPmVEl3q/12bVuDaQYY=;
        b=asjLVsS+PuxHh0j5TCEjcmVm3HYJxdeJGJroPrQIQBgb2x5Fa7ioKXwgzD1c1VsB6+
         8EFTRv9KpRFdD7Qr3iTh/AllzWQ3Ztqi0DyeHoUkY3dLLNiMmo/dDq/KFN+RsTVi7JAh
         ICDbAt4+EdjC5jGtJcbIpyvpjWcPHmCuBIAJdRadvIosOmPODYEqdL/bQwov1Hx2Otku
         9taFV+pl5wXkPYZ3kSL3c68JBnvsAQzoR14jb1zUARx/DrtMPBc9K5c1SbrB6tyxQ6Ku
         gyXRsObHyNq6mMonV3SJBf24qaZ/9VEgV0vmRykBemrFd81WG46KFMzoH13b+uEj9yVL
         XJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=f/VOOq8lXSlkiTFVM32cY0BcJPmVEl3q/12bVuDaQYY=;
        b=Wpt5gMSvVnDk1Dy14c04dX2ozoXV8P/yqdP4VuaVJ03hAwklx4m8MNWprDSE1t64+C
         8/x3/VtMkB9uX9lyYvoimkKQIdIZHqSDmTXkSJrgaRpbEKGWGKm8Yu88NcOm8WQNwVLc
         ohIuGaAox+eh/pxE/YmHSFnFmO+7p7oyPQqzMw0lxk8bQgpnJ4Gt2S5kqjjBnqR50dFe
         rP0lVnpmi53Wk653TBQwy129FRXOv9YYZxu1RJT+M9t5aHhfeDOTQUHS/QnEHnm5IhYe
         tOND4ZhnQcVLEf/sExAlyGEKvZMFfGELwm2XJCrXJhJPL3CuYrHq+viZVcCi/TAHLdJE
         EZjA==
X-Gm-Message-State: ACgBeo2gqEVMqc0uOR9KAGMHpUDNYUT5jRldZF5SiabLfQGIbq5VCoS/
        fI2rQoFpqGw+cKjuoVmO5Qvhy8CG/ag=
X-Google-Smtp-Source: AA6agR7Pi2BX4F2u2k11BqJFlDPz+CrdzSIRcFTEets2ZExEhWdZ16CQAYkc9z8ikshuPNi2SkP6bg==
X-Received: by 2002:a50:fb99:0:b0:43c:d008:d4f9 with SMTP id e25-20020a50fb99000000b0043cd008d4f9mr26827209edq.13.1660144192117;
        Wed, 10 Aug 2022 08:09:52 -0700 (PDT)
Received: from felia.fritz.box (200116b826708900bd59055014c64746.dip.versatel-1u1.de. [2001:16b8:2670:8900:bd59:550:14c6:4746])
        by smtp.gmail.com with ESMTPSA id p12-20020a1709066a8c00b0072af4af2f46sm2417358ejr.74.2022.08.10.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:09:51 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] tracing: react to error return from traceprobe_parse_event_name()
Date:   Wed, 10 Aug 2022 17:09:21 +0200
Message-Id: <20220810150921.8858-1-lukas.bulwahn@gmail.com>
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
index 4a0e9d927443..460d3ec8a256 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -883,7 +883,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	trace_probe_log_set_index(1);
 	sys_event = argv[1];
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
-	if (!sys_event || !sys_name) {
+	if (!ret || !sys_event || !sys_name) {
 		trace_probe_log_err(0, NO_EVENT_INFO);
 		goto parse_error;
 	}
-- 
2.17.1

