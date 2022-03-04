Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB034CCF8A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiCDIFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiCDIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:04:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DBBC4285
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:04:04 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 300603F621
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646381043;
        bh=0kJxljmXqNGTN5eMb3x4xxptqrabkXZDbHX7wYX3Zgs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cFdcUYxtPoagD1biMVr8ktNpVhWvJ76/Rk71XC8qmFPiwtiHoSqySVbWyDAAS7E5H
         VFtSgMzEKDJw/AagkV8tsYhjP1+xFaNaIo5953N7HelWmSoL5lX2uVUp1+7SJ16ANQ
         agtswAjZGNNaV48KF8xZnVFvd+oVTIKLbPzKkZ458eIub4s6gXqvx/AqAkPLMD/0a3
         bY+yyZAEP2Yo7aPFsOTKlrx3q0qlI5cwa+zfIKzutmNeX3CWZubxAuMFTcFBzU8vdr
         UzD+OVT+wOZcnqAFD9n64+3eytgm+T+ZylgW8Nh15xx46eC4D0C7AK57L/wmJDE28u
         zvymKI7ygfBNA==
Received: by mail-ed1-f72.google.com with SMTP id b13-20020a056402278d00b0041311e02a9bso4161452ede.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kJxljmXqNGTN5eMb3x4xxptqrabkXZDbHX7wYX3Zgs=;
        b=Lyd4AukWquKlcAXYjZeeo5+/EhO5Vnfnqe0zyrd4DY7he1tDkKpqGrLuu5lOSl4Va9
         3WnsYg1sv6y0eSoC0YeoR4gL+FeFMExpqA17AzQybHyO+nPf4S0bElaywe7+l/jCD4eW
         Oz4Q0ffntbU7E4Gab5eHSmM4Y/93bdlZvoqAqXeCv/EG9XqckBCvME2tq0obVbCBOVxn
         TD8jSfBCQMvx4QddwL2bW6xA1yoaQgkK8aJFZFTswad/yGPUloFKyImx0bNd/dAciJte
         /tQJQJzt6d/XdZAGkvGlcwB9rp0yK122HYkE98P1stAoejFcM5NaOYKVwIZZlC/aVP/+
         +GVg==
X-Gm-Message-State: AOAM532aahuLQjVKoBuV2nyN4HZoauxZUINlT+3xFRw7mXre24PatX+J
        Ng9YziG1XpRXiM23qOUdOzodC6SZ8RmvZ6lbwZm3e2MwQ9xWj7UIjHGQac1YAWaNs2+Ct3wdTh5
        l1jB6hluLXiVZTBSNr8cjIosBtE++g2pOMF83XlYBhw==
X-Received: by 2002:a05:6402:3486:b0:409:8ed0:9340 with SMTP id v6-20020a056402348600b004098ed09340mr38136588edc.255.1646381042930;
        Fri, 04 Mar 2022 00:04:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+80NQg1qjGxzXwSnkNAPo7pilmgr6uO9HNvq8gSWafsXxSwmS24hqLp+IqtbfmR78BXE2qw==
X-Received: by 2002:a05:6402:3486:b0:409:8ed0:9340 with SMTP id v6-20020a056402348600b004098ed09340mr38136568edc.255.1646381042702;
        Fri, 04 Mar 2022 00:04:02 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm1481465ejb.82.2022.03.04.00.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:04:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] tty: serial: samsung: constify UART name
Date:   Fri,  4 Mar 2022 09:03:45 +0100
Message-Id: <20220304080348.218581-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UART name from driver data holds only string literals.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 0b4f40044e87..279c413f2300 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -63,7 +63,7 @@ enum s3c24xx_port_type {
 };
 
 struct s3c24xx_uart_info {
-	char			*name;
+	const char		*name;
 	enum s3c24xx_port_type	type;
 	unsigned int		port_type;
 	unsigned int		fifosize;
-- 
2.32.0

