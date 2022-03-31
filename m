Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07654ED405
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiCaGkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiCaGkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:40:39 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A65AA54
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648708732; x=1680244732;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=QQJ2ROIOSbzJewf4Krt9nKSZ4UnHk+PyHajNWHICcZE=;
  b=yQB++TvydYV56pbQES9QklUg4wNyfSknkZBzYO3+vAsZQAuAFj81UOW+
   hqccEWsEb8yuOQhvm1a+cbdT7eAfD+wSwg5B7saow/QL07wZRz/b8SdW+
   87BGST9b4Bp2e5kFcBHzj9UwZu5ru+stAE9tDNH9uwNQKHTnSVJ+NGOPP
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Mar 2022 23:38:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 23:38:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 23:38:51 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 23:38:48 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <markhemm@googlemail.com>, <hughd@google.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Reddy <quic_charante@quicinc.com>
Subject: [PATCH RESEND V5,0/2]mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for shmem files 
Date:   Thu, 31 Mar 2022 12:08:19 +0530
Message-ID: <cover.1648706231.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charan Teja Reddy <quic_charante@quicinc.com>

This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
advices to shmem files which can be helpful for the drivers who may want
to manage the pages of shmem files on their own, like, that are created
through shmem_file_setup[_with_mnt]().

Changes in V5:
 -- Moved the 'endbyte' calculations to a header function for use by shmem_fadvise().
 -- Addressed comments from suren.
 -- No changes in resend. Retested on the latest tip.

Changes in V4:
  -- Changed the code to use reclaim_pages() to writeout the shmem pages to swap and then reclaim.
  -- Addressed comments from Mark Hemment and Matthew.
  -- fadvise() on shmem file may even unmap a page.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1644572051-24091-1-git-send-email-quic_charante@quicinc.com/

Changes in V3:
  -- Considered THP pages while doing FADVISE_[DONT|WILL]NEED, identified by Matthew.
  -- xarray used properly, as identified by Matthew.
  -- Excluded mapped pages as it requires unmapping and the man pages of fadvise don't talk about them.
  -- RESEND: Fixed the compilation issue when CONFIG_TMPFS is not defined.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1641488717-13865-1-git-send-email-quic_charante@quicinc.com/

Changes in V2:
  -- Rearranged the code to not to sleep with rcu_lock while using xas_() functionality.
  -- Addressed the comments from Suren.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1638442253-1591-1-git-send-email-quic_charante@quicinc.com/

changes in V1:
  -- Created the interface for fadvise(2) to work on shmem files.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1633701982-22302-1-git-send-email-charante@codeaurora.org/

Charan Teja Reddy (2):
  mm: fadvise: move 'endbyte' calculations to helper function
  mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem

 mm/fadvise.c  |  11 +-----
 mm/internal.h |  21 ++++++++++
 mm/shmem.c    | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 10 deletions(-)

-- 
2.7.4

