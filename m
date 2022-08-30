Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552525A71E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiH3Xdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiH3XdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:33:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2AC9A9CC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33daeaa6b8eso189192867b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=dj50MXIaDJBD96/1Gdf430/wXU4xb7a84h2xVZMa0Ew=;
        b=Qy/xMjE+Z9tI/RI2eW9aQXEE+x9bgipZmkl1TRFX4nG3lQ2Cxw/MGc9YBEMVb79P8x
         K7ZB6jWVCCidlAiCQ0KHSLobGlEUBTBOYT+IN2cosr4rJjNKEzJDFeo0nWGSZgVhOFnN
         LnJtK+KQLFx71PgotB16ka4GRRJjpTFnPNLg7HhkuXjEppj+KAqhY9tM//ZHz2AfaJ4E
         ojP4CyQHCBUPqv0EbNTJy1R5yPCLjtX4xD1E5S+rzObYF7P/nQl/buKNJiO0O+4YpcJO
         KWS4peUjbZVcIeXOVLV02EwcnTADwVU+JJD9CdooT51s51cyuvBlc8byyEyM9/c9zYEC
         TUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=dj50MXIaDJBD96/1Gdf430/wXU4xb7a84h2xVZMa0Ew=;
        b=pMbDLlfXhwsjRbE8GIM9brNSeG3pjstNgitWGzLpP7Y/KLiixnav4us9J9KMTOn/qr
         i+hJLvGoVZN706tTLIC6koYoPWbApKjwwEe0cVmz2nSTiw48YYbCoqe7EU/AEy4WjWxk
         ueup0UT004RX3QUu2gYd7qfEQ+GKKuNrjcmr4q3BVzk+7JxRQ7TiY6DeQOTjw5MX6R9o
         KNzjyWPcYtR02SbVG9wJu1h8yvQyWOfsLBMxs0z/m4OQ8Rq1WK6NpGawqO4VZ4W593mV
         SDqjvtiumMRKg7/Iqd37ZM5QV30SI1ornbDoZDQFvqc+bZ6SvMnmq1jFzSJ8wKkddgj4
         4tcA==
X-Gm-Message-State: ACgBeo1095B867//j2Xa/9JP/AI/wMHvCXnEQ6XZjPOe+oFJuOMSK8EU
        HoL3msR+UgGYfM5nmXB5SthVZqe7Hs2gq5H9D/FlbSURcIGZsQo5SIQ2gbHnc7vwao5ZWBE7YHB
        qs2KLXnXuKEVll9UhjMIUfld5nq1s9wy8y5+lZHvHzNpQMutfnmHEAMrnWMqFfYsbEytfDTtDrH
        7cMJO8J2YEVw==
X-Google-Smtp-Source: AA6agR5LroJ1DHbPpfH8aFh9/G1HMs3AO252ceiCeo1jPAZmf7JXzZYp5Fa4eHZtuGTExuaU7+SLdODaNccTaYcpsSo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1206:b0:676:e465:24b1 with
 SMTP id s6-20020a056902120600b00676e46524b1mr13676826ybu.323.1661902342496;
 Tue, 30 Aug 2022 16:32:22 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:26 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=samitolvanen@google.com;
 h=from:subject; bh=PQGbduDYSHEunY6Nux9oR4b8gX3kqUUQ66z3bs0DO/k=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3OHJOh3MpkrcMboNL3mLB+U7xNHC0btjo7mME4
 CgYIObyJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzgAKCRBMtfaEi7xW7ibxC/
 9u8tiBUAu11iMi2jQxB88ZoyRd3XcPtlmEJ49ZT4ibCRTKCQwU7x7cDMnDG2jMK91BvisB+yihmg9w
 N/xNoX9Du1hqgmpQ189vSRzZ8B3cTextiO0ei30mC5sYpY4O7ZzhfZ2RUhJ9GhDyhAqAEf/dyh6i7R
 slJI0p2V7MK2rO8Z0jyvl0g73TadyQ3IuIyhqfnc0JWw795W5qT0rTDncrsYsDg9bHqVA69umBLW/E
 JBpKqxPr5+1G3RypfC6VZNWayPrVcMVECCxIeWoI8JfgWyBD5zQ2Zeyjo3El1kUNH/J3pinc2ucgj0
 nCmZucarH0zhjvQSUJC5X8OSCGQyDJClv+hqBEIWhQ0gvLN9UVnXd5Ql7r49YFrN1kk9AWrqjbQ3Sc
 AD5ZEd5SjOGYRv3rAgmv+XiFslu7d+xB6EyKfNX1+EmfFdYMhyVFQNijCiaFZSRvXJJ7dnhc8wF96j
 FE3UOfpxc1eA3nQd4sJS9gasOaTmoIocuonggQXaz5kqM=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 18/21] x86/tools/relocs: Ignore __kcfi_typeid_ relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler generates __kcfi_typeid_ symbols for annotating assembly
functions with type information. These are constants that can be
referenced in assembly code and are resolved by the linker. Ignore
them in relocs.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/tools/relocs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e2c5b296120d..2925074b9a58 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -56,6 +56,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__kcfi_typeid_|"
 	"__crc_)",
 
 /*
-- 
2.37.2.672.g94769d06f0-goog

