Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7948E9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbiANMHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiANMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:07:35 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE7C061574;
        Fri, 14 Jan 2022 04:07:34 -0800 (PST)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E8924223E9;
        Fri, 14 Jan 2022 13:07:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642162053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i7KBn4s9MFX2XoUHMEDP/NSqeVw8lCb8KGDUHigUV7A=;
        b=Hn1/N79CWbWwKvxC37ybVZwl7DWsedisR4wLO7KQ9kqO0y4RfBJeRYfD+ZCf4NrNHVfGw/
        yJDU4bJNuo6j/yhPC0lxGHA6Co3dG79c+7afVV4RjfmHZ7KI5+0Ek53vny8zRREtRWre22
        X7THp6lOZz0Ltil8zPWcZ0rKt6MGnQc=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/5] of: base: small cleanups
Date:   Fri, 14 Jan 2022 13:07:18 +0100
Message-Id: <20220114120723.326268-1-michael@walle.cc>
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

Finally, define of_property_read_u{8,16,32,64}_array() unconditionally,
these are the last ones, which were defined static inline and had an empty
stub if CONFIG_OF wasn't set.

[1] https://lore.kernel.org/linux-devicetree/20211228142549.1275412-1-michael@walle.cc/

Michael Walle (5):
  of: base: convert index to unsigned for of_parse_phandle()
  of: base: make small of_parse_phandle() variants static inline
  of: base: add of_parse_phandle_with_optional_args()
  of: property: define of_property_read_u{8,16,32,64}_array()
    unconditionally
  of: property: use unsigned index for of_link_property()

 drivers/of/base.c     | 137 +------------
 drivers/of/property.c |  27 ++-
 include/linux/of.h    | 446 +++++++++++++++++++++++++-----------------
 3 files changed, 294 insertions(+), 316 deletions(-)

-- 
2.30.2

