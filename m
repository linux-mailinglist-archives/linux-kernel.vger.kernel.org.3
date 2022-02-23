Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795E84C1918
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243037AbiBWQyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiBWQyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:54:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FFE49681;
        Wed, 23 Feb 2022 08:54:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EA79B820F8;
        Wed, 23 Feb 2022 16:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7409DC340E7;
        Wed, 23 Feb 2022 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645635260;
        bh=dX+EwgQhKbQ1b86T1pA6/pdpuPolNYCq5ZQnp2NuDEU=;
        h=From:To:Cc:Subject:Date:From;
        b=kiF/9dFXS2DYVN+VDbMxDjiPhYtv5JX3inXe0JsJH2Wx/rGWLL8NDyuietpoSauQX
         MtNxxo43Z4xDJ3uhuZfao1mOVVXS0ij+mZAxibAMKS1IO6xmDCbTv80FEBg1v80gDf
         eWFs33gF1MQ48FLFhK11zZ2GhkKIU38YLG49sZ7cPpaFONXS2XjiLCxpizf6vuIDut
         gIg2pjBARN32A2iayjbzZmlnAHkJWBJ3Tz1Fj0gl3lrTw2AhicxbJQNSleewhm2b9d
         u3e1O5eqO9BVmsNABQNJsS+BkxwUe5glV4YgfkUQWz7OH+aJy8l0JK9H4W5REGPaLT
         BMMn+aC5wNxTg==
From:   broonie@kernel.org
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mfd tree
Date:   Wed, 23 Feb 2022 16:54:16 +0000
Message-Id: <20220223165416.2359767-1-broonie@kernel.org>
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

After merging the mfd tree, today's linux-next build (KCONFIG_NAME)
failed like this:

/tmp/next/build/drivers/mfd/sprd-sc27xx-spi.c:255:35: error: redefinition of 'sprd_pmic_spi_ids'
  255 | static const struct spi_device_id sprd_pmic_spi_ids[] = {
      |                                   ^~~~~~~~~~~~~~~~~
/tmp/next/build/drivers/mfd/sprd-sc27xx-spi.c:242:35: note: previous definition of 'sprd_pmic_spi_ids' was here
  242 | static const struct spi_device_id sprd_pmic_spi_ids[] = {
      |                                   ^~~~~~~~~~~~~~~~~

Caused by commit

  6fc90b92e9c7ef348 ("mfd: sprd: Add SPI device ID table")

I used the MFD tree from yesterday instead.
