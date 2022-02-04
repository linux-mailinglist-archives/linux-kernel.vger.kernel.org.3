Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB194A9505
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353337AbiBDIX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350622AbiBDIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:23:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046F8C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:23:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s18so9823431wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 00:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WsA2JKphRpijiftuKihdH23TIHoxkoFN5l3LxYwIuqU=;
        b=PoPP7HMJmxsQTyGfKRP63CZD5spkJJoTwkFWwm2aTTiJLOUTv5bb4S+9zlgvsfaj07
         46zqVF1GVv3CMYYmRDKXRKC3IGJrfC+ejq0IuOUXbxXnilAI64yvPua76WbENjCmh78c
         R9M0XvRi3rVolFyXvJEn5hvNbFYBezWjwp3EydKeBknyGmde5QnPFAMElrPSyOUFq7Yg
         2hzzQm1phOGDVsdHtP3SjMRl0BcaropWCaoUXSvggkMar0GeZCnfiDvOyMTOok2+bW8t
         ZGeLFRIxprgkER+sIV1QMuG43hVjULTuAAKj4+dKZCUejPw52RlwCqc42pyKmg3T7V+J
         0+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WsA2JKphRpijiftuKihdH23TIHoxkoFN5l3LxYwIuqU=;
        b=P0NY9T91V4EgUkhmUQKbHE2HuIpSGRydhS6yJgRpTtjLyUYZvbgSjEbKAgPAAajixS
         cf0EVq11rtcTXy5yFcVe4Km4VecmmUBSnACJvMYQkKzewMwO6PkdCIcMLbRUq8WP/TqC
         ZkuNuDmVl3xxiwoJJVyI+ho7qUcIBMWRvUmDZIb6QMBg8PCgdgFr49ibDbwLoljxp/3r
         zUDGlqjsMv8Yt01iAS47zQNxtkcNPDO55HNf1udyWvpRUzQUxYyIJo1q2nkLdgUXPRVc
         a0wpTRmB5e40UBPC90ZCa26+f6eWdiA7451cUut8F/lL9lsyr7xshFZHTzbFiyzaALvq
         zU0Q==
X-Gm-Message-State: AOAM5305e98SsZkZ212OPLlsrjbXAjAJfndaz8dS8K24Ep1jhmCrq+he
        1sRxHDVlrmlYfKwQr58YWg3X4w==
X-Google-Smtp-Source: ABdhPJyf9JLV02jOegwiuzsQi/Mp6bxZdm6QLt9GlBXUY1uydNiZUAieAPIQ9343mdk1++V99qMmQg==
X-Received: by 2002:adf:edc7:: with SMTP id v7mr1440216wro.584.1643963003539;
        Fri, 04 Feb 2022 00:23:23 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:3fbe:ff10:110:739])
        by smtp.gmail.com with ESMTPSA id s22sm8914078wmj.38.2022.02.04.00.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 00:23:22 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Lutz Koschorreck <theleks@ko-hh.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson-sm1-odroid: fix boot loop after reboot
Date:   Fri,  4 Feb 2022 09:23:15 +0100
Message-Id: <164396299209.31118.5895566929848483023.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128193150.GA1304381@odroid-VirtualBox>
References: <20220128193150.GA1304381@odroid-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Jan 2022 20:31:50 +0100, Lutz Koschorreck wrote:
> Since the correct gpio pin is used for enabling tf-io regulator the
> system did not boot correctly after calling reboot.
> 
> [   36.862443] reboot: Restarting system
> bl31 reboot reason: 0xd
> bl31 reboot reason: 0x0
> system cmd  1.
> SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:B;RCY:0;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
> bl2_stage_init 0x01
> bl2_stage_init 0x81
> hw id:▒SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:B;RCY:0;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:1;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:2;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:3;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:4;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:5;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.17/fixes)

[1/1] arm64: dts: meson-sm1-odroid: fix boot loop after reboot
      https://git.kernel.org/amlogic/c/e6b03375132fefddc55cf700418cf794b3884e0c

-- 
Neil
