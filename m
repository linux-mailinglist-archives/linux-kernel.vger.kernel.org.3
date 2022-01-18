Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE5492C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347391AbiARRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:35:15 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:35639 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiARRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:35:14 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EE72D223ED;
        Tue, 18 Jan 2022 18:35:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642527312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZyFhEK/VvCXOqYM0z8F6xxJ3dnN2fvgvz3jo1293DAY=;
        b=IGFTjLNpJ95roQWKKQLliEpNm3i0GgK36Vc6aPjs9cfrF0+/bKYpwCr1hgwyN8ZhkvS2Tk
        beYzoR+1bciWUnkEqLHUZGMn5trhj5u+2avaOHpdWh8OfvE6TQ3OMK/PqCov3+ancSC5Vc
        LfM0+ZD5tWGZ0CukIiszzfplbzXg93w=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 0/3] of: base: of_parse_phandle() cleanup and new variant
Date:   Tue, 18 Jan 2022 18:35:01 +0100
Message-Id: <20220118173504.2867523-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the smaller variants of of_parse_phandle() to static inline.

It will also introduce a new variant of the function, although it is unused
for now. They will be needed when nvmem phandles are modified to take
additional arguments and need to retain backwards compatibility with older
device trees.

Finally, define of_property_read_u{8,16,32,64}_array() unconditionally,
these are the last ones, which were defined static inline and had an empty
stub if CONFIG_OF wasn't set.

Michael Walle (3):
  of: base: make small of_parse_phandle() variants static inline
  of: property: define of_property_read_u{8,16,32,64}_array()
    unconditionally
  of: base: add of_parse_phandle_with_optional_args()

 drivers/of/base.c  | 128 +------------
 include/linux/of.h | 456 +++++++++++++++++++++++++++------------------
 2 files changed, 284 insertions(+), 300 deletions(-)

-- 
2.30.2

