Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9A4F10CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347686AbiDDIXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244280AbiDDIXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:23:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BC3B3EF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:21:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id qh7so8225976ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJEB66crM8wka6AgbPIlBAB85bR3Q+QeItJHEO/CkzY=;
        b=NSgjwg2RoYh/+XpTr3R5TuCkjFX7yNEIK6jdvNow+Uy/BPh6WeL7PfrqC5NpmQFN6V
         TelmxfCQ/KFvOfqfsH6gzy7zRs9zA8Zz5PboVLrnXPGZm9IP+HswrSrvqB6EBwbMz6Zi
         4GneTshZWbcpGWX1qGUipZdUTf5wRtITojxe+LQfDFGOSbzBOShsrRm3vDMUlIaGCCuJ
         MGmwRCVHlbfDnhSe01HS5+62ISDc+l21f2V7Qwi0RbEWQ38TWw41phOXhH0bgxScBH4A
         1NKoOTS0jBBZKLmZuKHvaeNlqzVN5aKUCT4khsEShLZ/CcCGiM4NBRHeGvK14+87gpgv
         evPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJEB66crM8wka6AgbPIlBAB85bR3Q+QeItJHEO/CkzY=;
        b=sfQHjFAX6Qsc545u8Q8k8geXGlyFMsw0mvK4zJYu/tewF33riztVQbQ/V2C0812GKp
         pBozdKIiYdXAysBpC9V8uh4Hh+vE+6GgYxA13hLjeok9ENbpflQuJEb3VuO32Ldd4Eua
         NVijg9ROct889GC1xdBRyeAlbZsOCJxPt1DU25qqQKXGqqXH4MOzyrMcKCszCryt8Jxp
         ACBmaB+5FM0e8qd7px1f8uid+jyjFsOzfHrsFOJFSxLB6fON9X17LCvsIyjvKa0LmM/H
         /a0qEGhKAcTiio0mxCBH4NU92+XejMSyLOo5XT0p+jLa0HaQdZ8xLgZXqGRq9I/DM9Kt
         57Xw==
X-Gm-Message-State: AOAM530uRfwI3Qb2eAkaUb5NFM9uxWjxwxhx6HihEegK0tcV9sOTLXIP
        c9R+1AJ7Nb/BfyGyC1m+gk0=
X-Google-Smtp-Source: ABdhPJyt7ZSqeKdu9FtZ2+rGfh9A8mbIzAD/JBSfhBsVbLrrdCic58UP9MD2382z25K+xJXpO5FVgw==
X-Received: by 2002:a17:906:37cd:b0:6e0:bdb6:f309 with SMTP id o13-20020a17090637cd00b006e0bdb6f309mr9792863ejc.394.1649060506624;
        Mon, 04 Apr 2022 01:21:46 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b006da94efcc7esm4047336ejh.204.2022.04.04.01.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:21:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: clean up struct pwrctrl_priv
Date:   Mon,  4 Apr 2022 10:21:37 +0200
Message-Id: <20220404082142.4639-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Tis series removes unused and set but never changed fields from the
pwrctrl_priv structure.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (5):
  staging: r8188eu: remove unused fields from struct pwrctrl_priv
  staging: r8188eu: reg_rfoff is never set
  staging: r8188eu: pnp_bstop_trx is never set
  staging: r8188eu: pwr_state_check_cnts is always zero
  staging: r8188eu: ps_flag is never set

 drivers/staging/r8188eu/core/rtw_pwrctrl.c     |  4 +---
 drivers/staging/r8188eu/hal/usb_halinit.c      |  4 ----
 drivers/staging/r8188eu/hal/usb_ops_linux.c    |  7 +++----
 drivers/staging/r8188eu/include/rtw_pwrctrl.h  | 14 --------------
 drivers/staging/r8188eu/os_dep/os_intfs.c      | 10 ----------
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c |  3 +--
 6 files changed, 5 insertions(+), 37 deletions(-)

-- 
2.35.1

