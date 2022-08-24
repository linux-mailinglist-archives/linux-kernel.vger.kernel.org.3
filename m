Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4359FF86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiHXQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbiHXQbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E901992F77
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661358674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccVMBc1bD/9NWDqLeOT+0fK/B1IszQ6Qg39orye31v0=;
        b=dgvABez0p3XYkLA9PjnCa+4TgrOQBxukLB5JFvYYsXC9gVyD9VPz3JKBks2clRo6l2EoJP
        hZCyMawYf3pyY3fvC8B+Au2p47IC0fBzpGcP2T/St3j7OttU2LxuxR+UWPoKSwU6LXgg46
        N3ingq8aTFueAwxViD0sVxMBQ6fv4Tg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-4RXzuCA-Oau5cEr7hNCxNQ-1; Wed, 24 Aug 2022 12:31:11 -0400
X-MC-Unique: 4RXzuCA-Oau5cEr7hNCxNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EDFF18A6580;
        Wed, 24 Aug 2022 16:31:10 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76918403348;
        Wed, 24 Aug 2022 16:31:06 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules ("do not crash the kernel")
Date:   Wed, 24 Aug 2022 18:30:59 +0200
Message-Id: <20220824163100.224449-2-david@redhat.com>
In-Reply-To: <20220824163100.224449-1-david@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus notes [1] that the introduction of new code that uses VM_BUG_ON()
is just as bad as BUG_ON(), because it will crash the kernel on
distributions that enable CONFIG_DEBUG_VM (like Fedora):

    VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
    no different, the only difference is "we can make the code smaller
    because these are less important". [2]

This resulted in a more generic discussion about usage of BUG() and
friends. While there might be corner cases that still deserve a BUG_ON(),
most BUG_ON() cases should simply use WARN_ON_ONCE() and implement a
recovery path if reasonable:

    The only possible case where BUG_ON can validly be used is "I have
    some fundamental data corruption and cannot possibly return an
    error". [2]

As a very good approximation is the general rule:

    "absolutely no new BUG_ON() calls _ever_" [2]

... not even if something really shouldn't ever happen and is merely for
documenting that an invariant always has to hold.

There is only one good BUG_ON():

    Now, that said, there is one very valid sub-form of BUG_ON():
    BUILD_BUG_ON() is absolutely 100% fine. [2]

While WARN will also crash the machine with panic_on_warn set, that's
exactly to be expected:

    So we have two very different cases: the "virtual machine with good
    logging where a dead machine is fine" - use 'panic_on_warn'. And
    the actual real hardware with real drivers, running real loads by
    users. [3]

The basic idea is that warnings will similarly get reported by users
and be found during testing. However, in contrast to a BUG(), there is a
way to actually influence the expected behavior (e.g., panic_on_warn)
and to eventually keep the machine alive to extract some debug info.

Ingo notes that not all WARN_ON_ONCE cases need recovery. If we don't ever
expect this code to trigger in any case, recovery code is not really
helpful.

    I'd prefer to keep all these warnings 'simple' - i.e. no attempted
    recovery & control flow, unless we ever expect these to trigger.
    [4]

There have been different rules floating around that were never properly
documented. Let's try to clarify.

[1] https://lkml.kernel.org/r/CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com
[2] https://lore.kernel.org/r/CAHk-=wg40EAZofO16Eviaj7mfqDhZ2gVEbvfsMf6gYzspRjYvw@mail.gmail.com
[3] https://lore.kernel.org/r/CAHk-=wgF7K2gSSpy=m_=K3Nov4zaceUX9puQf1TjkTJLA2XC_g@mail.gmail.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/process/coding-style.rst | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 03eb53fd029a..a6d81ff578fe 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1186,6 +1186,33 @@ expression used.  For instance:
 	#endif /* CONFIG_SOMETHING */
 
 
+22) Do not crash the kernel
+---------------------------
+
+Do not add new code that uses BUG(), BUG_ON(), VM_BUG_ON(), ... to crash
+the kernel if certain conditions are not met. Instead, use WARN_ON_ONCE()
+with recovery code (if reasonable) instead. Unavoidable data corruption /
+security issues might be a very rare exception to this rule and need good
+justification.
+
+There is no need for WARN_ON_ONCE() recovery code if we never expect it to
+possibly trigger unless something goes seriously wrong or some other code
+is changed to break invariants. Note that VM_WARN_ON_ONCE() cannot be used
+in conditionals.
+
+Usage of WARN() and friends is fine for something that is not expected to
+be triggered easily. ``panic_on_warn`` users are not an excuse to not use
+WARN(): whoever enables ``panic_on_warn`` explicitly asked the kernel to
+crash in this case.
+
+However, WARN() and friends should not be used for something that is
+expected to trigger easily, for example, by user space. pr_warn_once()
+might be a reasonable replacement to notify the user.
+
+Note that BUILD_BUG_ON() is perfectly fine because it will make compilation
+fail instead of crashing the kernel.
+
+
 Appendix I) References
 ----------------------
 
-- 
2.37.1

