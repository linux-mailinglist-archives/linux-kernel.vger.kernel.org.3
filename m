Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C3463628
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhK3ONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:13:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44098 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhK3ONt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:13:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D7BDC1FD59;
        Tue, 30 Nov 2021 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638281429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=y13oGE/G5z9IyZ2aIbGAGGOs7EOkZYcay6xqoffhj9k=;
        b=xwteTzbwji8LovS9QRug0Hn7nY2hYXOS2DaA0+ix0XrIUehSuZdpHYZUHAnPSpC2LDZcBF
        oEZX32l6xuyuiIa56DkyRYtWU+JZP3eFzObIMDqgoxfKjqR1aRQRBjCHyKOyPZZGEBjqrf
        vR4gJfTSfxaKPz5wOWrKDEbZnFNrfSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638281429;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=y13oGE/G5z9IyZ2aIbGAGGOs7EOkZYcay6xqoffhj9k=;
        b=mYR0lFWiDayu8FWGv+jdpECbqSBGLorZp2uFxQ53E6N0CekUSD0R5bsZF5GuPPg81iEWyx
        f/WO7TNnZypoRmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7F6B13FAD;
        Tue, 30 Nov 2021 14:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RM3gK9UwpmFcLgAAMHmgww
        (envelope-from <nstange@suse.de>); Tue, 30 Nov 2021 14:10:29 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 0/3] crypto: jitterentropy - bound collection loop
Date:   Tue, 30 Nov 2021 15:10:06 +0100
Message-Id: <20211130141009.6791-1-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the sampling loop in jent_gen_entropy() can potentially run indefinitely
w/o making any forward progress, namely if only stuck samples are taken
for whatever reason.

There's a straight-forward way to make the entropy collection more robust,
namely to terminate the loop and report an error if this happens. This
patchset here implements that.

Applies to herbert/cryptodev-2.6.git master.

Thanks!

Nicolai

Nicolai Stange (3):
  crypto: drbg - ignore jitterentropy errors if not in FIPS mode
  crypto: jitter - don't limit ->health_failure check to FIPS mode
  crypto: jitter - quit sample collection loop upon RCT failure

 crypto/drbg.c                | 7 +++++--
 crypto/jitterentropy-kcapi.c | 6 ------
 crypto/jitterentropy.c       | 6 +-----
 crypto/jitterentropy.h       | 1 -
 4 files changed, 6 insertions(+), 14 deletions(-)

-- 
2.26.2

