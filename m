Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F45591031
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbiHLLkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbiHLLkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:40:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0DC97515;
        Fri, 12 Aug 2022 04:40:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 049F338DC2;
        Fri, 12 Aug 2022 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660304450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HQHcR/65qc9BFscIU2dqNOjOuZde0RnfC+dbzIUXaEk=;
        b=k7W1ODFC0AmW6x1An6PXRz1phIhcSl2sFGTdc2N1mMjS0M1h6fch/Z+wViY5hFAAaNm0MV
        GCOqpzsYKZ8932d5F7ROJjLvoq661ib9tPxHcmvN520DypYlJibudzfeg9cG1ucBtHO5uF
        rIOMRQ5K6N4QdAnLLcygBR1qlAb5pcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660304450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HQHcR/65qc9BFscIU2dqNOjOuZde0RnfC+dbzIUXaEk=;
        b=vrtsSdQTYkKCt92Qt/KVUQKTg9/x6Ry9cwm2+kSiS4+3BYhfoBq7yrTXvvVyY9NVWGRTR0
        j4mQiVWQOU8IvaDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2B8A13AAE;
        Fri, 12 Aug 2022 11:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0AJjNkE89mKGewAAMHmgww
        (envelope-from <mliska@suse.cz>); Fri, 12 Aug 2022 11:40:49 +0000
Message-ID: <8e00eda1-4de0-2c44-ce67-d4df48ac1f7c@suse.cz>
Date:   Fri, 12 Aug 2022 13:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] perf record: improve error message of -p not_existing_pid
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Language: en-US
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When one uses -p $not_existing_pid, the output of --help is printed:

$ perf record -p 123456789 2>&1 | head -n3

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

Let's change it something similar what perf top -p $not_existing_pid
prints:

$ ./perf top -p 123456789 --stdio
Error:
Couldn't create thread/CPU maps: No such process

Newly suggested error message:

$ ./perf record -p 123456789
Couldn't create thread/CPU maps: No such process

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 tools/perf/builtin-record.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cf5c5379ceaa..4713f0f3a6cf 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3996,8 +3996,15 @@ int cmd_record(int argc, const char **argv)
 		arch__add_leaf_frame_record_opts(&rec->opts);
 
 	err = -ENOMEM;
-	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
-		usage_with_options(record_usage, record_options);
+	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0) {
+		if (rec->opts.target.pid != NULL) {
+			pr_err("Couldn't create thread/CPU maps: %s\n",
+				errno == ENOENT ? "No such process" : str_error_r(errno, errbuf, sizeof(errbuf)));
+			goto out;
+		}
+		else
+			usage_with_options(record_usage, record_options);
+	}
 
 	err = auxtrace_record__options(rec->itr, rec->evlist, &rec->opts);
 	if (err)
-- 
2.37.1

