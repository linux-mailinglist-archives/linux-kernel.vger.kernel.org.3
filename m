Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C834EE14D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbiCaTGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbiCaTGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:06:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB652215466
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:04:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x2so426794plm.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8K4qat18oyS/ON0Tc2wg3IJl/20RhGtMMHJnn7j74hI=;
        b=fu9LzFVAlRADxGRQVppAXuCP8QEOUuMJxhDaoGIzZSn5yF2pGIuxmwhJTWp5woQn4H
         EHzaLrxIYiJVgpunyLYPv3S9IfZSVNpubgMt/4tO/0lijzJbE1/2ZK2lcEqWyuEedN3T
         2+pKK2PG5hJ9rQ1KKpCLZBGkXKvVi+SILZFbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8K4qat18oyS/ON0Tc2wg3IJl/20RhGtMMHJnn7j74hI=;
        b=YxJs8CSHZR32C2TAWwD80VjKM+Vbd5FBGKIoNwjbj11Sdx+6zgYfBhrQKS0pnYDoL5
         6BzEK3TeF5Qvjby8Zx0Iu383J7xfVxYMk/nAxkriXTcbgrzvj8DE9btTRGnGaEnXBPB3
         rwtsg57knkXPaFo82lUoF5Jua9kv+Z2R3eFa6pLhlifHcTan5KwyfXNIDeHePYcc4/V/
         z5CumvFOLx7sPEpBQTpoDGdwMD1GgYFM8zK924yhmiW2Yf7HoLmx9kCMmUZcywRKmz99
         uraQldreuqD5CC7sMVDsABrJGU0MgtalemR9vEPCsyumAmQDCnrROxuWybZpPjwWY2/C
         gbBg==
X-Gm-Message-State: AOAM532zjWd/iCqpvpYrltefIqoAQ2J5KaFTZudIXsV5tLebuQT+RDMZ
        1NnwD3YlHN1qaJHQgQbV7OODtw==
X-Google-Smtp-Source: ABdhPJzmGmj8aYdwRSZROHgiAtffDN6in63gKRVnyEHWKadCoiriCaM3lZSBHfVtkIHAxWU6vFCsrg==
X-Received: by 2002:a17:902:d2c6:b0:156:2b2c:ab54 with SMTP id n6-20020a170902d2c600b001562b2cab54mr16131133plc.52.1648753486453;
        Thu, 31 Mar 2022 12:04:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v22-20020a056a00149600b004fb34a7b500sm196147pfu.203.2022.03.31.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:04:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ARM: vexpress/spc: Avoid negative array index when !SMP
Date:   Thu, 31 Mar 2022 12:04:43 -0700
Message-Id: <20220331190443.851661-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; h=from:subject; bh=/2a5CSsipys253M5vGRsqHVDoYM5WGy53UpPjsagOIc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiRftKixEnPaz5DYx3KcOYhAntbvuUAggDZhiZY7iw bo/iWgyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYkX7SgAKCRCJcvTf3G3AJn1+D/ 9JmnMmf4cTjvYcKaiTm+ZsZZnuFtJXdv4Sj5cEH11WQawVe+UAqmL0m1glp2GYK85YUhuNPWdd/2An 2zH3JiJlWtqNuCF8jHcxmtuSgvUfnipd2s/l5v12j/RyWt7yUJBB/f+RA68i2rAnPTLL+MerHlWtyb PhxoFZjC7hcnw/3gdFHtOQlTC5Z4Lw57BivrJXu7OBCGCFwK2R0ArvLd2alzA8/cOpesKeB1d2y7Ft N7SQIMtttTn1UaqFUxP5fAJbwQVgdvSbig44DEep6jFro3jykxmBiK44bGqIy/SGK3w2gDnRfDJk0S IaqlI3aixjk7Vh1lnsPLB42Bp6enuHtDlrLJejwBs11oBOh3J5fJKEZ0HnXDWQ1/iZsgb7aOpcQWh3 5/R4Di8zHLA4ywpxPYhsNey5F8A4Pf2U/RCo1uIUehCc/cjO6CaoddINTyJJ+Sz7fhjDrbVLLHzg1O AFtV6Wwp2HJv1Dpry96HDj6aDhK74xNllVO22PzFa46p0o4gi7flIyfOK6Mdxz/8UthhjoRXKIcJk1 ewXb0ZYaFh38NvdBpaC0xA193NKbxRb+hlwz21p1+6FreJdjhYMhaR+cYFkUhCVh6dRqUpiw37fYs9 CMKyba1yS3vRZqEXSCU7fAq2QtFHELV0CqQ+URjZHEklvJABZrjanhwsn6fw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building multi_v7_defconfig+CONFIG_SMP=n, -Warray-bounds exposes
a couple negative array index accesses:

arch/arm/mach-vexpress/spc.c: In function 've_spc_clk_init':
arch/arm/mach-vexpress/spc.c:583:21: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
  583 |   if (init_opp_table[cluster])
      |       ~~~~~~~~~~~~~~^~~~~~~~~
arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
  556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
      |       ^~~~~~~~~~~~~~
arch/arm/mach-vexpress/spc.c:592:18: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
  592 |    init_opp_table[cluster] = true;
      |    ~~~~~~~~~~~~~~^~~~~~~~~
arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
  556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
      |       ^~~~~~~~~~~~~~

Skip this logic when built !SMP.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mach-vexpress/spc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 1da11bdb1dfb..1c6500c4e6a1 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -580,7 +580,7 @@ static int __init ve_spc_clk_init(void)
 		}

 		cluster = topology_physical_package_id(cpu_dev->id);
-		if (init_opp_table[cluster])
+		if (cluster < 0 || init_opp_table[cluster])
 			continue;

 		if (ve_init_opp_table(cpu_dev))
--
2.32.0

