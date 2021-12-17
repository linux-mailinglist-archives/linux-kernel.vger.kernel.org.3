Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D21478E10
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbhLQOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbhLQOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:41:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473DDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 06:41:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z7so8557855edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 06:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uTnI2mJGzMXkNd6zD8dQtSYENNAOb/CaCe05utt5/js=;
        b=PukQFC8eup6D+l6pr0MjTOfXAx16xG33X2KSSCGy0M7Tq5ZMk9GinknpZA0yEJ5qKW
         tNuJrWNdhrtuCWbdRaBmGv5SlIwmqngx+ij1oUajyt5bWMZEMIXP2XaEr3y4021IaJ9X
         f366koKI3RsE+0mP2votUFQw1JHe66y7gF7Q7dkL3Yue+BpEGLnrHBEIFadgByPcL7sb
         jmsAMHzwcJRfBMXpdAKJiyJZQW1e5Y0GqTvI9aX/eVMeFzK2Duqk8zjBi1weVvkDPX/O
         dKNIdsY8E/y1/AzW6GgIq0W3Hby6QkLKpDnaHXUe8CNvrqCWbc/ePGLDwYA2NcjqEmoe
         7QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTnI2mJGzMXkNd6zD8dQtSYENNAOb/CaCe05utt5/js=;
        b=J366NS21nUnHgBYOqF+7KrrEvgSrKHnylB+ViZgBBlT4RasW22do01a1nVFF9oKwLM
         Kp580Lt0sR9fHrqg5GKQ3XQeYXWMun8SGfk3g/FWGXt+MsnWjrvZdQOo7SKUtKdPgoF1
         eYYVlD+PLckAcY66rIGS05Id3w3d/N8EboGvhMiOuObj/qxFt9Iy8lfaLxkexRRaIYY5
         9v6T4Ip5PLxNkhZaP/hRoToucSTgpVZxrXhU+aFJpef4gLReBI5IE0k6wXw3BEqW1gv9
         xP3/dxvs5DdTwd4DEOdWLczMeh79hnx/3V/1t8qt+BcpsRMA4Aw7pCw2sNuioD8XX130
         wT2g==
X-Gm-Message-State: AOAM532Vxd9EsXvLFk8gGOzKW3oKHiIk/2RZNh5E/005O5HbsAB8DBm/
        piek1LVj8X+8PVmdaj4oC9eXlQ==
X-Google-Smtp-Source: ABdhPJx5jidnmBk6Da67uNi/t5UdWsKGq7GOi1jst8jw+BtnuUuf9LmcEVZRHc8Jxr7q1+aWh1boHQ==
X-Received: by 2002:a05:6402:14f:: with SMTP id s15mr3145035edu.118.1639752089832;
        Fri, 17 Dec 2021 06:41:29 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id o1sm2992009ejy.150.2021.12.17.06.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 06:41:29 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, woojung.huh@microchip.com,
        UNGLinuxDriver@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        clang-built-linux@googlegroups.com, ulli.kroll@googlemail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        amitkarwar@gmail.com, nishants@marvell.com, gbhat@marvell.com,
        huxinming820@gmail.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, dmitry.torokhov@gmail.com,
        ndesaulniers@google.com, nathan@kernel.org,
        linux-input@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 4.19 1/6] net: lan78xx: Avoid unnecessary self assignment
Date:   Fri, 17 Dec 2021 15:41:14 +0100
Message-Id: <20211217144119.2538175-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217144119.2538175-1-anders.roxell@linaro.org>
References: <20211217144119.2538175-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 94e7c844990f0db92418586b107be135b4963b66 upstream.

Clang warns when a variable is assigned to itself.

drivers/net/usb/lan78xx.c:940:11: warning: explicitly assigning value of
variable of type 'u32' (aka 'unsigned int') to itself [-Wself-assign]
                        offset = offset;
                        ~~~~~~ ^ ~~~~~~
1 warning generated.

Reorder the if statement to acheive the same result and avoid a self
assignment warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/129
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/net/usb/lan78xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index b328207c0455..f438be83d259 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -945,11 +945,9 @@ static int lan78xx_read_otp(struct lan78xx_net *dev, u32 offset,
 	ret = lan78xx_read_raw_otp(dev, 0, 1, &sig);
 
 	if (ret == 0) {
-		if (sig == OTP_INDICATOR_1)
-			offset = offset;
-		else if (sig == OTP_INDICATOR_2)
+		if (sig == OTP_INDICATOR_2)
 			offset += 0x100;
-		else
+		else if (sig != OTP_INDICATOR_1)
 			ret = -EINVAL;
 		if (!ret)
 			ret = lan78xx_read_raw_otp(dev, offset, length, data);
-- 
2.34.1

