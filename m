Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45679585E5A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 11:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiGaJyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 05:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiGaJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 05:54:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6B21208F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 02:54:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54A623850E;
        Sun, 31 Jul 2022 09:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659261279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3BGFuTfz4lvoQEfxhAy6e7CZviTPVvslLVpsW9hoKy4=;
        b=tsWJ9v0JoiKj8t9T+tbC/yRoVpHhNXO+uj/9ZK7dQX5SH04TJyhbyukNYCwCx4WPuJ5Mgi
        jayneb/NlykkwQJig3hvokExE1BpZmWnWwm4/sC7vOwct4ZbswLTjV6PJ7cZR+Z5Xb0AoH
        Z1+r4QtYYaLMu3OoYBiuZNbzkDEFjmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659261279;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3BGFuTfz4lvoQEfxhAy6e7CZviTPVvslLVpsW9hoKy4=;
        b=CCS87rbJe99xwvWTBTz5SFWoipqN/Wp0iGNcOa30OZTdqXLiNE+q+r5QlrJSMHagcVgWdE
        MrSrsh7+BjVZXpAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48AD913416;
        Sun, 31 Jul 2022 09:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z0iwEV9R5mKbMQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 31 Jul 2022 09:54:39 +0000
Date:   Sun, 31 Jul 2022 11:54:34 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for 5.19
Message-ID: <YuZRWvbk4msK+M1p@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one last-minute rwsem locking fix for 5.19.

Thx.

---

The following changes since commit e0dccc3b76fb35bb257b4118367a883073d7390e:

  Linux 5.19-rc8 (2022-07-24 13:26:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.19

for you to fetch changes up to 6eebd5fb20838f5971ba17df9f55cc4f84a31053:

  locking/rwsem: Allow slowpath writer to ignore handoff bit if not set by first waiter (2022-07-30 10:58:28 +0200)

----------------------------------------------------------------
- Avoid rwsem lockups in certain situations when handling the handoff bit

----------------------------------------------------------------
Waiman Long (1):
      locking/rwsem: Allow slowpath writer to ignore handoff bit if not set by first waiter

 kernel/locking/rwsem.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
