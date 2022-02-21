Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A560A4BEA8B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiBUSg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:36:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiBUSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:35:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBFB104;
        Mon, 21 Feb 2022 10:35:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C06614E6;
        Mon, 21 Feb 2022 18:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956B6C340E9;
        Mon, 21 Feb 2022 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645468519;
        bh=A8eGBs0IOGhdUIbBagURdQ0opD122swLCP3bkGa8hm4=;
        h=From:To:Cc:Subject:Date:From;
        b=fE32w3f+/8eLnpK2ZStSxCo+l+/5y5Lj3Xmq8CPy3s1NvHmKxTSJfpzLDy8FFHlVu
         QsvCSs4Mv9d/VswE2Y/Z1tTDN8XWUv0fBsjYmOBuVb5VDn5Ad0MUUVRAd7CoZqPaLl
         Hufd194LxN2HiNiFW4GsugIOQhKAdtMPOqRrIIabzn+q1RmMWX4kAu2n3r2TFKgzMp
         vHOd6ifWbDKf/X+vT6FnDvZNvdgwDOfNayBRjCbgZ4W4YsQ5qDlyQqXTwGWns7Tk6Y
         9Nie98aKOFAT0nEcs6p/xdi6FIRmjzN7US2XPx8GmH1wLsmeaUfmmbe5zAgguBQMwz
         BQ61E0sLqZi5A==
From:   broonie@kernel.org
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>
Subject: linux-next: manual merge of the rcu tree with the tip tree
Date:   Mon, 21 Feb 2022 18:17:18 +0000
Message-Id: <20220221181718.453295-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  kernel/rcu/tree_plugin.h

between commit:

  04d4e665a6090 ("sched/isolation: Use single feature type while referring to housekeeping cpumask")

from the tip tree and commit:

  6a2c1d450a6a3 ("rcu: Replace cpumask_weight with cpumask_empty where appropriate")

from the rcu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/rcu/tree_plugin.h
index 65f25a32f6d75,6b9bcd45c7b21..0000000000000
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@@ -1214,10 -1219,11 +1219,11 @@@ static void rcu_boost_kthread_setaffini
  		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
  		    cpu != outgoingcpu)
  			cpumask_set_cpu(cpu, cm);
 -	cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
 +	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
- 	if (cpumask_weight(cm) == 0)
+ 	if (cpumask_empty(cm))
 -		cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
 +		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
  	set_cpus_allowed_ptr(t, cm);
+ 	mutex_unlock(&rnp->boost_kthread_mutex);
  	free_cpumask_var(cm);
  }
  
