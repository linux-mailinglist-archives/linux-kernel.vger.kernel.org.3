Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700E855F43D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiF2DmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiF2DmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:42:01 -0400
X-Greylist: delayed 84 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 20:42:00 PDT
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B861A83F;
        Tue, 28 Jun 2022 20:41:59 -0700 (PDT)
X-UUID: da7a4e636f9a415fbe13f7633b35e301-20220629
X-Spam-Fingerprint: 0
X-GW-Reason: 11109
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HNeS6uumcgOimgeWuoeaguA==
X-Content-Feature: ica/max.line-size 71
        dict/adv 1
        dict/notice 2
        dict/time 2
        meta/cnt.alert 1
X-CPASD-INFO: 4dec875638984b63ba29906e357124bd@fbSfg2VpY2ZfWHuEg6WBbYKSYmlpXFa
        0dW9XYWBkjoSVgnxsTWBnX1OEgnBQYl5dZFZ3dG9RYmBgYlB_i4Jyj1RgXmCCVHSTgHaehZNmZw==
X-CLOUD-ID: 4dec875638984b63ba29906e357124bd
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:186.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:65.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:0,DUF:126,ACD:2,DCD:2,SL:0,EISP:0,AG:0,CFC:0.347,CFSR:0.105,UAT:0,RAF:0,
        IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EAF:0
        ,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: da7a4e636f9a415fbe13f7633b35e301-20220629
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: da7a4e636f9a415fbe13f7633b35e301-20220629
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <xiongxin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 129007890; Wed, 29 Jun 2022 08:34:15 +0800
From:   xiongxin <xiongxin@kylinos.cn>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiongxin@kylinos.cn
Subject: [PATCH -next 0/2] PM: suspend: Optimized suspend is fail returned by wakeup
Date:   Wed, 29 Jun 2022 08:33:36 +0800
Message-Id: <20220629003338.299195-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_05,KHOP_HELO_FCRDNS,
        RCVD_IN_PBL,RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the suspend process is executed from the /sys/power/state entry,
the pm_wakeup_clear() signal is cleared in advance, and the wakeup
signal can be captured to fail the suspend process when the suspend
process is notified by the notifier;

Expanding the scope of the pm_suspend_target_state variable also allows
the device driver to know that the system has entered the suspend
process earlier.

xiongxin (2):
  PM: suspend: expand the assignment scope of the
    pm_suspend_target_state
  PM: suspend: advanced pm_wakeup_clear() for normal suspend/hibernate

 kernel/power/process.c |  5 ++++-
 kernel/power/suspend.c | 13 +++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
