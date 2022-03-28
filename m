Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5581A4E8C32
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiC1CcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiC1CcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:32:07 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9693EB82;
        Sun, 27 Mar 2022 19:30:28 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B350B200489;
        Mon, 28 Mar 2022 04:30:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B79820043F;
        Mon, 28 Mar 2022 04:30:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5E2A4183AC96;
        Mon, 28 Mar 2022 10:30:25 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: [PATCH v2 0/2] remoteproc: core: fix issue for multi-instance
Date:   Mon, 28 Mar 2022 10:20:10 +0800
Message-Id: <1648434012-16655-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the rproc->power reference count to handle the multi-instance
case, move the state checking for 'stop' and 'detach' under
mutex protection, and remove state checking for 'start'.

Shengjiu Wang (2):
  remoteproc: core: Remove state checking before calling rproc_boot()
  remoteproc: core: Move state checking to remoteproc_core

changes in v2:
- drop 'remoteproc: core: check rproc->power value before decreasing it'
- refine 'remoteproc: core: Remove state checking before changing state'
  split it to two new patches.

 drivers/remoteproc/remoteproc_cdev.c  | 11 -----------
 drivers/remoteproc/remoteproc_core.c  | 11 +++++++++++
 drivers/remoteproc/remoteproc_sysfs.c | 11 -----------
 3 files changed, 11 insertions(+), 22 deletions(-)

-- 
2.17.1

