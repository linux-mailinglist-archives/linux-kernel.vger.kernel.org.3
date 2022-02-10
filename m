Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5B4B0A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbiBJKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:06:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbiBJKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:06:43 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B5C55;
        Thu, 10 Feb 2022 02:06:44 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h6so8535147wrb.9;
        Thu, 10 Feb 2022 02:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=FPD4xO1P+78Y/NZipV2Yc+8FswUAtN3q8mItY6ywkSw=;
        b=QmQF9NFofioCPqaRQ/xtXqTWiKFv4fISuIYU/wppTpOUOYT2oVFrmKM30hyzW9XOXF
         weBSfLkDIzwC1gq4FYIaxqJgEPcSPslh2ZFFj0QKwr1dZpdkTG4mY26D2d5f11oX5Z8g
         rdh4qDGsYSsM1lpbHauTAINYBvOoRf9FIJaLrvgFIPLuqVJ2so1FhC+DKdkTa+naJUvg
         /VVYAeZUAQ89iROPos+uEAXr4t5L3DVAJfZKHVgqtfHnwYAqBayZAnIDILP3VHZwfoRw
         yNdFl0/SYw3wg5pVhC7EA/ND4xvWLyL2c2zMbD7GLBUCK4Ov6p4pmxrvUsoBRwFtYNxS
         A3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FPD4xO1P+78Y/NZipV2Yc+8FswUAtN3q8mItY6ywkSw=;
        b=Q9UO8/jRLHxy81y0SNWx9Q3AnD7cIfxqTSaBduvwfAHNEIVdxV27vNXf0qstzOHBi1
         +bwc20LD8bQQNhb4bCh0HI54a0GuUAj8t/neO9k6INJteaPzlwKi3BfbZA2dMXEQgQrA
         NuKZ+jZS6rj3mKaSXZ8TC9U+VAS4ScwKgzrBNB9uUFu6t9rpGgPwVXEuR/CaH7bD/1u3
         L+BxgjAlmpQnBHBpGS2FmNYxZwhZVEj4jv3W4PVx2xoJV5woohHB4m8Dt7FsrmpOtVYr
         bi+h0/O5ko5sKkw8SoYQLiEUTzIsmFTEEU6qMcu3dKKorskVed8Awg+Fx8kLB6G3GiU4
         2g4w==
X-Gm-Message-State: AOAM530Eebh13jO2q8T8shUVxzUO+A0aRkHAEvPAJQ4DSvUuR3JSO97v
        HQyxa9YhKbu374yJnkyzYZA=
X-Google-Smtp-Source: ABdhPJz28f2M3YAckbDT3m5BYofZoOYoV0Zalqy9f2eHSZ/BpSZ+pd3QtbiwxftomVxupxK/KE+sow==
X-Received: by 2002:adf:f64e:: with SMTP id x14mr5491755wrp.698.1644487602942;
        Thu, 10 Feb 2022 02:06:42 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id g15sm18817494wri.82.2022.02.10.02.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:06:42 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/2] arm64: dts: meson: remove CPU opps below 1GHz for G12B/SM1
Date:   Thu, 10 Feb 2022 10:06:36 +0000
Message-Id: <20220210100638.19130-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12B and SM1 devices experience CPU stalls and random board
wedges when the system idles and CPU cores clock down to lower opp
points. Recent vendor kernels include a change to remove 100-250MHz
(with no explanation) [0] but other downstream sources also remove
the 500/667MHz points (also with no explanation). Unless 100-667Mhz
opps are removed or the CPU governor forced to performance, stalls
are observed, so let's remove them an improve stability/uptime.

Numerous people have experienced this issue and I have tested with
only the low opp-points removed and numerous voltage tweaks: but it
makes no difference. With the opp points present an Odroid N2 or
Khadas VIM3 reliably drop off my network after being left idling
overnight with UART showing a CPU stall splat. With the opp points
removed I see weeks of uninterupted uptime. It's beyond my skills
to research what the cause of the stalls might be, but if anyone
ever figures it out we can always restore things. NB: This issue
is not too widely reported in forums, but that's largely because
most of the Amlogic supporting distros have been including this
change picked from my kernel patchset for some time.

[0] https://github.com/khadas/linux/commit/20e237a4fe9f0302370e24950cb1416e038eee03

Changes since v1:
- Split into two patches to allow for separate Fixes tags
- Minor edits to commit messages for brevity and typos

Christian Hewitt (2):
  arm64: dts: meson: remove CPU opps below 1GHz for G12B boards
  arm64: dts: meson: remove CPU opps below 1GHz for SM1

 .../boot/dts/amlogic/meson-g12b-a311d.dtsi    | 40 -------------------
 .../boot/dts/amlogic/meson-g12b-s922x.dtsi    | 40 -------------------
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    | 20 ----------
 3 files changed, 100 deletions(-)

-- 
2.17.1

