Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF17576C37
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiGPGaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiGPGap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:30:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9AC2613B;
        Fri, 15 Jul 2022 23:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04FC0B82F58;
        Sat, 16 Jul 2022 06:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68A7C34114;
        Sat, 16 Jul 2022 06:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657953021;
        bh=r3+JrXfBZrFAY4j0cj0Q56TypWvWJxqZKmhO3Hyv+1o=;
        h=From:To:Cc:Subject:Date:From;
        b=u9gJDtN/eXujzyCiOkQaZ4nJ+/b5+efR3M2nQNpZ1lLka6i2YDSrDJ1DW66M9BNyU
         znvdqznGOt+l6fZc6EwrpFIaqy+8M/IPiR+PuJYZqvFU5QCB15Osa+62d3dPq/vJcQ
         qdbkq4HEKEQEkG5MffNHsPKCWCMsuB6xzGbW6tvIHuIy3s8BaowzLDeVYhBP8vl08F
         /e/BuWlCb1WOiRRIUhJq70d5hHF+mFuDz5jaet+EhQImn1u+5dGF3LeUd6GWmCxe2Y
         QAxoaZYUSMFUA+9wyqMreIfdYpR/WRXPTU3bOHzfNpJWmPMNqxpTBVc57Apf+ierOs
         Bccxs52qFvUCw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld " <Jason@zx2c4.com>
Subject: [PATCH v2 0/3] crypto: lib - create utils module
Date:   Fri, 15 Jul 2022 23:29:17 -0700
Message-Id: <20220716062920.210381-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a utils module in lib/crypto/, and move __crypto_memneq,
__crypto_xor, and crypto_simd_disabled_for_test into it.

This supersedes "crypto: xor - move __crypto_xor into lib/"
(https://lore.kernel.org/linux-crypto/20220709215453.262237-1-ebiggers@kernel.org/T/#u).

Eric Biggers (3):
  crypto: lib - create utils module and move __crypto_memneq into it
  crypto: lib - move __crypto_xor into utils
  crypto: lib - move crypto_simd_disabled_for_test into utils

 crypto/Kconfig            |  2 +-
 crypto/algapi.c           | 77 ---------------------------------
 lib/Kconfig               |  3 --
 lib/Makefile              |  1 -
 lib/crypto/Kconfig        |  8 ++--
 lib/crypto/Makefile       |  3 ++
 lib/{ => crypto}/memneq.c |  0
 lib/crypto/utils.c        | 91 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 100 insertions(+), 85 deletions(-)
 rename lib/{ => crypto}/memneq.c (100%)
 create mode 100644 lib/crypto/utils.c


base-commit: ec8f7f4821d5e70d71601519bc2325b311324a96
-- 
2.37.0

