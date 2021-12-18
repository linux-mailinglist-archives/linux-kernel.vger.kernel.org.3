Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF96479B97
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhLRP1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 10:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233481AbhLRP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 10:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639841238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=86SiuzQkzNAn+schu4EkUzziC+m9VbK+PfQYtTZrNxs=;
        b=ZrVUHF6HLgZ7wh7/OiE+1vo0xPtBD+rUQ/6kkd5ZX6wnTzyAbohjAVnkDFMBWAuLFYHN8S
        iCSc5En6mKkzVMhqO9E3zD88rNvmp+kYVW+YbGM/l9wuzuRhiUK7w8NWJiKe5vEWXvfunM
        DQsdmmHKYK26gDIiWTBU/xYBgDJBhww=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-u_e7fBjpPACsir16y2n7HA-1; Sat, 18 Dec 2021 10:27:17 -0500
X-MC-Unique: u_e7fBjpPACsir16y2n7HA-1
Received: by mail-oo1-f69.google.com with SMTP id t199-20020a4a3ed0000000b002c296d691c4so3452335oot.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 07:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86SiuzQkzNAn+schu4EkUzziC+m9VbK+PfQYtTZrNxs=;
        b=U/YFn5rS+shqfp6YrbMh/g+M4xoyt4pWzOHvhsTby/f2lHiIhSW/GhAg9mXy7HNy3Y
         0EES7NQ6KkqPyILX+gJgg9tR+zsIjWEREXJl4ZiMiJiRZZm0cvDDXYGOgKi0LTaHoRcZ
         /wKEOvzmIUIk3z1Jq1wTXmsIgpokBm2XDyIKqUJ6/t2ALe4Ul0TcD7drJGLSUcS/v/yH
         SX6e23Khwry3AefAA5Z9x/uLS+tc/vloXt4mXWRr+oDwdpWnU42dBDDW+YZwXq/jEFJq
         BcuUaXkDU62cYOgg9aIdJv4ynJm9lKdz+SAc8tadSswpTDoXUGKrKXOXV9A1cvE5bIxJ
         CwJg==
X-Gm-Message-State: AOAM531S6HTZt9hvOEELzTSDu/q9O4Inxo7g7/e9Tn6RX0mnoh1qJlVI
        GVc4xCj9xIOMG5K3bs+pzptPUfVRF+heRWCI+kUOQ+4sCdAONr+PBulGz4M+y/fCEoxMvAE0gWB
        mRA19+obn3N+GGfDjTOHM1q8F
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr5798782otp.226.1639841236961;
        Sat, 18 Dec 2021 07:27:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQXs8/YlLAB/Dah8N/DouTHOvgWlTfYorr/QdF2xSDDW13RsfjVj/NVWwFUZ/bdOydpAXgVQ==
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr5798767otp.226.1639841236770;
        Sat, 18 Dec 2021 07:27:16 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z12sm2161206oor.45.2021.12.18.07.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 07:27:16 -0800 (PST)
From:   trix@redhat.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] gpio: sim: fix uninitialized ret variable
Date:   Sat, 18 Dec 2021 07:27:12 -0800
Message-Id: <20211218152712.2832502-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Building with clang returns this error:

gpio-sim.c:889:7: error: variable 'ret' is uninitialized
  when used here

ret should be the status of the call to
gpio_sim_make_bank_swnode stored in bank->swnode.

Fixes: 83960fcf4818 ("gpio: sim: new testing module")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpio/gpio-sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index ef6145f51c8ae..bef00dcc4dc8f 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -886,7 +886,8 @@ static int gpio_sim_device_activate_unlocked(struct gpio_sim_device *dev)
 
 	list_for_each_entry(bank, &dev->bank_list, siblings) {
 		bank->swnode = gpio_sim_make_bank_swnode(bank, swnode);
-		if (ret) {
+		if (IS_ERR(bank->swnode)) {
+			ret = PTR_ERR(bank->swnode);
 			gpio_sim_remove_swnode_recursive(swnode);
 			return ret;
 		}
-- 
2.26.3

