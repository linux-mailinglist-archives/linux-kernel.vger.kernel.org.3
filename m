Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD0C47EA43
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350777AbhLXB3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:29:16 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:41278 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhLXB3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:29:12 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BO1M7jM007688;
        Fri, 24 Dec 2021 09:22:07 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 24 Dec
 2021 09:27:37 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <hverkuil-cisco@xs4all.nl>, <sakari.ailus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <eajames@linux.ibm.com>,
        <mchehab@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-media@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/4] add aspeed-jpeg support for aspeed-video
Date:   Fri, 24 Dec 2021 09:27:34 +0800
Message-ID: <20211224012738.1551-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BO1M7jM007688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of this series is to add aspeed-jpeg support for aspeed-video
driver. aspeed-jpeg is a per-frame differential jpeg format which only
compress the parts which are different from the previous frame. In this
way, it reduces both the amount of data to be transferred by network and
those to be decoded on the client side.

In the last, debugfs information is also updated per this change.

Changes in v8:
 - Add information of decoder's implementation
 
Changes in v7:
 - Separate other patches alone from aspeed-jpeg series
 - for Aspeed-jpeg, generate an I frame every 8 frames
 - rename compression_mode as compression_scheme
 - Add more reference for aspeed-jpeg
 - Update debugfs message

Changes in v6:
 - Update description for new format, aspeed-jpeg, in Documentation.

Changes in v5:
 - Use model data to tell different soc

Changes in v4:
 - Add definition for the Aspeed JPEG format
 - Reserve controls for ASPEED
 - Use s_fmt to update format rather than new control
 - Update aspeed hq quality range, 1 ~ 12


Jammy Huang (4):
  media: v4l: Add definition for the Aspeed JPEG format
  media: v4l2-ctrls: Reserve controls for ASPEED
  media: aspeed: Support aspeed mode to reduce compressed data
  media: aspeed: Extend debug message

 .../media/uapi/v4l/pixfmt-reserved.rst        |  17 ++
 drivers/media/platform/aspeed-video.c         | 287 ++++++++++++++++--
 drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
 include/uapi/linux/aspeed-video.h             |  15 +
 include/uapi/linux/v4l2-controls.h            |   5 +
 include/uapi/linux/videodev2.h                |   1 +
 6 files changed, 307 insertions(+), 19 deletions(-)
 create mode 100644 include/uapi/linux/aspeed-video.h

-- 
2.25.1

