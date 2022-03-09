Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007424D31BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiCIP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiCIP2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:28:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C896397;
        Wed,  9 Mar 2022 07:27:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CED36147E;
        Wed,  9 Mar 2022 15:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD21C340E8;
        Wed,  9 Mar 2022 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646839670;
        bh=UHfRDJcyynBr1r5QzAuImHIGoYHpWR3Bll7JKdgtM/Q=;
        h=From:To:Subject:Date:From;
        b=tKnJK3MAH+v1odS4rlwFQFDnOAZJrNPLwfKcNl77pziWzoKLI5g/PzDwH+BdNLpLw
         3eK3NfWKk5R/O/I/TrhQHBaPG8vMkdK96yXDqP2sw8yURD+wZfYR2o/TczMMRDl+qs
         0IAB1aR0+s0z2wh3d7Jyaj5fyW0jyWDE7/DMKov2pceaKKRjLuvEuBakrzmh7H567p
         WDBNoAoUmyfVdqNaTXFZh+uAjvBf9H26obpY3mLAE9Z9LVTlRnRB2gWlebMA13CnNX
         wySa3vV5+SZRgYi1FjtKOsOn2F/mKKaEpz0fvoYgu+Ktp/jGWY223C6yrdu8auLJPh
         B9AvnDOhl+DPA==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/3] Linux v5.4.182-rt71-rc1
Date:   Wed,  9 Mar 2022 09:27:45 -0600
Message-Id: <cover.1646839649.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 5.4.182-rt71-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2022-03-12.

To build 5.4.182-rt71-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.182.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.182-rt71-rc1.patch.xz

You can also build from 5.4.182-rt70 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.182-rt70-rt71-rc1.patch.xz


Enjoy,

-- Tom


Thomas Gleixner (1):
  eventfd: Make signal recursion protection a task bit

Tom Zanussi (1):
  Linux 5.4.182-rt71-rc1

Xie Yongji (1):
  aio: Fix incorrect usage of eventfd_signal_allowed()

 fs/aio.c                |  2 +-
 fs/eventfd.c            | 12 +++++-------
 include/linux/eventfd.h | 11 +++++------
 include/linux/sched.h   | 12 ++++++++++++
 localversion-rt         |  2 +-
 5 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.17.1

