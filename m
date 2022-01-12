Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9090C48BFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351589AbiALI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbiALI22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:28:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C961C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:28:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k30so2713651wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKtDyNYer2rw6Zv9E7QWadmZIxE7oXLzSiDYp94iL9k=;
        b=N3oTYWmb+v9cGuBIeWCILWZcj+nVimwmYD78hO4muTLMz+5RQ2gA8bAcjU3/RX72Cb
         lOmadz2T2tEDgcQhmMNI/rIZTUtBfCf0j+wFou9FkYkHrwPTuuhToz3/+H6u3IPWz2nw
         uF/EyQJS8xt5e8fGyddIDYul+WM4sFc7bJRdD4rBhDUKdV4BT/mu5A6ZtAlZ5fwcmWH2
         YUe4JGwo5LDRWKOhkHKgW0aJ+uoTlpLcVwUAZ6KELe30PhKQX9438FmOfRDwVfwQX0qG
         OjgmZ+91hjQZRl3q5dV4L5y9JW5kIPzU2aitFcJo4bYyNgtvbtABvsOtY67tS0Vy1XaG
         vSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKtDyNYer2rw6Zv9E7QWadmZIxE7oXLzSiDYp94iL9k=;
        b=r/ilzxCqB5VZIpWJtUTq6UaVEj8enNzX5iNEfvrKrgFvHJMEYHEMctgQav2NwaIszo
         0GyRNX12MRO3Lw/MsQlJgXCNGUJpL6k2xDOCGtlsIJh5KY9uMH/gurhXXKmuKbtiTMl7
         U/eNlGsCWlL27naE2r7PXISEfg4blP7KMmcDDuzqYvAaRQRyr9UH0AaXeS672A9i3FBr
         J+Iu/J97KiaO3+0I5PotONiFpuQ35rnLEfU00jwZg+jggsuHrBoPFlpZISlF0SdUVx4I
         nkBSdbjWWyQieHoS/iGviY/hyE/9SoouxvBcNp/26UzrF3qKpNpwWOSbuhMgssNTd5Dn
         +EKQ==
X-Gm-Message-State: AOAM5317W8DEoHy6dSFZC1PBcMUWp/s8IqUOyor1DlqmdUvDPgXYaeQR
        2kgTcmZTaI5W5aP8lwKt0sc3noJFODju0Q==
X-Google-Smtp-Source: ABdhPJy5DHSJBcGXXU6KEF3PtRXYTJdsZ9LtzeYqX4zs5f3GcuDPV1oA+K5gXJ8cpzwkh7xaQgViHg==
X-Received: by 2002:a05:6000:1a8a:: with SMTP id f10mr7085427wry.246.1641976106700;
        Wed, 12 Jan 2022 00:28:26 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:381b:6e50:a892:5269])
        by smtp.gmail.com with ESMTPSA id v129sm254846wme.29.2022.01.12.00.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:28:26 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: Re: [PATCH v3 0/9] arm64: dts: meson: add support for ac2xx devices
Date:   Wed, 12 Jan 2022 09:28:22 +0100
Message-Id: <164197609474.825600.7106897196640617717.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112022713.25962-1-christianshewitt@gmail.com>
References: <20220112022713.25962-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 12 Jan 2022 02:27:04 +0000, Christian Hewitt wrote:
> This series adds support for several popular Amlogic S905X3 (SM1) Android
> Set-Top Box devices. Like most Android box devices, they ship in variants
> with multiple RAM, eMMC, WiFi and BT configurations. RAM and eMMC are not
> something we need to consider to get a working boot, but we do need to get
> the correct connectivity spec. Broadly speaking we see boxes with Higher
> and Lower spec connectivity; High spec is Gigabit Ethernet and Faster dual
> antennna WiFi, and Lower spec is Megabit Ethernet and a single antenna. In
> some low-end boxes BT is omitted.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.18/dt64)

[1/9] arm64: dts: meson: add common SM1 ac2xx dtsi
      https://git.kernel.org/amlogic/c/b5a03ecec30c1a71d51de3e73a2e7ab23c3ddeb6
[2/9] dt-bindings: arm: amlogic: add X96-AIR bindings
      https://git.kernel.org/amlogic/c/d2ecf5ae59c8eef9fe2ad20d83977c2889646d4c
[3/9] arm64: dts: meson: add initial device-trees for X96-AIR
      https://git.kernel.org/amlogic/c/37875d9dcb42d489ba28518b50fed0b2ba768b03
[4/9] dt-bindings: vendor-prefixes: add cyx prefix
      https://git.kernel.org/amlogic/c/3dbabb9ac746ab01c71aa019c58a2e0cc6eafe1c
[5/9] dt-bindings: arm: amlogic: add A95XF3-AIR bindings
      https://git.kernel.org/amlogic/c/bc7811bd4e884bbc21cc7b7031cb7c297662db9c
[6/9] arm64: dts: meson: add initial device-trees for A95XF3-AIR
      https://git.kernel.org/amlogic/c/8b749a0205bd41cafae37e878fd4a1b57b7b24f3
[7/9] dt-bindings: vendor-prefixes: add haochuangyi prefix
      https://git.kernel.org/amlogic/c/bf510ace20ac153946d6d0ab6305dd8aa52eec6c
[8/9] dt-bindings: arm: amlogic: add H96-Max bindings
      https://git.kernel.org/amlogic/c/2ca889b1201625d36efcd51d25371d937a6a0b8f
[9/9] arm64: dts: meson: add initial device-tree for H96-Max
      https://git.kernel.org/amlogic/c/ac7b4433714a37e2c4b61acc6ce9b4538175e836

-- 
Neil
