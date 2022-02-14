Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF794B5649
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356413AbiBNQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:32:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiBNQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:32:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6110B67
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:31:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1FCFECE19D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1275C340E9;
        Mon, 14 Feb 2022 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856310;
        bh=1wqWngPBeYFF/RRK8XYodlEqQYdd8dG1dgq3lciQsFI=;
        h=From:To:Cc:Subject:Date:From;
        b=aJYhgMOW6NITxS+EbwOJG0W2+9K8Y9LGU2lVIgjaR63PLtgEG0hng5Kh7xzOwTk1d
         7OzPTHXHLCQtEaCyVhQC4vR0ALqFSzoAjPz1omjkAoY3EZlSg7JxTy3XWdH5nw0W76
         SkHzB4FYPfkqY+5CgzKq8lOTODrc5DONDFWRkAxmqE+kA0CDagmsdG7XDL2jqqb785
         OruB+RovFUtjRfyznW4Hs6Lc7AjKTA5DmtF02I2gRvHa9Zmb5m9dsVS+km+KZlq9Vx
         23qmQOXMUFsihb9DsJnH8UCMtBKADxGm3jK8lA+zkbPT0BttKOTqyrF+5onFGIhADd
         Gq7uf/PdNhQ8w==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.17-rc4
Date:   Mon, 14 Feb 2022 16:31:42 +0000
Message-Id: <20220214163149.D1275C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b4c18c18ebf7cf1e602af88c12ef9cb0d6e5ce51:

  regulator: MAX20086: add gpio/consumer.h (2022-01-19 16:47:39 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.17-rc4

for you to fetch changes up to 4e2a354e3775870ca823f1fb29bbbffbe11059a6:

  regulator: core: fix false positive in regulator_late_cleanup() (2022-02-08 13:37:48 +0000)

----------------------------------------------------------------
regulator: Fix for v5.17

One fix here, for initialisation of regulators that don't have an
in_enabled() operation which would mainly impact cases where they aren't
otherwise used during early setup for some reason.

----------------------------------------------------------------
Oliver Barta (1):
      regulator: core: fix false positive in regulator_late_cleanup()

 drivers/regulator/core.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)
