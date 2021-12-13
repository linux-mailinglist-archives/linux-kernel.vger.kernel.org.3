Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41406472C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhLMMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:30:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231502AbhLMMar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639398647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rFseXIPz1IYUI6GVR/tsU1fEMIKeguRcL2+NPoTLos8=;
        b=VsbmMurj7dzHviwr4YruXDYIaW3y9A6wYOTx5VyhtjbYzZewo2TbKNmWKPjowaO47BI9KX
        F7x9P26EnyqMXR+AlXkKGtu8wTa2AXxnPTDa+qYhLpfPRVimBjdTChe9v8JjLXi0n8Eqzl
        Iqo6+BtxmjID8r/8Vs1K0pIq8KXy1Vg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-IvsLE_xTPBCQHqLircDzMA-1; Mon, 13 Dec 2021 07:30:46 -0500
X-MC-Unique: IvsLE_xTPBCQHqLircDzMA-1
Received: by mail-wm1-f72.google.com with SMTP id o17-20020a05600c511100b00343141e2a16so3522842wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFseXIPz1IYUI6GVR/tsU1fEMIKeguRcL2+NPoTLos8=;
        b=dedIq7jGHBsKDtmnzf/pvGm7Wwel88JTN4W40nIZAjuT4NR5TNr7vKw8e7Jpu0mJZM
         KxHLORgE60+zcWhfMrp+Wizrt1aX3iFCYppw8ilDZFte7yZEOVly1K+8gVpzGxN21/iX
         34lEoMT26FVpf89VAXO1z6+xPPGudftOOYqnZdqXCcabQ0L/5F5rgJyG6xcVirSA4dQM
         5qBJQ8x7Bx8jJpsjNBTMJhB93loNDRGOxw/XJ7v52w2NAH1Gm5mcoVkEsBFCpkNK4OJ0
         XGqwRnlIbLPdPIor++lQv8mHWPfbKG5GJI/lsWImyUR48WUOyqpGUTitpcznzIIgRcPH
         EVtg==
X-Gm-Message-State: AOAM530akWlWknMA2H2j8BByD821WarA7g9hoq5f8ctOB8IFxlzQND/Q
        PeF1xz+xPWsTgw0Q+VV6R5nOVHTawErbUi4I0ttO3yoZdli7M2v9EcjyXEqptYvxcB2rkIlMlX+
        hzMQNW0onPbaLd3OHXGyeJMbo
X-Received: by 2002:adf:c843:: with SMTP id e3mr12588546wrh.38.1639398644928;
        Mon, 13 Dec 2021 04:30:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyugIvHuLr1KneHTcenhUSGA0C2rTtCv2LMRa36IG+SIi8kKvVUdU6tJv9lHJIKxXCnmgndXQ==
X-Received: by 2002:adf:c843:: with SMTP id e3mr12588530wrh.38.1639398644768;
        Mon, 13 Dec 2021 04:30:44 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id h16sm12520056wrm.27.2021.12.13.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 04:30:44 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/3] bcm2835-dt-next-2021-12-13
Date:   Mon, 13 Dec 2021 13:30:38 +0100
Message-Id: <20211213123040.184359-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-12-13

for you to fetch changes up to 5e8c1bf1a0a5c728cee2b6c2162348a9dfddf1bf:

  ARM: dts: bcm2711-rpi-4-b: Add gpio offsets to line name array (2021-12-13 13:08:04 +0100)

----------------------------------------------------------------
Uwe Kleine-König adds offsets to GPIO line names array for better
readability.

----------------------------------------------------------------
Uwe Kleine-König (1):
      ARM: dts: bcm2711-rpi-4-b: Add gpio offsets to line name array

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

