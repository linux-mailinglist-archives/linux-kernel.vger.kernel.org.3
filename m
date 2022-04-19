Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E884506155
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbiDSAzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243748AbiDSAza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:55:30 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAFD1FCD9;
        Mon, 18 Apr 2022 17:52:49 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s16so4560842oie.0;
        Mon, 18 Apr 2022 17:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JN38yi6u/d5y+sPvnY6QgeeUUgy2NuqrRulT3vcIhH4=;
        b=TURysgL1DZCQ9nLrUUhNHYsbhb/iOSbR9khnZroffAZfJBWe+lo8iMh+DKvPSb1750
         1+SLN97j7xy1emrWb8DUsvtXlht+pPS59C4B6mxCdhUQ7UJw2WVeI+120OXzfcibpZ5r
         cBZ9AUB1C5O0BY5mPcHAk9kmxmv/+5x/o1XqeqR2SRM0EeYoL7diaQhpBkBgqyDdgMuk
         4w/bXACcyfraCURtgaXr4MxTg9v/TeYaUanT6zcMpidhFQ2m/d+LWIvzWWhqVWQBsMRn
         FfVUzBknzr5AxELX/avjMpch5rkusxJ8LidqfIG9DHwazXkrDyR2+//5dtX0i02toq3W
         y//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JN38yi6u/d5y+sPvnY6QgeeUUgy2NuqrRulT3vcIhH4=;
        b=a0LSv0hFsl3J7Xx4+OdLE+l2ZW61ZK9+BC9k0ttMQ+nzowJvSlEMGIcZHwvoK70Tno
         l4TjCKnrJS3w6xO2T+dk8sACvQvh1cgBFfpX1LG0pMWXt93+8TQRNFwiwwkMacN60srC
         vPGi232/glaRTvq20zcD+vGaL+c5As1HGc3YzKfZyZn+Y7xwwOVOsd9w4Ov0uJaYIwIW
         Nt6yjcM8neSxTSEkeYWtNJXjHkaYIfq2vStnO1Ql1lHeI2XdfmMNuz5PSKJIBvFtV4rX
         VpBWW1lgk7XAtcDPAE9MKPx76KUtds07N3/VG5FZoWRQLCMSrMqAwXuDj0aoHVJ7AHzb
         dkGg==
X-Gm-Message-State: AOAM532TGu0uw8ylD8mf4hbGIrhtyJ/MuqFiXtGeOg/HAZLPYHdL78Je
        GOLJs0nGzrHvMhWi0HUy14U=
X-Google-Smtp-Source: ABdhPJxFZWubu82A51A+WNrd02IXBWRXxROV7E+JEVWDnC8d7tlrUBJ/n23gqckXT9U1U+/PODqwTA==
X-Received: by 2002:a05:6808:1b26:b0:322:a467:b9e2 with SMTP id bx38-20020a0568081b2600b00322a467b9e2mr2201764oib.187.1650329568627;
        Mon, 18 Apr 2022 17:52:48 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:7cac:cda1:c0cf:63b6])
        by smtp.gmail.com with ESMTPSA id l19-20020a05687040d300b000e2f6d3afd1sm4534403oal.19.2022.04.18.17.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 17:52:48 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH v3 0/2] of: overlay: rework overlay apply and remove kfree()s
Date:   Mon, 18 Apr 2022 19:52:39 -0500
Message-Id: <20220419005241.831411-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Frank Rowand <frank.rowand@sony.com>

Fix various kfree() issues related to of_overlay_apply().

The fixes revealed inconsist variable names for the same variable
across functions, resulting in difficulty understanding the code
that was being modified.  Doing both variable renaming and the
fixes results in a hard to review patch, so split into two patches.

The first patch in the series contains only variable renaming.
The second patch contains the kfree() related fixes.

version 2:
  - All patches updated, changelogs in each patch

Frank Rowand (2):
  of: overlay: rename variables to be consistent
  of: overlay: rework overlay apply and remove kfree()s

 Documentation/devicetree/overlay-notes.rst |  30 ++-
 drivers/of/overlay.c                       | 280 ++++++++++-----------
 2 files changed, 160 insertions(+), 150 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

