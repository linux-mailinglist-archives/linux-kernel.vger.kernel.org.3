Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C644947D168
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbhLVMAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:00:39 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37162
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236706AbhLVMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:00:37 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C5FC33F1B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 12:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640174436;
        bh=Uaaf91TsDCVBXCnAeyY/LIJnl+PNE0jBHfxuTjG5pvU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=snENQkB3y7IbV2gMNu7zgyuBL7z725kHqtRL1Wrmnb0S19N9c2n8Vm074PgugtgyE
         Zw0x370QkjoBTNTGixrqzZw5foXkZ1OjMC4ULflGZOpe0b63ydyBqhxJc3fOoLYvAt
         /JYTxhgturCw4GHRv9JEWsN5jZCn3o0O8+4CTZyd2zKWIOO4O8mDQh0jyoLKdXA7wQ
         mptaQ6BqBFHPUzOU9RsIZYMdlN5U/H+EsV80DT75ieOVhwk/kVt4vKqjYj8sehOE+D
         SE3eOsRUg1KneP32QctHFscnuEF3XjvcApsBdkEryOVfVes1fU++SUGZK/l4A0z0qt
         bhbWE0WsNKKlg==
Received: by mail-lf1-f70.google.com with SMTP id m1-20020ac24281000000b004162863a2fcso1123019lfh.14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 04:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uaaf91TsDCVBXCnAeyY/LIJnl+PNE0jBHfxuTjG5pvU=;
        b=78c07v62dmVWXvTI4WbWPhc9wnhf4fusoVGiGDByPXdDBiAqX2s1ggjBAjnq3xUojK
         IIEpT2yPe5ejYz5nKLRNYdWnkZVEvhwjC671uEB8xKXkVlcT/CuvaAtbLoSrc/cYjngA
         zDBUus/tAimLndTAJnM4CECU5zRPZES+ibYEMomeWDsNkUPkbuzXqhI9JXIu8rcvxdBs
         sjYNuWJkAo9L03eAN91qTVDRgDoR+G4Jp6oO3TJ5/1dFKWMgZS5RtZhDIJG8Y1evwPdS
         esoypwfue63rWDr0oW9QSIOCOOWT18KdZn2kO12BO6U5KfsegDp8dB1VLzyevatNfDY4
         z5ag==
X-Gm-Message-State: AOAM532WTkpIPQZIYQosfLW9ZDSQbQQ/aubaDYo5EPSu5ttcVMnk5ILN
        z4S/DsV+91P7HAIytw4eHsnnSZ0oYQFeJBn7IEYIAx3lZ0OzMtqSkCIIqW5FDitadIFHM4ycFq7
        RKUHO4rbdYRQKPw+3pkJfrrEo3F8TgcU0fq+06xVgLw==
X-Received: by 2002:a2e:869a:: with SMTP id l26mr1955121lji.453.1640174435702;
        Wed, 22 Dec 2021 04:00:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGmWcDfhNo6CBJNG3HFp7TTZ6jptPYv23b/abs6CwKPO0IOvuX4aBtCxXmD9g9Amy9RbNfUA==
X-Received: by 2002:a2e:869a:: with SMTP id l26mr1955105lji.453.1640174435441;
        Wed, 22 Dec 2021 04:00:35 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id c24sm194268lfh.153.2021.12.22.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 04:00:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memory: tegra30-emc: Print additional memory info
Date:   Wed, 22 Dec 2021 13:00:32 +0100
Message-Id: <164017442836.13117.15236781204925669127.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211222043215.28237-1-digetx@gmail.com>
References: <20211222043215.28237-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 07:32:14 +0300, Dmitry Osipenko wrote:
> Print out memory type and LPDDR2 configuration on Tegra30, making it
> similar to the memory info printed by the Tegra20 memory driver. This
> info is useful for debugging purposes.
> 
> 

Applied, thanks!

[1/2] memory: tegra30-emc: Print additional memory info
      commit: 23a0ea001466a9d063f65254110ac7f07f5c3937
[2/2] memory: tegra20-emc: Correct memory device mask
      commit: e2f01d07fad2c3fd3875a2d7dd62e1903fdf874c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
