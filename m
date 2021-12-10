Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD4B4705E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhLJQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbhLJQlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:41:24 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF936C061A72
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:37:48 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e128so11048267iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZafkLFobqyzA9sOfpqeC47XBKRmIc7A9zuwdN/m64k=;
        b=kdHpuSoGE3JEEOYd8y5X52w741ug9zIS4Q8E13x6iVnC4pO3bxDQt4+iKvQREYDZtQ
         Z2TFMGii0U4VwBluYX7uqKxZQ0WDDKOOcDu21tS2N9k7wtvt4ML3kKtXAboDfZJPI2QM
         YlbfEOerHDmDyFWEmmpSnnV3eRjWAy2kAqgKh1Vwv1bQA26oQnW16KFf72QlAoxsJnIe
         RijZaxugesTubvIb3woBxJDaCcGz+2+mrJPQuw3PcxiUS4GRkIFHylvJgxlFuiF4B+j0
         2lOOmCU/w6cBzhQQygrl2nIg5HW9YBk08VdqaxiTqbSq1+EhwFpLwuf/2BKm3XN3H58Q
         97Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZafkLFobqyzA9sOfpqeC47XBKRmIc7A9zuwdN/m64k=;
        b=YIxUt8nx45zprte061H8POSdRsXzo2WgpM6pcnTMY5PICOhLFYr1oFnu9x4rYEuk7P
         gNScnC8qx161V6HNrsFWuCOPVtxqobTKimlivjRtRdaoxNNW+lEF3WrHRXSp5WebMniG
         p9Oz6aoIIxeep4x10s/Cc0q8O66w9GgAd2HALpsoX32+Z94DlRrqHtMPT9YAJOti8byo
         aBWAnr73A91QP5LVxkRdIKWWkWGBSgq+P31yYYN9u8/vxL0l5BTGYAqjaKtnndgUhrZv
         1TPxDx68zL/OhTjLmH1VtIIxJUlSm199abllOXZApG9fOK0E9ppdULQD9bokfKp1ClxG
         bs4Q==
X-Gm-Message-State: AOAM530sAJ/pTj3mQc2VkpK0jodOFcQPGAI9peeFzIqb9LBqnC9XUv0f
        NryDdbl68DnMJ6RKAHQb8eRQnsghsoRCgzqx
X-Google-Smtp-Source: ABdhPJzLjFO5PARwdp0VG5LdSkQYf/VHAlnP6KU1SwrtAMWoMzSTE97xRzFroMuKEbtGhtub6VQ4yQ==
X-Received: by 2002:a05:6638:2727:: with SMTP id m39mr18276999jav.75.1639154268320;
        Fri, 10 Dec 2021 08:37:48 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id p14sm2232642iod.38.2021.12.10.08.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:37:47 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     david@ixit.cz, manivannan.sadhasivam@linaro.org,
        jponduru@codeaurora.org, avuyyuru@codeaurora.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, evgreen@chromium.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ipa: fix SDX55 interconnects
Date:   Fri, 10 Dec 2021 10:37:43 -0600
Message-Id: <20211210163745.34748-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDX55 SoC has IPA v4.5.  It currently represents the path
between IPA and main memory using two consecutive interconnects.
This was an optimization--not required for correct operation--and
complicates things unnecessarily.  It also does not conform to the
IPA binding (as pointed out by David Heidelberg).

This series fixes this by combining the two interconnects into one.

					-Alex

Alex Elder (2):
  ARM: dts: qcom: sdx55: fix IPA interconnect definitions
  net: ipa: fix IPA v4.5 interconnect data

 arch/arm/boot/dts/qcom-sdx55.dtsi | 6 ++----
 drivers/net/ipa/ipa_data-v4.5.c   | 7 +------
 2 files changed, 3 insertions(+), 10 deletions(-)

-- 
2.32.0

