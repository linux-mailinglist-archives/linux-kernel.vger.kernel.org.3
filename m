Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994F246FC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbhLJIAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:00:47 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54462 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbhLJIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:00:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 069F7CE2A2D;
        Fri, 10 Dec 2021 07:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE003C341C8;
        Fri, 10 Dec 2021 07:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639123023;
        bh=YgnZMOANsfl/lYmjszwSNJTdqHSPX8kPuOKQKBgCP5E=;
        h=From:To:Cc:Subject:Date:From;
        b=acdODExQ3KrTCz131x8vaVj7VNNBmepsl4yOh0qyJUK83/1XxU2koKduu8Xm72jZb
         TCBTko+9OQ+HGU+WzoSnY30v0gIPRcvleU4K/6RkJr72ZMmEg6r7wG+GmX0uFNcfUc
         aBYMdz25wArQwzsTlm7jT6oNM40OPXskMogQc5e27dmeQ7I3xJetFYIehqw33i1pEn
         YtrdKjSryxHyRc/VKxzKjvJdGNdjdjD6iwEHKpUdBiL7D85asbe8mHuXwqRGgIZhQ6
         rTDmjgQtRc/VZd9exeRwhqpqFuoGso/EqxcFZ9Lys4+lR2tieLCBCNOALqka2oVK7+
         kI3UAoN17K7xA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvam4-000BVT-Oe; Fri, 10 Dec 2021 08:57:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Robert Schlabbach <robert_s@gmx.net>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v3 0/4] media: si2157: rework firmware load logic
Date:   Fri, 10 Dec 2021 08:56:55 +0100
Message-Id: <cover.1639120421.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed bt Robert, if there's already a firmware for si2157 at
/lib/firmware, it is preferred to use it, instead of the default firmware.

Yet, when this is missed, the driver may still work. That's the case,
for instance, of the devices explicitly flagged with dont_load_firmware
(currently, Terratec Cinergy TC2).

So, rework the firmware logic in a way that it will emit a warning for
devices that are using the eeprom firmware and may not work well
with it.

Compile-tested only.

--

v3:
 - Rename some data structs;
 - Better handle the cases where the ROM is unknown.

v2:
 - added a patch to allow supporting different firmwares depending on
   the device's reported ROM ID.

Mauro Carvalho Chehab (3):
  media: si2157: move firmware load to a separate function
  media: si2157: rework the firmware load logic
  media: si2157: use a different namespace for firmware

Robert Schlabbach (1):
  media: si2157: Add optional firmware download

 drivers/media/tuners/si2157.c      | 254 +++++++++++++++++------------
 drivers/media/tuners/si2157_priv.h |  31 ++++
 2 files changed, 184 insertions(+), 101 deletions(-)

-- 
2.33.1


