Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9917484243
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiADNUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiADNUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:20:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F434C061785
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:20:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q14so140617326edi.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 05:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/GkwF7Da5XIamKReKsj0HsZhSVJSApc2Gxuc5P0F58=;
        b=Orcz1Ulcpgxql5P3geTM4KS23mA4oqud5iffrm073yQbrJxGUBcEMP5qDl5yBdDLQI
         AkkRJeK0J2hxjMSkDJ/LI0n8tZaXDcEU8IsmptJNOyU/nfjPGY6b6EPr6vi/WVV7vlPW
         dcqTdvgIn4kjdLIVjHudOJWHuI2jvgO4PwYlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/GkwF7Da5XIamKReKsj0HsZhSVJSApc2Gxuc5P0F58=;
        b=RDabmBujki5pgYmrd5Wganx+fW4vyyDIscPejTjZ/HFo5l12EhxkhiwQI5unvrJLLl
         mZ3EOSIk/khbumrx+kMHx8ZmK8w9fmEDFhg9R9dd8Jcm0Y26+s/mYehpc9AjGB6++s2x
         kgVviYTNdzegaPRy/5cgyo2u1HIY+ekrMuM+cVE1dwocQqmOw7KX9DmRUTIVPJ3sQ0qs
         VIrwMeoQRWze/C4T1SEunP0UB5zT0T3BKlIcrEwSEBjP1B0P+/+egjgrzpU7Y7M7mJM3
         RQsXV7NJbwkzyYdddmsvLvt1CUUU1FRQXvGzN0mPwCR8BvWBarNjSBsuNKSlrPAinb75
         wUFw==
X-Gm-Message-State: AOAM53360/fdTdzSyCT5mQT66jEK9NyTNVamzp+rsdeFQYc9I6nYrnWl
        sGtrZn+dJYtOAFC0TUaM9e9LY5BzK2tBqw==
X-Google-Smtp-Source: ABdhPJyJMtxLvzivI2st83HvXyyfiTOFhY2WMHimu9EkqSxFO2LU/qKMIFCwsOUEHgckh0mm3Sj7Hw==
X-Received: by 2002:a05:6402:491:: with SMTP id k17mr48221773edv.333.1641302442702;
        Tue, 04 Jan 2022 05:20:42 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-92-231.retail.telecomitalia.it. [95.244.92.231])
        by smtp.gmail.com with ESMTPSA id y13sm14765575edq.77.2022.01.04.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 05:20:42 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 0/2] Change flexcan features at runtime
Date:   Tue,  4 Jan 2022 14:20:24 +0100
Message-Id: <20220104132026.3062763-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series was born from the review https://lkml.org/lkml/2022/1/2/127
by Marc Kleine-Budde. The ethtool module is minimal and lacks the
callback to change the setting at runtime (this has yet to be defined).
I'm certainly not an expert but might it make sense to use the
set_features() callback? Although I understand that it belongs to
`struct net_device_ops' and not to 'struct ethtool_ops'.


Dario Binacchi (2):
  can: flexcan: allow to change quirks at runtime
  can: flexcan: add ethtool support

 drivers/net/can/Makefile                      |   3 +
 drivers/net/can/flexcan.h                     | 107 +++++++++++++
 drivers/net/can/flexcan_ethtool.c             |  29 ++++
 drivers/net/can/{flexcan.c => flexcan_main.c} | 144 ++++--------------
 4 files changed, 166 insertions(+), 117 deletions(-)
 create mode 100644 drivers/net/can/flexcan.h
 create mode 100644 drivers/net/can/flexcan_ethtool.c
 rename drivers/net/can/{flexcan.c => flexcan_main.c} (92%)

-- 
2.32.0

