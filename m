Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02E4FC02E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347792AbiDKPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347729AbiDKPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:18:53 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905123204B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:16:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 86C6380271F;
        Mon, 11 Apr 2022 15:16:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 833F480244E;
        Mon, 11 Apr 2022 15:16:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649690193; a=rsa-sha256;
        cv=none;
        b=pjDYzEQoC7wxatNr4z68ngYNEKdR2E73wUrRJI4MhcKiuB5YgMN+hvUyWsRbosfvZo8ewF
        +D/8BZtaEZxj+wJpOfrYLmiqOTqby2oiUR/53ui8C1kySqeLbTtCSoNHssipKQ9DHTbvXw
        oeofk0vvcfjWvZ11L09LA5rmjFBG5aM6NRehb2kJbsNZaGE+jmmY96PrPAZBrJqKfEpNBd
        OKmt6nPGvywRlGncHyl2v6qzDrRbg99UVDx1fwP3IaXWKsSpyh6XV0lCeTUjaqjs3Dx+tV
        FN+/pm5kORG4h5yHzo2E1hYj2XYqDLtYiua85IB6K2+OZW/KzN4S+i1CGNLAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649690193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=u/Daua8zVIDUkH/aA9SNGA5WhmllLNHpY2jDyAUBpVg=;
        b=6s3LbdtTQbukBVFeOIKreN2p8SLPcByryeRPh1wVZQrVxjx8RKdGXM5ZEuhNIlQN863BfD
        qUgLKcJOJiWIFPoY7fCfLq0lBSoHNnvIVEXpmCJINPws7/dza3g++NS4H/i6JUo4uYKRr5
        IgjSvqPfnuxQbYeTw+L7bv/wrYsYUgRncsJCEbwZGNy+RsV7H5vmnW3QgLtocrlx927Cib
        EpyAnQxFVJ7wtpexZOBVtc+jMYAdpALMkn56vzdXELPgv1H9PDceofuUEoxViaXDQdVhXc
        a0lEWcUZye1+myjXHARmiIAtz+W6x0II2wUJxi+5uTL3zcFCBlACOU/kAXdwCw==
ARC-Authentication-Results: i=1;
        rspamd-68f9d8f9d5-ttzsm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.239 (trex/6.7.1);
        Mon, 11 Apr 2022 15:16:35 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Callous-Cold: 0d8fe7c25af736a0_1649690193873_275467051
X-MC-Loop-Signature: 1649690193873:3141922433
X-MC-Ingress-Time: 1649690193872
Received: from localhost.localdomain (unknown [104.36.29.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4KcXWJ6976z1H;
        Mon, 11 Apr 2022 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649690189;
        bh=u/Daua8zVIDUkH/aA9SNGA5WhmllLNHpY2jDyAUBpVg=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=dpRoAD7XMiEtKiRbyQP8Fqvq3W/jl4UUvb1VeqlmnB+Qq3tj83y0SRikUPZsfN+s8
         YXbF13xqHtO//1jK9QTQRShr1p5OPeGkdd0jRro6MqQLmiSRruSEUfjPbDHPf5mAlA
         5P4LKjboNY4ZZPPGsnW2TDf7AJCKz9FV6G2J1OLfW/pELqvgFG0gsh2bZ1Vr06u2mN
         2K2Z7utfuobrSYvfr6xAPxQ++NoCUVm4Uh5gXS+RJn4Y2/ZBzevB2JusDdLf8oZqlj
         CyId2q7UURcCP5XXpNhU+k/YFicZbyBi1U7kDZUnjxaYM3ffnEJERrL5bSRg2W4t69
         3bZraeBgoe3CA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 0/6] staging: Some tasklet removals
Date:   Mon, 11 Apr 2022 08:16:14 -0700
Message-Id: <20220411151620.129178-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following are patches to further remove tasklet users out of
staging (none of such drivers at this point should continue using
these for async work). More complex users remain, which will be dealt
with in future patches. Compile-tested only.

Thanks!

Davidlohr Bueso (6):
  staging/most, dim2: convert dim2_tasklet to threaded irq
  staging/wlan-ng, prism2usb: replace reaper_bh tasklet with work
  staging/wlan-ng, prism2usb: replace completion_bh tasklet with work
  staging/ks7010: replace SME taslet with work
  staging/rtl8712: remove event_tasklet
  staging/rtl8192e,ieee80211: replace ps tasklet with work

 drivers/staging/ks7010/ks_hostif.c            | 21 ++++++------
 drivers/staging/ks7010/ks_wlan.h              |  2 +-
 drivers/staging/most/dim2/dim2.c              | 29 +++++-----------
 drivers/staging/rtl8192e/rtllib.h             |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c          |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c     | 12 ++++---
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  2 +-
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 15 ++++----
 drivers/staging/rtl8712/rtl871x_cmd.h         |  1 -
 drivers/staging/wlan-ng/hfa384x.h             |  4 +--
 drivers/staging/wlan-ng/hfa384x_usb.c         | 34 +++++++++----------
 drivers/staging/wlan-ng/prism2usb.c           |  8 ++---
 12 files changed, 63 insertions(+), 69 deletions(-)

--
2.26.2

