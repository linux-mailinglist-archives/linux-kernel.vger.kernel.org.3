Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4B2570D52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiGKW3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiGKW3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:29:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326872A26D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:29:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so54591417b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=K0OuwQmEGasRg3T61Q5R2kuINEILQFbAvI3PiK5PAXg=;
        b=iCBlUt6yN6MXIcKUwwY+vKNoQRLZWoF+9g7eO3Ivfunwm0Yq91Na87FlcsJIfBGw1X
         ePEHq5loKbO/xX1ql0RR/2BeWkP17LtUU6W3zIm+Ef6RSk8hAo6+w6BEvMbtFt32Umc0
         uhx8p0u48KzYnwnLIanRinUgFwzQtRX4QuOTjQUGTKzzMqVqyGbcuBP6R9LCO9qNZ9GQ
         hsghzjMuAb8mHXxhOllMDH4M4te7p0DStvOpS03zD8H1PLFTcZnhPqu/PkHPt7fg2QL3
         EdONmBMmIcis/SacevBWEZejIlGq/Zo/N0K6RJt7Mpntix+Wj821VzoKqoDCRuUFIZPi
         enPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=K0OuwQmEGasRg3T61Q5R2kuINEILQFbAvI3PiK5PAXg=;
        b=dVFWfTv3yymObiTAgiFMGNy6EJLWKcXN+s/v4+YT7XxrBC1gITD0TUvGFhbff9vnnD
         SqcXZIDWEnqGnITGgu+ji52t5nPa1KB275AA9hCyqOJBtKIG+SWG5cnRTZ3Kq6a/aBU4
         ysT4gFe3AhJ0cqBrfeRvuDePWDdjLH7xUAj6pd+gBtpBov5SkI9gdrT+/9fEwyZ5qm37
         NpivRLg3u+0y4Ovyz7N/pe5D+QWRRimQ6MS4c460n8IjDiLSzAeamY6OOID//ftRjA5G
         PRmyZugwlECSJttRu0Rj80h2kCF2uMi0405GnKY5q/zHUzVB5s2Mm9UrLU7ylo0Yrfoi
         /2pQ==
X-Gm-Message-State: AJIora9JY9YHJ9NQ4IREVKl5pk6C/vkX3p9zJudo76kmcUSLm7HOjyfL
        hzlQ0giAWtDKHhUbhiocQ/8XVdUq2xHKyCHl1A==
X-Google-Smtp-Source: AGRyM1vsvg94wwIvZZdwVgFQlnYbw7EZY7JeDSMXYiBiIa1tKuXOgQO5tVD+lSd+jh5j9kRDjWweEdaHsqLLSCcvBg==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:4bd0:f760:5332:9f1c])
 (user=justinstitt job=sendgmr) by 2002:a25:abc5:0:b0:66e:3983:3ca7 with SMTP
 id v63-20020a25abc5000000b0066e39833ca7mr19375467ybi.168.1657578569477; Mon,
 11 Jul 2022 15:29:29 -0700 (PDT)
Date:   Mon, 11 Jul 2022 15:29:19 -0700
Message-Id: <20220711222919.2043613-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH] iwlwifi: mvm: fix clang -Wformat warnings
From:   Justin Stitt <justinstitt@google.com>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Avraham Stern <avraham.stern@intel.com>,
        Justin Stitt <justinstitt@google.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

When building with Clang we encounter these warnings:
| drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c:1108:47: error:
| format specifies type 'unsigned char' but the argument has type 's16'
| (aka 'short') [-Werror,-Wformat] IWL_DEBUG_INFO(mvm, "\tburst index:
| %hhu\n", res->ftm.burst_index);
-
| drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c:1111:47: error:
| format specifies type 'unsigned char' but the argument has type 's32'
| (aka 'int') [-Werror,-Wformat] IWL_DEBUG_INFO(mvm, "\trssi spread:
| %hhu\n", res->ftm.rssi_spread);

The previous format specifier `%hhu` describes a u8 but our arguments
are wider than this which means bits are potentially being lost.

Variadic functions (printf-like) undergo default argument promotion.
Documentation/core-api/printk-formats.rst specifically recommends using
the promoted-to-type's format flag.

As per C11 6.3.1.1:
(https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf) `If an int
can represent all values of the original type ..., the value is
converted to an int; otherwise, it is converted to an unsigned int.
These are called the integer promotions.` Thus it makes sense to change
`%hhu` to `%d` for both instances of the warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 430044bc4755..e8702184c950 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1105,10 +1105,10 @@ static void iwl_mvm_debug_range_resp(struct iwl_mvm *mvm, u8 index,
 	IWL_DEBUG_INFO(mvm, "\tstatus: %d\n", res->status);
 	IWL_DEBUG_INFO(mvm, "\tBSSID: %pM\n", res->addr);
 	IWL_DEBUG_INFO(mvm, "\thost time: %llu\n", res->host_time);
-	IWL_DEBUG_INFO(mvm, "\tburst index: %hhu\n", res->ftm.burst_index);
+	IWL_DEBUG_INFO(mvm, "\tburst index: %d\n", res->ftm.burst_index);
 	IWL_DEBUG_INFO(mvm, "\tsuccess num: %u\n", res->ftm.num_ftmr_successes);
 	IWL_DEBUG_INFO(mvm, "\trssi: %d\n", res->ftm.rssi_avg);
-	IWL_DEBUG_INFO(mvm, "\trssi spread: %hhu\n", res->ftm.rssi_spread);
+	IWL_DEBUG_INFO(mvm, "\trssi spread: %d\n", res->ftm.rssi_spread);
 	IWL_DEBUG_INFO(mvm, "\trtt: %lld\n", res->ftm.rtt_avg);
 	IWL_DEBUG_INFO(mvm, "\trtt var: %llu\n", res->ftm.rtt_variance);
 	IWL_DEBUG_INFO(mvm, "\trtt spread: %llu\n", res->ftm.rtt_spread);
-- 
2.37.0.144.g8ac04bfd2-goog

