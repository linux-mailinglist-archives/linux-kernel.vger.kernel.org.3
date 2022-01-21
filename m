Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466194964BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381153AbiAUSFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243813AbiAUSFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:05:13 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E873C06173B;
        Fri, 21 Jan 2022 10:05:13 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id e81so14648126oia.6;
        Fri, 21 Jan 2022 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdV9jeW0XS2fClTtRWmHZ/pfb6gc0JxRxLCJ6LOKoaE=;
        b=AzcR6VdjuelfiahI5TmX8ThHztIrVPqXF//q8UUC6Tv7E2zGdMVfUpJ0GktO5y8BIJ
         7yG0uKbtA1KWgXGQEI7vjNU81H0usY0gIvPlSG6sDjjNDBCU45iE3Jh3rENPbKwAt3Tp
         iXlTKr5AV6GB/01/GU//VCSJ4Sa/1YjYqHEGV2e6HW8tlhAeSW2OcYp0LhfSg7OYTZ14
         lHI42wUc1YprM7Z3Bbz2a2R32X8kmU/YWhJHhmDdO/i/S7gX9Dt0hZWGb7WT1aZ+yM/6
         Zk783zHkayfMP4LApQTQ9CtuEw5hIBaVThVgu3c0VYHTodiXsCGR7DLLok+fsGD66y6R
         GFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdV9jeW0XS2fClTtRWmHZ/pfb6gc0JxRxLCJ6LOKoaE=;
        b=3BGOUVyLBwWFADImbudUz4mL73KxjdKx2fkpe1wXftAAXupPh3QFMluVOgrad8Y2E5
         kBLK+a5Zd7FmYoNeO9Mv0trjwyNCkOWE4J2gx21s755eiXQkDGn0za45GOC+Rt6FXism
         gz5nYrA7pKXXl+fe7ByIUQgnHxXqgAGHbjqRvSvv09MLa48anEdyvPsjok6bDMbCObA6
         uBG3SRXLx9sLGdoYkTI/fyORDHC3MhhhkhcLOnHMNaxOFwHJJeKBeVY+pDknkvwMYgVM
         aHTIjGQhF00T6knVj3PQgYSko8Gnb74zqNIRsTtUufHBg0q1z/u86VlWvDA0zAJg3fUm
         vAuA==
X-Gm-Message-State: AOAM532PSL+VT7VxEZXiNBQ4uBYaJVPQyfZPRiThR3D5XW5uOcjBdCa+
        gGIZOQTRT5vFAAcesum/OqLQSFdnef9WvQ==
X-Google-Smtp-Source: ABdhPJzkHQXgi/7aZ1YZqRdoznmU5C+u3toYkIIqlD+gV2rBPCTnvA000JYZYfw+t6wILooyTY+yJQ==
X-Received: by 2002:aca:545:: with SMTP id 66mr1541800oif.34.1642788312506;
        Fri, 21 Jan 2022 10:05:12 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:b8b6:7c7e:83cf:255])
        by smtp.gmail.com with ESMTPSA id k14sm1191144ood.15.2022.01.21.10.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 10:05:12 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     daniel.thompson@linaro.org
Cc:     michael.hennerich@analog.com, lee.jones@linaro.org,
        jingoohan1@gmail.com, deller@gmx.de, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: Re: [PATCH 24/31] video: backlight: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 15:06:04 -0300
Message-Id: <20220121180604.2198-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121170540.w6c4wqwrqzpde2lm@maple.lan>
References: <20220121170540.w6c4wqwrqzpde2lm@maple.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Daniel

Thanks for your reply. This is one of my first patches, so I am still
learning. This series of patches affects others subsystems too (hid,
leds, sound etc). Should I create series for each subsystem
separately, instead of creating one series for everyone?
What do you mean by "this patch might wants to land in one tree"?

Thank you for your attention!
