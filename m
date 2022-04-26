Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF270510986
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354439AbiDZUKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbiDZUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:10:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FCA1594BF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:06:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so3129207pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYZny63Olqdg6ug0jPC0IStZPSKLknIicaEuGEKKAA8=;
        b=veF8bU8ZuY4+7L01tnkAqnvnIS105JuIyOIc9jEjB2riL9bUNDkywylOlBB9cZ7alg
         aYHfxFvJn/kPoxsuT4AF/LLIK37UKhDWs5cY8ow5krN42QIvpj+xt9duHH8PwI2F6gMU
         WQNP0iIq3XlbYhsY04ueU6IU+1pHigr2y5mgo0RAt/awM0logn4wMW/2p7/HXGVAfc0h
         apCilHYRzF4k/lZh700CN/IGer3dnVLBvkSecCKJLRMjHJHpnseTtm+Fpe4DQkDeHo5X
         FO7ctl/cV8eo6zuLvl5g6miMsFcEhLNamYo7SY42XDD/fA73pG7gaRa1v1HURA99tO4c
         rc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYZny63Olqdg6ug0jPC0IStZPSKLknIicaEuGEKKAA8=;
        b=IH1/guTD7x6H8ZUHNXYE+NHn7upJVINMKOAXuZaBnc9RmRERcGIByIh9CDOUc+QlfE
         mJWUZafDLjLYnvisW6gJ3+nf2/533RdBcoEub1iLxUFAKgQRLTqKNFqKKo1YgBUeM9Ah
         a/jMVbRfZ2L8T+se2job5pgpAwBi+9Fo5GKDjVL+ywCX9bvH5yNz8ieCsOeX2gcR3ONa
         FANw/zMgMYVQpY2GotmEh9kXBLKOs27AyiqB4ubiG3l/O4IGaq36AZo1K7kQQ2S968l8
         zA0NmeiKpQ0utWFkXFQUUrCA0nbzDyjf9SkgqsYDc9hGxydGguyswmg7hyiVH0OsGxni
         LeWw==
X-Gm-Message-State: AOAM5334sen22qJSonLWxe4bp1oGep7Z5uVqcibKi91YCGsP3ZcBxZJX
        TyoNZR7OlrPFRxytpPy8jzvQFazbQGq0ig==
X-Google-Smtp-Source: ABdhPJwGioRwBB+ZEDr03SJUKywxCI2kMXKUwm+5HMD5y9n1SXucNrhUMQ5dzztjaBew2CyWlubH0A==
X-Received: by 2002:a17:902:b941:b0:14d:af72:3f23 with SMTP id h1-20020a170902b94100b0014daf723f23mr25933783pls.6.1651003617294;
        Tue, 26 Apr 2022 13:06:57 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:9bcd:e060:b370:70d8])
        by smtp.gmail.com with ESMTPSA id o5-20020a62f905000000b0050b5b5efa47sm16203839pfh.191.2022.04.26.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:06:56 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v3 0/2]  soc: ti: wkup_m3_ipc: support i2c voltage scaling
Date:   Tue, 26 Apr 2022 13:07:40 -0700
Message-Id: <20220426200741.712842-1-dfustini@baylibre.com>
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

The 'firmware-name' property which contains the name of a binary file.
    
A prerequisite for this series is:
[PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
https://lore.kernel.org/linux-devicetree/20220414192722.2978837-1-dfustini@baylibre.com/

Changes from v2:
- correct the name of the property in the commit message of the bindings
  patch to firmware-name instead of the old ti,scale-data-fw property

Changes from v1:
- change 'ti,scale-data-fw' to 'firmware-name'
- add 'firmware-name' property to the examples

Dave Gerlach (2):
  dt-bindings: wkup-m3-ipc: Add firmware-name property
  soc: ti: wkup_m3_ipc: Add support for i2c voltage scaling

 .../bindings/soc/ti/wkup-m3-ipc.yaml          | 12 +++
 drivers/soc/ti/wkup_m3_ipc.c                  | 93 ++++++++++++++++++-
 include/linux/wkup_m3_ipc.h                   |  9 ++
 3 files changed, 113 insertions(+), 1 deletion(-)

-- 
2.32.0

