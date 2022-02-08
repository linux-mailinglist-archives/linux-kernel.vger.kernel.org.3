Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9F64AE04A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353263AbiBHSEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiBHSEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:04:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC2C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:04:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q7so4074935wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esaHoJx4QHm8kkodcqDserNTJ99eLynAuTTriRkvM1E=;
        b=RwcAexFIpLprQCua5xnJFoSaNdoYU+MVkpsruPLL30E6yZFv1NNKJ+PjC6TbHMM7Yb
         SC6SHogzn8WSQNai4UZeqLjqkLOkd5Uxv6TFoc9utacrbG+6ZXlkFQ8f3TE3IZcxRFaT
         NOX0ZGFW9pOB2KtjQeHvhrUVSR8ks3pWAmDsXhKr4T5/Afz+SeHjzakL6I7+Xiq3gvmT
         ZmclHZVIrDyHVZLcXFFYufx3KXJDo8WrEKlSHX+UA82a56qLINrQkP2Gkp/Mn9vaQnBF
         2YQyLdMkY3N2aedfQmoOCK0s8/q882lcyHxdrmDfbXvXKIm/Jktd2Gq6OJODG23n6V6X
         FFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esaHoJx4QHm8kkodcqDserNTJ99eLynAuTTriRkvM1E=;
        b=b+DZnMYW6i6lCU3mkD8qV/79Ay9d6xQ3jwZQHObTQXMr8TIZGHCxYL2LFK3cNoC5cx
         ZN0GsL9daBrohC5a6TPr1CbY3ST9u8WP+qW+lE6uwPo4gwpnIatIRGq5X/gcu/8RJfFd
         qk/Li14QfpLHZbhTn1kcaP103E+7/UDVlabfJ8qLnIRCR+hYgV/B1tm4dBSxocSBL/OJ
         4Spykfvkgajompuc9Wi1Ca32UEqIv3l+JM5I+IvemR+leEK/AO8VshX8Fw2XwAtMd9gP
         kw8vKLWS/z8EINlXqACcWAkHj+7kMqqp/xyVeM9B5dGoFgYhlnIjS3q5Kbr3Jwkop9vx
         mF7A==
X-Gm-Message-State: AOAM5325IYSYcQaOi1u4ZdvS8D+Ow3jpVIoSxulrNvPuSHCkSNbxhgrJ
        BBRqns8dA6fkDNTfInhgWZMYXth3qtQ=
X-Google-Smtp-Source: ABdhPJwpLWEzuSHz7SS3Lyj8/PRvuGSF9l/ZPSaohSwLn3nPBg2LoIZqy+IfgxG012JNS1OBCWltPA==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr4375442wrt.193.1644343473212;
        Tue, 08 Feb 2022 10:04:33 -0800 (PST)
Received: from localhost.localdomain (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id n26sm3176872wms.13.2022.02.08.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:04:32 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Tue,  8 Feb 2022 19:04:24 +0100
Message-Id: <20220208180426.27455-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Use the GFP_ATOMIC flag of kzalloc() in two memory allocation in rtw_set_key().
This function is not allowed to sleep because it executes in atomic context. With
the GFP_ATOMIC type flag, the allocation is high priority and cannot sleep.

This issue is detected by Smatch which emits the following warning:
drivers/staging/r8188eu/core/rtw_mlme.c:1603 rtw_set_key() warn: sleeping in atomic context

Before the above-mentioned changes, checkpatch.pl reports the following issues:

CHECK: Prefer kzalloc(sizeof(*pcmd)...) over kzalloc(sizeof(struct cmd_obj)...)
+       pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);

CHECK: Prefer kzalloc(sizeof(*psetkeyparm)...) over kzalloc(sizeof(struct setkey_parm)...)
+       psetkeyparm = kzalloc(sizeof(struct setkey_parm), GFP_ATOMIC).

According to the above "CHECK[S]", use the preferred style in the two kzalloc().

Changes from v1: Split one patch into two according to a requirement by
Greg Kroah-Hartman.

Fabio M. De Francesco (2):
  staging: r8188eu: Use size of dereferenced pointers in kzalloc()
  staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context

 drivers/staging/r8188eu/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

