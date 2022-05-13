Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA3526641
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382212AbiEMPgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382217AbiEMPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:36:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2A611177;
        Fri, 13 May 2022 08:36:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bo5so7996025pfb.4;
        Fri, 13 May 2022 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7uUSDFA4nveMFnKca6XkX5fot8a0gngUc3fbjuqiDc=;
        b=hvTJc3UDtG2aW5iVCKWiWROQFUI0X9RS6Yq3r92RXI+NPWzR46rXtgJbfNgLxXZFNI
         dCvp1AgllkksbOOaqv6OzhnnSVh+L83r/6s0kpVSwsuoDZ2/EXhYG/g9uxSe8+PBQP7/
         gTP3pD3M1JopN8I0KxWPi51ff7WeOiJ0BXSmP/0YCIn8+6qeRY6khO9b7AC5kdEDA/6U
         GoYiXaupRMbYqNwiT6srPEgY/dN53zgBE+eQHf7m4dFETDibOdBVjK2yEeHYCfeUq3Rm
         IDgW5UUWw+vFhOtgh42DQ4lx5I50udUszoqEBLOIuGbvIhqIH0O0RgLtjyZK6l4Qii5g
         5V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=f7uUSDFA4nveMFnKca6XkX5fot8a0gngUc3fbjuqiDc=;
        b=51jGTpupujuzs+BbZ0p0E8zeJyelnGxOebpTC8sqIHS2jYjXhmUReW5UiGx81yPdLk
         GtoC00UTdpc339PYGYi1W04mTif6UqHDb3FUDoYYOFS2bTrL8Hrl2smmePK908NEtzL2
         08ZJNIi0r0Yv5Wfb/oTSGpDii8Xzi36QKb31v1Ej/KFlP+3EHvq9MwwKeOmOWwH3btII
         sunYyXcNiOBcLRi3SZ6k5uDdezTL63FBObA4CoxHhalXmT5DF2Lev/3LrsiAuhXaF2oi
         vDEIbmu2jun9PdeOQ7faC4+BXtHd69odAVF8aY7pixafmX5NXgomqhJiKhhFnWEGzZZo
         aVxA==
X-Gm-Message-State: AOAM533qPXRqX3MgfVHPQVkZoEGBm+AK+dyDm3JqRLrmH5bJSYseeBgc
        v0qhyAXEYtPmY+Mpz4Lywtk=
X-Google-Smtp-Source: ABdhPJx/BqMikW4NsJMOYMi+CjuUl39oFPtaAixMIFQ+9v1pbfTH2YfozWAYbfzBDPd9YmnZd+KVYg==
X-Received: by 2002:a63:cd0b:0:b0:3c6:afc0:32a6 with SMTP id i11-20020a63cd0b000000b003c6afc032a6mr4420179pgg.436.1652456183258;
        Fri, 13 May 2022 08:36:23 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id b10-20020a62a10a000000b0050dc762817dsm1942137pff.87.2022.05.13.08.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:36:22 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 0/2] can: drop tx skb if the device is in listen only mode
Date:   Sat, 14 May 2022 00:36:04 +0900
Message-Id: <20220513153606.302464-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
References: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In listen only mode, tx CAN frames can still reach the driver if
injected via the packet socket. This series add a check toward
CAN_CTRLMODE_LISTENONLY in can_dropped_invalid_skb() to discard such
skb.

The first patch does some preparation work and migrates
can_dropped_invalid_skb() and can_skb_headroom_valid() from skb.h to
skb.c. This preparation is needed because skb.h does not include
linux/can/dev.h (for struct can_priv) and uapi/linux/can/netlink.h
(for the definition of CAN_CTRLMODE_LISTEONLY) which we need for this
change. The function being already big, better to de-inline them and
move them to a .c file.

The second and last patch is the actual change.


* Changelog *

v1 -> v2

  * move can_dropped_invalid_skb() to skb.c instead of dev.h

  * also move can_skb_headroom_valid() to skb.c

Vincent Mailhol (2):
  can: skb:: move can_dropped_invalid_skb and can_skb_headroom_valid to
    skb.c
  can: dev: drop tx skb if in listen only mode

 drivers/net/can/dev/skb.c | 65 +++++++++++++++++++++++++++++++++++++++
 include/linux/can/skb.h   | 59 +----------------------------------
 2 files changed, 66 insertions(+), 58 deletions(-)

-- 
2.35.1

