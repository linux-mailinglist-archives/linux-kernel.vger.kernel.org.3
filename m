Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15505580413
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiGYSgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiGYSgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:36:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F7512752;
        Mon, 25 Jul 2022 11:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C1560B53;
        Mon, 25 Jul 2022 18:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0CDC341C6;
        Mon, 25 Jul 2022 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658774208;
        bh=Q2XNA0Q1bE5O+9vMB9ZW+aF5lqBS4RBtbxpja9WWAXQ=;
        h=From:To:Cc:Subject:Date:From;
        b=inynRV/otoshGpelSEcLO2DWRH6hjMgjRFX10nNxDu3uNaHLsAK1zdXtgHvI6CxZ5
         4ikaqLMIW84cnQq3YiyymVdbhPIrwBTdwN4Xx4wLLabQ2VJepnwwBmnQQcD3WpiJiy
         UNX4qMxlDKOdd18Fb6nVGWlX+CZVHjCDglTzM1OQce+1EXBiGSk0XYywl0JMeinAuG
         ilLOWg9Hm2KnmB5460J9bNIZfASF8YicNx06crQ0S9V+e50hs9wK9t76h9C0SvB4wk
         rwsf9P7MO9hX4RYbl2uBzm9ZI7FgVSRf2fyXEi9PyNetMbYlo4pWjCvrExiAiXdNkW
         NDJu5NVc5JmpA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld " <Jason@zx2c4.com>
Subject: [PATCH v3 0/3] crypto: lib - create utils module
Date:   Mon, 25 Jul 2022 11:36:33 -0700
Message-Id: <20220725183636.97326-1-ebiggers@kernel.org>
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

Changed v2 => v3:
   - Added missing MODULE_LICENSE
   - Dropped patch "crypto: lib - move crypto_simd_disabled_for_test
     into utils"
   - Added patch "crypto: lib - remove __HAVE_ARCH_CRYPTO_MEMNEQ"

Eric Biggers (3):
  crypto: lib - create utils module and move __crypto_memneq into it
  crypto: lib - move __crypto_xor into utils
  crypto: lib - remove __HAVE_ARCH_CRYPTO_MEMNEQ

 crypto/Kconfig            |  2 +-
 crypto/algapi.c           | 71 -------------------------------
 lib/Kconfig               |  3 --
 lib/Makefile              |  1 -
 lib/crypto/Kconfig        |  8 ++--
 lib/crypto/Makefile       |  3 ++
 lib/{ => crypto}/memneq.c |  7 +---
 lib/crypto/utils.c        | 88 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 99 insertions(+), 84 deletions(-)
 rename lib/{ => crypto}/memneq.c (98%)
 create mode 100644 lib/crypto/utils.c


base-commit: 9d2bb9a74b2877f100637d6ab5685bcd33c69d44
-- 
2.37.0

