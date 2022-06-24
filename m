Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CB65596B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiFXJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiFXJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:32:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C3B3BF8C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:32:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 223D11F8BA;
        Fri, 24 Jun 2022 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656063126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=U05t/Xfvw3gM8q3xuk5OGGCBzvwg4X9/WMErVj5lY8c=;
        b=VFH8sFvuEBdtswvvFrUuKvr5Ijh2bkdYxd0zzQuR9xWWvU7Ezd0MK+NI3fV/Ucwd9jqeM6
        drUB7RBQZlX1IKUtDFHh0pzAQWGgHTArrnqNU3x1x/lW5AauIZbtat410O2N9mBpjMM3lQ
        26NNHfG1xMLtPT4wIGm9FriIw957q7g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C500D13ACA;
        Fri, 24 Jun 2022 09:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vRRiI5SEtWLMCwAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 24 Jun 2022 09:32:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH] lib: bitmap: fix the duplicated comments on bitmap_to_arr64()
Date:   Fri, 24 Jun 2022 17:31:47 +0800
Message-Id: <0d85e1dbad52ad7fb5787c4432bdb36cbd24f632.1656063005.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the recent commit 0a97953fd221 ("lib: add
bitmap_{from,to}_arr64") now we can directly convert a U64 value into a
bitmap and vice verse.

However when checking the header there is duplicated helper for
bitmap_to_arr64(), but no bitmap_from_arr64().

Just fix the copy-n-paste error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/linux/bitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 2e6cd5681040..f091a1664bf1 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -71,9 +71,9 @@ struct device;
  *  bitmap_release_region(bitmap, pos, order)   Free specified bit region
  *  bitmap_allocate_region(bitmap, pos, order)  Allocate specified bit region
  *  bitmap_from_arr32(dst, buf, nbits)          Copy nbits from u32[] buf to dst
+ *  bitmap_from_arr64(dst, buf, nbits)          Copy nbits from u64[] buf to dst
  *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
  *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
- *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
  *
-- 
2.36.1

