Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E66450D385
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiDXQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiDXQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:34:46 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA182A1B4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:31:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bg9so11444663pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pw2gY9g3Zv3KXM6VXF/ImbqSLw84yB8cj4stx7YhQT4=;
        b=Ju5qlgtY8/ORpMVMvWLrQUKE0tSJ2+epFXYwkkXh//9V/x5KT+UTQ+HLWnOQEljHmc
         ijOcRsoETTaSM6WBdlwbtMm0y3ZxqsY5S5eeXQTtTwO1OPcPafhVktCVndjcXbM7kold
         v0JUjR5QZUZte3nUNu8g3h7ELaujPa2V4momOBvyHtGy3fJ3HfqyrUeiyWFlF1asfiUw
         9INuDZNbMQw5FviVOC4ErZR5KcMcpzGrfZDqSHtrSHed93CsVKtX6jS5PXW8u42B+PRC
         d1SySWGv1PlqGGDAx6eBgzpcG35cTiGdtyPIA1EgdFQVvixOBWWp2ZHig+tB9tcKQV2e
         BWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pw2gY9g3Zv3KXM6VXF/ImbqSLw84yB8cj4stx7YhQT4=;
        b=Hp23DQGBrXYeCIGmT48uenFUaJiRmFN6Uhn7mBZbbb6qdANQ0PG1iRL6Y/XiKHAZ9m
         h/ZcQZT5hwr2LWFFhIWQE8RpwGz8ibU2DeiB2anE2IzxQPh7A4RC+h4JZZbguYhlxMlg
         EpM2YVGkyBF7OBZ0KGkMFDBvXZKKszDsV2rxZzGBB8WVKs40b7++ikXDTPbb6D/6rcnk
         ddBXQ/9Ok8n8MXyj2I5bpapa73NlXhc19MDoXJMPQCLgsFZtY7nFF5xgj0/xPjLkRaH3
         Ok673Wr6nyfkyce4uQ1hRvaGRx3iED31lemA5l6i4hD0EeewHU9V9tqiW5U/aBUhdQPS
         PRgw==
X-Gm-Message-State: AOAM533MzRDtnlkiD+G7Ic1cSUQon35+q/oDcNL8dYsA3VN2Xkrb09b4
        Z2RxQQIaX2CXON01BtXkchw=
X-Google-Smtp-Source: ABdhPJw3IpC+QxPsTGZQJ6he+jsRJNc1Ee5RsRMr6aPMF9erOSofHzVJLWyUe1OK/Xhf0dzyGcCAVA==
X-Received: by 2002:a65:4c4e:0:b0:39d:21c4:2381 with SMTP id l14-20020a654c4e000000b0039d21c42381mr11988550pgr.566.1650817903265;
        Sun, 24 Apr 2022 09:31:43 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:b82e:45af:4bb0:4014])
        by smtp.gmail.com with ESMTPSA id i5-20020a635845000000b003aaba2d78c2sm7113472pgm.71.2022.04.24.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:31:43 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: fix some null checks
Date:   Sun, 24 Apr 2022 22:01:29 +0530
Message-Id: <20220424163132.37007-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some NULL checks which doesn't make sense. 
So either we should remove them or fix them appropriately.
This patchset fixes them.
Tested on Comfast CF-WU810N RTL8188EUS wireless adapter.

Vihas Makwana (3):
  staging: r8188eu: fix null check in rtw_free_recvframe
  staging: r8188eu: fix null check in _rtw_enqueue_recvframe
  staging: r8188eu: fix null check in _rtw_free_mlme_priv

 drivers/staging/r8188eu/core/rtw_mlme.c | 8 +++-----
 drivers/staging/r8188eu/core/rtw_recv.c | 5 +++--
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.30.2

