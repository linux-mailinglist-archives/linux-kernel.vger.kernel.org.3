Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FAA576CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiGPIuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGPIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:50:23 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB6B1D32F;
        Sat, 16 Jul 2022 01:50:21 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u14so8104lju.0;
        Sat, 16 Jul 2022 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gPKSfw7yr5duwtVwsapF6h4VldWJ9CPAFxSNGvj8x70=;
        b=Yr6yBntqRAH+wU+yWZjfB2L8a+t7oaZTbke2uqW480njLX32A7Mv5jVHUeogCxWqnl
         VpI83y0h7PwcLNuqIEmb4fygspadRBAPRID9hbjtsaCxmKLdHOUEzLEK2lfNhS+CI4H7
         k23C6WjDJblbeeG2f1FRW/X+jgTsex2NzhlVk8DdM9vGoTkeobqF8InN34YLUzKoQbd3
         8QbEQaN9ngG36NykMr8R8+pNaYPlWmi0+eBGiDhZwubrpusAsGV9S61W2k9aDxtKBDoc
         YB1RCb9ffNgMk1xHvB6oEBZMzikvZmmLE0G7I5l1OUcgrqDdL8hbj9sEkFh8OtQsjeR2
         NEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gPKSfw7yr5duwtVwsapF6h4VldWJ9CPAFxSNGvj8x70=;
        b=1ODptqaa1xx8N/1PrOieWZOhW2hTkJw7TY6GzYqFV98smdO/Bdrd7Xa0cYt+5QxO2A
         CrLoqdjXwr7vMaERC3DnB39cfQI6WqoMm26haLr8vI+rQJDDsHRSKXsUxGKT/nPaPAem
         AmI0Sp9S18ScR9MDv39ImT+Tq31ytfMCLss/bUpaPo3eR4PznRuIB/BPmS2p71TD0bTG
         gkZVQh2z9cFvc7fp47G3b793IWeYgR+OLSXFmXfFQ8MuoSCtb0EVUoiMnNqPQL3ORM2l
         Q3G9TRgM+kup0M9hxFbByK1PoNLt1wUhHf9GrpiImHl6u0XBhib5u6Mom0NeamZgKW1P
         PJKQ==
X-Gm-Message-State: AJIora9glW4cyCJ9Avc1+3xz27+TzyeHZvVL16KQ+HQ3d2DaStmt0lbg
        aDby6EzR7z+XdN48H4pSpbOvZ25QVeWfZmmWd3arhUibJ9dbsac=
X-Google-Smtp-Source: AGRyM1u1ABXRVnxJl0iLO11wO+tyJ5lSuTr3FC0r6N1wtpUXU5lyBliYXTuh2shcD8ou9/+f4m8BdPT7PydMv5po4DI=
X-Received: by 2002:a2e:8785:0:b0:25d:473b:b60f with SMTP id
 n5-20020a2e8785000000b0025d473bb60fmr8813612lji.354.1657961420160; Sat, 16
 Jul 2022 01:50:20 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sat, 16 Jul 2022 16:50:08 +0800
Message-ID: <CAMhUBjkMyRP2iyMpovN7=GFP2SSpt+Na453RR6nNSBeyQR6oww@mail.gmail.com>
Subject: [BUG] power: supply: cw2015: Found a bug when removing the module
To:     t.schramm@manjaro.org, sre@kernel.org
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a bug in the cw2015 driver.

When I insmod the kernel module, I get the following log:

[  199.445154] cw2015 0-0010: probe
[  199.445447] cw2015 0-0010: No battery-profile found, using current
flash contents
[  199.447198] cw2015 0-0010: Can't check current battery profile, no
profile provided
[  199.448577] cw2015 0-0010: No monitored battery, some properties
will be missing
[  199.449556] i2c-core: driver [cw2015] registered
[  199.482970] cw2015 0-0010: No profile specified, continuing without profile
[  199.486086] cw2015 0-0010: Failed to get supply state: -19

And when I remove the module, I got the following warning:

[  200.470198] cw2015 0-0010: remove
[  200.471445] ------------[ cut here ]------------
[  200.472752] WARNING: CPU: 0 PID: 413 at drivers/base/devres.c:1058
devm_kfree+0x2a8/0x330
[  200.478314] RIP: 0010:devm_kfree+0x2a8/0x330
[  200.485019] Call Trace:
[  200.485226]  <TASK>
[  200.485405]  ? power_supply_put_battery_info+0xc2/0xe0
[  200.486169]  cw_bat_remove+0x89/0xa0 [cw2015_battery]
[  200.486570]  i2c_device_remove+0x181/0x1f0

I think the problem is that the driver fails to call the function
power_supply_get_battery_info(). However, when removing the module,
the driver executes power_supply_put_battery_info(), causing a
warning.

Since I'm not familiar with this driver, I will just report the bug to you.

regards,

Zheyu Ma
