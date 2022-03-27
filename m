Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB474E87A2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 14:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiC0MQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 08:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiC0MQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 08:16:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FC737A04;
        Sun, 27 Mar 2022 05:15:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lr4so15053825ejb.11;
        Sun, 27 Mar 2022 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiW08mGrW/P2Qfz12hcyjdp5Im5rBtj/BzAioF2K6ok=;
        b=GvdAGJNFZbFBKz4XXMJ2vU7F8YMboGHFplP8NxflbV3EAWaem2FlkQ/CqvKHcYGBUU
         1Bf3Zt6WPy4T0u/lIT8UoCbnorFZx5LBFM/MTOl8LqqI6LHhvruAjeqmgd7EVt2MFsJO
         WHrNDOp7e/aHW4g0TvxZ0GBoD1GJMvN/ogijD5h5KVM7BYU1m74TvRKBuhdmjBbV5s7y
         B277Vsg49RknWnxHLSd3BWzDNu74VjjblmrAlBj5xxR0vOux2GfmDKDfKsVaxyR/hhmi
         VczFavVFbHokr6tthKV1MLvWhCyX7yA/H6JYI4+0Su/K/ncXO71K/2Eb5bC8krylgezk
         9XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiW08mGrW/P2Qfz12hcyjdp5Im5rBtj/BzAioF2K6ok=;
        b=4jCBChIUPLvAfKdya1TRIlfcAFh9lLExNDRQbp2I+QRk9uAgh9ab4WWf0hySPnFXfg
         cPvIKxyVAoQRK6eBMuuVzOsY9SxnAHyFdDkF5dPyU5gtBS2y9V+IMHvOPSsN8mWFG6dI
         Dqg4uHUS508xZmSSTZ3JzIWPODGwtrFca9hxyeo6Aym2QCH6EjD52VbLZnZ9qfRZTyQq
         +z0i+1Hw7N6KvlVVdZ9Vf3UMzb8h5Mj/8gak80xhsFd66jDQDUnGriFDgxVFBzIw7pnr
         HPc6+VzKuoSDzxvIeM504Ib0zs2cbHHObCYIWReNHFV7D0XB5N23DaSa0aKwTzRtoQjE
         vzgA==
X-Gm-Message-State: AOAM530HRRipCVvJAolVUOby/AAG8xDsVcjncdtNu5ZooT85Gfaj46MU
        5XzYJaBLrU5Hyg4siSkUm5utSSLXhEUDyw==
X-Google-Smtp-Source: ABdhPJy0x7yednyiZPiZ6exwcVYQOdquEz2Xnh5haQQ/MHARxitoeV9Oqx3aP4UEEGAFrJVFGJ8O2A==
X-Received: by 2002:a17:906:1384:b0:6df:c7d0:9131 with SMTP id f4-20020a170906138400b006dfc7d09131mr21231034ejc.134.1648383305620;
        Sun, 27 Mar 2022 05:15:05 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f06c2008407e4c213cb9d01.dip0.t-ipconnect.de. [2003:cf:9f06:c200:8407:e4c2:13cb:9d01])
        by smtp.googlemail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm4530127ejc.64.2022.03.27.05.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:15:04 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] asus-ec-sensors: add support for board families
Date:   Sun, 27 Mar 2022 14:14:00 +0200
Message-Id: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Users provided information for boards from AMD-400 and sTRX40 families
and demonstrated that sensor addresses differ from those for the AMD-500
family. Also the AMD-400 family board uses the global ACPI lock instead
of a dedicated mutex to guard access to the hardware. 

This patchset implements required changes to support other board
families:
 - per-family sensor definitions
 - options to choose hardware/state guard mutex: an AML mutex, the
	 global ACPI lock, and a regular mutex in case no ACPI lock required.

These changes are used to add support for the PRIME X470-PRO board.

Eugene Shalygin (4):
  hwmon: (asus-ec-sensors) introduce ec_board_info struct for board data
  hwmon: (asus-ec-sensors) implement locking via the ACPI global lock
  hwmon: (asus-ec-sensors) add support for board families
  hwmon: (asus-ec-sensors) add PRIME X470-PRO board

 drivers/hwmon/asus-ec-sensors.c | 431 +++++++++++++++++++++++---------
 1 file changed, 310 insertions(+), 121 deletions(-)

-- 
2.35.1

