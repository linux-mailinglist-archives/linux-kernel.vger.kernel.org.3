Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D41A50896D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378520AbiDTNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353397AbiDTNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:35:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5481D331;
        Wed, 20 Apr 2022 06:32:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1782B1F380;
        Wed, 20 Apr 2022 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650461576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u3nsAkEoYqusYH+jh45jkLwQcDUnIF0+uF/B/hY/l4o=;
        b=q2AdWvrfJz5IJ0RDBFjwi/XcMLsz6Ptgvx47LNvAxzvTuyChqBBRcnwYhBU/rZQsiDThl4
        Pu3JsWRlFkbsPj2o0WZR/QZ83+MrLtG6/42YG0wvqMO0K7w5VbXatkGfXCUw2b1EFGSO9A
        ofBpkFW55RJSVX4Y1aIr7vN1PsoCxKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650461576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u3nsAkEoYqusYH+jh45jkLwQcDUnIF0+uF/B/hY/l4o=;
        b=M+gf6K5IJc0kPf+bs5s93cxy0UkV7Bb45gvxIMeMrGuzHsOvI2s/UFEfD6HfNBqXcqn3RW
        mijZssFdDA8T5/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE57B13AD5;
        Wed, 20 Apr 2022 13:32:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o1ETOYcLYGLcAgAAMHmgww
        (envelope-from <mliska@suse.cz>); Wed, 20 Apr 2022 13:32:55 +0000
Message-ID: <35bae747-3951-dc3d-a66b-abf4cebcd9cb@suse.cz>
Date:   Wed, 20 Apr 2022 15:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] perf: print warning when HAVE_DEBUGINFOD_SUPPORT is not set
To:     lkml <linux-kernel@vger.kernel.org>
Content-Language: en-US
Cc:     linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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

When one requests debuginfod, either via --debuginfod option, or
with a perf-config value, complain when perf is not built with it.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
  tools/perf/util/util.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index fb4f6616b5fa..289d83baaa2f 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -430,4 +430,9 @@ void perf_debuginfod_setup(struct perf_debuginfod *di)
  		setenv("DEBUGINFOD_URLS", di->urls, 1);
  
  	pr_debug("DEBUGINFOD_URLS=%s\n", getenv("DEBUGINFOD_URLS"));
+
+#ifndef HAVE_DEBUGINFOD_SUPPORT
+	if (di->set)
+		pr_warning("WARNING: debuginfod support requested, but perf is not built with it\n");
+#endif
  }
-- 
2.35.3

