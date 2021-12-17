Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E70478950
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhLQK6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235160AbhLQK6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639738686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfMj5Cdv9ABQA5uXGp3mACXyYa8FBWK9SwauD15vTUk=;
        b=KJbB7ID3xHtUozi2AadE96dPbrovr2NkJ6nmIQCKZt6XQaSCNPRGcqh+MiPp7srgNfO9mi
        e397IPj3QATKXnkWrRdBtUAq6jpSTSOeQx5kEh+rQ1Pg8kfHhwZYuiCLAG2Ju5MaRjwVnh
        +rN9nO3MpJ895nz8pmZXsiNNMpZka7c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-b_qzDuX5O8200qja_l6zHQ-1; Fri, 17 Dec 2021 05:58:03 -0500
X-MC-Unique: b_qzDuX5O8200qja_l6zHQ-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso2773392wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 02:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfMj5Cdv9ABQA5uXGp3mACXyYa8FBWK9SwauD15vTUk=;
        b=r2PY1XM7+rRMVLeFjSLmLNJ9mN0pVuHQoVr4h79csNBURZWTCiiE9CbvEjIWaZXL/+
         1F2HzQa/1GAMSgxLeQw0R/myEAS1CGY9hDCvR5595vKZHICKs3yc1Qy3d/HXOBwt0UcT
         EisflrsZmJVQAZo1W0k0xphG0RO/d4Q7XxPL/RB+rZfXuTnftbtSM60AE/4f3Zwv/gCa
         LNoNQG6CJPPGL05AKSuL/Xu3dG9Ts84O4dweA3NkfQDy0Z7Scci29f169qlzSHZtBr9R
         GLSOZfJh0ysPZAV4lpit7ghXwhDhaM3MqIynfd3LKt+Ug0iofmiaAeXnnJ/wv1hBRcFq
         G/1Q==
X-Gm-Message-State: AOAM531J0GzV3FbVkvaGGO1Ah6F54iVhdIPvnKyMrZUWcaht5WiUt2Fv
        455Zj9pLsJtdfvG1s/tZGDIkOGNcDQOZCwnpxEGIQQwLbx4TVh4FX1Gc5Z/DsRql353jeOQCUs3
        XUDkYySVaXe8CO16PGBB3zAqi
X-Received: by 2002:a05:600c:3ac6:: with SMTP id d6mr2240076wms.191.1639738682589;
        Fri, 17 Dec 2021 02:58:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysepd7uhQTf9/QJszbG/jm5Yl980CRUzB5yGgrcxWsh+7XsGwRjPoBHPcTl4LGXQFGL0ZYgQ==
X-Received: by 2002:a05:600c:3ac6:: with SMTP id d6mr2240054wms.191.1639738682352;
        Fri, 17 Dec 2021 02:58:02 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3b0e:bd00:1099:cf34:d27f:de8a])
        by smtp.gmail.com with ESMTPSA id h5sm7405122wrz.63.2021.12.17.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 02:58:02 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     tglx@linutronix.de, mark.rutland@arm.com, paulmck@kernel.org
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        peterz@infradead.org, mtosatti@redhat.com, frederic@kernel.org,
        corbet@lwn.net, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH v3 2/2] Documentation: core-api: entry: Add comments about nesting
Date:   Fri, 17 Dec 2021 11:57:53 +0100
Message-Id: <20211217105753.892855-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217105753.892855-1-nsaenzju@redhat.com>
References: <20211217105753.892855-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The topic of nesting and reentrancy in the context of early entry code
hasn't been addressed so far. So do it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

---

NOTE: I moved this into a separate patch to simplify the review.

 Documentation/core-api/entry.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index 3f80537f2826..f665f201ead0 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -105,6 +105,8 @@ has to do extra work between the various steps. In such cases it has to
 ensure that enter_from_user_mode() is called first on entry and
 exit_to_user_mode() is called last on exit.
 
+Syscalls shouldn't nest. If it were to happen, RCU / context tracking will
+catch the misbehavior and print out a warning.
 
 KVM
 ---
@@ -121,6 +123,9 @@ Task work handling is done separately for guest at the boundary of the
 vcpu_run() loop via xfer_to_guest_mode_handle_work() which is a subset of
 the work handled on return to user space.
 
+Nesting doesn't make sense in the context of KVM entry/exit transitions, it
+shouldn't happen.
+
 Interrupts and regular exceptions
 ---------------------------------
 
@@ -180,6 +185,16 @@ before it handles soft interrupts, whose handlers must run in BH context rather
 than irq-disabled context. In addition, irqentry_exit() might schedule, which
 also requires that HARDIRQ_OFFSET has been removed from the preemption count.
 
+Even though interrupt handlers are expected to run with local interrupts
+disabled, interrupt nesting is common from an entry/exit perspective. For
+example, softirq handling happens within an irqentry_{enter,exit}() block, with
+local interrupts enabled. Also, although uncommon, nothing prevents an
+interrupt handler from re-enabling interrupts.
+
+Interrupt entry/exit code doesn't strictly need to handle reentrancy, since it
+runs with local interrupts disabled. But NMIs can happen anytime, and a lot of
+the entry code is shared between the two.
+
 NMI and NMI-like exceptions
 ---------------------------
 
@@ -259,3 +274,7 @@ and for e.g. a debug exception it can look like this:
 
 There is no combined irqentry_nmi_if_kernel() function available as the
 above cannot be handled in an exception-agnostic way.
+
+NMIs can happen in any context. For example, an NMI-like exception triggered
+while handling an NMI. So NMI entry code has to be reentrant and state updates
+need to handle nesting.
-- 
2.33.1

