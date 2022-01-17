Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15101490353
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiAQIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiAQIAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:00:34 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4ACC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:00:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b14so35948463lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+H0zUCZv+PTbsjw6WPR3YzVb03mPL0wUh/zK0tt2hGw=;
        b=w3o2mfF/QcNtbmAO+X3N+3mZb66b8dPkWJSAzmHn/XQxtHKM4X9lxc6EZzTNmRSJh6
         mUFIqRpzqAzrChRDUmhTTr1n/IkAbq4TWwb8WfElWjG2kpoA/YuIvVqYLy62w8Dp1lCy
         Z7MdE8L9n6OlodsZDq0iOTCIdJUFxeKZUkzixzfJZcvq8Qx2KD0A7rRcrQi9bu7ZsRMD
         qMFy1wjG6KEImCBr19vgNwI5YFKGJn5mgIgKZvpXA2TBwioOIgTQ/LVe08oDrHbEn59m
         n2MS92npwB7ya7/C1nkj8UCFguanp293eKiiQVvwQQg8XMOdCewsqgWtyLMQ3aiwq72u
         uCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+H0zUCZv+PTbsjw6WPR3YzVb03mPL0wUh/zK0tt2hGw=;
        b=QYjdlWkah4oC6ZSc4pw342W7YHTTFNsEOyoHomP0qcSf6eSlPQgFOL7cXD+v2s3wiQ
         L253s2ZOz+U6sX1B/Gy1VXCRW2ZPuIWLpCOS/RaaAUSpJnGAb9lheR0NGdFWmvQ8O+wV
         zVorBVvuLbTDNRHwfjXUnNHA5J9t9sM5y7v+JQZR/IMONbXOY6QWlyesJhNZMJavbAS0
         4jkwP4NAJ1eVMQO4r9uAWS0gIoMImemOykC6i2reiNRiauZX7+BlXWcDEvHvaxhUNAnA
         IF9VBiMazdN1LpGDNlvxfAH2AzmMP7o4NABkAtoZ3oxM/nQ0G6tz7FyijT6BjCKh2OWN
         /Gkw==
X-Gm-Message-State: AOAM532aZ9JIr9haY8aMYBSHfFzViM+fPXCDyYod3g5XuqC7VJJ7eBW8
        j3O1IbgMartrePbRop8RqAl8Qg==
X-Google-Smtp-Source: ABdhPJxO6ngGKXzadDc3G8zp/wx4Iok3uM6u7Dx6cWr47gGgibeoEZgtpG5Pnr8GbcbDUWBwVDLBQQ==
X-Received: by 2002:a2e:a5c9:: with SMTP id n9mr15395640ljp.220.1642406431042;
        Mon, 17 Jan 2022 00:00:31 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id x18sm1279423ljd.105.2022.01.17.00.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 00:00:30 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jasowang@redhat.com, mst@redhat.com
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v2 0/4] RSS support for VirtioNet.
Date:   Mon, 17 Jan 2022 10:00:05 +0200
Message-Id: <20220117080009.3055012-1-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio-net supports "hardware" RSS with toeplitz key.
Also, it allows receiving calculated hash in vheader
that may be used with RPS.
Added ethtools callbacks to manipulate RSS.

Technically hash calculation may be set only for
SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.
The completely disabling hash calculation for TCP or UDP
would disable hash calculation for IP.

RSS/RXHASH is disabled by default.

Changes since v1:
* refactored virtnet_set_hashflow
* refactored virtio_net_ctrl_rss
* moved hunks between patches a bit

Changes since rfc:
* code refactored
* patches reformatted
* added feature validation

Andrew Melnychenko (4):
  drivers/net/virtio_net: Fixed padded vheader to use v1 with hash.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report.
  drivers/net/virtio_net: Added RSS hash report control.

 drivers/net/virtio_net.c | 383 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 370 insertions(+), 13 deletions(-)

-- 
2.34.1

