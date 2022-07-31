Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A070A58605A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiGaS2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGaS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:27:59 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 31 Jul 2022 11:27:58 PDT
Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1110BE1F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1050; q=dns/txt; s=iport;
  t=1659292078; x=1660501678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6I9TRH1ZkVMYRUP2fY6iFDmWZdaI7GodAr19qhlINQQ=;
  b=Vrzv8oiwXChLIcYR7XKSTkeJ6nBliAiNfaRdCFZtt8xKU/6FVnZU1TFE
   0kFpINoCZ/Fck6zmhnF4bH+vBjWtHBtWz+5z4gqFGp0Cbds1PFAjbdTb2
   5mvcvjba31CzHn4UBQ2CbS/M95TJy7zaxcS7tgWOoXLSc3zA+uAO31AAn
   Q=;
X-IPAS-Result: =?us-ascii?q?A0ALBgDAyOZi/xbLJq1agliDJVYsEo4RiHmYEIQAgXwLA?=
 =?us-ascii?q?QEBDzMPBAEBhQaEdyY0CQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwSBC?=
 =?us-ascii?q?ROFaA2GewFGhE4BgxoDEKZdgiuBAYNPAYEfhQwGgT2JeYVkBoFJRIEVgnqDO?=
 =?us-ascii?q?YJGhW4EgRiWbQMJBAcFSkQDCywPFgUICRcSEBACBBEaCwYDFj8JAgQOA0AID?=
 =?us-ascii?q?QMRBAMPGAkSCBAEBgMxDCULAxQMAQYDBgUDAQMbAxQDBSQHAxwPIw0NBB8dA?=
 =?us-ascii?q?wMFJQMCAhsHAgIDAgYVBgICNhg5CAQIBCsjDwUCBy8FBC8CHgQFBhEIAhYCB?=
 =?us-ascii?q?gQEBAQWAhAIAggnFwcTMxkBBVkQCSEcKBAFBhMDIG8FBz4PKDM1PCsfGwqBE?=
 =?us-ascii?q?iorFQMEBAMCBhgDAyICEC4xAxUGKRMSLQkqdQkCAyJtAwMEKi4DCSEfBwkwH?=
 =?us-ascii?q?ZZEgwc/gUWBA8FMg1uLIpRcGjGnbXqWfIlVKYM6lUyEUIFhPIFZTSMVgyQeM?=
 =?us-ascii?q?hkPlyaFTEJsAgYLAQEDCYZHiD8BAQ?=
IronPort-Data: A9a23:pAoe467LzZhw+ey71ivf3gxRtHjGchMFZxGqfqrLsTDasY5as4F+v
 jZLDWrSO/aOZWehLt8gboW38E4Au5HUy9AwG1A//ntmZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyOa/FH1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDkRVLW0
 T/Oi5eHYgX9hGUtajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFaJpqeScLiC+ivCay0bgNEnH2cpPUE5jaOX0+s4vaY1P3
 fUVMnUGaQqOwrvwy7OgQe4qjcMmRCXpFNpA4Tc7nXeDVa1gG8qrr6bivbe02B8wi89SA/vSe
 +ISaCFka1LLZBgn1lI/U8huxr7w2xETdRVHhlfEnJY0zVHCkhRR1bzyaeLZKtiVEJA9ckGw4
 ziuE37CKh4AOdOcyRKB83SxluHIgCX3UZ4TE7v+8eRl6HWXx2oOGFgVWEG9rP2RlEGzQZRcJ
 lYS9y5oqrI9nHFHVfH0Ugf9oWaDpAJZXdNMVeY78wqKjKHT5m51G1Q5c9KIU/R+3OdeeNDg/
 gbhcw/BbdC3jICodA==
IronPort-HdrOrdr: A9a23:HtWsl6uD+zLCg00K2ac4X5OI7skDf9V00zEX/kB9WHVpmwKj+/
 xG+85rtyMc5wx+ZJhNo7q90cq7MBDhHOBOgLX5VI3KNGLbUQCTQ72Kg7GO/9SZIU3DHio379
 YFT0C4Y+eAaGRHsQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,206,1654560000"; 
   d="scan'208";a="3282105"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 31 Jul 2022 18:26:51 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 26VIQpXu008219;
        Sun, 31 Jul 2022 18:26:51 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [v4.9] Fixes to linux-4.9.y stable tree swab.h and random initialization
Date:   Sun, 31 Jul 2022 20:26:30 +0200
Message-Id: <20220731182635.1910069-1-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered one regression when I merged 4.9.320 for one of our
platforms, the include of swab.h from user space (libudev) triggered the
error described in https://lkml.org/lkml/2020/2/12/93

Cherry picking that commit solved the problem as expected.
[v4.9 PATCH 1/6] include/uapi/linux/swab.h: fix userspace breakage,

Then the next part of this series:
[v4.9 PATCH 2/6] init/main: Fix double "the" in comment
[v4.9 PATCH 3/6] init/main: properly align the multi-line comment
[v4.9 PATCH 4/6] init: move stack canary initialization after
[v4.9 PATCH 5/6] init/main.c: extract early boot entropy from the
[v4.9 PATCH 6/6] random: move rand_initialize() earlier

Is to get the code flow similar in linux-4.9.y compared to HEAD
implementation. I suspect there is a not completely ok merge conflict
that was resolved during backport to linux-4.9.y branch with regards to
the 'random: move rand_initialize() earlier' commit.

Now the code flow is in the same order as latest HEAD.

-- 
Best regards, Hans-Christian Noren Egtvedt.

