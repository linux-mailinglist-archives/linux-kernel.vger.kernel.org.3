Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D56D5A4CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiH2NCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiH2NC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:02:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7870E62
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:55:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p18so7878391plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=y8JRr8kgovDGUSbrIvtDYU07Ci2xm02sK97rHOtJi1s=;
        b=TOxy9FhNRXuKLyAztNnapaCJw7BgoL0j8IeBdyeV/V2QZtRFnPELVaHc3PdaN9JFHr
         g10avkzutpmPFtL4q1SRlT4ZV3VamEiWCnRUzrTsJaAQhgO0v6Rfe1J5KG/8UoRC0nPP
         MjMSf3Bl2/FPVxJVPmc957c7o6Ps930In4MAfp4D2xH3WceF9fzb8s0NQX/f6EK1fJUe
         Bb04HQseeI2lGkANvO7gfJ1yym+lU13CGe4f5DxnTavDMYuu/wU73Gl0WkYL9P/DccT+
         xDx4VQPkJ300kePvO5ovjM1aA+BsuRY2Zy3ttx5yShVbr/oXdmaxvuXsUxi3WssLNash
         /6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=y8JRr8kgovDGUSbrIvtDYU07Ci2xm02sK97rHOtJi1s=;
        b=eQpz0LrY34tM8eL2iHsRx1eV95oJaSsZS/PcvdhpIEZutbYP6RMLWOjIIMwJQvBGua
         J03hMO3wJEfACtWOVpe0MCDxml4ZSapZTkLUc1stpBTh25RpirzruHdiQaS3ZZWW6Jcu
         +zMbbGa+ucFDotJndVSnGei3KFM60ZtejuiQuzeZztiIJcdrkPYEakkp6H0zwuhB4/qG
         Hn7ziA2ZxTbUdvMMK08i+EWmjy4q6wNnEUENKLD36DbYSf4LO4JISFZHt+c1R2zbXcJ8
         LH36MSfgzama+WTexfw4BQWKHfXcPQFFZoeEOeKJyRidYFmgI//t2uSXPUWgPqKi7hYb
         2ccQ==
X-Gm-Message-State: ACgBeo1tpQsa745hMCUS+lU9nALNBRas8yihEdXc4Ppbu/yVHosokQ+h
        tjknZMCrsIysVzOTQnJP+ROtKEb05bw=
X-Google-Smtp-Source: AA6agR4fkfMtcyz5bMUfZlo9epwlUt+cxichMZA/MpW7aL40VmVjXauvIS8cgKyRYJFzKHehK6FAiA==
X-Received: by 2002:a17:902:dac8:b0:174:d1ac:182 with SMTP id q8-20020a170902dac800b00174d1ac0182mr4108789plx.64.1661777715768;
        Mon, 29 Aug 2022 05:55:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b001fd7cde9990sm5004425pjz.0.2022.08.29.05.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:55:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     xu.panda@zte.com.cn, ray.huang@amd.com, dsmythies@telus.net,
        rafael.j.wysocki@intel.com, Jinzhou.Su@amd.com,
        Zeal Robot <zealci@zte.com.cn>,
        zhanglin <zhang.lin16@zte.com.cn>
Subject: [PATCH linux-next] tools: power: x86: intel_pstate_tracer: intel_pstate_tracer: Replace the relative path of the called grep with an absolute path
Date:   Mon, 29 Aug 2022 12:54:48 +0000
Message-Id: <20220829125447.268741-1-xu.panda@zte.com.cn>
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

From: xupanda <xu.panda@zte.com.cn>

Using absolute paths when invoking grep can lead to serious security
issues. A malicious operator may create a new file named grep in the
PATH before the real grep file. When the program executes and calls
grep, the fake grep file will be executed, so that the malicious
operator can execute arbitrary code or even obtain root privileges.
Using absolute paths when calling grep avoids this problem.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xupanda <xu.panda@zte.com.cn>
Reviewed-by: zhanglin <zhang.lin16@zte.com.cn>

---
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index b46e9eb8f5aa..d6fae6e51d30 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -348,8 +348,8 @@ def split_csv(current_max_cpu, cpu_mask):
     if os.path.exists('cpu.csv'):
         for index in range(0, current_max_cpu + 1):
             if cpu_mask[int(index)] != 0:
-                os.system('grep -m 1 common_cpu cpu.csv > cpu{:0>3}.csv'.format(index))
-                os.system('grep CPU_{:0>3} cpu.csv >> cpu{:0>3}.csv'.format(index, index))
+                os.system('/usr/bin/grep -m 1 common_cpu cpu.csv > cpu{:0>3}.csv'.format(index))
+                os.system('/usr/bin/grep CPU_{:0>3} cpu.csv >> cpu{:0>3}.csv'.format(index, index))
 
 def fix_ownership(path):
     """Change the owner of the file to SUDO_UID, if required"""
-- 
2.25.1

