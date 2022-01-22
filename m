Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1B496AA4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiAVHc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiAVHc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:32:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741F8C06173B;
        Fri, 21 Jan 2022 23:32:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso16228081wmh.4;
        Fri, 21 Jan 2022 23:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=eLJ1e0t7pNb7/jsmEfgWimt9GUNNFZcrb7wADH/t7SE=;
        b=bl2Q4lLV4EuYLIeOTG8HyAaoPmk6wvVq5hZGZJQf8OGbqPct7X2b2Afb2Nm9M/Inkt
         zqwcLuz1yuTqFCJ0bQDM1b+9JQ+2Zw1bh4Uy/K1G9Vtn3Y/T9nzSxAGJZ3LdBq+DWBs6
         G60lBnB/sVJxvHNNbalhh0uOOwSKqgXn4ENyFEO4WGnkuVBmOuxH51nTtB5ewzUmJaW5
         qtORYOG4sJqoNcnFkLE41glfyilh2b0fDmy1cGx3S0wJpyVll1sO7nm44XAHmNl2r9f8
         Tsgn9CI2p3toUmRlCWamjTPL/e+ltWjDI4B0RhIycZ8AnfIM6lrUMDiIciWjKt+nslgY
         S7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eLJ1e0t7pNb7/jsmEfgWimt9GUNNFZcrb7wADH/t7SE=;
        b=ud0p881S7K6gCZlMrrm3vxkR8tqagtcIuCBoMQBfDAnI0y2Zyk0c/xtnZu0/N3cPOv
         E42ox+iMpdNScsG09l1gWaGDpQnaydPS2eoSUSFROvhZGcJKswDmXt19nlenAdJqh9O6
         0erpTE6/hgOSy1FjNYmAwpxgyXWwBh1MXIFdC3sxo1OwzmnMA5jfhg3Q2a8nrgDtS5QO
         hnTBaW0sKOpQLG/1l/HgSz8CZPNJtkMHIJ3mdK9ulWUP/uJ43Vbl5+RdPtzzHP8qb+rB
         JfDkSHHjV2Owj0dHF+TqFZgSurce6U+7a/g9WNadwputGEwg6itDYDP0Bw5X3O/vMtsy
         iIoA==
X-Gm-Message-State: AOAM530BDhi7exNiQAHjHM3qP5mP9oeUHcKd6MPhVphd7eW4mlWQh+3Z
        DUYWsZFbK9jRhahpK+UEYAdbQFl902TpG2F5
X-Google-Smtp-Source: ABdhPJxETDu2LPO+h9VYZACT8m+jzuSr6/A2dMQSNAwgOT7t2iW47JBiA/7I6Nrnq495CccE0/Vn9Q==
X-Received: by 2002:a05:600c:3caa:: with SMTP id bg42mr1667733wmb.193.1642836745883;
        Fri, 21 Jan 2022 23:32:25 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i8sm8970485wmq.23.2022.01.21.23.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 23:32:25 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Furkan Kardame <furkan@fkardame.com>
Subject: [PATCH 0/3] arm64: dts: meson: add BL32 reserved region to Beelink g12b devices
Date:   Sat, 22 Jan 2022 07:32:18 +0000
Message-Id: <20220122073221.2398-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This resolves a long-running issue where Beelink GT-King/Pro and
GS-King-X wedge on boot or shortly after when booting from vendor
u-boot. In some distros the issue is often reported as triggered
by large file transfers to/from USB or SD cards. Reserving the
BL32 memory region prevents the issue.

Christian Hewitt (3):
  arm64: dts: meson: add BL32 reserved-memory region to GT-King
  arm64: dts: meson: add BL32 reserved-memory region to GT-King Pro
  arm64: dts: meson: add BL32 reserved-memory region to GS-King-X

 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts   | 8 ++++++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts | 8 ++++++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts     | 8 ++++++++
 3 files changed, 24 insertions(+)

-- 
2.17.1

