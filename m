Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA63472C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhLMMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:30:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231733AbhLMMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639398647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gA3AgJvvaiYoX1ah6MEdVk5UJgjR18BBxBCdJiXQUV8=;
        b=Gk2ueK/sKAOTnX9VCQCm4g+y7qzwfiA6Jhtfq9JP4nTGBgXdTPxdK6Dff30g0rc6qyclKx
        +m2SxKRhGm0B+QoYF1f6YuoQEcnqGDSbTzDKnkv9DJa5NI937nc/ffZYjUc4YClhDrb3po
        I4VZ3Ipk2UNujyHxi3HWH1rqr62gORk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-fvsx7drxP6WxsaAgHZfaug-1; Mon, 13 Dec 2021 07:30:47 -0500
X-MC-Unique: fvsx7drxP6WxsaAgHZfaug-1
Received: by mail-wm1-f69.google.com with SMTP id bg20-20020a05600c3c9400b0033a9300b44bso6420502wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gA3AgJvvaiYoX1ah6MEdVk5UJgjR18BBxBCdJiXQUV8=;
        b=oB2TsouAzwATaFZwNRuqeEhqPgU7Lys5/YPPnST+QReNjvl/AUe1mY4CoZXDmHOWCu
         MbW9EDEaCsVSUK+IR9H39Xm1gddh9xM2H7Upj016lFw2YOPPG9pF3aUq/+WlnZ5R9jM9
         Rp9DyCBd40eo6QQZsC+OzNqhbn3f+FY5ewRlnesekw+CZwoyxrJQcXBuH/+17r98srON
         o9rFFwxbeWaxVfjH6m9X/KXgaEGjts90gS42F9ySK2jI1OtFUCnI1W17gdOqOg7l3qqa
         zrcstUBiXqoYbSgx/I7G6HG6mt9BRRwvnnm5RBj4XWII13HSfQTklyXJ4j3SEkkeceBJ
         stxA==
X-Gm-Message-State: AOAM530M97ZrIc+CcJP9MK0CSCrysshQLyR5bMCG7yWx7ZiKjHF6hTBb
        LzRCC/cTTzFA0DWQ1K79zX0xGFkVJTdktNztUFWp2XBauyQPDTGqt+HWL3l+nZzIRf6eFMWfd4X
        xev2QuDeWovCRY/ZUvmAIZwGZ
X-Received: by 2002:adf:efc9:: with SMTP id i9mr16906642wrp.717.1639398645627;
        Mon, 13 Dec 2021 04:30:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuS2NSrMx5OCpdcSetQ4/rSlNZ1XBSemZCkvJxL+Rv0YnIrcxnV0M7NxDoxvhr0A4pcYBfew==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr16906625wrp.717.1639398645483;
        Mon, 13 Dec 2021 04:30:45 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id h16sm12520056wrm.27.2021.12.13.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 04:30:45 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/3] bcm2835-dt-fixes-2021-12-13
Date:   Mon, 13 Dec 2021 13:30:39 +0100
Message-Id: <20211213123040.184359-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211213123040.184359-1-nsaenzju@redhat.com>
References: <20211213123040.184359-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-fixes-2021-12-13

for you to fetch changes up to 6a56599b5a6b19adb21f8f0d9f2d33511426fb20:

  ARM: dts: gpio-ranges property is now required (2021-12-13 13:06:25 +0100)

----------------------------------------------------------------
A series of devicetree fixes aimed at the Raspberry Pi family of boards:

- Phil Elwell adds gpio-ranges to RPi's main GPIO/PINCTRL driver
- Phil Elwell and Stefan Wahren correct RPi400's GPIO expander's
  labels
- Stefan Wahren drops fallback compatible from RPi2's vchiq devicetree
  node

----------------------------------------------------------------
Phil Elwell (2):
      ARM: dts: bcm2711-rpi-400: Fix GPIO expander labels
      ARM: dts: gpio-ranges property is now required

Stefan Wahren (1):
      ARM: dts: bcm283x: Drop fallback compatible for vchiq

 arch/arm/boot/dts/bcm2711-rpi-400.dts | 4 ++--
 arch/arm/boot/dts/bcm2711.dtsi        | 2 ++
 arch/arm/boot/dts/bcm2836-rpi.dtsi    | 2 +-
 arch/arm/boot/dts/bcm283x.dtsi        | 2 ++
 4 files changed, 7 insertions(+), 3 deletions(-)

