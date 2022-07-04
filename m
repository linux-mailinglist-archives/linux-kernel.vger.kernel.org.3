Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4971F564AAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiGDACf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiGDACd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:02:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBE860EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 17:02:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so11929272pjl.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdZMx96lFpA7S1ssPrnhd1zMXzAzvtb+hhHFnjZtUgk=;
        b=BI93EtocFmaCWG+WAr6LVOIYW3LOnU2+jPIDormyTQLPuK93I9n8xbN3DDDWImo+7q
         1mtT1A/7dwzY4plvSTTwAwOmJbtZzgxdUU6AQZkudhKxpDbQV/D+/9DBzAMLNWAG1Jzs
         2T7nkUlVY6BOoiev4WXp/16BEIDbEOjtHctN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdZMx96lFpA7S1ssPrnhd1zMXzAzvtb+hhHFnjZtUgk=;
        b=UDjWcG4jKL/7PgE+WB9r3ggbrdBChjuJFu/x7wJ8vNaPJpYpBMxRULnSaWngKW21R0
         xsFK0mURLT9+6Y5Tvg8LSn9DiILwzBBx6XVyYITTTTyxw26OPm6vFh488VQYxw8eicZQ
         m2EqnelpSzc6c7GDwXdbrV1h9JxMv/KCi2nMbjHptzdkkN5/0v9roUd1f/L8/v/9dJKk
         h6pb7OiuDBC3HUWjKKANjORZh3VI/Y3EKmrV3C62RTx8ujWE9G3SQuw8i/kAt0VVJyj0
         xEVNWWKAw1I7LehkqydybnZOOPkvvYHCSvLYI4DJMV38pvwQNmz7Nn0ptPj0xBvC+W+X
         JycQ==
X-Gm-Message-State: AJIora/O4wHcC6b7M11/tPl++l/dCrlQjmaz3IsGbk1HjajDNwPJxQFF
        4UN9Y5jyB2+VXO5i56L2MvVHdw==
X-Google-Smtp-Source: AGRyM1uPU3xRrYI6KERUteamcE7kNew25JL2on5eGPfHlgelNP+XwwsSeOyFdA9OnPTTkOMJ0SZtBA==
X-Received: by 2002:a17:902:cf06:b0:16b:cc33:5bce with SMTP id i6-20020a170902cf0600b0016bcc335bcemr10733042plg.152.1656892952487;
        Sun, 03 Jul 2022 17:02:32 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id 63-20020a621542000000b00525204224afsm20014171pfv.94.2022.07.03.17.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 17:02:32 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Brian Geffon <bgeffon@google.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Signal to disallow open of a dm device
Date:   Mon,  4 Jul 2022 10:02:24 +1000
Message-Id: <20220704000225.345536-1-dlunev@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a previuous discussion upstream about this kind of
functionality (see https://lkml.org/lkml/2022/1/24/633). The previous
patchset was rejected with concerns about how the feature was
integrated. This patch takes a different approach, and instead of
tying itself to unrelated mechanisms (e.g. deffer remove), this one
allows an explicit signal via message interface to signalize device
mapper shall block any further access to the device. The primary use
case is to restrict userspace access to decrypted data after a device
was setup with a kernel facility (e.g. swap).


Daniil Lunev (1):
  dm: add message command to disallow device open

 drivers/md/dm-core.h          |  1 +
 drivers/md/dm-ioctl.c         | 10 ++++++++++
 drivers/md/dm.c               | 12 ++++++++++++
 drivers/md/dm.h               | 10 ++++++++++
 include/uapi/linux/dm-ioctl.h |  5 +++++
 5 files changed, 38 insertions(+)

-- 
2.31.0

