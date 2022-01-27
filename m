Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570F749E7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbiA0Qln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:41:43 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:42203 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243874AbiA0Qlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:41:40 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9DC9D22239;
        Thu, 27 Jan 2022 17:41:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643301699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sO/AhngIul0mvC410oF69TOhLnEgY1UA6QAhHQWufqM=;
        b=WWLc8SyCimIFCUDX/NQtjs/Pz9p9HabtdgmUf2M55TY4l4grQSM7aR00U+ZK12sEyRj6d3
        uRIw5PSJWAyJvrI1+rsUWW1T3JlXYHPGFPZYRqKJX+Lp5l6gVCMh8PRf8WkvEHZQeQ2fFq
        Wro6JWr+sKTP85TKYXdXIX+81J76hso=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>
Subject: [PATCH v1 0/7] soc: fsl: guts: cleanups and serial_number support
Date:   Thu, 27 Jan 2022 17:41:18 +0100
Message-Id: <20220127164125.3651285-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts the guts driver from a platform driver to just an
core_initcall. The driver itself cannot (or rather should never) be
unloaded because others depends on detecting the current SoC revision
to apply chip errata. Other SoC drivers do it the same way. Overall I
got rid of all the global static variables.

The last patch finally adds unique id support to the guts driver. But
because the binding for the security fuse processor is still pending,
it is marked as RFC.

Michael Walle (7):
  soc: fsl: guts: machine variable might be unset
  soc: fsl: guts: remove module_exit() and fsl_guts_remove()
  soc: fsl: guts: embed fsl_guts_get_svr() in probe()
  soc: fsl: guts: allocate soc_dev_attr on the heap
  soc: fsl: guts: use of_root instead of own reference
  soc: fsl: guts: drop platform driver
  soc: fsl: guts: add serial_number support

 drivers/soc/fsl/guts.c | 215 ++++++++++++++++++++++-------------------
 1 file changed, 114 insertions(+), 101 deletions(-)

-- 
2.30.2

