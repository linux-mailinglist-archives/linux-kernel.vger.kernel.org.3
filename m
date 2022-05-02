Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB115176BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbiEBSrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiEBSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C159260F4
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651517042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7G1poOEMReOFGnC0Us25exoH9KAMdn29EthSamAbOPc=;
        b=IB/8B6BLhiZCM1FwLgKHSFeCMudVvayGZuHzkMary10MHZV4cMu0eXgihHgnkSlAW7WbKs
        yX60MDzJ9UCwHxTq4bazR1DysBR2lFoC6y38spmk10Vu+H3ltYgYgrgijpFL7yHrHkVCBx
        2xTtipdT731xDAVBwtm4QnwXAZEaHic=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-OakeLXamPGWeVdxEK-MZAQ-1; Mon, 02 May 2022 14:44:01 -0400
X-MC-Unique: OakeLXamPGWeVdxEK-MZAQ-1
Received: by mail-ot1-f71.google.com with SMTP id w8-20020a9d5388000000b0060613b46a98so1571676otg.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7G1poOEMReOFGnC0Us25exoH9KAMdn29EthSamAbOPc=;
        b=A1/x7n+/cZe9QzsmkUayN8AJv1eMzwpy6EAh0Gc/sYblphhPnKMBbLLMJVqHOipRP9
         8Ukhs9fzoYXnTfQbuGwfHLhFXgmTI07T+DiQbRA83vbiixqRFABjptPETKqOa/SPlth+
         g5AEHkixlfDP5C8s6st5NDMVQZJf6Lv0pylibVFE5phNWE1CMVQdEkcKJVPYx4CuIGqO
         e2//jHOOin1h9Umz4xRxboG77xboa6RezaaWmJfZvilqppfUXv+82hvse8OIsvOrEBxV
         I/Oh5jNY1MIALT3DPlQjiFrPHKP8MBxvEHA8bbJmev2OC7moNe8tn/l6Uk8/WN3GKnaa
         TV4Q==
X-Gm-Message-State: AOAM533BEvnI/osX6KwEKdadTVsV80l0j/9ICd/YBbH1ruODBXQiSHkM
        sy4k3CkIOSfielokuDYWnu17+zXJHvwyTL3at14GuVCu/gZvUydbC6a2i/ahoxDr5RR89tmU2cM
        4PxiBs+ZV8ikSEo3c+043NuvX
X-Received: by 2002:a05:6808:124d:b0:325:788d:e23d with SMTP id o13-20020a056808124d00b00325788de23dmr242201oiv.267.1651517040816;
        Mon, 02 May 2022 11:44:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRUXu471IEGrZLxcEbLEi/3H6c//jwnIiNRuOEi8DV1xn2Tn8hH+1nrApiGgqLDS+he9PJGQ==
X-Received: by 2002:a05:6808:124d:b0:325:788d:e23d with SMTP id o13-20020a056808124d00b00325788de23dmr242195oiv.267.1651517040612;
        Mon, 02 May 2022 11:44:00 -0700 (PDT)
Received: from treble.attlocal.net ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id r2-20020a05687002c200b000e99b1909d4sm5370524oaf.25.2022.05.02.11.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:44:00 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Subject: [PATCH] scripts/faddr2line: Only use text symbols to calculate function size
Date:   Mon,  2 May 2022 11:43:50 -0700
Message-Id: <2fb2bc4e857848c83cfa96483e4b25b23d46be49.1651516951.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the following commit

  efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")

it was discovered that faddr2line can't just read a function's ELF
size, because that wouldn't match the kallsyms function size which is
printed in the stack trace.  The kallsyms size includes any padding
after the function, whereas the ELF size does not.

So faddr2line has to manually calculate the size of a function similar
to how kallsyms does.  It does so by starting with a sorted list of
symbols and subtracting the function address from the subsequent
symbol's address.

That calculation is broken in the case where the function is the last
(or only) symbol in the .text section, which can occur quite commonly in
a kernel module or a .o file.  In that case, the next symbol in the
sorted list might actually be a data symbol, which breaks the function
size detection:

  $ scripts/faddr2line sound/soundcore.ko sound_devnode+0x5/0x35
  bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000

Fix it by only including text symbols in the symbol list.

Fixes: efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")
Reported-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 6c6439f69a72..2a130134f1e6 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -189,7 +189,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
+	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$2 !~ /[Tt]/ {next} $3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
 }
 
 [[ $# -lt 2 ]] && usage
-- 
2.34.1

