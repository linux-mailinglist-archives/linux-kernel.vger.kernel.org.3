Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A11959FF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbiHXQd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbiHXQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C31923FA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661358668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Meo/JVVOcnrflu5rlIGOgtbrV+Zw+zKCUGgyNys75s=;
        b=LVR0GDn0LlyANRjs6QyFyC51RNHINXxrk/oxc4e4Eyz4x7AYogbT/ptBti4eew3Fw995Gv
        ZTRLPg7pi56roHhW3+JXFaabrR38l2Hi8sNJuiMIyq3ysEkddR5rGQY+QPBU5j0DQ660BA
        ftK9nY4n6FKyTRLpClmSIsZmfxefqV8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-1hJq29stMFOCbma2_vFXbA-1; Wed, 24 Aug 2022 12:31:06 -0400
X-MC-Unique: 1hJq29stMFOCbma2_vFXbA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17417185A7B2;
        Wed, 24 Aug 2022 16:31:06 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4C6492C3B;
        Wed, 24 Aug 2022 16:31:02 +0000 (UTC)
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
Subject: [PATCH RFC 0/2] coding-style.rst: document BUG() and WARN() rules
Date:   Wed, 24 Aug 2022 18:30:58 +0200
Message-Id: <20220824163100.224449-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it seems to be rather unclear if/when to use BUG(), BUG_ON(),
VM_BUG_ON(), WARN_ON_ONCE(), ... let's try to document the result of a
recent discussion.

Details can be found in patch #1.

--------------------------------------------------------------------------

Here is some braindump after thinking about BUG_ON(), WARN_ON(), ... and
how it interacts with kdump.

I was wondering what the expectation on a system with armed kdump are,
for example, after we removed most BUG_ON() instances and replaced them
by WARN_ON_ONCE(). I would assume that we actually want to panic in some
cases to capture a proper system dump instead of continuing and eventually
ending up with a completely broken system where it's hard to extract any
useful debug information. We'd have to enable panic_on_warn. But we'd only
want to do that in case kdump is actually armed after boot.

So one idea would be to have some kind of "panic_on_warn_with_kdump" mode.
But then, we'd actually crash+kdump even on the most harmless WARN_ON()
conditions, because they all look alike. To compensate, we would need
some kind of "severity" levels of a warning -- at least some kind of
"this is harmless and we can easily recover, but please tell the
developers" vs. "this is real bad and unexpected, capture a dump
immediately instead of trying to recover and eventually failing miserably".

But then, maybe we really want something like BUG_ON() -- let's call it
CBUG_ON() for simplicity -- but be able to make it be usable in
conditionals (to implement recovery code if easily possible) and make the
runtime behavior configurable.

if (CBUG_ON(whatever))
	try_to_recover()

Whereby, for example, "panic_on_cbug" and "panic_on_cbug_with_kdump"
could control the runtime behavior.

But this is just a braindump and I assume people reading along have other,
better ideas. Especially, a better name for CBUG.


Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>

David Hildenbrand (2):
  coding-style.rst: document BUG() and WARN() rules ("do not crash the
    kernel")
  checkpatch: warn on usage of VM_BUG_ON() and friends

 Documentation/process/coding-style.rst | 27 ++++++++++++++++++++++++++
 scripts/checkpatch.pl                  |  6 +++---
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.37.1

