Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC53B4AA81A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379401AbiBEKfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:35:15 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:58140 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiBEKfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:35:12 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 867B62010EB;
        Sat,  5 Feb 2022 10:35:10 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id A198680719; Sat,  5 Feb 2022 11:35:05 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 0/2] random: fix write locking for crng_init
Date:   Sat,  5 Feb 2022 11:34:56 +0100
Message-Id: <20220205103458.133386-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to a comment in random.c, crng_init is protected by
primary_crng->lock. These two patches fix the locking for
writing tp (that is: increasing) crng_init in call sites where it
may matter. At rand_initialize() time (precisely: either in
crng_initialize_primary() or in crng_finalize_init()), crng_init
is set to 2 without the lock being held. However, then the
kernel is running with IRQs disabled and only the boot CPU
active (but not yet in PID 1).

Dominik Brodowski (2):
  random: fix locking in crng_fast_load()
  random: fix locking for crng_init in crng_reseed()

 drivers/char/random.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.35.1

