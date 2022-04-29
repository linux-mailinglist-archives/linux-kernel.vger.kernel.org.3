Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC05351499D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbiD2MmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359327AbiD2MmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:42:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D00C9B44
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:38:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id y14-20020a9d460e000000b00605ee347da1so2500262ote.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GyLq/VeXsUx7i3jX6gXpo6bXbVNITIFiiUrEDtEMY+w=;
        b=yBhyfloaiTY1IVTbeQadAid7OQA5iFJYxuwJ71nUqzOYUX6rTgNjU2a+VJl7EAC4NV
         49q0sAscKw1XpWdXFzHfWb84cR0Ta1bpYLPKdUxB1oPiJLubSviIRSe+nBBVAHmfumX/
         r4eklVMjUTL8YQrl88ehVnE9Hzt+1EjwY7eRA0ZAeDp3BOWRzipo/Wkbe6YBYKkpaYGc
         A2WIBmU8owUzbma6An2NEDIq+8tGv+9V5sVaEdIfGBwaZf/sX5Qq2BjVI/FGoJxmXQvh
         fVhe2yQeGhn01V4Qi3rbya6Eg3SR2ZfPalj1i7GKbH4QqrwO/rjAX5cclDfUMAOmxosM
         k6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GyLq/VeXsUx7i3jX6gXpo6bXbVNITIFiiUrEDtEMY+w=;
        b=0VTRainqwJhw6onvqXxQzr+LhjKnsqiHfmFSCffD+w3YVosRzAs6pmAs+yp4RIdZ+a
         2yHNhJuhLvulE+zr3aNgJiwn1voji4wLlV2gLW994NkV5o8tCyfcmLq6wEIkFj7mV7fH
         AWnsgiVWFUOHzYGs2qRlGN7HZw4A7ouwF5sSRCX8cyD2CE0uPwy7uN+8TWMZ4Y7tFu/g
         vUUEX1E+ZmWMH3Y8y82bo+y65aB8wWGgC3ZzkS0DSQiyUM+SwaNvIx/XHO8GfY9mpgbP
         o+pnn0OGX9L3fAq4w06vGjUtWUUpPZ+TN6+GjzJu0oDjdZnt9eW1LTEPtyKjrHVzTc+f
         2nnQ==
X-Gm-Message-State: AOAM530jyVrrQiSwDCKVgtStQOiHnG3Qq7StGaTXixN5Egp8N3ELDq5n
        jsEfgc+BR7uBT/rhipn71o2fPw==
X-Google-Smtp-Source: ABdhPJxPDW83R2yw7JMq1jxLLs7fVovH8A1+UGFMXP2aSOvwrrTatEspXjIK4tKZeaULwGrtm7ZbSQ==
X-Received: by 2002:a05:6830:89:b0:605:642d:bd4f with SMTP id a9-20020a056830008900b00605642dbd4fmr13679037oto.235.1651235921194;
        Fri, 29 Apr 2022 05:38:41 -0700 (PDT)
Received: from fedora.sc.usp.br (gwsc.sc.usp.br. [143.107.225.16])
        by smtp.gmail.com with ESMTPSA id e12-20020a4ae0cc000000b0035eb4e5a6d9sm705158oot.47.2022.04.29.05.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:38:40 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH 0/2] media: s5c73m3: Update gpio interface and documentation
Date:   Fri, 29 Apr 2022 09:37:38 -0300
Message-Id: <20220429123740.147703-1-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Andrzej, all s5c73m3 specific gpio code is completely removed
and replaced by the gpiod framework. Moreover, the documentation is updated by
fixing the misplaced gpio property.

Maíra Canal (2):
  media: s5c73m3: Replace legacy gpio interface for gpiod
  dt-bindings: media: s5c73m3: Fix reset-gpio descriptor

 .../bindings/media/samsung-s5c73m3.txt        |  2 +-
 drivers/media/i2c/s5c73m3/s5c73m3-core.c      | 95 ++++++++-----------
 drivers/media/i2c/s5c73m3/s5c73m3.h           |  9 +-
 include/media/i2c/s5c73m3.h                   | 15 +--
 4 files changed, 45 insertions(+), 76 deletions(-)

-- 
2.35.1

