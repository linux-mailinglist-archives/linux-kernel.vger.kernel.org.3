Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99234470BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344248AbhLJUq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:46:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344228AbhLJUqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639168969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ohtjp5ENEhR73TGjgyBs/JxihfZk0CXzRtqhRe/3wZY=;
        b=X2PbA5w70Z3GtvPtWqwU75JnM0TJmQyxsPW/KYjdJDPCRHkZHF9Ruga/wcspeij3oQwrR1
        T281TPIBfHFO3IQZ4M/6DPOGekG1p1ydemhTTMEB6tOGpdoIDs60FtYbVQcJMX1TX77Ggw
        aVdERjvfuGPIEPtJxS+v5aK3gGIM75g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-HIuiFW6eOhStaycKlMHrxw-1; Fri, 10 Dec 2021 15:42:46 -0500
X-MC-Unique: HIuiFW6eOhStaycKlMHrxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 890D4192FDA0;
        Fri, 10 Dec 2021 20:42:45 +0000 (UTC)
Received: from wcosta.com (ovpn-116-199.gru2.redhat.com [10.97.116.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D03B2781EB;
        Fri, 10 Dec 2021 20:42:28 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PREEMPT_RT PATCH 0/2] Fix warnings in blktrace
Date:   Fri, 10 Dec 2021 17:41:54 -0300
Message-Id: <20211210204156.96336-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches fix wrong usage of lock primitives with
CONFIG_PREEMPT_RT in the blktrace code.

Wander Lairson Costa (2):
  block: Avoid sleeping function called from invalid context bug
  blktrace: switch trace spinlock to a raw spinlock

 block/blk-cgroup.c      |  4 ++--
 kernel/trace/blktrace.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.27.0

