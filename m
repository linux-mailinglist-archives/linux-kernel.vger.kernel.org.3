Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CCF4896BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbiAJKvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:51:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244251AbiAJKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641811850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SbyEAGXm6uVAR10E6kW8QyvfQbDxdraL/FSOR9ycncM=;
        b=DWfh2sHgOTWe5PHKjpQ367wogut3R3UTewg47/sRHT9R2h1O/CeEzIXKHVDhmrRtU4TVcz
        EPkvQxQdmWkBBv1QWvN1zoyk2k+5vPir9VQmz1SpiI8ZY9h+YuNEhAu2maR/bEgmXpEKKD
        kBcHM/0tFq2C9NiZBW7mboyZVFyi8oM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-mXwteg9RNxqsWK8GN-LJ1Q-1; Mon, 10 Jan 2022 05:50:49 -0500
X-MC-Unique: mXwteg9RNxqsWK8GN-LJ1Q-1
Received: by mail-wr1-f69.google.com with SMTP id k4-20020adfc704000000b001a32d86a772so4059598wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SbyEAGXm6uVAR10E6kW8QyvfQbDxdraL/FSOR9ycncM=;
        b=zXTzhEUADRbQ6yC+4GGQ1pVCvDcl333rigooiqIbNs+emK2TglBB6p2daIpAfFbe3U
         4L67xsjJookuaDENgphMD9nkPhGSgTrXBtMuLehJixTSKBBNQcKQUCx51YKGrHBcAPNf
         Me0rhXWkzr0mmIpXVsfDjj7fXIdrKuGp32n2MEgcrbZdf+k20KpGFi7cBqRwZqJYODBq
         9dVTH91T93w0UvJurPVsqRE9OVbYkT+ts3BG6OGwx2ZeCjVoI6w7ojKkD/VxHjCK04rD
         UeN+lytrnoMjf0EGVQbhih0/nJrOu6sHrDzz6VgA6oBHw9ZpRyGyccUz66kzGha4JTic
         48SA==
X-Gm-Message-State: AOAM530VZBTPKwNDt4IRplwzASgrB44nCaQQpDotgyxb66qd0DcnxaQN
        CNVvZyL3FvuaUzrDkJ1gemzVabAqDxt65iIfsiRA6u5GfEM2GM0x3hKgOej+nTHlb2QA0jMnnY8
        iRN/ZOKJoaSCE6AYimfagFpfx
X-Received: by 2002:a7b:c305:: with SMTP id k5mr21416715wmj.144.1641811847843;
        Mon, 10 Jan 2022 02:50:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysN9EkPLfD6O/v+iNsqBZ2ymYyZycxdVBE8rH21g120evtaf2rhvzsHLMdH6me9L3zGbBSpA==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr21416701wmj.144.1641811847602;
        Mon, 10 Jan 2022 02:50:47 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92])
        by smtp.gmail.com with ESMTPSA id r1sm7051224wrz.30.2022.01.10.02.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 02:50:47 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     tglx@linutronix.de, mark.rutland@arm.com, paulmck@kernel.org
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        peterz@infradead.org, mtosatti@redhat.com, frederic@kernel.org,
        corbet@lwn.net, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH v4 2/2] Documentation: core-api: entry: Add comments about nesting
Date:   Mon, 10 Jan 2022 11:50:44 +0100
Message-Id: <20220110105044.94423-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110105044.94423-1-nsaenzju@redhat.com>
References: <20220110105044.94423-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The topic of nesting and reentrancy in the context of early entry code
hasn't been addressed so far. So do it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

---

Changes since v3:
 - Introduce Paul's rewording suggestions

 Documentation/core-api/entry.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index c6f8e22c88fe..e12f22ab33c7 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -105,6 +105,8 @@ has to do extra work between the various steps. In such cases it has to
 ensure that enter_from_user_mode() is called first on entry and
 exit_to_user_mode() is called last on exit.
 
+Do not nest syscalls. Nested systcalls will cause RCU and/or context tracking
+to print a warning.
 
 KVM
 ---
@@ -121,6 +123,8 @@ Task work handling is done separately for guest at the boundary of the
 vcpu_run() loop via xfer_to_guest_mode_handle_work() which is a subset of
 the work handled on return to user space.
 
+Do not nest KVM entry/exit transitions because doing so is nonsensical.
+
 Interrupts and regular exceptions
 ---------------------------------
 
@@ -180,6 +184,16 @@ before it handles soft interrupts, whose handlers must run in BH context rather
 than irq-disabled context. In addition, irqentry_exit() might schedule, which
 also requires that HARDIRQ_OFFSET has been removed from the preemption count.
 
+Even though interrupt handlers are expected to run with local interrupts
+disabled, interrupt nesting is common from an entry/exit perspective. For
+example, softirq handling happens within an irqentry_{enter,exit}() block with
+local interrupts enabled. Also, although uncommon, nothing prevents an
+interrupt handler from re-enabling interrupts.
+
+Interrupt entry/exit code doesn't strictly need to handle reentrancy, since it
+runs with local interrupts disabled. But NMIs can happen anytime, and a lot of
+the entry code is shared between the two.
+
 NMI and NMI-like exceptions
 ---------------------------
 
@@ -259,3 +273,7 @@ and for e.g. a debug exception it can look like this:
 
 There is no combined irqentry_nmi_if_kernel() function available as the
 above cannot be handled in an exception-agnostic way.
+
+NMIs can happen in any context. For example, an NMI-like exception triggered
+while handling an NMI. So NMI entry code has to be reentrant and state updates
+need to handle nesting.
-- 
2.34.1

