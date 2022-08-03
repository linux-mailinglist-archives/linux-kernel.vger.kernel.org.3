Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26A058936C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiHCUo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiHCUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:44:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3BB9FC5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:44:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k16-20020a252410000000b006718984ef63so14147685ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0sKogew4m6eCnkm9Qwz368UT9tOW4WxFrPuJ/tuZBLY=;
        b=ob5DwtSjNECtxnS+HT9qoDLpsMlGuD4A/DhuB8jtbj96zm7uzCWnWlX+AiA1OUjzWU
         aqQdI6op/b1qZn2enAIscsZCDTY3DK2dPQPyYuNp/w6zUr9V3sENZuk1TSMLDGjSu1QW
         5RqZgwgK+WcrVObpOSatpr5G0sPmzOo5mil/POxat7xjWKAmVE4ULVIguXSh5npxVwus
         HSOEaImyJF9jklYeGzL/yThSRIa8f7pW2sjf65LsLL8okLaK+39bR0XwEFTjHhpwEKyb
         11Yl+p7oJaiZduYb7i+ZhCdj40d+5JQpiijRq7tHU4Rnhzo1uQudKhmcal39TM8WCoBM
         KTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0sKogew4m6eCnkm9Qwz368UT9tOW4WxFrPuJ/tuZBLY=;
        b=V1PYut0QhW9Fw4jMHo7Ptzv+X92fMVKqWSj8ceYnGS9h6Oi54bH3AEGSnnMYQWXT4H
         xsQWE4/tYU/7/bJjKORaxL6Vf7QZbmRO4W6kQuIAkYlbBnjtktCgMu/qq+I9N1SZFmYQ
         awUQTZ1wjNF8h77lzs90U4FEEECR9005jAkaz0+qWBDoMEFdkY++w5/G7+abX99+OwOa
         fVAYBp9PZnvHp7KPeIA4VUmLg+Sn6lD/+hXUjQD0qd5JghvR3uovIPvbvMn+qgRn0ub5
         i4tIMyrg8xlOgFLJdUqcl6v0SpeSp6qyVkxdjP1cgI2qYiZ98kAdLDm/P1XuY8kfK6lT
         gdNw==
X-Gm-Message-State: ACgBeo0wOtV5l7TZJIGjKj3i/UdcUiwcbA7iEZ/e8RoeIVctRc6EQo0Z
        CH1MxDOauD2Am6dgFdjzUip4wsLoeVF0ZbyurA==
X-Google-Smtp-Source: AA6agR5swAlRAG0PoXXTtzTzeRtGlfsuTK3cgLN3STV50CkZr1FuU63M63rJYJC1oNB2Odd/8z1DQzP4Zmk5hllYvg==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:1bc6:4ec2:4609:dea0])
 (user=justinstitt job=sendgmr) by 2002:a81:5ca:0:b0:31f:38d6:f59f with SMTP
 id 193-20020a8105ca000000b0031f38d6f59fmr24401528ywf.324.1659559493505; Wed,
 03 Aug 2022 13:44:53 -0700 (PDT)
Date:   Wed,  3 Aug 2022 13:44:42 -0700
Message-Id: <20220803204442.2996580-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH resend] ASoC: SOF: ipc3-topology: Fix clang -Wformat warning
From:   Justin Stitt <justinstitt@google.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Justin Stitt <justinstitt@google.com>
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
Note: resending with the subject corrected, this patch fixes a build
warning that will break the Clang build when CONFIG_WERROR=y.

Original patch: https://lore.kernel.org/all/20220721211218.4039288-1-justinstitt@google.com/
Reported by Nathan here: https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/

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

