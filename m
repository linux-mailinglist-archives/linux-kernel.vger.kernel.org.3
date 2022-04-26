Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCB2510968
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354343AbiDZUF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242199AbiDZUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:05:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C091192A2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:02:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p18so18511907edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=nI0EZj2A55ofUBsRwqZw5nL4hPw6vp7tBJKIxUDbZ3w=;
        b=RYNO4UQo1gghXi7ShsFOWpoa2AgEuj+nhRC1vI+N4cGR0/o9ywyYsig+APShHwvwQx
         fNbzXc1c2mB0SZR0DmpeKtqQAZbcDqCt1pTsLcjEt0CqNuRsu/rOcA0H6xV/UtuAERBY
         T8HPcI4hxSjHeaqv6t7EA6iuESishozpcqhv79MS3DQfoT0jLqgwBvhzwM5WmHsXQ0bE
         ScvUrWisH2mKiBxSWuK76RTvLfIimILLYQ4ilu9pwGVhoU/FuzPfLHrFX998L/8IFGU+
         MEtbF+0J7veR182tIj6wtsJfgKYzehfJo2L85aC5lTzmM81d+NxMJEc/zCj5LN2my6CV
         L5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=nI0EZj2A55ofUBsRwqZw5nL4hPw6vp7tBJKIxUDbZ3w=;
        b=jhSXlAidAE9xLyeG1drOsR3Y8bxcL5B0nUG7WX8C5sd5uj8s604Zk4qm+lqWqUJQ36
         gH1Pn3UuGLjXDGKCYi5jDnd9wtbgTw8LjTRhLE0XRs3pqpynJuhXH4Wje9KUJrrtveg0
         dM13pxRZ73bnThtgZTg2ExSbuSxPRljnXAxtB8ra5BKi6wp/4RkVzOaIGhVZp7dh0GFP
         d09953pgiPT4heJ2KRqfunvAim4DZSVbj7qLay27nvsNEVcN+KMP1cgKErSQ73o6nnLP
         +MFRbU0C3nB+w1NL6LCUN7c/BYC2F3sjZ6+bF96dXuiT+hY0nHEM28Jo3KMk/MPXqoeI
         mfLw==
X-Gm-Message-State: AOAM531zECXooeqc0AmbdlxXoFxNXThlaYsFVvVxWVfeDAf/YGpby2wf
        xL4k2WZ4Ttp1SlXyn4YrnIEhNknTE1spCw==
X-Google-Smtp-Source: ABdhPJzJM/8HXY9cSwertk5JmTXSE0G9XOGiRqJHu98TuhrKCx+8rivQE93w87ub8bgrrf5qtcv6QA==
X-Received: by 2002:aa7:d393:0:b0:425:a8f8:663a with SMTP id x19-20020aa7d393000000b00425a8f8663amr26229099edq.323.1651003336028;
        Tue, 26 Apr 2022 13:02:16 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709063a9200b006f022c00fa6sm5287742ejd.165.2022.04.26.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:02:15 -0700 (PDT)
Date:   Tue, 26 Apr 2022 22:02:13 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: vt6655: Replace macro VNSvInPortD with
 ioread32()
Message-ID: <cover.1651001609.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvInPortD with ioread32.
Avoid cast of the return value as much as possible.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

This patch series is new but patches have been send before.
Review changelog on each patch.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Used this code for testing of fuction: CARDbGetCurrentTSF in patch
"staging: vt6655: Replace VNSvInPortD with ioread32":
	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF *pqwCurrTSF: %llx", *pqwCurrTSF);
	
	low = ioread32(iobase + MAC_REG_TSFCNTR);
	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
	dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF temp_ph: %llx",
			 low + ((u64)high << 32));

output:
[  +0.000083] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 116e83
[  +0.000008] vt6655 0000:01:05.0: CARDbGetCurrentTSF temp_ph: 116e83
[  +0.000009] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 753d80
[  +0.000005] vt6655 0000:01:05.0: CARDbGetCurrentTSF temp_ph: 753d80
[  +0.000010] vt6655 0000:01:05.0: CARDbGetCurrentTSF *pqwCurrTSF: 753d8f
[  +0.000004] vt6655 0000:01:05.0: CARDbGetCurrentTSF temp_ph: 753d8f

Philipp Hortmann (3):
  staging: vt6655: Replace MACvReadMIBCounter with VNSvInPortD
  staging: vt6655: Replace MACvReadISR with VNSvInPortD
  staging: vt6655: Replace VNSvInPortD with ioread32

 drivers/staging/vt6655/card.c        |  6 ++++--
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/mac.h         | 24 +++++++++---------------
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/upc.h         |  3 ---
 5 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.25.1

