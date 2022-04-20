Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FE8508705
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378134AbiDTLdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbiDTLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:32:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B0101C5;
        Wed, 20 Apr 2022 04:30:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7383D1F380;
        Wed, 20 Apr 2022 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650454210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gxj/xM+34AD8finRqcqGcd6F18GgFYTPW9Dp5jQsnqI=;
        b=D4RovC5U+P8vMc2ol5oOFJUTywig1T0D0OQh9gaJ0JAkNnTyndf23rrEax63UQIiVLaH7A
        O7ABIdKn+15UzOY29/iuueQWeWJAcwK5wnMUWmwzknYa0bvY0aQE0vcROl+GIikNJI19I+
        wN+YgdfFkkjmuEeYE/bQuY7SSK2WSFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650454210;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gxj/xM+34AD8finRqcqGcd6F18GgFYTPW9Dp5jQsnqI=;
        b=kky0+Quo1sBYWRnxNCFVsuRWUcx6VsD1huh322JLNmWWtgZGEb+bC8kQHoQ2PFgbAX5KNg
        kBN2juL1HS9jjHCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56FB113AD5;
        Wed, 20 Apr 2022 11:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S037E8LuX2LZSAAAMHmgww
        (envelope-from <mliska@suse.cz>); Wed, 20 Apr 2022 11:30:10 +0000
Message-ID: <0d1c5ace-88e8-7102-1565-7c143f01a966@suse.cz>
Date:   Wed, 20 Apr 2022 13:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] Add HAVE_DEBUGINFOD_SUPPORT to built-in features.
To:     gcc-patches@gcc.gnu.org
Content-Language: en-US
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change adds debuginfod to ./perf -vv:

...
debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
...

Signed-off-by: Martin Liska <mliska@suse.cz>
---
  tools/perf/builtin-version.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 9cd074a3d825..a71f491224da 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -65,6 +65,7 @@ static void library_status(void)
  #endif
  	STATUS(HAVE_SYSCALL_TABLE_SUPPORT, syscall_table);
  	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
+	STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
  	STATUS(HAVE_LIBELF_SUPPORT, libelf);
  	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
  	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
-- 
2.35.3

