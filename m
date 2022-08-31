Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA075A88D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiHaWKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHaWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:10:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27188186D3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:10:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2961422038;
        Wed, 31 Aug 2022 22:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661983799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=l3Q5DvQGEH+WsVHsWcDeULdQu2Ku6pAIt7NlxRIeG14=;
        b=FuYNtYD3P5RIynwDyFzL12UjoWn3QMLvxwHoLXbWEfz5NGAYlMjLenXCOMW6DgDDj2i0Qp
        /34GWtqNEWu/s45Mei703Rb0iFUuaqYCqDlIo4bufGDaLecl67jYYQYXxsN7akoHaHCbD8
        PDLg7TUvXcWJufw1W4+C/sllWeWoEgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661983799;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=l3Q5DvQGEH+WsVHsWcDeULdQu2Ku6pAIt7NlxRIeG14=;
        b=dX0+XwxNi18qBpPaeNeoNVsHq0xLBPVgsFKomiwVzW1KKn7JldtqhI/MjifPsxl6Jq2K7p
        +uj/AOOqoOcXEhCw==
Received: from echidna.suse.cz (unknown [10.100.228.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E127A2C141;
        Wed, 31 Aug 2022 22:09:58 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     dmitry.torokhov@gmail.com
Cc:     linux-kernel@vger.kernel.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH] module/decompress: generate sysfs string at compile time
Date:   Thu,  1 Sep 2022 00:07:10 +0200
Message-Id: <20220831220709.28972-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compression_show() before (with noinline):
   0xffffffff810b5ff0 <+0>:     mov    %rdx,%rdi
   0xffffffff810b5ff3 <+3>:     mov    $0xffffffff81b55629,%rsi
   0xffffffff810b5ffa <+10>:    mov    $0xffffffff81b0cde2,%rdx
   0xffffffff810b6001 <+17>:    call   0xffffffff811b8fd0 <sysfs_emit>
   0xffffffff810b6006 <+22>:    cltq
   0xffffffff810b6008 <+24>:    ret

After:
   0xffffffff810b5ff0 <+0>:     mov    $0xffffffff81b0cde2,%rsi
   0xffffffff810b5ff7 <+7>:     mov    %rdx,%rdi
   0xffffffff810b5ffa <+10>:    call   0xffffffff811b8fd0 <sysfs_emit>
   0xffffffff810b5fff <+15>:    cltq
   0xffffffff810b6001 <+17>:    ret

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 kernel/module/decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Feel free to drop the to-be-expected commit message body if desired.

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 4d0bcb3d9e449..c033572d83f0e 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -256,7 +256,7 @@ void module_decompress_cleanup(struct load_info *info)
 static ssize_t compression_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%s\n", __stringify(MODULE_COMPRESSION));
+	return sysfs_emit(buf, __stringify(MODULE_COMPRESSION) "\n");
 }
 
 static struct kobj_attribute module_compression_attr = __ATTR_RO(compression);
-- 
2.35.3

