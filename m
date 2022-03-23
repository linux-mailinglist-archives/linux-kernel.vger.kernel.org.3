Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73114E511C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbiCWLSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbiCWLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A334F78927
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648034210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mnoovn4iIxQv1+UzkN6Wleh5OeGZAIr5QweFyWnmYAk=;
        b=Bb3E4KTLjKcpyG4eEXj69l7Cejj6WcTxndV8CNSulsAozAP5TUt9spP3fbYlAqB1RpCN/c
        QYRH1i/KmsMUbrUY9QjFtwt7mk7HoHn23oqQf+UUyYQ9UxKEDwTyfBSL4/zeB1XFHKkQEm
        1vw+Vr+GJjets9mX67Fjeex/CCvwpWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-dR4WZOF0Nc-6z-9VayGMMA-1; Wed, 23 Mar 2022 07:16:47 -0400
X-MC-Unique: dR4WZOF0Nc-6z-9VayGMMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C90D318A6581;
        Wed, 23 Mar 2022 11:16:46 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5BF3112132C;
        Wed, 23 Mar 2022 11:16:46 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id 49D591C0223; Wed, 23 Mar 2022 12:16:45 +0100 (CET)
From:   Artem Savkov <asavkov@redhat.com>
To:     tglx@linutronix.de, jpoimboe@redhat.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 0/2] Upper bound mode for kernel timers
Date:   Wed, 23 Mar 2022 12:16:40 +0100
Message-Id: <20220323111642.2517885-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As previously discussed [1] we had a report of a regression in TCP keepalive
timer where timers were up to 4 minutes late resulting in disconnects.

This patchset tries to fix the problem by introducing upper bound kernel timers
and making tcp keepalive timer use those.

[1] https://lore.kernel.org/all/20210302001054.4qgrvnkltvkgikzr@treble/T/#u

Artem Savkov (2):
  timer: introduce upper bound timers
  net: make tcp keepalive timer upper bound

 include/linux/timer.h           |  3 ++-
 kernel/time/timer.c             | 36 ++++++++++++++++++++-------------
 net/ipv4/inet_connection_sock.c |  2 +-
 3 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.34.1

