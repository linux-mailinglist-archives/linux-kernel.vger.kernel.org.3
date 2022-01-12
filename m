Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9944848C0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352043AbiALJ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:29:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60712 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbiALJ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:29:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E1D9218E4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641979766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SGJWeBIRCFu2Z436LWe4J4iUoNXWQKOuV8vrim/qEcA=;
        b=K7eYg/Sg8KXQaaaSw5ofXi5T/hUSpbOp8MU3rBgvOeFWGTmwL3mkViM+adUxQxYkJ5HpzP
        QB6MQeVwQZMhdCEKsAXYYs2zfKalC6eZV9B9tDmgGY8uFJj+5xD7heX6gWM8jpCkCNHT1W
        eUXArIYQ0dz4Y6st0fyhIgrS0uXolpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641979766;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SGJWeBIRCFu2Z436LWe4J4iUoNXWQKOuV8vrim/qEcA=;
        b=agKfgLImyX8/ZgTFS5ibFDXg9ebl9UM8thnOn9AwTSB4JS+wdUXOxMXMO9CUS25gVEAnNH
        7EOVUxOa20BIfdDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DB0C13B3D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Dd0LCnaf3mFISwAAMHmgww
        (envelope-from <mliska@suse.cz>)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:29:26 +0000
Message-ID: <5168172b-d6f2-a13b-5d43-175cd864ebe9@suse.cz>
Date:   Wed, 12 Jan 2022 10:29:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] objtool: Fix -Wformat-truncation seen with GCC 12.
To:     linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes the following warning that seems reasonable:

check.c:2836:58: error: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 9 [-Werror=format-truncation=]
2836 |                 snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);

Signed-off-by: Martin Liška <mliska@suse.cz>
---
  tools/objtool/check.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a9a1f7259d62..9555f7ad57cd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2852,7 +2852,7 @@ static inline bool func_uaccess_safe(struct symbol *func)
  
  static inline const char *call_dest_name(struct instruction *insn)
  {
-	static char pvname[16];
+	static char pvname[20];
  	struct reloc *rel;
  	int idx;
  
-- 
2.34.1

