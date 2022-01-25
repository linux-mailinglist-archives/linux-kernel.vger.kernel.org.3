Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B2149A891
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319487AbiAYDI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2372861AbiAYCeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:34:46 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B40C04966F;
        Mon, 24 Jan 2022 18:09:58 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h16so23320876qvk.10;
        Mon, 24 Jan 2022 18:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iTzkTuWEmHmGPDRas9+M9Ndg+E5GCPS0cGBZk3zyHzM=;
        b=MIkGN5P1HpshH3EHw2rOxYu1PsKdP/ZF7tMRkn1zxDQh2/PYgYuU8nX+0dq805ryMv
         sU82DfhERYJpZrdwMxrqlpaIfrAKZ8fN85NtWHulamIW/pbSSReJBABcN4coW9INlNx2
         pXiK9NZu/YFd/c8+Jcu37AYHE09FxLF19FiuH5jUSoHzxSJceIqQPZTsN0Sb4mjlYDPW
         47JpLAzFnoM9dLxQxXoGUD12HKPvdt5AUwUKKOHCT01QekAa663/kmsFaPdOCuIOq9uN
         JzHN2KQaNtcUriBJV5aWumeE6OFbVKzxZFqlrv/hTdgoXxPUsGMoE+b+yXXIC8vV3wNM
         +SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iTzkTuWEmHmGPDRas9+M9Ndg+E5GCPS0cGBZk3zyHzM=;
        b=iOWubIZqCCn1LVBe5KfIes9BJPjGmZUelCYnkAtpj8U72C+TstaksHemol9maa8hfk
         0P7hq9Kj2vg6DeO92JvTSBbOGFMJJKDHNoSDKrnn0Yf/qnYLjkASo4V2QQb3lagz6fjx
         pi6dnglRl7Ol3bH1WDT38S95/H4fIVd+juReftKLVv76vEvd0ixvd6NW5/2aamxVG8Sn
         zJbjPvMRhT19jnLi9cXtWJzNskbjzxwUkfpkyiRq+x+Kq9uDN9wCPZ926GylgYHX1qJ4
         DfNX5IetQSKlFJVY7tVCK2Znv/gcqbO1VmWO0G8Wevll36p2D4ZV8yYAKHRxoIWh0VVd
         +I0Q==
X-Gm-Message-State: AOAM531UbGi4Fu1/ShE87YQ+vQGDATVpCHMvVYE7pfKRfz4AzVrnhioU
        ZpC5nUqi5WcbMjL+LLwVp0k=
X-Google-Smtp-Source: ABdhPJxHqcQbH1+pQp5eK8/FR7Mg7wYzrRVK6Xy9DdVaS8pqKUNOGuUGMbmz/qqqJxhfrfnZMB2oJA==
X-Received: by 2002:a05:6214:21c8:: with SMTP id d8mr11621660qvh.65.1643076597298;
        Mon, 24 Jan 2022 18:09:57 -0800 (PST)
Received: from Dell-Inspiron-15.dartmouth.edu ([129.170.195.217])
        by smtp.gmail.com with ESMTPSA id m190sm8024845qkf.58.2022.01.24.18.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 18:09:56 -0800 (PST)
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
Cc:     Ben Wolsieffer <benwolsieffer@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] Add support for the HP TouchPad
Date:   Mon, 24 Jan 2022 21:07:02 -0500
Message-Id: <cover.1643075547.git.benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds basic support for the HP TouchPad (codename
"tenderloin") tablet. I started with a copy of the AQP8060 Dragonboard
device tree and made the necessary changes as a separate patch.

Ben Wolsieffer (3):
  ARM: dts: qcom: add HP TouchPad (tenderloin)
  dt-bindings: arm: qcom: document HP TouchPad
  ARM: dts: qcom: basic HP TouchPad support

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/qcom-apq8060-tenderloin.dts | 478 ++++++++++++++++++
 3 files changed, 480 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8060-tenderloin.dts

-- 
2.34.1

