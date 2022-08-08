Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEDF58CAB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbiHHOsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243305AbiHHOse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:48:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26A8B851
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:48:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e13so11580733edj.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YC8oAmOD0EWSr0qf5Ff8MSZfqRgbTMyuirH/vAO1tUw=;
        b=CKCZ8aIPbRMTFTWhAKKcpP1Hc1aiODp11elYBagY0w/FAyvoJuqeW7NwiaKjbO4l79
         K9bzWFLa7dQ+8JDwtQy8qxsnuCXKI9aLllJOhnIFMzkUIW2DH+irrgXxr5qUx3mmDYpJ
         UDvmSW+CZEEMTvDnKN0fmBet7gQsQqQAzv2rn/soDUfw+WFp4imWiY15A6DG8GxI5EYG
         1rMqjnEyXdbbYO76MePYsL8Opd/GHQhTw1L8sv6F0mogZ0Om2g2CltWlZ+7NTvybJpOc
         2W9PsyUvZCgWD6QEx6losLrgD1NjoomngDpv7vgQVVPK3bjvuBTyZnUZ0n7/CEJFVR+H
         v46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YC8oAmOD0EWSr0qf5Ff8MSZfqRgbTMyuirH/vAO1tUw=;
        b=0D3woH0OqY6zuJJrvObGgm5gXgiDhUAZsKo16NawZC8Q0pe26/3Y2B9lT2FWtm2NR+
         mqMlleZcF3inCYfWAznqOzpSNCix+dRQ0svcmXw4jxbsn2Y2AS1BZn32iprBjj1l44VX
         s5hdaNbX12GWhvrsP3JTieFvJ002Vz937jf8k8bPa/T4W/LHoBWDkOkf2lAe+57hEsfM
         5gRXy5OrC05ozLDiLJjRPzUEjMQkYOSMdctIFGR8D6XHVJFEpW6JkQzcPmd6AsDFnFKl
         sy/4kpjPbgJWmdQ72EXVvg2uniNkeMGoUjvXh814uvEerMC+SPRgfGYUQlYlzmz0JEV6
         UC7A==
X-Gm-Message-State: ACgBeo35JdsiriGYC4bPLg89sNiIYgXRyNkuBovwikSAGNIDLEmdXZiE
        CWKJouw7Y3GnBhntFl3/GZ68tQ/9Gl+gtQ==
X-Google-Smtp-Source: AA6agR6Lf7IIZzRUPVWIQKNn++M9hDxdEZrrs1Z5fz50qIrQZeOkHs2PHt1zeStj3UCIOE/L0spK/w==
X-Received: by 2002:a05:6402:524c:b0:43e:aba4:a42d with SMTP id t12-20020a056402524c00b0043eaba4a42dmr17160905edd.328.1659970108269;
        Mon, 08 Aug 2022 07:48:28 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3vuv1059rd6h4r.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:cd22:c517:e143:e53b])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007306a4bc9b4sm5106408ejg.38.2022.08.08.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 07:48:27 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 0/2] iio: temperature: mlx90632: Add supply regulator
Date:   Mon,  8 Aug 2022 16:48:04 +0200
Message-Id: <20220808144804.1558849-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supply regulator to the sensor as initial update before proper power
management is presented. This will reduce the diff for the following
patches.

Changes in v3:

 - Style changes of few more arguments in one line

Changes in v2:

 - Regulator voltage was removed as per comments from Jonathan Cameron
   and Lars-Peter Clausen
 - Style handling for the error reporting of the regulator DT binding
   was adjusted
 - NEW: Delay function was created and grouped together with call from
   the reset command, to ensure consistency and reduce the amount of
   code.

Crt Mori (2):
  iio: temperature: mlx90632 Add supply regulator to sensor
  dt-bindings: iio: mlx90632 Add supply regulator documentation

 .../iio/temperature/melexis,mlx90632.yaml     |  4 ++
 drivers/iio/temperature/mlx90632.c            | 61 +++++++++++++++++--
 2 files changed, 60 insertions(+), 5 deletions(-)

-- 
2.34.1

