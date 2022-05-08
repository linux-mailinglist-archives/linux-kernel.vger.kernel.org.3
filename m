Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9015351F1D4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 23:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiEHVcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 17:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiEHVcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 17:32:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA940DEDC;
        Sun,  8 May 2022 14:28:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso9782995wma.0;
        Sun, 08 May 2022 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A/zOqb4x/q8KxE0MrgpQFzG6bfh8WIATxK/7TnCd/GM=;
        b=dmpe+mmUEqO2Bi7E0HKUyAPX4i5aQHML9SA2Cp9S+SbSeywomzxtHiPKhBP3T5/+/Y
         WupsVLsHiANQprLBxqlj7xuQHXCa36j9ZmowYYq9se+XIqg1/rvNDIS0PVevvIf6vwxr
         mavAVUPp2V3+QqtTCi/bsIVIyE4i0vXPOuinZx1TzVMTB4wfFO7N8rTu2NIfToO1EVDQ
         Da4+MtG+VxzPKOzwZ1BHXCz7LifXdxjXJr4GWpMXHvJ6WCVXnOzK4k6G+RdJNZQIk/b9
         584u425A8UsTxSBeiGZGIjGjU+v8EZ4ndodQqRBtm6o54J1IhMFW41PbOvsp9Dh7Qxg8
         yBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A/zOqb4x/q8KxE0MrgpQFzG6bfh8WIATxK/7TnCd/GM=;
        b=rrO+Ynf/yK0sVjZ4p0B7V7EmBKMBrpkTYem/onXLEJORsy3nR3adUZXu38CM9yIce5
         9BGtnHdncDP4tjkfWiW1P7kmTOvFAOZWkFY4f75cLHrRheyPfRrq5m6OQjw6VO8qsZPD
         71XCkSdpq+zp+5JUWVWtAxcFNhi8nFVdpcWEhHN/drbeXdwFMSylHIQgOZoIalvi1slf
         R6c7Jm7WCQ8N1RpGqUhWoa3560rMwl38X0/yKGdYExpgK0JmNJLzlSQsTh3hXNCk3Za+
         3A6la0aV2eZL2vEu/b8lwvP8Bbp+4+3x8oH/glT9FDA9nmTx1asOVgiJbYxT0NK9N0ka
         2/2w==
X-Gm-Message-State: AOAM532Fo9D6qb0h34sdBrsndpAEG3EExkMTlSGLUmz2BxRzNvxShGmP
        ye89/aoyOyKGsBsE8OiGMG8=
X-Google-Smtp-Source: ABdhPJzl/qff/sBxuFnWUAx+AW81h6wIqQ6XCu4smjK1s4+YK0vM34kUo20wHmx1AuGHCQI/j0apqg==
X-Received: by 2002:a7b:c8c3:0:b0:394:547c:e5af with SMTP id f3-20020a7bc8c3000000b00394547ce5afmr19608805wml.202.1652045300405;
        Sun, 08 May 2022 14:28:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x4-20020adfffc4000000b0020c5253d922sm9253047wrs.110.2022.05.08.14.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 14:28:20 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hdsp: remove redundant assignment to pointer kctl
Date:   Sun,  8 May 2022 22:28:19 +0100
Message-Id: <20220508212819.59188-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer kctl is being assigned a value that is not being read, buf
is being re-assigned later. The assignment is redundant and can be
removed.

Cleans up clang scan build warning:
sound/pci/rme9652/hdsp.c:3317:28: warning: Although the value stored
to 'kctl' is used in the enclosing expression, the value is never
actually read from 'kctl' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/pci/rme9652/hdsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 3db641318d3a..dcc43a81ae0e 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3314,7 +3314,7 @@ static int snd_hdsp_create_controls(struct snd_card *card, struct hdsp *hdsp)
 	if (hdsp->io_type == RPM) {
 		/* RPM Bypass, Disconnect and Input switches */
 		for (idx = 0; idx < ARRAY_SIZE(snd_hdsp_rpm_controls); idx++) {
-			err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_hdsp_rpm_controls[idx], hdsp));
+			err = snd_ctl_add(card, snd_ctl_new1(&snd_hdsp_rpm_controls[idx], hdsp));
 			if (err < 0)
 				return err;
 		}
-- 
2.35.1

