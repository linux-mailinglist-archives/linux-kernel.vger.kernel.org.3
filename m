Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B925AB1D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiIBNmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiIBNmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:42:14 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BB2356D1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:18:59 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id u9so3809854ejy.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yJzALTHOqe6QfIve70YAaeVz9nTrBVF/M11ycFDNp24=;
        b=eFgGQSodHUN4MdqbSOoaPRy6Ygqxtz0Yjc3JL0GXIySm/S2cj2nytxdq9aDHq5iq9K
         OW2WpoFBVAc125W6YSj1u1t2AE3n6cX5jfOCzg7EtBHKR0twuoXBHdTXcwg1GugHLVhf
         aM3c+epDVCAOBpW+o2VrTYXSQ9Ki+yWHomeBhTjHpBPYscuKXde7/WIAJkGqFV1/qavl
         zI/OPUD5Oe10jgW4TqCEkpDKxtQCsrQWsURZooKGO1KLOGs3LVHa7h6eFTefS1YxIVYf
         xoZ9KqLmSgj+LYZB4ygFbnbSwR0wQTQJiqBpN9R2YUBFtQq4V+tPUF1NQnPxfWVZtgUK
         KkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yJzALTHOqe6QfIve70YAaeVz9nTrBVF/M11ycFDNp24=;
        b=HpZYsA17swRiZlHL6UpAytGAw+s9kyRXrSd5BKoy1im+k40C87w9sNi4E7TJN4LHz0
         VzovHGfyNxqWosuiyAWXk1+wkh+B8PtNDhYNojc8Rxp97dyZ/YIDNn4E6h9lkkHFDxJ2
         oY/W/YhgfnSJx1OVaVqFlNhNco/xjY9VkIAt8GhCsKZSnHd5OSSwl9XNOQJ4qpWMla2J
         4yi3bIHPp+5p+wRodUoNYDT1rWMklN4+w/8xDc9RHBKE27NrYywdurK34mj+yAVth52D
         qEXgzZ5An2ExWEiitsMAG3hhQeMB3qPU9J5iqB8eejhPAF1zGxs/wOA8KeO90868OuBY
         iyBA==
X-Gm-Message-State: ACgBeo2VI8VQxhEGwYnOEpCbJRLROvqlaTe1Lx0jtf4w343Oav6dGeIW
        4OsIYCFt7k7T6FTbLDHQ8buhhQ==
X-Google-Smtp-Source: AA6agR7rKNmnZfJhKmVwR5qy2gB0K/NDDZuacrO5wNDa9phlXV34WsFsTRZMZGPf0hlpMvmvtRt6Ug==
X-Received: by 2002:a17:907:7b95:b0:731:113a:d7a2 with SMTP id ne21-20020a1709077b9500b00731113ad7a2mr26274699ejc.377.1662124358992;
        Fri, 02 Sep 2022 06:12:38 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id gz28-20020a170907a05c00b0072b92daef1csm1243371ejc.146.2022.09.02.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:12:37 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 0/3] iio: temperature: mlx90632: Add powermanagement
Date:   Fri,  2 Sep 2022 15:12:10 +0200
Message-Id: <20220902131210.3316286-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

