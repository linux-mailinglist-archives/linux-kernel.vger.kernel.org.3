Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1E4EEF12
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346768AbiDAOPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbiDAOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:15:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067751D8304
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:14:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w21so4496199wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=1btWfQ/cwwDf+2zR7TTJasEyjJMKEHxOGQFvSsQzUNo=;
        b=drDk9UlAfQl8dv0tbJ/z6xC2Grcsru7JjL9gwD6kTbH9HdbjLZOcMoA3136FCkDdpF
         ASVS7qUzI5h87CsTvYm0MQt+YnCxecL2ATTP7l4XrckrmcIpEsjgMyWnlVdihMW9L6Xj
         Lh/2jEjU52rzyd4P0b3asys1JtxtM119FjajeeKUfeX1/V1UaSmVcdIzwvfRemSqLZ6K
         cVnZULgvP972s2W3XHzv5vTsGEo0zrJPRehSFVHQ+/qwF0GdN9T0Fu+YermCJkZ02nNu
         uISKnWIUWLcS7fwkiUTrzpukOXV4SCI2INJpSPTRz7/bPnPQydVqfjsiL3eJn8qF8K+x
         PfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1btWfQ/cwwDf+2zR7TTJasEyjJMKEHxOGQFvSsQzUNo=;
        b=6YALQNnDlgJ6ifzV7PJ4ZSUgN3KQQpo8lRWS6HyeLW+VtdfDOyfDTCsP7eKaznVJSo
         JzmXKQ+jo9xNvyYVLZQMbngNKSX8DdufObmCbT7bwfaccUQOwUIFaAuEw2mdhIaTgjO+
         oSoNuewtsdveFPk+JQUIRGzhjUm0u/w3CUnKby8QKtYYM296i9yYyszcF21MMt7GjPp4
         MtBZ9bDVAyVGVHNGi01S4lYVtfujoGbJ5Wt5F9BGFnqw+SeLgEKdmv+OW7R1ppIckAEE
         lVE6GNoG+Vi3+NRxWsRqzn1V8Ug7b7jCnBENtgFbIwqYKx8Fp1f2JsrymMFCMZHeDNad
         o3gQ==
X-Gm-Message-State: AOAM531xeU4KOQkAEmH3D4hNJDOqcayyNHPHwuM5qUe+XTDolls4y/qv
        HDg8wueRWxujru91RtAnbuZEQA==
X-Google-Smtp-Source: ABdhPJxziInbIQM7rU7QrfHhBeMrpFnpjbR2ITa3QPuqaB6h2ay9esiw6GE7JzxYi1mnlF+O56b9dQ==
X-Received: by 2002:a05:6000:1cc:b0:203:fdbf:e576 with SMTP id t12-20020a05600001cc00b00203fdbfe576mr8043910wrx.147.1648822439548;
        Fri, 01 Apr 2022 07:13:59 -0700 (PDT)
Received: from localhost ([2a01:cb19:826e:8e00:843b:fbda:3082:4270])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm16727828wmq.27.2022.04.01.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:13:59 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: Add device-tree for MT8195
 Demo board
In-Reply-To: <0b042c71-4d07-76a6-53bb-94bbd4bad6c0@collabora.com>
References: <20220327200312.3090515-1-fparent@baylibre.com>
 <20220327200312.3090515-3-fparent@baylibre.com>
 <94d231cf-ce4c-22f5-b9af-41ae68f1e659@collabora.com>
 <20220328144107.ed4xwzuiezzixqrx@radium>
 <0b042c71-4d07-76a6-53bb-94bbd4bad6c0@collabora.com>
Date:   Fri, 01 Apr 2022 16:13:58 +0200
Message-ID: <875yns51sp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lun., mars 28, 2022 at 16:50, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 28/03/22 16:41, Fabien Parent ha scritto:
>> On Mon, Mar 28, 2022 at 03:47:09PM +0200, AngeloGioacchino Del Regno wrote:
>>> Il 27/03/22 22:03, Fabien Parent ha scritto:
>>>> Add basic device-tree for the MT8195 Demo board. The
>>>> Demo board is made by MediaTek and has a MT8195 SoC,
>>>> associated with the MT6359 and MT6360 PMICs, and
>>>> the MT7921 connectivity chip.
>>>>
>>>> The IOs available on that board are:
>>>> * 1 USB Type-C connector with DP aux mode support
>>>> * 1 USB Type-A connector
>>>> * 1 full size HDMI RX and 1 full size HDMI TX connector
>>>> * 1 uSD slot
>>>> * 40 pins header
>>>> * SPI interface header
>>>> * 1 M.2 slot
>>>> * 1 audio jack
>>>> * 1 micro-USB port for serial debug
>>>> * 2 connectors for DSI displays
>>>> * 3 connectors for CSI cameras
>>>> * 1 connector for a eDP panel
>>>> * 1 MMC storage
>>>>
>>>> This commit adds basic support in order to be able to boot.
>>>>
>>>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>>>> ---
>>>> v2:
>>>>    * remove empty i2c nodes
>>>>    * remove empty spi node
>>>>    * remove unused pcie pinctrls
>>>>    * fixup node nodes to not contains underscore
>>>>    * rename mt6360 pmic node
>>>>    * move mmc1 node right after mmc0 node
>>>>    * use generic node name for gpio-keys
>>>>    * uniformize pinctrl node names
>>>>
>>>>    arch/arm64/boot/dts/mediatek/Makefile        |   1 +
>>>>    arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 447 +++++++++++++++++++
>>>>    2 files changed, 448 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>>>
Boot-tested to console on i1200-demo board.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
