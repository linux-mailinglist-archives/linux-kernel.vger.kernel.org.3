Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597B65ACCEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiIEH3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiIEH2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:28:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7019338
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:26:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k17so4768207wmr.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lnIlSEWqt2NuMr0K7xfjm9a6tpssYyqRvH3ULhoQs6E=;
        b=EUI+aE5By8Fm45Y8d6L5isq9giQdqO2xEjrOpxA9/qsJFGKS0KWzRvv72P6F6VQdC4
         FtWJ1HPSQ3R/HXPiL0FfRC/Qi+mYDb6QxD6bj8I0NPbTiWT1o+BQBTZZllIiyZGU9rJs
         73V8ODYo2WmN5Eh5uFydeP1Zakyx/rScuuzFvl/VBVF7D3HfBd9Fi+T70LqG09GUHCWH
         nU65d5GiBV4aHNIUEaZKmYbmLECM3B5RWTB0RflQQ3JK+mYnGncfmpJ700ImmjrELBNG
         2lOjgR2LHVf1JkOB4BfGeH151hMJsCFzAzHotkYTFcZHgksAoMzk9H6rLOTGp8U9eFzm
         7Otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lnIlSEWqt2NuMr0K7xfjm9a6tpssYyqRvH3ULhoQs6E=;
        b=5vrKTUPiriGVmi282XtQlrQN8r2DS2Ar3XmlmEc8Z6YZTydXST/wWtRGFySTVHEaR3
         FCXEbqvzBdqi7ElJGdD/8A4LIfHyOSg0vk9Tr4550tci9AfY4kmmW5CHLPTzMra2P6PX
         We17je5Nijw5qSEbe6zq17O155tzJR5gMKQtXK44Ext91wpQtZ5wOdlEB83PjlHcxo4m
         NCErls7R94GgW9kRcLOyH2scbSDUd7Gg0YfKchAjLjRwo6UwMgIIyFk8yllMweWewIbm
         a/RdKcUTN17hifSv51ppTMLGvkYq6UvwcXakoy0mZEtVUwgJDvYEe721N+R85T3wkfxL
         vu6g==
X-Gm-Message-State: ACgBeo0hj/GF+nKIaV5xz/iqkOz5wb8qv54ecpeHBYZFeJZrNqr4VkDS
        G/QaGUo6nmBxrHTAoySjbEFw1Q==
X-Google-Smtp-Source: AA6agR7e3YZmCionyQgAwi+41U/5n8SW9PV18lBGEcpsXwbdFta/TDuiQqzLXJkQWdRl/uFr+MusIg==
X-Received: by 2002:a1c:7907:0:b0:3a5:a965:95e6 with SMTP id l7-20020a1c7907000000b003a5a96595e6mr10026082wme.75.1662362806227;
        Mon, 05 Sep 2022 00:26:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:982:cbb0:f365:27e9:453c:4c15])
        by smtp.gmail.com with ESMTPSA id l17-20020a05600c1d1100b003a5fa79007fsm10521723wms.7.2022.09.05.00.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 00:26:45 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Furkan Kardame <furkan@fkardame.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add Beelink GT1 Ultimate binding
Date:   Mon,  5 Sep 2022 09:26:44 +0200
Message-Id: <166236280066.644940.15832711054372731780.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707093954.21716-1-christianshewitt@gmail.com>
References: <20220707093954.21716-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Jul 2022 09:39:53 +0000, Christian Hewitt wrote:
> Add the board binding for the Shenzen AZW (Beelink) GT1 Ultimate
> Android Set-Top Box device.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.1/dt64)

[1/2] dt-bindings: arm: amlogic: add Beelink GT1 Ultimate binding
      https://git.kernel.org/amlogic/c/70bff3a65d4b974434b7f576f52a269fa4f0dd04
[2/2] arm64: dts: meson: add support for Beelink GT1 Ultimate
      https://git.kernel.org/amlogic/c/5b3a87a5c4f20da682d50dbaf8c4aa357cfd0d2d

These changes has been applied on the intermediate git tree [1].

The v6.1/dt64 branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
