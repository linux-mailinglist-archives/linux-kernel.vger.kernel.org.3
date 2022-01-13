Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4A48D3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiAMIwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:52:19 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:43729 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiAMIwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:52:18 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AC4D9223EA;
        Thu, 13 Jan 2022 09:52:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642063937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nk/tlhygRyPHYRON39lIbG0WaM6CPzwwuxYQihbC8a8=;
        b=Aqzgb+xZKpGAXiOYH3GKJMusfUwj90/DiTQXm+gEhtuFKd5Ur1MOeaK+qGgUsJArDjtkTw
        zQs+90MvQJoScm525UheAjWrdO/6mVSrLX2Z0CVjepeSv9ozs7nHlzQZU337ENPwz+x4Jk
        BO0EkGC8OwZSHYlNCHBVzX7Ljhu3aTI=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/3] of: base: of_parse_phandle() fixes and new variant
Date:   Thu, 13 Jan 2022 09:52:05 +0100
Message-Id: <20220113085208.2636517-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a result of the discussion in [1]. Rob suggested to convert
the index parameter to unsigned int and drop the check for negative values
and make them static inline.

It will also introduce a new variant of the function, although it is unused
for now. They will be needed when nvmem phandles are modified to take
additional arguments and need to retain backwards compatibility with older
device trees.

[1] https://lore.kernel.org/linux-devicetree/20211228142549.1275412-1-michael@walle.cc/

Michael Walle (3):
  of: base: convert index to unsigned for of_parse_phandle()
  of: property: use unsigned index for of_link_property()
  of: base: add of_parse_phandle_with_optional_args()

 drivers/of/base.c     | 137 +++-----------------------------
 drivers/of/property.c |  27 ++++---
 include/linux/of.h    | 176 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 189 insertions(+), 151 deletions(-)

-- 
2.30.2

