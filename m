Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218AD48C017
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351695AbiALIjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351692AbiALIjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:39:40 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA460C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:39:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso1062401wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWG9vBcQpdezGVNfoLqs5/hoQhuBz1pfm9w1OuCGqus=;
        b=WH/s9OYrYJ4YRPiYQv8neNcmG2o+THiFmc/yCz+U8e4uX92XDg7GP7x2jPBvcKgmH/
         8tU5RvwdiTLhpWVydkOxRlN7nU6KwRZ37Fi+JHyUPkxG/8BEF7sGRazLni73pgk7tgZ/
         leA3eHnaNowIUfmKMlKJHKpXYBMXxDVyusrA0Pijxq/qGInz4JkCZZLvQD4oAgBJKMqI
         B8hNRE9O/Nd1S5tEQ2vfV+tG2TS57BB/mR0pmYtl6P/sMVllBRsXr53U4sajK/Ed3GtI
         YlAQjHk+FAQcqAuxuiiIlc+pakhzAvLnARovUVZe6GvKoc4SLtihfliZ5Rc6M6QBHbfW
         yRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWG9vBcQpdezGVNfoLqs5/hoQhuBz1pfm9w1OuCGqus=;
        b=hYTMSYLnubJy0aVO/aGpdiPU9t3jCkm0bbBkQCLoPnpOCJDVdXHeLjRY4iTldyMMTO
         IKVvlVdB1mrPd+uw51waqvV/aNck7ZwKPiwc0G5BHNN97n13Jg8njvVZNMDUZ74lJB4L
         Sg7Dc/x7RHFDIRbz02+PGDsFXAKQk+L3aBCtTiT/ankbvQw58hS6FOYwa7jrZhdNntKz
         ZkkoGXTlFR/OqzNyILqJT7Bf1eh7VjJVbEeIe57yNfZVbWXOkclOv8tcH0pWcgIc+hxm
         LZ8wurssqqdmdq/0WsOtuKP8zU0qnRP+RhvyPqEa45/JjnA+Bv50v/yfRhb1caWVw9he
         nBtA==
X-Gm-Message-State: AOAM532B3T9fTQ7CnClBhbXD4rQMcedr218OWMhqQf06s7MRwvmMQ+j0
        ULCRKBlvxmyddQts4rXc1DjVWA==
X-Google-Smtp-Source: ABdhPJwl+znlZE+kOyE1H6sd8NVFx9t7L4Bia2avp1k23EUyp06dOzppYbH3jF7zxdCzUDL3750V8g==
X-Received: by 2002:a7b:c931:: with SMTP id h17mr5829621wml.49.1641976778273;
        Wed, 12 Jan 2022 00:39:38 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:381b:6e50:a892:5269])
        by smtp.gmail.com with ESMTPSA id m7sm3653368wmi.13.2022.01.12.00.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:39:37 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH V4] arm64: dts: add support for S4 based Amlogic AQ222
Date:   Wed, 12 Jan 2022 09:39:35 +0100
Message-Id: <164197677138.826461.16430612345551126459.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106112214.6987-1-xianwei.zhao@amlogic.com>
References: <20220106112214.6987-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Jan 2022 19:22:14 +0800, Xianwei Zhao wrote:
> Add basic support for the Amlogic S4 based Amlogic AQ222 board:
> which describe components as follows: CPU, GIC, IRQ, Timer, UART.
> It's capable of booting up into the serial console.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.18/dt64)

[1/1] arm64: dts: add support for S4 based Amlogic AQ222
      https://git.kernel.org/amlogic/c/1c1475389af077a9636c22dcb8c9ef498b48fcfc

-- 
Neil
