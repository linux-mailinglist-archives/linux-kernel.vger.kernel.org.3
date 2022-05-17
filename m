Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A6752A442
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbiEQOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242110AbiEQOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:06:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437B13DDDD
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:06:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q18so17407109pln.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQgF3isZDKLWuH4ifhpSCAZBSH+rYxzOtBZkOg2gi8U=;
        b=IKPT3GX934EYxIcfasHxe3tTubPIVtfAnAYWZyhpW6GwiiQm8Q6EvrP2+PB8BY19Uq
         z+jk5+9YM1zPXzRO5OQ7YUIp53As19xlDBYBdy/uEzcOAzGRVrhjAkq966jbCHsoAuKA
         tOWVI/NRZcv3Z4czEtGycQ0WEj+LhunFeJpIocarnusiOo+7JDpn55cQKQjKPbzbPzda
         jtCH5gPbtVtnb+8C5U+OuKDP8CPrGLOgJgPa4aUyWbfiH1obfiNEQufp5X5lHBqLDJoU
         cdKP0lDpxewvCjYEm23e5/TfGWuFdwVpYaXJDFtfOQhzGYQhxMDHhnS4EUfrHf+vXMm4
         fi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQgF3isZDKLWuH4ifhpSCAZBSH+rYxzOtBZkOg2gi8U=;
        b=QkSLZbNO2zyJAAIm9+JVRQFb+d652pnyPKbdmsy6gMhmsI7SoS26Y8d1dvsi1NBm+Y
         pVb3eZkLOx0U3LFNJ/GSTvY2rT/aJu3+2wIq1D+u4wdOW6MddCKMyTeUvVqaVXNhf0Pd
         HNo+5kha3C+8aatTI0GZexf6RgnDynk/biyhtiZ5zAzUCAvjvIN/+U3rE8DDDreuJjcu
         tRgGitMOQ8P01nwKJjQYAIV1IF6/csrB3RBt1/xh4DAvURf3iu22IrNad/dxW6UPvtHO
         BWHbcOH1TsA1klMPMRXg6vZOM6OOCtCB8m8rlN6+omGU+OxSk6efoCvIYhvRpr95vwtE
         Sukw==
X-Gm-Message-State: AOAM531fvTv807It0Mc4pIh4Ldz+YBUS1nPyYLkx6yp3FLKrxT//EYys
        Ut3CvfbSEWmGgcUPFJkQxuw=
X-Google-Smtp-Source: ABdhPJwg4wnpKRIv3claIbAuADoipHj0NqvZyKT11KCxorFdy2PIfBueO5522lxLSA+hZo/YBz6iVA==
X-Received: by 2002:a17:90b:1651:b0:1dc:aec3:c17 with SMTP id il17-20020a17090b165100b001dcaec30c17mr25037491pjb.43.1652796396778;
        Tue, 17 May 2022 07:06:36 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:1:3174:ae5c:a49e:4e77])
        by smtp.gmail.com with ESMTPSA id z34-20020a631922000000b003f27f91135asm3113289pgl.76.2022.05.17.07.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:06:36 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 0/3] staging: r8188eu: fix some warnings 
Date:   Tue, 17 May 2022 19:36:23 +0530
Message-Id: <20220517140626.3716-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes following checkpatch warning:
    WARNING: Comparisons should place the constant on the right side of the test

Compiled tested only.

v1 -> v2:
  Fixed subject line and removed extra spaces.

Vihas Makwana (3):
  staging: r8188eu: fix warnings in rtw_p2p
  staging: r8188eu: fix warnings in rtw_pwrctrl
  staging: r8188eu: fix warnings in rtw_wlan_util

 drivers/staging/r8188eu/core/rtw_p2p.c       |  8 ++++----
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 12 ++++++------
 drivers/staging/r8188eu/core/rtw_wlan_util.c |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.30.2

