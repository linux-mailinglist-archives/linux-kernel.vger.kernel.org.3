Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712B2565CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiGDRTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiGDRTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:19:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E17EC10;
        Mon,  4 Jul 2022 10:19:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e12so16770979lfr.6;
        Mon, 04 Jul 2022 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8AfDeFXZ8XocaLETf4oZhAETHHa8uunZ5QqYb/i3uY=;
        b=jqFLl7xYPbSmIPIm/j70e7h737f/+zXneEP+POo2lh5pF61tmVuKDuy0xcIKF5Toqn
         56M+nmel1gYmRBZvEhfq/bshL8QAF3zcbJ7NzW4kz2KJ9r0FlxesH4GMQG0XZ2fl0Kp6
         mBEUIPhUNS0JqXzQf6rmGtGYmGCHAKrw3V6HC7ds0amnkBwjVsqCVQyeA5AQ3lq5M7lk
         20pCGHBqcenVoilYMihIq0Tbs6v/TtA922rp/XY0ihUP3FQuSei+P/40kNPXUOAAYEsY
         LnRojbsbRfSUKkGKpy1u0fUAe6e0pk/UZEGzdvQd1QNNfUUBW9aMpAbHVxz+QrZH0gjA
         7GJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8AfDeFXZ8XocaLETf4oZhAETHHa8uunZ5QqYb/i3uY=;
        b=k8NyFPQ0cm+OgahoAoEFPBz/q7vWujBa9w2XjkvkzbrMa35/bDtr2F3lWZSpUht4Ld
         0BYv/JNCYdJFwi/CfsQGMR1KTs4LNivXwXIbZirnHNUC+fliVSLvl+Ph3jNnQjpHgs7T
         Dh+ZG+OO9P4sHHByJuxh3X5qUKoysZ2faZYyNDoOjMt25wspVwGTqr8JhUoCoXAFIa8r
         m5c9s5TGsfrzu1x4tX6Rjz8MOziVmWqN05OkeKzWwgDCKkoNzfusjIDMSv7U8GPFAz6z
         b6efb7SJYBeGpud0croVL5B50nNtIWR8Alaq3EfM/dPGlTEKBBaA/pXZVaA6ycu7niyr
         U8kg==
X-Gm-Message-State: AJIora9u1R22Vssp+LytZvpx+qjd4k6Y/MWYXIcIySEULIkPZIO64Dmz
        3t5CzSfpKhmHp+5OGdpgeG0deKqt2QU=
X-Google-Smtp-Source: AGRyM1uHKzN2Jc6u4vClcPS/cKHRuvQgHvDsBAM1IAlHeHJIoTtO/wt6SUQz2wnqtHlQ0lwW2iiCAg==
X-Received: by 2002:a05:6512:a8b:b0:47f:9e2b:9f28 with SMTP id m11-20020a0565120a8b00b0047f9e2b9f28mr20032190lfu.596.1656955148384;
        Mon, 04 Jul 2022 10:19:08 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a2ea609000000b0025bf6099cdbsm2772720ljp.78.2022.07.04.10.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:19:07 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] Improve MCP3911 driver
Date:   Mon,  4 Jul 2022 19:21:07 +0200
Message-Id: <20220704172116.195841-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Hi,

This patch series intend to fix bugs and add functionality to the
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

See patch notes for more specific changes between versions.

General changes for the series:

v3:
- Drop Phase patch
- Add Fixes tags for those patches that are fixes
- Move Fixes patches to the beginning of the patchset


Best regards,
Marcus Folkesson


