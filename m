Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB9D4F5B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbiDFJjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458157AbiDFJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:34:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9A410C520
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:19:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c42so1369950edf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 23:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhXUcy9K9Pn3mobbZPyUvJVrgWzwSgkEZ6xzrmm1G9I=;
        b=oy5+TSPG1XLg9ubfohlBh0LafhyPO1CagI0zqJWxFoyVCmrsziM4lv5PryW+OhwyGF
         WxZqPjiw7ZIP2K/vf6rbSbhOenF984H+7rUgD8gANx5+un6qQRAtvR0GV3snDkwr8qje
         hng4WSRIik5BjUlo0xinKFituCXPX9sniijZXoJOKsB+2qjXSsYM/EZ4E2G+yMno4p+N
         8QTf5ooyM4heeQF55GQRTHqHk6Yo88QZDh/fkz9MxAPl0EscJw21xI4gKxZf2BBI+Z91
         0w8Azu/Qu9U1gufJCQZDTLAkaVya27WuBtKJfsMvCM8QeD8xev/RepKt8KhZ2CiO2GFY
         Ms+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhXUcy9K9Pn3mobbZPyUvJVrgWzwSgkEZ6xzrmm1G9I=;
        b=z3HETFWqEOYDH0cEwx1v4QsKdj2EjTuczAkzk4Olx2ECmnTxorfthZSL76hKSk1N/b
         QdZq00K0K2nXm9htRorrFjU/zuGf8T+wmpB2sNvPh33LCLsHeagVUMLgzufs81GZPLiy
         8YqHIH+H93XKyEXfWhR8bNJE1H0oEKZZ7Adr+n0qjKjmygGrMBb1eKhjbTngVmW4puKI
         AMeKDfcTClX0Z0sxcGxYjQfDHdza8Sb/WikIgSzrDMvur/J9qEXoAdAwJKXxwMy5cR+r
         gWAJQJYjjYPZ59JR5PB9HQ5c1tdfuB5q53l0+R0FJmkJxtqmTldTVYCk29oTL45BPutg
         QV4Q==
X-Gm-Message-State: AOAM533p3IsW2UpIHgi2Yf9ePBsoIKDUSUlbFr4EeYFRPXUXBAT3xD0n
        JolJeZ4aFLZxivUNOk4DddPweVg7RYk=
X-Google-Smtp-Source: ABdhPJy/ljDagNPU3F2GD5sXL97C5xeiHPwAtW/wOWPCtPWqSEEzpIaTkMk11IsXB8FAUguuWqreqw==
X-Received: by 2002:a05:6402:14b:b0:418:d06e:5d38 with SMTP id s11-20020a056402014b00b00418d06e5d38mr7031243edu.90.1649225951685;
        Tue, 05 Apr 2022 23:19:11 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id q3-20020a50da83000000b0041cdd6e92b1sm2475251edj.27.2022.04.05.23.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 23:19:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: use round_up()
Date:   Wed,  6 Apr 2022 08:18:54 +0200
Message-Id: <20220406061859.9011-1-straube.linux@gmail.com>
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

This series converts the driver to use the in-kernel round_up()
instead of custom _RND* implementations.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (5):
  staging: r8188eu: use round_up() instead of RND4()
  staging: r8188eu: use round_up() instead of _RND4()
  staging: r8188eu: use round_up() instead of _RND8()
  staging: r8188eu: use round_up() instead of _RND128()
  staging: r8188eu: remove unused _RND* from osdep_service.h

 drivers/staging/r8188eu/core/rtw_cmd.c        |  2 +-
 drivers/staging/r8188eu/core/rtw_security.c   |  6 +--
 drivers/staging/r8188eu/core/rtw_xmit.c       |  4 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  8 ++--
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  2 +-
 .../staging/r8188eu/include/osdep_service.h   | 43 -------------------
 6 files changed, 11 insertions(+), 54 deletions(-)

-- 
2.35.1

