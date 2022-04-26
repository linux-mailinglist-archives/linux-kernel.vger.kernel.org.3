Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7236050FE84
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350716AbiDZNO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242086AbiDZNOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CF606E9;
        Tue, 26 Apr 2022 06:11:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b19so25383495wrh.11;
        Tue, 26 Apr 2022 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kfnF6/CFLRO/YWIMp2M2vTWsFrhBcq/i21FGwSxlZOI=;
        b=a/6ncwPOBYgHuHdxgzRIisoTlNMEFriWCOm4ghCkoVEycDQ3RoA834EkKHozJr4msL
         OuBhDNJEMvKum07ErAJj7sY0Hu+lQ0y42e7hUjW5WoCShTQyJ5UaQjFQCuneiyllKtco
         To3vUsy01Gm1s33icdf+PNyO0OiHSWH/CZNtJrekO//jBvfyzG80E8xA9/d/HYrZBb0v
         46zxySMRIOtwk/OCmt2HhaV2LMkVtmguQ1dd03aYfql9z2addpto6Cbw1lO1YCMKGjDv
         teNcYqOqjbEgI6g/WkItxfrj3HdnfaAv593RI7on48bvmrjdG41nl09WV+mcRszbARzA
         JPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kfnF6/CFLRO/YWIMp2M2vTWsFrhBcq/i21FGwSxlZOI=;
        b=sA3xfwaxX0NT2ScAKwn9uhhbi9wtBzCA0HWZt7bEsoI5CEzQ0iNz1JB6DENVhIw04W
         qTA/Ucevxq0sx3xnXJvzeo71VtVoeIifx4WQQ3NlX+QEFKt4chen/WzNnUNCNp+A0kMl
         8WvhHjJuU1+WCPfKZjS0XK2/pFh5Nzjh34sWFGTvpw8byPx0nyX3gan4cPc6JTrQ9FrK
         RfHJ70x/HNxOOEqKiwBWgAuQQufM0efluyMRTHMdpVf9f5swG3EEtuuAwwjogzJ/1WvP
         RoNmGszDXYwvjmXSuxXcB5CCvJGP5KF/P0QzgK5OWXLCGluhHW+a8mZ2rRbtEViCyJff
         Y0rw==
X-Gm-Message-State: AOAM530SgQm6MVhKrystl9APIULCLKUixdbC9tlZ5Ysia6SjFBGebyqq
        Z3w2BDBAHlCyjLk+P7tmXh4=
X-Google-Smtp-Source: ABdhPJx2TKDehW+zO5PUolqYD+xQQY91TLVCUtspWTcZUD6s/GLueRY2HtFuovygDfc7b5s6GQ/hcQ==
X-Received: by 2002:a5d:6189:0:b0:20a:e30f:ca18 with SMTP id j9-20020a5d6189000000b0020ae30fca18mr3535686wru.241.1650978670834;
        Tue, 26 Apr 2022 06:11:10 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:10 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 03/14] iio: event_monitor: add linear acceleration modifiers
Date:   Tue, 26 Apr 2022 15:10:51 +0200
Message-Id: <20220426131102.23966-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Following the introduction of IIO linear acceleration modifiers, update the
event_monitor tool accordingly.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 tools/iio/iio_event_monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 2f4581658859..1fee44abb836 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -122,6 +122,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PM4] = "pm4",
 	[IIO_MOD_PM10] = "pm10",
 	[IIO_MOD_O2] = "o2",
+	[IIO_MOD_LINEAR_X] = "linear_x",
+	[IIO_MOD_LINEAR_Y] = "linear_y",
+	[IIO_MOD_LINEAR_Z] = "linear_z",
 };
 
 static bool event_is_known(struct iio_event_data *event)
-- 
2.17.1

