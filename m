Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D116591046
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiHLLpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbiHLLof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:44:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0265AAF0EF;
        Fri, 12 Aug 2022 04:44:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2872E38E85;
        Fri, 12 Aug 2022 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660304634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rE08NAcCuF+IEl0otRKm+fJbFUf5aCYLvwBhKGbE2Us=;
        b=rTkn5pAgUu+j0/ZBum6QeAA6awTHnQYSGsucr1PPOZtvDgonEyH6RvdFRRqjE5GtWVcfIJ
        T+5xLauWU/t+OzoKLxarOPXCNH268rz6Z6KACBW9Fi3FO0CqwV3Q+w229CrMCJO1oob0LF
        UgkQ8KseEkOJ6wvNGyP6KV3L2WgyzMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660304634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rE08NAcCuF+IEl0otRKm+fJbFUf5aCYLvwBhKGbE2Us=;
        b=MO+oGP+79woBgXP3/TgAkt4ipgBnUv3yB5G9ozRq1PWRLZeqiOhu1Wy7lFLq8GQg2apumx
        mUMaX/LuPUSJe4Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FBC913AAE;
        Fri, 12 Aug 2022 11:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CLzDAvo89mLmfAAAMHmgww
        (envelope-from <mliska@suse.cz>); Fri, 12 Aug 2022 11:43:54 +0000
Message-ID: <325871cf-b71f-6237-8793-82182272ece8@suse.cz>
Date:   Fri, 12 Aug 2022 13:43:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] perf: Print debuginfod queries if -v option is used
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <2983e2e0-6850-ad59-79d8-efe83b22cffe@suse.cz>
Content-Language: en-US
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
In-Reply-To: <2983e2e0-6850-ad59-79d8-efe83b22cffe@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ending a perf record session, the querying of a debuginfod
server can take quite some time. Inform a user about it when
-v options is used.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 tools/perf/util/build-id.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 0cc68cdd84c8..d1cfce0613ee 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -653,7 +653,9 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
 	if (realname == NULL) {
-		debuginfod_client* c = debuginfod_begin();
+		debuginfod_client* c;
+		pr_debug("Downloading debug info with build id %s\n", sbuild_id);
+		c = debuginfod_begin();
 		if (c != NULL) {
 			int fd = debuginfod_find_debuginfo(c,
 					(const unsigned char*)sbuild_id, 0,
-- 
2.37.1

