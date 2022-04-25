Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5692E50D8D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbiDYFct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiDYFcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:32:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594C9263F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:29:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s14so24512523plk.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nPLRlhg/0lhN/HtGvqWRt3vnb6gZRPusJBT9A2ntz78=;
        b=jyi1xmYpZkLiZGkGd9LzZHTIwrlmTlU9iCMSgBIqLwgfHBXtnqbNElP/5aAyclgZF8
         pjYUZKcxzkcRTjwsyUIsJT4roFZghk3VuyBJeDWhgkXjGVy8QYUvtPPcwO72rtLLeoCB
         Hfs8GSs3+MfccaeRUo4pJLZGu/q/FknFThDV3kQLOUHmDcZv9mPQxmPfyt80IrU/9+K8
         0gc4kw4xRymizxo2Gn99Xjh9vRYXwgNrZGWPXC5QhZ4HOlopEn1jt68X0x9yR3Wl8cXs
         8ooTmC7phAniOZTL/i73bc3vy3WERFk+ECw4GIOBsVi6qAxV/wKh4nDVXLo950ydj0cD
         1Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nPLRlhg/0lhN/HtGvqWRt3vnb6gZRPusJBT9A2ntz78=;
        b=TjEQpmqq7hNxjnl2gujGvk3eSEYLHNvKpCqTRgs6YLtyNIPiI4fPPjvN93HrSiwr6d
         qalumRZvhnihggo2N8DCfTwbK/seJ8K9QtSQ/IUU0BarLgvQjOdUJePQPYhc4r9EJrAf
         kIKt9g1Jz39kRDgeVXLWjdKORwhYn35jnqX4oae39boG6lV2N0BitGxDb+CAVOAYqw3S
         brBhLOJqeLRNsTqAX1suLQcuJr61xpNS8X4WAuYn4uVGFfP2YOrIdpU/K0bkJ/kZwE/a
         Zkex669WOViMelHMrVEi9ekWim5clphOoaenRM448ntzf/8wvfpfSx8vWpWmu2V0sMts
         aASQ==
X-Gm-Message-State: AOAM532PMNhHdo/2+/TUlO4kbQZV4asWCWuwkJWcIvhI4UMT0DRREidj
        66YRAPLdwXv4Ol3oCubACtkwWA==
X-Google-Smtp-Source: ABdhPJynkCpqwEnze65m3HZVlYOWpkBQstjbUHKWCYdb9fXlmDc/uaiWvd+mtBce0dACBMBvb9RPaQ==
X-Received: by 2002:a17:90b:1c01:b0:1d2:add6:805f with SMTP id oc1-20020a17090b1c0100b001d2add6805fmr18849931pjb.29.1650864579862;
        Sun, 24 Apr 2022 22:29:39 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:237c:3672:1f2:b81c])
        by smtp.gmail.com with ESMTPSA id 5-20020a631045000000b0039d942d18f0sm8282017pgq.48.2022.04.24.22.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:29:39 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH 0/2]  soc: ti: wkup_m3_ipc: support i2c voltage scaling
Date:   Sun, 24 Apr 2022 22:28:04 -0700
Message-Id: <20220425052806.484590-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow loading of a binary file containing i2c scaling sequences to be
provided to the Cortex-M3 firmware in order to properly scale voltage
rails on the PMIC during low power modes like DeepSleep0.

The new 'ti,scale-data-fw' property contains the name of a binary file.
    
A prerequisite for this series is:
[PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
https://lore.kernel.org/linux-devicetree/20220414192722.2978837-1-dfustini@baylibre.com/

Dave Gerlach (2):
  dt-bindings: wkup-m3-ipc: Add ti,scale-data-fw property
  soc: ti: wkup_m3_ipc: Add support for i2c voltage scaling

 .../bindings/soc/ti/wkup-m3-ipc.yaml          | 11 +++
 drivers/soc/ti/wkup_m3_ipc.c                  | 93 ++++++++++++++++++-
 include/linux/wkup_m3_ipc.h                   |  9 ++
 3 files changed, 112 insertions(+), 1 deletion(-)

-- 
2.32.0

