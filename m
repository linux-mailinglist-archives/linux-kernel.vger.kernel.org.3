Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7499D472C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbhLMMiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:38:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235726AbhLMMiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639399091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VDJTUp9yQ9Fgh078RcawVA+pctF95O3INziCHJ7FhTI=;
        b=AgAcDYaFK3pCJogdJFSeDBOwJ5Oetywh8Y2eULeuvX7y+B7tVHn4VvYleVFhCNz1DkbqSa
        ZUCrSaqCsbKPp9NuAyyaPJll4MjE4sgQi848EM5rzfgmL3X89ByA+Nx8BwZrfaFcLVSztU
        DoSZCJuCuu0UsUoiptyQ47Ftzl8nGHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-162-tJ55by42PjWqnnt715fu2A-1; Mon, 13 Dec 2021 07:38:08 -0500
X-MC-Unique: tJ55by42PjWqnnt715fu2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81A2419251A0;
        Mon, 13 Dec 2021 12:38:07 +0000 (UTC)
Received: from wcosta.com (ovpn-116-142.gru2.redhat.com [10.97.116.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2165884A0D;
        Mon, 13 Dec 2021 12:38:03 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v2 0/2] Fix warnings in blktrace
Date:   Mon, 13 Dec 2021 09:37:35 -0300
Message-Id: <20211213123737.9147-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches fix wrong usage of lock primitives with
CONFIG_PREEMPT_RT in the blktrace code.

This version fixes a missing piece in the blktrace patch.

The patches apply to the PREEMPT_RT tree.

Wander Lairson Costa (2):
  block: Avoid sleeping function called from invalid context bug
  blktrace: switch trace spinlock to a raw spinlock

 block/blk-cgroup.c      |  4 ++--
 kernel/trace/blktrace.c | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.27.0

