Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2D5187FB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiECPMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiECPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:11:55 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C30D37A8D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:08:22 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-75oE-M6RP7eBPNBNfwRyUg-1; Tue, 03 May 2022 11:05:38 -0400
X-MC-Unique: 75oE-M6RP7eBPNBNfwRyUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F29F3D32CC7;
        Tue,  3 May 2022 13:40:18 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9EF19E60;
        Tue,  3 May 2022 13:40:09 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux Containers <containers@lists.linux.dev>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] ipc: Use proper ipc namespace 
Date:   Tue,  3 May 2022 15:39:53 +0200
Message-Id: <cover.1651584847.git.legion@kernel.org>
In-Reply-To: <87sfprudal.fsf@email.froward.int.ebiederm.org>
References: <87sfprudal.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 11:09:22AM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <legion@kernel.org> writes:
> 
> > As Eric Biederman pointed out, changing the namespace broke checkpoint
> > restore. I have reverted my previous changes.
> 
> Can you remind me the bug that is being fixed here?
> 
> I am probably just going to fast to see it, but it would be good to have
> it described in the commit comment.

It was preparation for the "ipc: Check permissions for checkpoint_restart
sysctls at open time". I wanted to split the commit and make it more readable,
but it looks like I just confused everyone. This change should be part of the
next commit.

Here is a new version of the patchset where I moved the bugfix to a separate
commit as you requested in the next email.

Does that look better?

--

Alexey Gladkov (4):
  ipc: Use the same namespace to modify and validate
  ipc: Remove extra1 field abuse to pass ipc namespace
  ipc: Check permissions for checkpoint_restart sysctls at open time
  ipc: Remove extra braces

 ipc/ipc_sysctl.c | 108 +++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 59 deletions(-)

-- 
2.33.3

