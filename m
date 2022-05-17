Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ABA529EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbiEQKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiEQKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:05:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CEB49F23
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:05:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7dbceab08so152147647b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZA9V5lO/+F+bF8jz1FqVjCsKgJDekjpTcf5RC67Rb+U=;
        b=CN+dHXm2PBRqvy1rf8fgS0o1jp5PYo7NivTVKQ/nKjhnlxSy7HON46mSOSXnbxnGt0
         0sM5TU3u1zBA21392OldZVr96LXY6KYit/jNYjk5EXR2CKoahlGMahwQ3FJUVseXyfI9
         cjBk1AWdrStlRBMUoPYESDY747UFkaFerpdGd9zJn2SF9wswLfipINF+E48kcMMNxFzF
         q4qSS/wz8gpL9dt631yseTk9m+wgmd+eNfv/jyPAJqke0+nnHbJavlK+Dqkq+5zr3Lw2
         jkxf/YGWa6gjweNW4DGXn5BjStf5V4Q9H6pXaZnnq3VkYUYWaAXIH05H2Uc9MjHsoekj
         DBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZA9V5lO/+F+bF8jz1FqVjCsKgJDekjpTcf5RC67Rb+U=;
        b=f2KkjFRz5Z8+gPW73uUochJzmlI4KhesIKzObn8L2nldgvGfPFgkTmZYrf/KBoJyGy
         Kg1sg/OoQi1pYjDV8QX/fdepMWki4QPbYJKkQ2/J1mFwMqolSzCxpdoTpJC1kR5PzWKQ
         7CYDbre0ScsyJH9hdez48N0SbFUuCQOkVTZl0uRFG8pIlaQeole9OKvq91uoBXSJN0Fb
         hVyCN7Vlfv/WehcanPjDzqAXbqOXUhFysNF8j3kfeMsp/vtbP2+SkC6l+bUTNl9qRKqp
         p8SWtXaXv0O11EOGmRDoFmK39GSGcwgHO6QmY6Z4f8pnCBW5ZHI14SyzUNsYR5uofyD3
         VblA==
X-Gm-Message-State: AOAM531twZ1dS/VuBEDujElJjcKYAleKFDQtxloYUo/StbltTB8aUcjA
        t/7Tqn3nXn3g8/1WgSxCmb+/jPAvsonRHXovZLpIQpe0BBusa0lrp49qV+INgbqTy1GGcu3i2RF
        +Q+CLpfP1zuG5Sd+TRfVamJdbEbNjdVzFphmzXh6JxXWat3SNCtkqTe0uQbRF5NF7MFEekR7h
X-Google-Smtp-Source: ABdhPJzMkGHc7O1/Q7FmKZm+eLOtBU+xuDYiFF/nyYQhd08PMvWlme4OLTlm9m4QdO//1tq2jicPIWNqvZsR
X-Received: from suichen.svl.corp.google.com ([2620:15c:2c5:13:ae7d:134a:180d:9b32])
 (user=suichen job=sendgmr) by 2002:a25:6406:0:b0:64b:17e3:9dd with SMTP id
 y6-20020a256406000000b0064b17e309ddmr21661588ybb.186.1652781921142; Tue, 17
 May 2022 03:05:21 -0700 (PDT)
Date:   Tue, 17 May 2022 03:05:04 -0700
Message-Id: <20220517100505.2569874-1-suichen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC Patch v5 0/1] i2c: core: Adapter and client stats as sysfs attributes
From:   Sui Chen <suichen@google.com>
To:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        wsa@kernel.org, openbmc@lists.ozlabs.org, tali.perry1@gmail.com
Cc:     joel@jms.id.au, andrew@aj.id.au, benjaminfair@google.com,
        krellan@google.com, Sui Chen <suichen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds statistics to the i2c_adapter structure as Wolfram
previously suggested
(https://lore.kernel.org/linux-i2c/YgEYEk355t8C4J1x@shikoro/).
It also adds relevant statistics to the per-address i2c_clients where
applicable.

The list of statistics are:

- bus_errors
- nacks
- recovery_successes / recovery_failures (only applicable to
  i2c_adapter)
- timeouts
- messages (only applicable to i2c_client)
- transfers (only applicable to i2c_adapter)

The statistics are located in /sys/class/i2c-adapter/i2c-x/stats and
/sys/class/i2c-adapter/i2c-x/x-xxxx/stats respectively.

Since the counting is done in __i2c_transfer, where the number of
messages transferred is not known upon error, the error counters are
attributed to all unique addresses that appear in the message list
passed into __i2c_transfer.

Currently an rbtree is used to find the i2c_client located at a certain
address. Would be happy to know if there is a better way of doing this.

Thanks!

Sui Chen (1):
  i2c debug counters as sysfs attributes

 drivers/i2c/i2c-core-base.c | 240 +++++++++++++++++++++++++++++++++++-
 drivers/i2c/i2c-dev.c       |  94 ++++++++++++++
 include/linux/i2c.h         |  41 ++++++
 3 files changed, 374 insertions(+), 1 deletion(-)

-- 
2.36.0.550.gb090851708-goog

