Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37561506C41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352262AbiDSM0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbiDSM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663A735DD1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A6B6149B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EBDC385A5;
        Tue, 19 Apr 2022 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650371008;
        bh=VM/2xAmBn6HnnjUhR/9G09EFPSi/qYV/P3NwKk1doQg=;
        h=From:To:Cc:Subject:Date:From;
        b=RtsFnr35m6LCtaQjRHR65Opi9WDWizH18kvDH/3S7PRQob5/c8GEyvyQtlZxdw413
         XBBqAS7sUgs8dGwCoNuRmLXq+ZX/6w+q5NvTgJ3WTDMiMzmQuJwdjcMXL7cwYg0KYW
         /aOC5JwheIQ9M+NYhjykvkAIE3JfK7IhSoMay8prIHV569Uc3h7wVYM6kimR8Lwk/u
         hgSpwcaO0zensQUnFTRWSN8+wS0GhFx1N/rylJmKw4FmOIFECWL6N6nsTaQIWS3ETq
         ZWk+MW5hwVuFDNkCeGMMIOfZ3fq61pinaPXTJ0dpmUAAzdMUXCAffk1uYqDz//hQfF
         Vu6zO72wNk+eQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 0/3] rcu/nocb: Fixes and simplification
Date:   Tue, 19 Apr 2022 14:23:17 +0200
Message-Id: <20220419122320.2060902-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some updates for the nocb side:

* 1st patch is a simplification on adding/deleting an rdp to a nocb group

* 2nd and 3rd are fixes for the kthread's creation failure path

Frederic Weisbecker (1):
  rcu/nocb: Add/del rdp to iterate from rcuog itself

Zqiang (2):
  rcu: Invert rcu_state.barrier_mutex VS hotplug lock locking order
  rcu/nocb: Fix NOCB kthreads spawn failure with
    rcu_nocb_rdp_deoffload() direct call

 kernel/rcu/tree.h      |   1 +
 kernel/rcu/tree_nocb.h | 226 +++++++++++++++++++++++++----------------
 2 files changed, 139 insertions(+), 88 deletions(-)

-- 
2.25.1

