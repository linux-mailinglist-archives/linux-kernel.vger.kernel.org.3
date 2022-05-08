Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A2851F0A4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiEHTfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiEHTel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:34:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C6D90
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:29:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so16730343wrg.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=vACEGzkRJywEG4wOyEYIXnA0uAB7czqrj5mo8+dtRsI=;
        b=NXqOl8Jjt5VXx7e5nPBvMGzMCaMUCeDJKoqVqNs9WUoaxUfFlUZwMlJdf9Bu/ADH+N
         5KdH7AJOncehTZBPJOhZiEruft1MDeZH/qHwSluP+4uIIeQ37hJuLeAn1muYKPKK7tSw
         rHX8WDHcLQYdQEU8ZPlZIIpeDKbT7Z3UWmqpGWc2qZObraaNgitidacv06vVy9caZDUx
         TCxcwMqrGIs9d7334OE2tApJ+Et+Mq8XM/mKNxR0iIgk09KZ8wSSqgwIJUGxR8YFETfg
         a3VKgYX6hIki8e3xWK7yIjYXsASBvquJ1kW8GL0F7THUv74uWkd4L15ARa4LQBf1rmjk
         JVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=vACEGzkRJywEG4wOyEYIXnA0uAB7czqrj5mo8+dtRsI=;
        b=qHZ/5FFiI3CQ0uonm73m25c6SUl8f8De2ap265FtvoosQtrHUhN0Lx4e5sc7FX+98U
         D3m7NMA5+c/pM1OcoRSF+6PEcO/Rd+ZYxgtjqto6kgxDiewmtC7S6uZKc+S3hS1yd0NC
         /YQndOCPrkpzrvEX+1gPd9wzNnM7C3uzqZz0xXzwp3aqqWqjclO6dh/bTxvMWPSJEo2P
         Gr4HKL7NXXid09GrkTe+hfHZbY4M9gDczmYzBOKANsPRuZSRQzNb1EPJATrZe04bJY1I
         SO5Su8E0kVt4GipWgd085vrdq1LwQqjJat3Jk8v+Ek6BP7EfbJzuLofexaMeR+uYfHoK
         z6iA==
X-Gm-Message-State: AOAM530FE5z1TXmyHAyQw4P1+RJyncXHcMAyh7VUQdq8bar7stEeHdND
        cZZ5XlE6bzi7kTSmbQJFfLMHvOHN+cQHbQ==
X-Google-Smtp-Source: ABdhPJwW9xvd1fc//i/fBbz04HuHkGVeT+ybds2CZjJS3jIdxO0G3A6xdoasQd2ycPmfFej5ZTzSMQ==
X-Received: by 2002:adf:e253:0:b0:20a:f176:d928 with SMTP id bl19-20020adfe253000000b0020af176d928mr11097430wrb.505.1652038190851;
        Sun, 08 May 2022 12:29:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f3ed42031f51b0dd5fb7060.dip0.t-ipconnect.de. [2003:c7:8f3e:d420:31f5:1b0d:d5fb:7060])
        by smtp.gmail.com with ESMTPSA id x8-20020a7bc768000000b003942a244f2fsm15012167wmk.8.2022.05.08.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:29:50 -0700 (PDT)
Date:   Sun, 8 May 2022 21:29:48 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: vt6655: Replace macro VNSvOutPortB with
 iowrite8()
Message-ID: <cover.1651957741.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvOutPortB with iowrite8.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (3):
  staging: vt6655: Replace MACvStart with VNSvOutPortB
  staging: vt6655: Replace MACvTransmitBCN with VNSvOutPortB
  staging: vt6655: Replace VNSvOutPortB with iowrite8

 drivers/staging/vt6655/baseband.c    |  8 +++---
 drivers/staging/vt6655/card.c        | 11 ++++---
 drivers/staging/vt6655/channel.c     |  6 ++--
 drivers/staging/vt6655/device_main.c | 23 +++++++--------
 drivers/staging/vt6655/mac.h         | 43 ++++++++++------------------
 drivers/staging/vt6655/rf.c          |  8 +++---
 drivers/staging/vt6655/rxtx.c        |  6 ++--
 drivers/staging/vt6655/srom.c        | 10 +++----
 drivers/staging/vt6655/upc.h         |  3 --
 9 files changed, 48 insertions(+), 70 deletions(-)

-- 
2.25.1

