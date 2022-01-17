Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4FE4901D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiAQGIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiAQGID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:08:03 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8387C061574;
        Sun, 16 Jan 2022 22:08:02 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id h11so28546557uar.5;
        Sun, 16 Jan 2022 22:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jfic68I58oAdYQE6st8yUtkeQd/b8yHt8As/UNfzHgY=;
        b=pMndv7IEtBwVrVbJUtdwOetT8PRD/GIH1C326Awqgj6aRcjOGqOetv7M9EhmxjQk0J
         SljI+44KPBbFCxr2Ps76s/iboYZX6MFnLJ12JJtesJxNDTSFXDWcjvnetH2tMaPBMnOz
         TSn2GOPdgIRiLTKFB7d9QWroafYuRfn3EnbyAbyWYLec4aRINyf2SjI+mHf6mhgWtJ/A
         kMty4u8eDQR5DkmPSwdf3xQv3OETZPpzWnOe3zPpnXCYFu0R+7r8bEaV4AgZL2gE4ako
         N1RuvECZA5Q7CrlJydTgzmqBO61vzhtILTiH3irdsYnWwchCi+tCj0DvXXniWaSKqLkA
         nAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Jfic68I58oAdYQE6st8yUtkeQd/b8yHt8As/UNfzHgY=;
        b=tk8KccTmEGlPeozfSlurLM8ZuFxHyY2nziB7ZgU4kf7vtyS/U/vJ4ThVT+YoCu8pRW
         FoAJvSFnVvZwsebE9VvsaeL1Lj/0wulOpFbXgIkLOYxPh/QKKrZMfutcHY9ckVryQdDY
         durua2uPg3AX3kIJwekjY0tV5kz/aBnvqFKpk8Qlf2pnlCfti7JkZj1v3m139Sz6CKmk
         mmCoy5Cop12rh3/Z51IJOVk8LKG3B3HRJtRvKkoXdXVDkyt/Q8XX6YqaPl+dcJiO3H4j
         oOytCiw2q/X2q5BB5OIPLpy9g1dy1zAa0lpks2jHkn+ABn2rvGXsY7wTMLAu3OsGk/Bk
         Lwuw==
X-Gm-Message-State: AOAM533ONT0yEvCIOiLZd38mC91BlzUK9ORkw72049AJPc9WBubV7F8p
        lbLGc/dGCz5hspSffJPbTUawQEV0RajWS44X
X-Google-Smtp-Source: ABdhPJyFqYcL0o7EL0cDhQby3v34SWlMvpheXtNw66AbZrKOusGcZdge89z7dmgrnOPAUUAozdoz7w==
X-Received: by 2002:a67:e057:: with SMTP id n23mr5015149vsl.6.1642399681736;
        Sun, 16 Jan 2022 22:08:01 -0800 (PST)
Received: from kubuntu-desktop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id s32sm3430087uas.3.2022.01.16.22.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 22:08:01 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     dmitry.torokhov@gmail.com, johannes.berg@intel.com, richard@nod.at,
        oleg@kaa.org.ua, cand@gmx.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] input: fix Kconfig dependency on IIO_BUFFER
Date:   Mon, 17 Jan 2022 01:07:59 -0500
Message-Id: <20220117060759.84924-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When JOYSTICK_ADC is enabled, and IIO_BUFFER is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for IIO_BUFFER_CB
  Depends on [n]: IIO [=y] && IIO_BUFFER [=n]
  Selected by [y]:
  - JOYSTICK_ADC [=y] && !UML && INPUT [=y] && INPUT_JOYSTICK [=y] && IIO [=y]

This is because JOYSTICK_ADC selects IIO_BUFFER_CB
without selecting or depending on IIO_BUFFER,
despite IIO_BUFFER_CB depending on IIO_BUFFER.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/input/joystick/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 3b23078bc7b5..db4135bbd279 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -46,6 +46,7 @@ config JOYSTICK_A3D
 config JOYSTICK_ADC
 	tristate "Simple joystick connected over ADC"
 	depends on IIO
+	select IIO_BUFFER
 	select IIO_BUFFER_CB
 	help
 	  Say Y here if you have a simple joystick connected over ADC.
-- 
2.32.0

