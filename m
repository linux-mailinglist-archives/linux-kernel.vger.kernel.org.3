Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AB1571478
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiGLI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiGLI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:26:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C637C19B;
        Tue, 12 Jul 2022 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657614404; x=1689150404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+yu2tvZdutikNbzPw9Ti7rEqL0TQZsqOkvFYbx8BFbA=;
  b=FcPynXarS1S8hNkm/Sdh6VJq8jyUkuKOcMUcGtkQGeW6bxmDF3dHmW8n
   Op+8hO/ubgsyzvTdZuNLaQY8ZoGI8DQn3XeMW/69FVrToYAhDQfNsWTFi
   n2EdvV5A36ogJHMmRqQ6RDjUpp5W6CW7N3FSWiL5bjAyYW2utl2Yn8WU+
   dbvGWZa8o+VCDS5mdU4d91HTo7bEaeUcyRTVbKLkvtpw96YK29zrAYAjV
   uFfLDJVPRL2Ik5/zS4tMZfKrrkfmXCOsccVS4Y/t4J20XfqqgOnBn04ct
   vDQLsthq9e8Edhxw3iJlWO7uFEoGmZLqPoSBoOGG4FQdiEv/09smJdGL6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="346556754"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="346556754"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:26:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="622418019"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:26:41 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Optimize synchronize_rcu_tasks_generic() on early booting
Date:   Tue, 12 Jul 2022 16:26:04 +0800
Message-Id: <20220712082606.3662616-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fix warning trigger when call synchronize_rcu_tasks_generic() on
early booting and make synchronize_rcu_tasks_generic() directly return when
the rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE.

Zqiang (2):
  rcu-tasks: Convert RCU_LOCKDEP_WARN() to WARN_ONCE()
  rcu-tasks: Make synchronize_rcu_tasks_generic() no-ops on early
    booting

 kernel/rcu/tasks.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.25.1

