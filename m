Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805B557D597
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiGUVMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:12:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DF54D827
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:12:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m11-20020a5b040b000000b0066fcc60d1a0so2149904ybp.19
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=H9qhrESkqws7B+N4ickDyQEkgfiwzQoqEZa3FmSu3cY=;
        b=mHkbVb8pyTYQPWxcIrfNOEjTQyv7GlKv2jUyqlvrEIw43WaBE5bpTN37PKVVXUss3v
         IkGFZGYfzwwH7gvS34yfIicRB8vAcr9J2j6pNIrWs9C/77wyTqntpBio0JKdb4Dv45il
         r9k+0K6lRxoseZA33pY8lAUt6eD5LXlHyfsKu96nKHKgMGYwhXWLKYURO71ud4y1MqNa
         dhP8d18OxotrFHYcH0sCVVNjkK5ChkCvNHPIcqWTkVU0S7pREt3fEL2x9QbFIRuLLfTQ
         o1Qk5Ai+LKZZDuF6QdqNw4QHu/XJrE0oFaQI5jYGxXq7PQINPK2ti9nCnNPd4sxypiOD
         22Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=H9qhrESkqws7B+N4ickDyQEkgfiwzQoqEZa3FmSu3cY=;
        b=12cy7i+pE+y6MKUtu+jGntn0m9IBDkoNMD2krYsir9ZB04CKVfIfpx7hCzRn42xtg/
         nMitv8AaH15dv2urZ5aWsqV29OLhgLHsjqGHK0TSGyEXQ4cnnjYkWu9lb9PNyi/ZuKWV
         7HpIxSOkig26lIGPmI28zHkX5xRa/gRdH0bAqStj8DS8j40X9wi/pSIDrZd/cqTq4ctg
         jcE+KTovWdKt6CYJiy6mOa7wlylE01Vh5qJiO55ZX8bWrxYv/w2m41BMNwKoL/EbqvK5
         dEtei8rdhwlly0RXPKXsEldSvwOwctkMGdo+7CMYVWPZPr/IU+WyEUXa1+GFQ0ka2wMX
         cvdw==
X-Gm-Message-State: AJIora/pNzScceVuYucm45SYw6VDWPofmahjn6mwEXgvAbTslW5iAkfH
        zkQOlOUwRyeYUZVBLsuVnsKd7OxnzZ2aGtc4/Q==
X-Google-Smtp-Source: AGRyM1vTYnR4aUWgN23O0d/xGeCiiVR9GEMqYRiTTMzQgIpMCx+gOwuM+yLRXZE4QVVT2iCwBiTkp6dnAnUtBxecvw==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:21e:d672:5a6a:420e])
 (user=justinstitt job=sendgmr) by 2002:a81:7709:0:b0:31e:6ee2:dbe6 with SMTP
 id s9-20020a817709000000b0031e6ee2dbe6mr481076ywc.438.1658437965705; Thu, 21
 Jul 2022 14:12:45 -0700 (PDT)
Date:   Thu, 21 Jul 2022 14:12:18 -0700
Message-Id: <20220721211218.4039288-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH] soc: sof: fix clang -Wformat warnings
From:   Justin Stitt <justinstitt@google.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Tom Rix <trix@redhat.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang we encounter these warnings:
| sound/soc/sof/ipc3-topology.c:2343:4: error: format specifies type
| 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
|                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
|                  ^~~~~~~~~~~~~~~^~~~~~~~~~~~~~~^~~~~~~~~~~~~

Use correct format specifier `%d` since args are of type int.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Reported by Nathan here:
https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/

 sound/soc/sof/ipc3-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index b2cc046b9f60..65923e7a5976 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -2338,7 +2338,7 @@ static int sof_ipc3_parse_manifest(struct snd_soc_component *scomp, int index,
 	}
 
 	dev_info(scomp->dev,
-		 "Topology: ABI %d:%d:%d Kernel ABI %hhu:%hhu:%hhu\n",
+		 "Topology: ABI %d:%d:%d Kernel ABI %d:%d:%d\n",
 		 man->priv.data[0], man->priv.data[1], man->priv.data[2],
 		 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
 
-- 
2.37.1.359.gd136c6c3e2-goog

