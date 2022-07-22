Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B328F57E1DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiGVNEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiGVNEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01162AF949;
        Fri, 22 Jul 2022 06:04:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a23so5143311lfm.10;
        Fri, 22 Jul 2022 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtx1POFQfGcm6rMrqG9zNaho/uQFWTyjs4Tf3lJFOcg=;
        b=fJ4TxTo8srrpzKU87PviIHDVWYPWfk5KEqerQY7surMDSJcklaqAfJU/cYN4vA/QVo
         6pfF1uFiHXk7SdsVl0D+pKyH8KDXPqzZ39G05Nb2uoCiMVNDw/Pk5hmD0nG5ILpwb4Lb
         /m9JwBh5X+rEXlzmKnc3AJa15q3DHY2CgaI+ALCAA9SsJvY/Wdsq45eMsSjOQBMNDZnA
         wPRaaDHJJVLFSvfkNLTgELT2n4uHVPFIAs9Az+RdyVkh2vSb8eQ4TP/LoVkdvXOkX9yP
         Lt1BS+8l2rz4k+nqU1hX9gjVrSPIwHUS3IuoFH88mad3eiMaRSal4306btU9C19AD6PW
         Kw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtx1POFQfGcm6rMrqG9zNaho/uQFWTyjs4Tf3lJFOcg=;
        b=HCZCs98YFIZjJXno1kXk7QU2xE+1IgBnjPZp8Zd3KZKFgfhoaSQ/u7IY3CiViMnYJp
         w8tmaWmkYLIeWUgsWaSr6LwwwMnOnyw7AEmpimrxBJXICp5CaOFd/nnQK36oxIDatjc+
         QyHKh4vshpKs4A8UaIUtiMkbYEjgICmF3WATnK8iKaD6/Xa1hV/TFl1HAjDTyEFhSxUS
         3HVATIJZOHoU+8cfGt3UVr4ad9QC5B7xSv90u7gr9Evx13+RYylVDctzIQdoXmeRQy2z
         niCMpzdArczsUMgS9jSrLAMkMzcGWsKj+6/q9Jmg5q16yj4tQGqB9vVa8i0tADjilKi9
         ubkQ==
X-Gm-Message-State: AJIora+hSjt1+HGgzQO7w6+2GG3pE5oAafuhyGw3ASDILmGXMZuCIjAd
        ZeRdYs+CEG9H7Ok0jhZtzfo=
X-Google-Smtp-Source: AGRyM1sESBw/ngj8wF18Z6xJhKlZwLijIJqWMren1QpYZ+ohaNUhCpGPBjRDGSJ61Mtm1iQbMd/yTw==
X-Received: by 2002:ac2:530b:0:b0:486:6982:5ab5 with SMTP id c11-20020ac2530b000000b0048669825ab5mr193269lfh.138.1658495039206;
        Fri, 22 Jul 2022 06:03:59 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b004786d37229csm1039673lfs.155.2022.07.22.06.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:03:58 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] Improve MCP3911 driver
Date:   Fri, 22 Jul 2022 15:07:17 +0200
Message-Id: <20220722130726.7627-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series intend to fix bugs and improve functionality of the
MCP3911 driver.
The main features added are
- Support for buffers
- Interrupt driven readings
- Support for oversampling ratio
- Support for set scale values (Gain)

Among the bug fixes, there are changes in the formula for calculate raw
value and a fix for mismatch in the devicetree property.

Another general improvement for the driver is to use managed resources
for all allocated resources.

General changes for the series:

v3:
- Drop Phase patch
- Add Fixes tags for those patches that are fixes
- Move Fixes patches to the beginning of the patchset

v4:
- Split up devm-cleanup functions 
- Cosmetic cleanups
- Add
    select IIO_BUFFER
    select IIO_TRIGGERED_BUFFER
    To Kconfig
- Add .endianness = IIO_BE


Best regards,
Marcus Folkesson



