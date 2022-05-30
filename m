Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54CC5386D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 19:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiE3Rhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 13:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiE3RhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 13:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B783850B31
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653932239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=shV7O+Jl4tdPj+rv5TqwBvaVp+vMnu1oH0m+CFvaf8k=;
        b=RF1qWitLnOacGqhqRVp7F7t4ovYh3eJahN4ZCfGKf8ytEUDCjes75xZOVYWEp7UyuF2kbQ
        t2u6D8GP4fNeMaKP73vH2okR04tsinhC4GaVfbs1IzRdPqJ1SjshpsculbQ4MVUKte+nUZ
        mzCtnu3Nw2j4nR7qKvmTWl/qk3Sqbds=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-_zQIoO3pMBaILemnTaw8ig-1; Mon, 30 May 2022 13:37:16 -0400
X-MC-Unique: _zQIoO3pMBaILemnTaw8ig-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21DA91C08979;
        Mon, 30 May 2022 17:37:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D97D8416365;
        Mon, 30 May 2022 17:37:15 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C57C44169301; Mon, 30 May 2022 12:51:56 -0300 (-03)
Date:   Mon, 30 May 2022 12:51:56 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] mm: lru_cache_disable: use synchronize_rcu_expedited 
Message-ID: <YpToHCmnx/HEcVyR@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


commit ff042f4a9b050895a42cae893cc01fa2ca81b95c replaced
lru_cache_disable's usage of work queues with synchronize_rcu.

Some users reported performance regressions due to this commit, for example:
https://lore.kernel.org/all/20220521234616.GO1790663@paulmck-ThinkPad-P17-Gen-1/T/

Switching to synchronize_rcu_expedited fixes the problem.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com> 
Tested-by: Michael Larabel <Michael@MichaelLarabel.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/mm/swap.c b/mm/swap.c
index bceff0cb559c..04a8bbf9817a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -879,7 +879,7 @@ void lru_cache_disable(void)
 	 * lru_disable_count = 0 will have exited the critical
 	 * section when synchronize_rcu() returns.
 	 */
-	synchronize_rcu();
+	synchronize_rcu_expedited();
 #ifdef CONFIG_SMP
 	__lru_add_drain_all(true);
 #else

