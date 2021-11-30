Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD108463576
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbhK3Ndf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhK3Nde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:33:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFC2C061574;
        Tue, 30 Nov 2021 05:30:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id BBFE41F450AA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638279014; bh=JkySVPDGNpn6LKnMdJT35Z7jMO5ycnbzeeqnHqbYpaw=;
        h=From:To:Cc:Subject:Date:From;
        b=TyemHOwWjXHmyKHiFUbMlhzNKzwZ2oTnTz358YxXJ02Y9n4x35je46NZRcKjia3aW
         zjUKPO5kiSrZg/29paczvzKWT2DIzkl4/k16CUiPOIEmAfnv6UKIRXP2q31YS36+Zq
         WH3VQ0b0sRXfU740xMA4QoFlQksA+PA9Qvv+ywCm4chWbVUtBRm71TxuYegnBAcYrn
         uWwcPhSXd0wROvi+D0dk7gXUss0a3pZaE0leg+YRZCbp2kiek7awEGr8KhACdTtfRL
         2yPxONGvyiM/x8FWd9Rqxesli01TPO6Rk7s5yBRTBfuzbaf7imcaBEptEI13hrqF20
         ljY+eVOQKPxqA==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/1] hidraw: Improve subsytem throughput
Date:   Tue, 30 Nov 2021 10:29:56 -0300
Message-Id: <20211130132957.8480-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In a discussion about SteamVR for Linux[0], users found out that
modifying hidraw code would lead to more stable frame per seconds. This
patch aims to fix a bottleneck at hidraw subsystem to increase the
system throughput when using a lot of HIDs at same time.

I created an artificial benchmark tool[1] to test this. It issues a lot of
ioctls in parallel for 5 HID devices. While the original kernel took
around 1570 nsecs to complete all the calls, after applying this patch
it took around 412 nsecs, almost 4x faster.

Thanks,
	André

[0] https://github.com/ValveSoftware/SteamVR-for-Linux/issues/21
[1] https://gist.github.com/andrealmeid/b495999b8efce3c741e14a709a21e49b

André Almeida (1):
  HID: hidraw: Replace hidraw device table mutex with a rwsem

 drivers/hid/hidraw.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

-- 
2.34.1

