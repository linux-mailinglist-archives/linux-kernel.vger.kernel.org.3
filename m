Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89C0503307
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiDPAZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 20:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiDPAZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 20:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 054C7D76FE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650068551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=h1XwkelATqyJXyrAy9Tvp9OY746XgB08PijO9HKoRRQ=;
        b=Arx2YsAuSJ26DEdFNeC9/vhZZ0Hzd9GaY5dfbsz49qTYLNh+dWal1LKzZ62wI/Eie8KnQr
        v6DpJl5sNTp0ol6qXoLi8dTLEQUpDdRow6UWZSKFuRHBP2RSbtZ4fdA198cIZXFGP0BoNv
        oUgvsxODsSHjN+TLB/LfAEbUEkcmW7M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-J9nJ1p4xOHCsWaJU3Ch8eA-1; Fri, 15 Apr 2022 20:22:28 -0400
X-MC-Unique: J9nJ1p4xOHCsWaJU3Ch8eA-1
Received: by mail-qv1-f69.google.com with SMTP id a3-20020a056214062300b00443cd6175c8so7890896qvx.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h1XwkelATqyJXyrAy9Tvp9OY746XgB08PijO9HKoRRQ=;
        b=ovDOIsx/hmsln6GRfSCqN9zwZ9IGevxfu7BKw6f5jfXbzo0ZuP8ytvrVPU5KxtKvNT
         L1UvbW7UZuPEzSVAZiWLUFNSarcLVm1TQJcek2+9HDN2E73Dd+EJbZXf8g7WfRnsLuFZ
         DIxXILewiHhOFGYBx4kZgAjIyuV97LpYIur7mZwxRVTy9fooJU6FeJaqDR69qiEFOsmT
         q4FSYuAdaGELV4s+kUY7IW7j8XwZ3AepPIUmEIqBAC2502ZdD8kCLShveryOl6ZEFBiP
         XzbB6O1MUk3NAZdpD68agXapdLat8GKaI/XZfpL1THuCb6i9PBQ9RSqzbYp9gZCKP/B3
         Hi8A==
X-Gm-Message-State: AOAM533CKgIzwTg/lk5aZcNviBxN71Gm7OYIwBkaTGynbcJVo2hHnOt6
        kqUve/XonTBBswoah0Chz6h5fMr/mqbpksGUWInmrTPFP4QGiIM3A5zwxhU7+I8yGdW0SA9hTjZ
        /bq0m6LGA1psPQck9JsPpIA1H
X-Received: by 2002:a05:6214:2a82:b0:443:e2fc:c209 with SMTP id jr2-20020a0562142a8200b00443e2fcc209mr970638qvb.59.1650068547777;
        Fri, 15 Apr 2022 17:22:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygJo7ZWTm/LQ5wRG6vWW59EyE2twDCS/xRDWopGgKD8nB0G+Rsfx3Z0YMgK9N+WKN16r7f6A==
X-Received: by 2002:a05:6214:2a82:b0:443:e2fc:c209 with SMTP id jr2-20020a0562142a8200b00443e2fcc209mr970632qvb.59.1650068547533;
        Fri, 15 Apr 2022 17:22:27 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id d2-20020ac85ac2000000b002e1cc2d363asm3712218qtd.24.2022.04.15.17.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:22:27 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] MAINTAINERS: Add x86 unwinders entry
Date:   Fri, 15 Apr 2022 17:22:14 -0700
Message-Id: <7b9eb43c029d20676d9173ec5b2c675b43e2a99c.1650068519.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new section for x86 unwinder maintenance.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f114c37f..79bdc42a7477 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21434,6 +21434,15 @@ F:	arch/x86/include/asm/uv/
 F:	arch/x86/kernel/apic/x2apic_uv_x.c
 F:	arch/x86/platform/uv/
 
+X86 UNWINDERS
+M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+S:	Supported
+F:	arch/x86/include/asm/unwind*.h
+F:	arch/x86/kernel/dumpstack.c
+F:	arch/x86/kernel/stacktrace.c
+F:	arch/x86/kernel/unwind_*,c
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.34.1

