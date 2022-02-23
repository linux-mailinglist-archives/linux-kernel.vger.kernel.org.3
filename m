Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521BC4C1D86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242297AbiBWVRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiBWVRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:17:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A87389D;
        Wed, 23 Feb 2022 13:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864036146A;
        Wed, 23 Feb 2022 21:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A197C340E7;
        Wed, 23 Feb 2022 21:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645650991;
        bh=dVA6FsrIZlXDxX3UZou79kyBWx4acf0DRXX9Let5EH8=;
        h=From:To:Cc:Subject:Date:From;
        b=JLbz/v9T2QJXXvhKj0K6W4QNfAAm9gxg7LWW9yNO27URW31r6ua/ggSlMq8DzQDVk
         7bbSHahJTEPXb7D8QpCpDW53bc/RBflPW2Mo4Krg6TLQIUJcC6k2ki3CfnFnB6j6V4
         rhljCKg53W+2yHpM74Wo0LRrbs1dEZfWROE1BqAkeBQEq0ARUrvt82k3RcxbfYwpJ0
         tQ+d9DsNfZ8GuyoQV2kAPplrA6Lm/iEp7NwIzv+gapdYA57Mnp8Md8KADUvuzqjjYq
         IN1GkwpJuxj3j15xYUKrQ8K5cywPPgs93CI2n2OF+CYTVLkc4V4f0kKKo6NbA9ljO7
         ihMvMbZuganag==
From:   broonie@kernel.org
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Li-hao Kuo <lhjeff911@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Vincent Shih <vincent.sunplus@gmail.com>
Subject: linux-next: manual merge of the nvmem tree with the spi tree
Date:   Wed, 23 Feb 2022 21:16:27 +0000
Message-Id: <20220223211627.123208-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the nvmem tree got a conflict in:

  MAINTAINERS

between commits:

  f62ca4e2a8630 ("spi: Add spi driver for Sunplus SP7021")
  a708078eeb992 ("spi: Add Sunplus SP7021 schema")

from the spi tree and commit:

  5293c629db958 ("nvmem: Add driver for OCOTP in Sunplus SP7021")

from the nvmem tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc MAINTAINERS
index 3746d28eb5f41,507697a118385..0000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -18717,13 -18491,12 +18717,19 @@@ S:	Maintaine
  F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
  F:	drivers/rtc/rtc-sunplus.c
  
 +SUNPLUS SPI CONTROLLER INTERFACE DRIVER
 +M:	Li-hao Kuo <lhjeff911@gmail.com>
 +L:	linux-spi@vger.kernel.org
 +S:	Maintained
 +F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 +F:	drivers/spi/spi-sunplus-sp7021.c
 +
+ SUNPLUS OCOTP DRIVER
+ M:	Vincent Shih <vincent.sunplus@gmail.com>
+ S:	Maintained
+ F:	Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
+ F:	drivers/nvmem/sunplus-ocotp.c
+ 
  SUPERH
  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
  M:	Rich Felker <dalias@libc.org>
