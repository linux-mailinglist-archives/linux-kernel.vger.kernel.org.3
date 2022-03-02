Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F156D4CAE9F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiCBT0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiCBT0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:26:12 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77756C1176
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:25:28 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4FA453F5F2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646249127;
        bh=yRTE0dXDieeLqipRcJqUM5emUc5L/qHhnbBmseJ0BJU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Jv2RtizdGwinP2qfowNk4Ywy1N3i4Q4KpqSWNcUHHCciU02rQOh9NRJcy8qabHJbu
         qxG2x5iyQ3gMWu/hbhRHljUJihGRtXzGqU5ZAunqmi712EbU+QrAkVL0Oh2PhVwtcK
         nlEbUkjk1aHXjgzU7rLDsNAVATum8MPAX6jJnfDl410OrIJ0tECM1CF2OvtvA8GGi4
         2cgL/nNnH814updnzNUpNqf/bFFMvcoj7gx0ngvb0CbXcY+hVXfwHC8TUtVzFRuSIo
         uS08M5U2JeamZcKlj7zOtu79Hn+Bbo8fd5KipX7N1g5I3Wn82EViIZMLYFNBeWlrrn
         PZPsvqiaNOqaQ==
Received: by mail-ej1-f72.google.com with SMTP id hc39-20020a17090716a700b006ce88cf89dfso1490834ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRTE0dXDieeLqipRcJqUM5emUc5L/qHhnbBmseJ0BJU=;
        b=z0LzWrEFniyuv7T7FojL4MgLERY2xea3tUiE1jlTMqv3FTGM+85GSB+RH1FfUxpWhy
         00divoY6KjlRw2sC/vW9P+bF1d0Zh+fREvyiRjZYzbPPpRnMmLZdYiSK0t5W1UMJnG4R
         kvrbFiFSO6i00l3sSkRdkqnqrN41wq7kbO0qWoCXxEe3SM9IacG3x9RY/HRwCI+NDZ6w
         3qK9kfBjq7H3Ul44Ly8H0dK41/mQGrUflQE923DvHSxJJsGpAirTCkfVb3YzYmLF0cgJ
         7fq8dM2S1o+N+K3/ueAqC2+keIdWo1HKmQBlaon8a+FdBWzD9ockSKj8b2J0Cu2CTJfY
         UGfA==
X-Gm-Message-State: AOAM530Y0VgE9hKSWVu8UXNDi/anV4VsbCoroUISdzwvOmMsaBDVpIbh
        wBaVGny+vInTFzTwI4GzyGypQ6NwVEH6vC5SVDCKqV0D/nimeYilhKUUpN9q4KJweXEpw63s229
        kPZDaU5N3nB4uTGaYRm6g3Rq9y3+w19ZZ2/LnBgGhiQ==
X-Received: by 2002:a17:906:d964:b0:6ca:4019:3928 with SMTP id rp4-20020a170906d96400b006ca40193928mr24495907ejb.762.1646249127009;
        Wed, 02 Mar 2022 11:25:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymNIa6tXZ6VSjhto2ZRHEvmJFRAiiKkV9BB4bSPd2kVGliWkPAB8/SjWMA+lWclcfMKx3gNA==
X-Received: by 2002:a17:906:d964:b0:6ca:4019:3928 with SMTP id rp4-20020a170906d96400b006ca40193928mr24495893ejb.762.1646249126792;
        Wed, 02 Mar 2022 11:25:26 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b00415b0730921sm1482765edk.42.2022.03.02.11.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:25:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 0/6] nfc: llcp: few cleanups/improvements
Date:   Wed,  2 Mar 2022 20:25:17 +0100
Message-Id: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are improvements, not fixing any experienced issue, just looking correct
to me from the code point of view.

Changes since v1
================
1. Split from the fix.

Testing
=======
Under QEMU only. The NFC/LLCP code was not really tested on a device.

Best regards,
Krzysztof

Krzysztof Kozlowski (6):
  nfc: llcp: nullify llcp_sock->dev on connect() error paths
  nfc: llcp: simplify llcp_sock_connect() error paths
  nfc: llcp: use centralized exiting of bind on errors
  nfc: llcp: use test_bit()
  nfc: llcp: protect nfc_llcp_sock_unlink() calls
  nfc: llcp: Revert "NFC: Keep socket alive until the DISC PDU is
    actually sent"

 net/nfc/llcp.h      |  1 -
 net/nfc/llcp_core.c |  9 +--------
 net/nfc/llcp_sock.c | 49 ++++++++++++++++++++++-----------------------
 3 files changed, 25 insertions(+), 34 deletions(-)

-- 
2.32.0

