Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF04A468E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbhLEXby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbhLEXbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:31:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977BEC061751;
        Sun,  5 Dec 2021 15:28:25 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y196so6818943wmc.3;
        Sun, 05 Dec 2021 15:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYHt7ZQzY4yWVSIqfF5+ilzaoRCdpYyTUSLoTpW95ig=;
        b=RS7mn8P3TrwLllhL8Vg3BlzAkzTGLOs+GN/jJAgZ00EMnfLTibUCwfdMN1IVZ7Wcyp
         NV1Owj8g5jvVDwBxo/tI21NCnCnOY4bqS6kaxOtTAyVAb+JxiMxAzPMAWNOCliHtK1JU
         xF13sICtRnk6YAiUisIPudeQ5PV872swJRfo5ZAhi6OL55hM4TjYEAfrUHcERgFFl639
         EPOdVuiPaVMzcDZus/S0T6Ze5WZ5w3cuPysS3fL36zZ+YwBu2Xp5/hmCyiWk3aCN2n5L
         Xt6uvZJfOoa/lstbm1k1EY/OpmV4QvqKc+25GGOQh812+Qy0Sig0F7ZL2d4/UCe3lvya
         tlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYHt7ZQzY4yWVSIqfF5+ilzaoRCdpYyTUSLoTpW95ig=;
        b=Y0MFTsAEXidKpEw+aNkHfwjnV0Z3OLkPD0iYwn65jneUEd84x5HUg+MB/8tBJwpI5B
         1kp2sFpQCSP+fAlvUbJ7joAlqcLelBsNaX0U0iwcHQuaNT1X+GzVw/3qLlZojXAYmAuV
         5HmW+GAeEHjdxqo7dxjhi4oYqIKbUcgPqY5hYr8jw9cq9X9dxI/TGWQ9VXulUUUAxUxL
         Pde84hiAK5OXN6mFPbOkZ06lMnoA6XZIgCgnvHb+xMFoqENwVf9eI+oZyuOB4QMWX2GN
         8XAjqQGuNwI14mFOm9CMP7pZA19UK0lqWjtt6bAHAuPKpzu/0BZxBqud4KCtw814Xoov
         l9cA==
X-Gm-Message-State: AOAM530pXCupQqYhvNf8d+ZxjVlhK1/yH+LG3cPflpJQGdusMCNUUvrL
        vhvpmuo9l9d2aeVt8fACSke18x8GiL0/pA==
X-Google-Smtp-Source: ABdhPJw+Mc0XuHPaYMPfdfLL2D4qzyV574s0zmfji3g/HDr5siecHX6Q8rJIYEWdr0WZ7dUAFjtREg==
X-Received: by 2002:a1c:8002:: with SMTP id b2mr34867358wmd.2.1638746904107;
        Sun, 05 Dec 2021 15:28:24 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y15sm11600091wry.72.2021.12.05.15.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:28:23 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_pci: remove redundant assignment to tmp after the mask operation
Date:   Sun,  5 Dec 2021 23:28:22 +0000
Message-Id: <20211205232822.110099-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable tmp is being masked with a bitmask and the value is being
written to port base + 0x3c.  However, the masked value is being written
back to tmp and tmp is never used after this. The assignmentment is
redundant, replace the &= operator with just &.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 60f8fffdfd77..81aac3c25ead 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1278,7 +1278,7 @@ static int pci_quatech_init(struct pci_dev *dev)
 			outl(inl(base + 0x38) | 0x00002000, base + 0x38);
 			tmp = inl(base + 0x3c);
 			outl(tmp | 0x01000000, base + 0x3c);
-			outl(tmp &= ~0x01000000, base + 0x3c);
+			outl(tmp & ~0x01000000, base + 0x3c);
 		}
 	}
 	return 0;
-- 
2.33.1

