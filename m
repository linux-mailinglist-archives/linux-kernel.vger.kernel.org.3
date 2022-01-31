Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0014A4AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379855AbiAaPrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379801AbiAaPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:47:08 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F10C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:47:08 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id e9so20020035ljq.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=tWF6c50iluk3gJWzzn2nu1IXzyQw+e+0Zhpcp6dcL3w=;
        b=Jbk3gukCnhxmdiZU+9xzA2ljkZcm/ma0pywuYYKWI5RpsI4ovcscKufG87o9Kn2lFJ
         N865G2uzR/dppRp/HI/2iSR3PVLurIEEwohkhHZeMzYcgDBNANwl3MXLrFT3quQmvdua
         qVX+Pp5THkUSnhYbFccV1r1jzW8Ol0qkxJFU1toE8SskLLmy3R3M1AVMnVeqAYzHHopm
         COZcN+Pzsa1BHbbpcJWSkvWwARiVfOveX1OuIItjPRpjZ8MN/6/WgsRPmMxuYdYdy11F
         1zbCPjzj+Gy50xL8vTSTqWkxE8BIXUGJuTelZ9U1eqK8nIjAxqAGHN6Tn5Ftejcy5NAs
         Sf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=tWF6c50iluk3gJWzzn2nu1IXzyQw+e+0Zhpcp6dcL3w=;
        b=UwDhC94ncgBkV55uqcLilg5B5Kj3bmko+WI2d/7fCBCx9OuxfQxcOr143YXK7dtaOF
         snKYOurYhPJzoVNuG+Z2OP1zN5Heu8WTC3dGq/0EyymVKaTufVMvtknRvjm7eQThQ2DV
         JDC2Uy6xNusn0H8ZjmvpGW0p5WIS1Rt29Tn6OFXCfbjxW23Hnqitxpzrptzc8NZKI7qe
         7BVWGUqzbo16vSLxBAjjngiaFU77HsQeqyIQgZE9n8ifdUZqAZKxbvB0NgFpUgFp9dBz
         QKhL65mOT6+SFxpIG7W4Kpwkld3Wnv88Mibv0DrSQQLyzs000gkDlzrnPs2iCBSdXJj7
         6jmA==
X-Gm-Message-State: AOAM532/EpIHOyfqfoutFwjdJWp2JSSd8V3Is0rRp0V5OukP5/wZLu1k
        KVLupjGOv+QgHhPy5H31boBNTg==
X-Google-Smtp-Source: ABdhPJwh9KDovrHgZIc7eIf4hAso96TSKRmbgq3VRJLuec/AC/qFjvlNO4g/0e8OXTstuSKOxy8uvg==
X-Received: by 2002:a2e:2e16:: with SMTP id u22mr13549471lju.205.1643644026573;
        Mon, 31 Jan 2022 07:47:06 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id y36sm3374769lfa.82.2022.01.31.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:47:06 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] net: dsa: mv88e6xxx: Enable port policy support on 6097
Date:   Mon, 31 Jan 2022 16:46:53 +0100
Message-Id: <20220131154655.1614770-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220131154655.1614770-1-tobias@waldekranz.com>
References: <20220131154655.1614770-1-tobias@waldekranz.com>
MIME-Version: 1.0
Organization: Westermo
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip has support for the same per-port policy actions found in
later versions of LinkStreet devices.

Fixes: f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index dde6a8d0ca36..8896709b9103 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3652,6 +3652,7 @@ static const struct mv88e6xxx_ops mv88e6097_ops = {
 	.port_sync_link = mv88e6185_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
-- 
2.25.1

