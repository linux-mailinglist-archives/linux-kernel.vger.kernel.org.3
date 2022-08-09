Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD7258DD46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbiHIRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245439AbiHIRgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:36:46 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB83252A9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:36:43 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 38DB5308CDE;
        Tue,  9 Aug 2022 19:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660066600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VZt664nU4iaCEsjl//1sznp9FIoqKqqif3OcJAGljig=;
        b=EiHd7VtY0+B2qxg2oDafaNv8DICAxZNMixrVzmK63kjfI+rMni8SSE/qdVmkRoS6Jjej29
        6YVYNStKQJ3oYJ2llf9g9D3OevBvpsN+BjisVJO7acTNRvDtW2S3PhQvrqeSIYS0FZvCxh
        3P15ZfLYyff20AB96NzDzL/Y87o3lbYpt+zoyUWcB/UlyqgmK0DhYcD9y5l7hs24RX//O9
        Pd6jj6I5nov6IdvHqDBr3jA6aBmxlBOEQ5Pvac597vB6npnzB1qkPVs/PdyJOHfDKwXhB/
        Ncf7GEharjAn6mRzzfBB/fQ8RDuYhZxZqpch4X1Cfkvv8F/H/5tZn3DjPZ8/EA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 0/3] cpumask: UP optimisation fixes follow-up
Date:   Tue,  9 Aug 2022 19:36:32 +0200
Message-Id: <cover.1660066581.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an older version of the UP optimisation fixes was merged, not all
review feedback has been implemented.  These patches implement the
feedback received on the merged version [1], and the respin [2], for
changes related to include/linux/cpumask.h and lib/cpumask.c.

[1] https://lore.kernel.org/lkml/cover.1656777646.git.sander@svanheule.net/
[2] https://lore.kernel.org/lkml/cover.1659077534.git.sander@svanheule.net/

Sander Vanheule (3):
  cpumask: align signatures of UP implementations
  lib/cpumask: add inline cpumask_next_wrap() for UP
  lib/cpumask: drop always-true preprocessor guard

 include/linux/cpumask.h | 26 +++++++++++++++++++++++---
 lib/Makefile            |  3 ++-
 lib/cpumask.c           |  2 --
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.37.1

