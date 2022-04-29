Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2151550E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380475AbiD2UDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378695AbiD2UDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:03:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AA8A88B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:59:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j6so17332252ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DC42akUmXSJZIGpq6cvum+SY5AfJqneY0kBWz8FmIG8=;
        b=EVivewMmOEJKk/UPYHu+PQVj2gvbHZVsKVFmVQ0bIzHElYbopxbqW/AbWmbPUthPE9
         dMRNtcNte05BQ0gwR8s4QwVqfCgmb9UZKZxfAqNr+fxkxD421yUQQhKyXOZZl0O4CkEN
         ENGiMO6NZJVJgDgkHTUf915UyQnLaaJHb8hAT7dAry5oG4kkq5DjSRuI9oixrs6K9M9t
         BpvYkhnrLcyzPytugEzm0Hux302iNLZ2iWHOYuF8h98KOoGpHVSJ1Tm3rCFOXekZOztg
         Cg469MXXJCfhuBKi+J6RLYRId84DEHRX8szNWYWd5iQRWW63Kbazc6ZyN1f5myYDA6o2
         ySkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DC42akUmXSJZIGpq6cvum+SY5AfJqneY0kBWz8FmIG8=;
        b=lPwtNbmtfdDSfLB6M/YXnMYS5bUeS8ZfLq7tKIFCt6iZ3PDFvHicHlH+1aMPsjfN/H
         wzr5WZccJqG+zBO5D+kB15x3km2oQGShnD0liBYCoFU1priNK0ypKyHZKzxdv/jm+gZa
         R0hibE5lJtUghDGrv8mrktepbgdEOKxR7CBeSY8Eusmkr0iL/5rdFcQzXo6B3Xtk3Zha
         e84C+HmCq0n8rOCY0jhSNJT7N0qkZ3yEi8oahJCY33YuDq7qrJBt5D140FMErQI6to2Z
         s2ODVrc7SjfgZkDLdrBxAmko/aZ00DIc9MWbq7EYATBujPHgHy03SUVaCnSIEkMtRHKM
         VIWg==
X-Gm-Message-State: AOAM533POuzulxg2e09tCwa/N9LQb2/HQvHikHD5314uDijk/sEXpayr
        vStedJMyQCd9KKXbEOJ6hqfXpA==
X-Google-Smtp-Source: ABdhPJylbbDDzvgBGDC539LnqDh8umSLmjIuHWum+Gipd4Yb3qRkyXVbD0TpbIL8Aw/QsDUnvWlGyg==
X-Received: by 2002:a17:907:1b02:b0:6ef:ea73:b2ea with SMTP id mp2-20020a1709071b0200b006efea73b2eamr851803ejc.753.1651262390921;
        Fri, 29 Apr 2022 12:59:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id en8-20020a17090728c800b006f3ef214de7sm929486ejc.77.2022.04.29.12.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 12:59:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rpmsg: fix after driver_override patchset
Date:   Fri, 29 Apr 2022 21:59:44 +0200
Message-Id: <20220429195946.1061725-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Marek reported issue introduced by commit in Greg's tree:
2cd402b8fd4 ("rpmsg: Fix kfree() of static memory on setting driver_override")

Therefore this should go via Greg's tree as well.

Marek,
Could you test if it fixes your issue? It worked for my case which used
different RPMSG driver.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  rpmsg: Fix calling device_lock() on non-initialized device
  rpmsg: use local 'dev' variable

 drivers/rpmsg/rpmsg_core.c     | 39 ++++++++++++++++++++++++++++------
 drivers/rpmsg/rpmsg_internal.h | 14 +-----------
 drivers/rpmsg/rpmsg_ns.c       | 14 +-----------
 include/linux/rpmsg.h          |  8 +++++++
 4 files changed, 43 insertions(+), 32 deletions(-)

-- 
2.32.0

