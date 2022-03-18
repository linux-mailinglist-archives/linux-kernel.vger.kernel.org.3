Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698884DDE95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiCRQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbiCRQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FB47139AF4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647620198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xelVqge/xO6GXKf9ttXQSExuZAjbuquWRkR8eVnrK4U=;
        b=Ajs0PH37X8Op0nH/Rayrx9A99FstJhdlZVf/bpio04XA/4X+qQ8P7455YWXapbZf903gaa
        UBg4HAmdzF7W/C49FS/TtIPQq2AlenFmR6MlmoCjKo9cTSxPQUaJSl6gZj4wEMo08DiWtI
        1keVDKbhPY8wP0HvlJ12qJZLhaFfayQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-IUScUqh1OECoVYFofz_3lA-1; Fri, 18 Mar 2022 12:16:35 -0400
X-MC-Unique: IUScUqh1OECoVYFofz_3lA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED706296A621;
        Fri, 18 Mar 2022 16:16:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.19.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB3F21111C62;
        Fri, 18 Mar 2022 16:16:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] locking/rwsem: Miscellaneous cleanup and fix
Date:   Fri, 18 Mar 2022 12:16:07 -0400
Message-Id: <20220318161609.1939957-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long (2):
  locking/rwsem: No need to check for handoff bit if wait queue empty
  locking/rwsem: Wake readers in a reader-owned rwsem if first waiter is
    a reader

 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem.c            | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 11 deletions(-)

-- 
2.27.0

