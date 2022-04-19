Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1975A5075DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355523AbiDSRF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355644AbiDSRFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 625D446173
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650387296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1xJQ+Ui6UOB2KQXFqRu+TUHNHKwnrgyNZyqA1C89j8Q=;
        b=DUX2aBJj/MX37j0RMvSNLYJgV2hfyXq9aqe5EKNFNEfQoutWjcx3bc6nQPU2lPVqwfCbrW
        NRhsiSv5qqOM9JhZzqmHQVtDDO5TXn+d4cVbCSbVYzisykSmoRpcYKYnUbwrkRR9Oo7t75
        1Z0Tvyn+dy+/do9i4f9Xdrx6EZbl3tQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-VQWz3EQIN3y9z0wArI8GQQ-1; Tue, 19 Apr 2022 12:54:52 -0400
X-MC-Unique: VQWz3EQIN3y9z0wArI8GQQ-1
Received: by mail-qt1-f198.google.com with SMTP id c17-20020ac85a91000000b002f1ff042e0eso3764681qtc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1xJQ+Ui6UOB2KQXFqRu+TUHNHKwnrgyNZyqA1C89j8Q=;
        b=fMgFl62snRDDaUq/4eG7OVa6dt9NFe9d1IKmImSlcKOUWVp/NGX5l3HZGzxsVddBhx
         LLZaCmMAYI8RN9olrAPaG9Q3xFpAJq03QY5rtt1thtP69Pf2zufJAwhjh/2YsVuPj3pd
         ZworeTM3VIkMQP18GU18lJHQ8/GWVM7MDSgIhiOtEqGx9mqDFFJ3+YH/z9mCy6tOeQHM
         PX2gBS1nz/zgu0OmilYrDKr/ksUpuKhyZHdqNOaVaVJfyHtz4Tnkoee9ZG8HSpRoqgy1
         4TFate6w1vabExpeUmd9JTn+6K4mV4W1z/sIo5uKziIQTt6tC06KhuLidV1GjPLUIHJQ
         gaUw==
X-Gm-Message-State: AOAM530e03XRqT0ok797+U8Zdcve3mBAaV2TTs7fc4rIW80rRTaVbYxv
        GXKuTR9KQlBF262lcLMzmNp0rDRfO81GFsUPbFdcjivwWOaCZC6jCP3L/0WFO1HOoZEi8nQm+DA
        vR43mg/I8NDqtM9PaAtJeqfSl
X-Received: by 2002:a05:620a:4086:b0:69e:98ce:cb42 with SMTP id f6-20020a05620a408600b0069e98cecb42mr6648614qko.6.1650387291936;
        Tue, 19 Apr 2022 09:54:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcY8O5YIPzumo1EajfB09IvC5PzqJVgfp5t3/0OIWU5zpX4IrqZmhRcYic1pp7h7e2/O4l9g==
X-Received: by 2002:a05:620a:4086:b0:69e:98ce:cb42 with SMTP id f6-20020a05620a408600b0069e98cecb42mr6648606qko.6.1650387291729;
        Tue, 19 Apr 2022 09:54:51 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id g9-20020ac85d49000000b002f1fbe305e7sm268406qtx.80.2022.04.19.09.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:54:51 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2] MAINTAINERS: Add x86 unwinding entry
Date:   Tue, 19 Apr 2022 09:54:41 -0700
Message-Id: <db2b764b735a9481df9f7717a3a1f75ba496fcc1.1650387176.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new section for x86 unwinder maintenance.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
v2:
- tweak the component name
- fix comma (oops)

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40fa1955ca3f..63ace80af8c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21434,6 +21434,15 @@ F:	arch/x86/include/asm/uv/
 F:	arch/x86/kernel/apic/x2apic_uv_x.c
 F:	arch/x86/platform/uv/
 
+X86 STACK UNWINDING
+M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+S:	Supported
+F:	arch/x86/include/asm/unwind*.h
+F:	arch/x86/kernel/dumpstack.c
+F:	arch/x86/kernel/stacktrace.c
+F:	arch/x86/kernel/unwind_*.c
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.34.1

