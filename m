Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1897A587533
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiHBBvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiHBBve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:51:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3675F19282;
        Mon,  1 Aug 2022 18:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C474F61059;
        Tue,  2 Aug 2022 01:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79600C433D7;
        Tue,  2 Aug 2022 01:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405092;
        bh=xdSHWCs9h2K8wnnw4cbgM7/350sCkbahN/3I64zs7hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EtwVpI630efU4ieZgeGF0aDPjdpB8550taPoCLaCPoEJ0H/Y4ArTKSYtxJ3v17VzO
         X0QPGDTfPHKpLe3jfz6Q7BbZPMGe0QcNv8MFQNzby7tro1lN99+67F24gwVgwT8z5F
         JOge2Fn2f24/VAAVX/6coOhGPpArFWdSnG2Pkvs5cMPgtnGCmNmEaOgopaz2DUtAKV
         oHPat6UpwxJDHUY6+pk6evOjKMyYdcMgt3qFh/y5VkcHmx9P7e1qayXZhApB0xUgQD
         jLQFT3rfLNmVJaEkoAwMYLQ+jRjlUdmXNw36FwLYvtf8QspT7ivCMBOjE2K4Z/88x9
         O4hCAG7gMfvmg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v8 01/31] kallsyms: use `sizeof` instead of hardcoded size
Date:   Tue,  2 Aug 2022 03:49:48 +0200
Message-Id: <20220802015052.10452-2-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

This removes one place where the `500` constant is hardcoded.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f18e6dfc68c5..52f5488c61bc 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -206,7 +206,7 @@ static struct sym_entry *read_symbol(FILE *in)
 
 	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
 	if (rc != 3) {
-		if (rc != EOF && fgets(name, 500, in) == NULL)
+		if (rc != EOF && fgets(name, sizeof(name), in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
 	}
-- 
2.37.1

