Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6558248687F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbiAFRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbiAFRbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:31:40 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907C1C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:31:40 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v4so3040894qtk.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSBn+Ips2mtFKmkest40VuG2t1Y4Y842E21N7HcVLJw=;
        b=KRlCFD5KV+WoJ+jF34AGPj77mfOTitmcVtdNTWCJ0WyhMf7uB/TfCP6b+01TV1eF7G
         Z9Rz1Tk2QJEAU4OGX7qnERqkDPihLIskT9gJrWpCajmgLeGm3ovHofUdfGGD/U57Bald
         E8AqlWMbVzVYjsBqw8yR35fEk1hzUW+ZZ6JAKq6nE+FSVpMia+YMmp1yU2lWnbN6134g
         N+dlVB0pOl81XfwbhH61YgaCuJRyYJvbhku03FdwbytcfF90/Mo96jIzw/3bFkbB3Krz
         ucy1cOlyrZhSd/pJeDZUkEbOFqkkiFxSJHZpDOBU3ULTe6lXvRzh8QoMPWGVNPPL7hOI
         CqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSBn+Ips2mtFKmkest40VuG2t1Y4Y842E21N7HcVLJw=;
        b=MBQGytFJXObqgMD5SqxViqMr8uk/3QrmGc1SeLKJfiq8SGJ1xihTDmqFZ3sUBowUj+
         UwNaoweTk0U0pNNcYxuCg4ZtW24lmPyNXERNZ8UaiMiIOH50iYX6JOfYWpbKUnCntMZY
         NbL56f8lc4SwivW0cbZpoTHajmUSAGUe123kz1QCgOw4oRyB/W166Y4MIxEOstLWmxf7
         0qxwBt4etXz+tlJJJqCWSDYIiRts/axzU9fmlO1wyXisAymWc8n6FTZlUFtY1mIi6N0Z
         Tc+CKhRR5ozOSzeO71xvSSLl/XMu1GqaZrOc21kmca6ayIHKBfi5nDoQrYm4Wy+1Ky/N
         2BzQ==
X-Gm-Message-State: AOAM533ebROMzod1aoPEs9zdwzGDKUJZTsU0nTrYJsbwqNGCh/s6LOv3
        6u9OzbEQRi2xheVJ7CSQPdRijSzReJMGJA==
X-Google-Smtp-Source: ABdhPJxE5KkAAzma7mqLIUe2FZ4XWQGFK4NRb0bHNrVt5TNjZCSoBUnAU8GezkGBh69GcrQDQoAVgw==
X-Received: by 2002:ac8:7d47:: with SMTP id h7mr53966124qtb.486.1641490299706;
        Thu, 06 Jan 2022 09:31:39 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id i21sm2126536qti.31.2022.01.06.09.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:31:39 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v3 0/3] Extend LMh driver to suppot Qualcomm sm8150 SoC.
Date:   Thu,  6 Jan 2022 12:31:35 -0500
Message-Id: <20220106173138.411097-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for sm8150 in the Qualcomm Limits Management Hardware(LMh)
driver. Also add required device tree entries and dt-binding.

Thara Gopinath (3):
  thermal: qcom: lmh: Add support for sm8150
  arm64: dts: qcom: sm8150: Add support for LMh node
  dt-bindings: thermal: Add sm8150 compatible string for LMh

 .../devicetree/bindings/thermal/qcom-lmh.yaml |  1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 24 +++++++
 drivers/thermal/qcom/lmh.c                    | 62 +++++++++++--------
 3 files changed, 60 insertions(+), 27 deletions(-)

-- 
2.25.1

