Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B45AA31A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiIAWcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiIAWcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:32:33 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FFC1092
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:32:32 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id c3so334330vsc.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=H6ognOyqgR63Qc5uxwtLsdJe5XquKuPnICVqa9a8AKs=;
        b=Yjx+TGhJgVa88DDNYKa0fjVNTMlJaMO/tyUZU6y3og+6nYzwev4neOE97zwDXbETHB
         fF8xoIuqF5Tvstqbf0dU8zyUh2QMzGkB6U6gEOucvqJ/Oies13jEAaSE2lmhVxwnLR/D
         bAW/WmZGGvKCxuD3kEv5YwNQilRT+kwbX7WTSn74VQayUDRZcOF4cfE2AEVwO90bCsTK
         A5/53sGWlHQ6U3RTWPd5dUpH7BdUy9SM+IbMOlPIzsVeFYdpRlsfMPlplnQM0wH/e3lZ
         BrgbmP5weBThNZuaevXlt9J7GkkCohcjr0ngBG3AWCQOOmt1ZxtrV0Nqf3q/E0MU9443
         opuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=H6ognOyqgR63Qc5uxwtLsdJe5XquKuPnICVqa9a8AKs=;
        b=noHhDdM/r2ah98N4DpRU31FDLb2i2BfBQojXAz1wp/F3ZrrCENKuerHTuL+9Bdx9Kc
         XO1EFK4Vk9IC/IgBuJbdl1DOdMMPGfVQRsOxNmeGV8CZO9QA3A+cl0qx+CFvWofm91Bg
         OPvoyys69JQQaXDBD4Z/8DckrYjtMwI55pa0YWSF+/pTax8zX8z3Gcq/q0tLRNS7KgGo
         AGM5Hin9u7CGbmyNjZDI6aY57jfjQVLGNQNsEr++XseHb9Mp9C4MPYKXonVrtIzHveWG
         mItajogwuMQUtkU5LobDk8XIL5uIlGATGQ5m+HdJlMVDOXZyWscRCKNEN9jzmtPXqh/8
         GgeQ==
X-Gm-Message-State: ACgBeo25hQhnA4B9zw4CXLPB9kjyQP4E9wkJt4PRw+nevH9iKj7BXqiC
        ZycIMCRsnnXDIPuchr+Sa9mQzJ/l3Ym7bWJ6Rj+eUGKhHKjJgBVv
X-Google-Smtp-Source: AA6agR6m2BFDhZF8xc/TQvHE5/JD07yIzmeqHx3EbH+37ZwhGDqt/hrDf3heDlbAYgGk5SNZLDBr4+9lbVnFAuVS9Xg=
X-Received: by 2002:a17:903:41c6:b0:174:3acf:8294 with SMTP id
 u6-20020a17090341c600b001743acf8294mr32176674ple.118.1662071024760; Thu, 01
 Sep 2022 15:23:44 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 1 Sep 2022 15:23:33 -0700
Message-ID: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
Subject: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
To:     linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've found that the bd71847 clk driver (CONFIG_COMMON_CLK_BD718XX
drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847 C32K_OUT
pin) which is connected IMX8MM RTC_XTALI which ends up disabling the
IMX RTC as well as the IMX WDOG functionality.

You can see this with:
# cat /sys/kernel/debug/clk/clk-32k-out/clk_rate
32768
# cat /sys/kernel/debug/clk/clk-32k-out/clk_enable_count
0
# cat /sys/class/rtc/rtc0/name
snvs_rtc 30370000.snvs:snvs-rtc-lp
# cat /sys/class/rtc/rtc0/time
00:00:03
^^^ time never changes

This happens via clk_unprepare_unused() as nothing is flagging the
clk-32k-out as being used. What should be added to the device-tree to
signify that this clk is indeed necessary and should not be disabled?

Best Regards,

Tim
