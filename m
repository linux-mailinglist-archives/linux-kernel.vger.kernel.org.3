Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6781C5AE3C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiIFJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiIFJEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:04:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCB4E0B1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:04:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fy31so21658427ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yJzALTHOqe6QfIve70YAaeVz9nTrBVF/M11ycFDNp24=;
        b=Owl86h5NR9ReQqMeW7GT73P3dQdBR/VZcA8FxJuxfflV8hFzauw8TySH5B7FsJBg7m
         PCyjKKUHWZ9WWIrRORwpSCc9Ivji7EmIa6gx1M9QaTUufhql8Bh+u5B+6hzhEwf73MBD
         dDeoWb2Dv5ZF5JrQBWmo6evRCi/jQN0ZldsTTyZpLL6vdZ6BgJQtruezX2fX7inDchga
         6SXNKwghFvbLUD9eveL5ztihgkAyTbRaAfhiR3jMy0gonGuaaZ8d7OqJLQw/NbFDmP0S
         cOr2BwJTjPajtEht9UZqiHwmssQ2M2Cf1bkeeFU4mzaMZ8VaILaqMzRxsF2ajx/rrm1X
         qWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yJzALTHOqe6QfIve70YAaeVz9nTrBVF/M11ycFDNp24=;
        b=53D8gYYddTI4nQPLLLLcZ5Z6qT2kIXQNg0RN79KUaCYK6C69iRjjmU6u1ZOUjJsgFR
         Q7PGhYFrlxSv6V2LyQ9y0K7Af/6GvKm0ftRo7UOWpl69m+kqaVnmgReeVm7XekKGg2RJ
         6q3GYe8fq2oMgKTNcQeObIW4ZFTNHtjxpk2u3UhdlZAYuoW3+5vTkWyoNktv1P3PgYB4
         ID3zZ/nQBt9uDpTBO3ebwZoslXXepbDMYNDoXC5Zr21PATqu7kJonkrRl2BR0yCzehUB
         XGbSyDHr1kX8LyK3u2bSNr979YNiutm49H06XOSjzBDZ/9sb8hDsRrs+MytJQR9w8Yg9
         5aWw==
X-Gm-Message-State: ACgBeo31+57J1VBmVx4J06+MYb/2WuiKRtvljg/uqy6hhbhk2LbhRQr6
        aTVxLUchTMCYHj3nB+vKob2JPKaKt6y2rw==
X-Google-Smtp-Source: AA6agR4kyo8ymwNi/buAaAyJGzBLg9A3uOBIj7OJzRib/Q9Qr8Ybqc8r07OCZ7BGQzb0/1Ms4Z6/2g==
X-Received: by 2002:a17:906:da85:b0:741:40a7:d08d with SMTP id xh5-20020a170906da8500b0074140a7d08dmr35269094ejb.263.1662455089627;
        Tue, 06 Sep 2022 02:04:49 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id b29-20020a50ccdd000000b0044ebf63d337sm1612531edj.57.2022.09.06.02.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 02:04:49 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 0/3] iio: temperature: mlx90632: Add powermanagement
Date:   Tue,  6 Sep 2022 11:04:29 +0200
Message-Id: <20220906090432.33841-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

As discussed previously on the group under the
"Controlling device power management from terminal" thread the mlx90632
sensor provides measurement capabilities under sleep_step mode. This
series runtime suspends the unused chip to sleep step mode to save power
but in case of continuous sequential reading it switches to continuous
mode for faster readouts. This value is hardcoded to
MLX90632_MEAS_MAX_TIME (with some buffer) and not user configurable.

The sensor runtime suspension is set to MLX90632_SLEEP_DELAY_MS which is
hardcoded to 3 times as much as MEAS_MAX_TIME.

Crt Mori (3):
  iio: temperature: mlx90632 Add runtime powermanagement modes
  iio: temperature: mlx90632 Read sampling frequency
  iio: temperature: mlx90632 Change return value of sensor measurement
    channel

 drivers/iio/temperature/mlx90632.c | 355 ++++++++++++++++++++++++++---
 1 file changed, 317 insertions(+), 38 deletions(-)

-- 
2.34.1

