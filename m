Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4474F126E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355343AbiDDJ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiDDJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:59:21 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9732B3BFA6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:57:24 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 53AEF22246;
        Mon,  4 Apr 2022 11:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649066242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3iRgRdpMfTlBKZhAJTpWmM2V3NADCY9wGlscim215TA=;
        b=cGHy11kgijULBG1tfZNUBvl3TNAy3fNEkBGExX8CUxTujlifgYDEmQlQdsVAdWsxe7WiQv
        rGoDPkC2B5Rs3E1xHdm9XRkDvnCex4wu/oQm/cwNwhxD0kQ6tw4x6iLrDpMno4QGp/H4FD
        GaMH629/DTA+srZq5fLO4HgV0X/4ijA=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RESEND v2 0/7] soc: fsl: guts: cleanups and serial_number support
Date:   Mon,  4 Apr 2022 11:56:02 +0200
Message-Id: <20220404095609.3932782-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend because of new development cycle. Shawn, can this series get
through your tree? Sorry you weren't on CC on the former submissions.]

This series converts the guts driver from a platform driver to just an
core_initcall. The driver itself cannot (or rather should never) be
unloaded because others depends on detecting the current SoC revision
to apply chip errata. Other SoC drivers do it the same way. Overall I
got rid of all the global static variables.

The last patch finally adds unique id support to the guts driver. DT
binding can be found at:
  Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml

changes since v1:
 - call kfree() in error case, thanks Dan
 - add missing of_node_put(np), thanks Dan

Michael Walle (7):
  soc: fsl: guts: machine variable might be unset
  soc: fsl: guts: remove module_exit() and fsl_guts_remove()
  soc: fsl: guts: embed fsl_guts_get_svr() in probe()
  soc: fsl: guts: allocate soc_dev_attr on the heap
  soc: fsl: guts: use of_root instead of own reference
  soc: fsl: guts: drop platform driver
  soc: fsl: guts: add serial_number support

 drivers/soc/fsl/guts.c | 219 ++++++++++++++++++++++-------------------
 1 file changed, 118 insertions(+), 101 deletions(-)

-- 
2.30.2

