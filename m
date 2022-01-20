Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC0494DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiATMOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiATMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:14:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783B5C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 04:14:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so13181515wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 04:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpM/rGmBFzv7cwTGJJLNgA1OU0/AoeYggu1XWiqY0Xk=;
        b=J6wSwcUYCIUKMjJC9dceWaT0FrzS3MYCWGO6u5QaaZ5OpSjB4Mj33mdFevF8YX4/fO
         eOr6IEaO/NtMSHWMpaExKmutuRmcSSPsiqE03W+oDze9G5JxBxiZczF6CF8tcoPW2BQ4
         +ojTS/azripxXXAAqq2KZnDEkbByTPlGiflLm7PDYCJuR49RRWx5Zhip3vD+pA8Gd28j
         H/qiikB38Cveu3J5TvYX1e0jvWyGjuBRj7Im/2m+BI7ALjAocpQlBF1SZ7mDWBFV2HXG
         oo6ChMBO6u2srGl59/w1de2TSxUCvHYTOCfqsnwas/HQivNhduw2JI3IhxC9+iI/2l+d
         0lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpM/rGmBFzv7cwTGJJLNgA1OU0/AoeYggu1XWiqY0Xk=;
        b=6S9w3CxQjxbR5nVAH+tnrVF1mX1oNp4kUtAG+n1lExypfiuiPPUx79D+2HlhmyZuIq
         oFd3tKoSCgo/yogO/1wdQ9uKv9DLZskW4BYgruZzEdi0iE8Y+HT17c973gNtvoYQGB9B
         96+eYjOk+eOUIMU5AXYI1vnk6iNKTtzVYzn98Qc0Hmzcl2LU0Ni1NQHJsYhUv8Ljsccy
         810YXiRCM3+iismJrXPrvftKU//6rFtwAEKR3JLLTQcJMWigmLbMAVzoX//Xez4qyCpI
         4kEGuwXGTaq2yFVKF9HhbkWGoD3V0ghOljZSFXwaV0SV/+nGqU1hR9aHQJdSuDX0eKI5
         VBZg==
X-Gm-Message-State: AOAM533Q2HbPk9Mkc/4KpLUpVivI31VUK3jBf2OlvnFXPeGfSEdC7N3E
        rLoVLBDQaHKGQABk15k5X590rQ==
X-Google-Smtp-Source: ABdhPJzoOXVTD93A3oHdCn7GNYdZ/w/iULAXwJNFyE/+MrVoE2APhlsp2kN8aP/zRyzW+K66ZtMFgw==
X-Received: by 2002:a5d:584e:: with SMTP id i14mr19318297wrf.690.1642680849034;
        Thu, 20 Jan 2022 04:14:09 -0800 (PST)
Received: from fedora.sec.9e.network (ip-088-153-139-166.um27.pools.vodafone-ip.de. [88.153.139.166])
        by smtp.gmail.com with ESMTPSA id x4sm2853863wrp.13.2022.01.20.04.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:14:08 -0800 (PST)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org
Subject: [v3 0/3] Add support for Maxim MAX735x/MAX736x variants
Date:   Thu, 20 Jan 2022 13:13:10 +0100
Message-Id: <20220120121314.463944-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- Merge dt-bindings into i2c-mux-pca954x.yaml

v2:
- Move dt-bindings to separate file
- Added support for MAX736x as they are very similar
- Fixed an issue found by kernel test robot
- Dropped max735x property and custom IRQ check
- Added MAX7357 config register defines instead of magic values
- Renamed vcc-supply to vdd-supply

Patrick Rudolph (3):
  dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
  i2c: muxes: pca954x: Add MAX735x/MAX736x support
  i2c: muxes: pca954x: Add regulator support

 .../bindings/i2c/i2c-mux-pca954x.yaml         |  43 ++++--
 drivers/i2c/muxes/Kconfig                     |   4 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c           | 124 ++++++++++++++++--
 3 files changed, 150 insertions(+), 21 deletions(-)

-- 
2.34.1

