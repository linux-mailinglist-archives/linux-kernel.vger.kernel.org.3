Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0894A654F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiBAUEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbiBAUD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:03:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB0FC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:03:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l25so34060578wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 12:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkSgioWMLTkoGqDIWLCMutKn9jLySdUQ1z5vlGZxV6U=;
        b=YpXqGIV2xajDvz/AyCf84Z84DIJMY5LWHcF7m1Wl+JNx9uLVn99PhIm02pgkxdNJci
         WQUhQlO5O5TL7tKJJtepsJDxS7TpCxfoW6UjSf7tiiCtlbcon42ptbIyMUEuy+J/BTqU
         U9mtJEm9935C9ygtdwfRa1JKqjOPxCyFYBs5EYb4uf8NHp03nuJC3DW7u55CYxJbbHle
         0YmaEQYu8rGxRJbhJtHJCk9VIpR1sRsnv7jTEggIbYpQkPdXRPQ7Vk1DFtuUuWwmUQN5
         uHSW+rpsKydP6AFn5Rk4HpL0wxv7P9rzbJ7OJvv2f1bHAzGsuCu6H1rHWYDY9mXZpz77
         ZnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkSgioWMLTkoGqDIWLCMutKn9jLySdUQ1z5vlGZxV6U=;
        b=Ro4x8dGHotCWnKCap43ThlasCMbIjI7IclOyuUuzS362emyq1oPcDk9Q9W+R2Tz0R9
         /d/A3fwGsRyKtJ4fjU8ArOfKjxU64ynTW7nD25XIjh2lX+6W7kALQFDvGucBPj0zuAmq
         KxVn5ihkBsYiewB7BjptCiw7D65kLjipxgmnoGE2um3ruf8N1h/Arhqj0/aHolfGbs/H
         FHE/fC0U8NC3mZEqNsy1qt9dRf2JLr709hpT5MZAP0YBYI7yNR4DYsPYBBxWvskmp3Ir
         UEYE55qKA2ywYtP8rXWoWeZBrJVzhBIpLfSciSS5G814tON1fI53Ut6xYZp0YC19ETTq
         xFUg==
X-Gm-Message-State: AOAM531pYS/q0T3ZjX7y++pBXq9xsULeyK+gwK2oZam8OIRMlYaAF4yH
        +46lh2Kf+iUeFf0kx8YPwTVVGg==
X-Google-Smtp-Source: ABdhPJwBVoJ+wrFxx/APcr+nBCT9totWanxEoRnTZs35TqYnQamUL6C8DYh7A9BoM5v+B7XbfZgvvg==
X-Received: by 2002:adf:e6c9:: with SMTP id y9mr23944872wrm.389.1643745836719;
        Tue, 01 Feb 2022 12:03:56 -0800 (PST)
Received: from biernacki.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m6sm3367280wmq.6.2022.02.01.12.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 12:03:56 -0800 (PST)
From:   Radoslaw Biernacki <rad@semihalf.com>
X-Google-Original-From: Radoslaw Biernacki <rad@semihalf.ocm>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        upstream@semihalf.com, Radoslaw Biernacki <rad@semihalf.com>,
        Angela Czubak <acz@semihalf.com>,
        Marek Maslanka <mm@semihalf.com>,
        Radoslaw Biernacki <rad@semihalf.ocm>
Subject: [PATCH v2 0/2] Bluetooth: Fix skb handling in net/bluetooth/mgmt.c
Date:   Tue,  1 Feb 2022 20:03:51 +0000
Message-Id: <20220201200353.1331443-1-rad@semihalf.ocm>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is second version of the fix for skb handling in net/bluetooth/mgmt.c
First patch is fixing the skb allocation which theoretically might push skb
tail beyond its end.
Second patch simplifies operations on eir while using skb.
Patches adds two helper functions to eir.h to align to the goal of
eliminating the necessity of intermediary buffers, which can be achieved
with additional changes done in this spirit.

v1->v2:
 - fix mgmt_device_connected()
 - add eir_skb_put_data() - function for skb handing with eir

Radoslaw Biernacki (2):
  Bluetooth: Fix skb allocation in mgmt_remote_name() &
    mgmt_device_connected()
  Bluetooth: Improve skb handling in mgmt_device_connected()

 net/bluetooth/eir.h  | 20 ++++++++++++++++++++
 net/bluetooth/mgmt.c | 43 ++++++++++++++++---------------------------
 2 files changed, 36 insertions(+), 27 deletions(-)

-- 
2.35.0.rc2.247.g8bbb082509-goog

