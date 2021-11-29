Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD734610E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbhK2JRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:17:43 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59946
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241884AbhK2JPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:15:43 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CF4AB3F1B7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638177144;
        bh=xL3cwvRjtg5iZMory+31gLHybfwEMgxutZRdlC/JHuI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=PPsbxPxDFcQxX11bFEPC05jHaFtLJGT2y4J1Td6CYZcyo7fqsAHtnKp7AXogwO4Lb
         h4tz8CmfqWoo2Lr5ua3W3Gy8cx4DBa3maXCQcta7GDGygSyT9O3jZVWTTruCvBuk8P
         JtAMCtBzk98Bk6ynaszoIs+Q+XT9cUBPgGwivQGIjUZWR+InabWHpM8VMR+Hg7RkUE
         mAgXokknpsUg3hrhvnr+xPdPO50iD9L0+ZnAZRB4+F2tqGnBnpuIcBOzqTjVX8K8uM
         LwbdRHFrXv4121JyA6mp/JgHqHbCpcPc/33/ickzM8gj5PJEAxYxmUSeSbe2P0+Jf9
         4cBsskOyoU0CA==
Received: by mail-lf1-f72.google.com with SMTP id q26-20020ac2515a000000b0040adfeb8132so5540204lfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xL3cwvRjtg5iZMory+31gLHybfwEMgxutZRdlC/JHuI=;
        b=0z5stIZqEaRmy+Tk9YUFHBFztyeOpICtTtA3ZGbBacZKTNWGmgUIE652J1GzmT6Mm+
         7T1o/Bsrg9JQfxEm+8gBi7VDJFkaaIqu18erbLP+Hrf1H2hrDRpce3C1zNW2Uk9HDFj8
         G5mNx7KP/DPfd8je9g+9s3SMqnWw0/h3wPiYwnu1/sxS9CscDdCGBhJs79fHEJWlMMP5
         FwJLdCW9UW65j37cxEcSIgc0r1fq6ZrzH6OZWsdptiy03OmAgRr4dEvHvG1SIPfTdwx6
         dcxwfF/QWgcD8a2Icc9idLyRB0OzGrHQci7xFNil6E7csSPMYQlOoatSpkOQyEVmss6P
         Qeag==
X-Gm-Message-State: AOAM530hRRb/sDaG+cB2OIJ1xJFIyoGfRrPxroXd9jSyW16YOcfnCLdz
        AUm+/xoDZUmKSCUHRxzip6vKAdLoUX9g1c/G7aHDQOwzEC96IrA7kRhAO9h3X3neRoF0QyGqjQj
        W5I9axqnl2sA/2d5ve/2185x7OBZUWEfRR3O2tgw4Jg==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr44689114lfg.63.1638177143499;
        Mon, 29 Nov 2021 01:12:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7gbNto9BPWB6Xc1Rpw7eBAG+LURrXG89GxHn4ELAZQbZdwtQ+0AvRPZElUJ+4liEROyhslw==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr44689086lfg.63.1638177143193;
        Mon, 29 Nov 2021 01:12:23 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p3sm1273815lfo.162.2021.11.29.01.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 01:12:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Kai Song <songkai01@inspur.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] memory: tegra: Constify struct thermal_cooling_device_ops
Date:   Mon, 29 Nov 2021 10:11:46 +0100
Message-Id: <163817710354.21425.9622697114945269603.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128204158.19544-1-rikard.falkeborn@gmail.com>
References: <20211128204158.19544-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Nov 2021 21:41:58 +0100, Rikard Falkeborn wrote:
> The only usage of tegra210_emc_cd_ops is to pass its address to
> devm_thermal_of_cooling_device_register() which is a pointer to const
> struct thermal_cooling_device_ops. Make it const to allow the compiler
> to put it in read-only memory.
> 
> 

Applied, thanks!

[1/1] memory: tegra: Constify struct thermal_cooling_device_ops
      commit: 56985dc4f437d7a77d4abede73191da20cf11429

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
