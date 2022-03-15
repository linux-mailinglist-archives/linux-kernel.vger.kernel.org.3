Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D804DA368
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351439AbiCOTkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351414AbiCOTkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:40:21 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07516289BC;
        Tue, 15 Mar 2022 12:39:09 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 13so299490qvq.8;
        Tue, 15 Mar 2022 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2R5wH7aZWLbq7NU5C7S2zfPJjL0MgrTHEo9aJHUkpcs=;
        b=YP7xzPGpoR3yYsKXNbyMstcMwSpyG4B7mE6pdO47Xfl8t7snvSVN9KfHhMAAWnXocB
         cFZbRaH4YDmVRBHMtsDoG75yQfun3oFcj8CeMqJ8weq1v2IzuyDt4/iV/ygtUhoJ/ZYL
         Uw84z/r8xgLOA4XIIq3M0K84C86uLEYcQvBc6POH9LsqHfq5p4fxxwoG2PpwrrwT6mcj
         zEJ5Ibt12Cxc0KccNsyGxRDIkmb8cyY06jYGL0XhBxDSPylPNKGadh/q5wOSOYQ2fkdC
         HpR4ECQi5Yyt2EaetRbhvWL+1wizjiBs9eQWuK1xEtgNNaW3BDHSo1jdHsvMBEa2ioEE
         BrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2R5wH7aZWLbq7NU5C7S2zfPJjL0MgrTHEo9aJHUkpcs=;
        b=HRJInyi1mSK2gf6IZcVFZvqOHAQ1x32/rZsDws+j5KrEQKlmSF5vDc3ok8eir/+L4g
         XGWfwguYfmUkkOPFf0AxFTdKOUsnV34YeXVdc99SvR3VfJtEh/ntMuyGFIzNLA8LUiUB
         3akuOmWV+dxcARaQ3aZyKPiMpEXUbw7ehW/Owv6F4W+6oSkoF1mESwNCASXZGNzrLIYx
         JgquHfs3IUjOHmdyzuZls8xRPxMfh6/sKFY3xI/QfZegY0j25fnfhyG5HemIeRbCdjNq
         IMsHB+PNIQWVx438vBJAxVHldxUsPb1bX/L+KH8TcqnZ9p45M5/Pm/xfqt7DA5bSB3xc
         trrQ==
X-Gm-Message-State: AOAM5307JJlmAOBEiYyzZmGs9P4K3C2CkrpS24DcS8nnBTOYFMjupU1J
        BmrEZ4j5ykNfxvnbJd2TIwc=
X-Google-Smtp-Source: ABdhPJxZptkq4Q7hj6GPgtj6YgLyWYFQk1gsN6Ggq2WaLBy0Kip0IE6VKtsIUwAI4HJpkf4o7QwQdw==
X-Received: by 2002:a05:6214:5297:b0:435:aa83:d639 with SMTP id kj23-20020a056214529700b00435aa83d639mr22908168qvb.107.1647373148181;
        Tue, 15 Mar 2022 12:39:08 -0700 (PDT)
Received: from ishi.. (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b0067e02a697e0sm1440798qki.33.2022.03.15.12.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:39:07 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH 3/6] counter: add new COUNTER_EVENT_CHANGE_OF_STATE
Date:   Tue, 15 Mar 2022 15:38:54 -0400
Message-Id: <486a5de67414470449efb84d06a2f2214f4bb31d.1647373009.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647373009.git.vilhelm.gray@gmail.com>
References: <cover.1647373009.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

Add new counter event to notify user space about every new counter
pulse.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20220203135727.2374052-2-o.rempel@pengutronix.de
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/uapi/linux/counter.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index d0aa95aeff7b..96c5ffd368ad 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -61,6 +61,8 @@ enum counter_event_type {
 	COUNTER_EVENT_THRESHOLD,
 	/* Index signal detected */
 	COUNTER_EVENT_INDEX,
+	/* State of counter is changed */
+	COUNTER_EVENT_CHANGE_OF_STATE,
 };
 
 /**
-- 
2.35.1

