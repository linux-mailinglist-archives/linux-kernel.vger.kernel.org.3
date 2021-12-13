Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988B7472C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbhLMMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:30:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235068AbhLMMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639398649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLYI0WALRsCu7UB/YxQlYwQ/KGlU7bHXWe3IZrBaLYQ=;
        b=X1RaGgqYLvS9dyrfOQiPPlgy1R7jPMEofLCgMp+PjDPAQwlwQJHyqd1MY0zdQ3QRNHbu1l
        zqUldGtyKQtSpaxrpCw7/F12cQ4KGmkhQ3ufZg5v5wAjuI11bUPpLcpfIcifSBCxIRx2rn
        dRePjr+EkApV9Qjp411sRnhmdG1uwOo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-X0ExgIZtM2iRrVCz_XqNSg-1; Mon, 13 Dec 2021 07:30:48 -0500
X-MC-Unique: X0ExgIZtM2iRrVCz_XqNSg-1
Received: by mail-wr1-f69.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so3811334wro.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLYI0WALRsCu7UB/YxQlYwQ/KGlU7bHXWe3IZrBaLYQ=;
        b=pXwV26qvHI5o1TyfsRid5KXfPBTj5phE2aVksralF6oLSL1Zxh1AfdPb4hcb/tfkVU
         tfBYCb2L/1rpRRNxJjSlhonbyekyIuKJLauCKV3wO4eMaXOGmujGsc7gjK/L9E4zL5uB
         5TOV3KNpPbhQ1gobaXO9ArRvx59qcf6ble8GrlvZLmqYbZT4WoMny6onQWXWWwAoZ2MT
         owHqkuBGHYZqiwGRSUCKs1cVqIH82V00cvmxEjwIq7F1RnZ+eOL5fc+m3JKZaMWC9kXh
         t5De5BSDD65H8P6VSAhnuYokue5Co2CT5F+ClFvGUOw0HWOeRxuj1l0DFnU9RLLPiU7i
         Z/ZA==
X-Gm-Message-State: AOAM533i/lT2M+KODakD00S9+QCxwgxJzJTbPMA6l6LOV3Hm4CJwowRj
        1v4Eygb1winm/++waiOGVxF8m91gz2rpD8ZvlBe2who0YB4ib8quLFEulsve82cx9qsLmg4kpXr
        C7qFteDtTsNIVUlxmBTzLlC0U
X-Received: by 2002:adf:cd04:: with SMTP id w4mr31967235wrm.406.1639398646445;
        Mon, 13 Dec 2021 04:30:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyK+NRoauEABkz1zDu2VymchJ5ebjqVhRNSTBcnqZyI7wVpws1hvmdyC0zMJtnWbyaYOkJisw==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr31967211wrm.406.1639398646271;
        Mon, 13 Dec 2021 04:30:46 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id h16sm12520056wrm.27.2021.12.13.04.30.45
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
Subject: [GIT PULL 3/3] bcm2835-bindings-2021-12-13
Date:   Mon, 13 Dec 2021 13:30:40 +0100
Message-Id: <20211213123040.184359-3-nsaenzju@redhat.com>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-bindings-2021-12-13

for you to fetch changes up to 4e5be177f6d2545dd639f41138af3b138470c61d:

  dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to json-schema (2021-12-13 13:10:11 +0100)

----------------------------------------------------------------
Stefan Wahren converts VCHIQ's bindings to YAML format.

----------------------------------------------------------------
Stefan Wahren (1):
      dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to json-schema

 .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 17 --------
 .../bindings/soc/bcm/brcm,bcm2835-vchiq.yaml       | 45 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml

