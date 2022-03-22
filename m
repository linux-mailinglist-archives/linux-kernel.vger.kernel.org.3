Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470F14E42DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbiCVPXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiCVPXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9A4E4CD49
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647962497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pXHPWXKwW6dA2VH85GvT6aXK+VO1evC+jnd2BN9ct3E=;
        b=ObKVt4C+Oyxcw51cSiCY4eSt4qB1/x0KuIu8yY5kMT1h0dMQfkwQR+DL14D1SCbf62hbNx
        pTPUvsz2zHLEaXnXKOnNl8pnEU/P61B1fgFWJs7eQtpkC9YaEizJZbdp3g8nSmKc3WUI8a
        HJr0Oa7CdsVW2TF/gqXtxL9Ts4DlDoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-st6ri318Pt2CkPyZOi6bag-1; Tue, 22 Mar 2022 11:21:35 -0400
X-MC-Unique: st6ri318Pt2CkPyZOi6bag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EE8585A5BE;
        Tue, 22 Mar 2022 15:21:34 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49A3B40D2822;
        Tue, 22 Mar 2022 15:21:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/3] locking/rwsem: Miscellaneous cleanup and fix
Date:   Tue, 22 Mar 2022 11:20:56 -0400
Message-Id: <20220322152059.2182333-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 is just a simple cleanup patch. Patches 2 and 3 applies the same
consistent rules to optionally wake up waiters in reader & writers
slowpaths as well as in the out_nolock paths.

Waiman Long (3):
  locking/rwsem: No need to check for handoff bit if wait queue empty
  locking/rwsem: Conditionally wake waiters in reader/writer slowpaths
  locking/rwsem: Always try to wake waiters in out_nolock path

 kernel/locking/rwsem.c | 121 ++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 51 deletions(-)

-- 
2.27.0

