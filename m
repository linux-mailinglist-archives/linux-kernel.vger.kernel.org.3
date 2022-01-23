Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55937497081
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 08:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiAWHjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 02:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiAWHjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 02:39:01 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86627C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 23:39:01 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id i1so2963646pla.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 23:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uhRfBYr+QspbVT8yLaJrPUXP2Z6/BOSZ8fDX9dfoTa4=;
        b=Qo1CRKU0nmS3Z+DuG+KK6MQE0+MsHldMbHb0EM2b0eu0z7cJ3RJ3j7xZBcy901s0CB
         nxv7hm5WqYedXjS6YN+4DaW6licZCrGNj1QnPCgUQvJhvpVTNUocRAU87Twx02jDZlOc
         Y5cCytgPA2K0T5VXvnOW87RPcormIA/0j6YUSe5baikRp1NgV7rQ3RgbMTbRX5a87X39
         7iTiFPL+P2eX3Sk/GrlyVNdZ3RIsnEbEq0tdB/WaFxV0L2Hz52vjvVrBXktDU7EutcZE
         RGG4kaX3NExkqieFZ0zHx4r+eiVJcOvC961yV7qzpaDN1G43CLPKUDpWUYE3EaHzvzTW
         N+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uhRfBYr+QspbVT8yLaJrPUXP2Z6/BOSZ8fDX9dfoTa4=;
        b=OS4rIOe+6aGjU0FhVdWgP+lrRc0nCfkYBOTyQpaCxRm+H6Uk9c4WPgOIasxyNSluWF
         oq2tHgLdNFsUc42bKt7XYYe9SX2/1jAerdcR522UzE9HaEUVIN7vki4Q6noQSs2C44G0
         UX0YyoVzi65iPpCYvYcey9eydXFYLFcYs512U/nodO3j4iAoqIg214kAs9onK7lpWx1z
         y2V4CfFaTIrOvP8Y6JjqClvwZ5m8nsPhrodQWQZbXWj/A8GF9hOnaCizaAI/oLK8Q/Z8
         wZcTFvWK+bosKP84Tn4Lrgyt/2WNQY5n8/bT7CviOTjaBLeD9eE6Ue6c1pojvA4JCJOk
         fLIQ==
X-Gm-Message-State: AOAM531499I/EItLHtGn3obBjBX1GUVdyD1LMRAijcwGeCQYwWGnIOma
        bRCEOMXlI5ZEejOYoKpYvXk=
X-Google-Smtp-Source: ABdhPJyJPbInC92Cnl9KOmoACPzxsCxjYf9t+u3So/gmoRz8o6odpR+nXdj3dCD0J8YFcYsI/U/Rag==
X-Received: by 2002:a17:90a:e541:: with SMTP id ei1mr7840048pjb.91.1642923540933;
        Sat, 22 Jan 2022 23:39:00 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id n2sm8878979pga.39.2022.01.22.23.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 23:39:00 -0800 (PST)
Date:   Sun, 23 Jan 2022 20:38:55 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: pi433: add debugfs interface
Message-ID: <20220123073855.GA79453@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When troubleshooting RF applications, one of the most common approaches is to
ensure that both sides of the communication path are using the same 
configuration such as bit rate, frequency deviation, encryption key, sync words
and so on.

The existing driver implementation doesn't allow the user to see which values
have been configured onto the uC which makes trobleshooting more painful than
it needs to be.

This patchset adds debugfs interface to this driver and exposes a read-only
access to uC reg values to address that problem.

Patch dependency:

This series depend on these patches as they change the same set of files:

- https://lore.kernel.org/lkml/20220108212728.GA7784@mail.google.com/
- https://lore.kernel.org/lkml/20220114221643.GA7843@mail.google.com/ 
- https://lore.kernel.org/lkml/20220118230312.GA4826@mail.google.com/

Paulo Miguel Almeida (2):
  staging: pi433: add missing register contants
  staging: pi433: add debugfs interface

 drivers/staging/pi433/Kconfig          |  2 +-
 drivers/staging/pi433/pi433_if.c       | 82 ++++++++++++++++++++++++++
 drivers/staging/pi433/rf69.c           |  2 +-
 drivers/staging/pi433/rf69.h           |  1 +
 drivers/staging/pi433/rf69_registers.h |  2 +
 5 files changed, 87 insertions(+), 2 deletions(-)

-- 
2.25.4

