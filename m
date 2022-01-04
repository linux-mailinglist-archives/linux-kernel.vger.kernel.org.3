Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F2483D09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiADHix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:38:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54328 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiADHix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:38:53 -0500
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d353:5de8:6c9d:602a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6614F1F4138F;
        Tue,  4 Jan 2022 07:38:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641281931;
        bh=HocsvGOuLezQKsuF/xYuc+qqHeGMMKBZYDtcezq1e9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=XFDWOFExLpN8umM/K0Gci/w8z2/Cyj8zEQWJnfFS6Y4ZQPlNww70vqmss4D0kjU6w
         oONmgrk1javAQzhJy0Wsc5FDVRpOottHgDXHFDoOHb4cPYamCGueEczFYZ3zTo5DsN
         SPhQNvXRKQlFHlDCc++BzakMOmna9XlaAdAIzuL4KQ7fT/PAZWm4kHJDC0Y2zPVkGb
         JE2Im/UizsXoDwUyKPSAyNZrJAPnuszadJiaPep6fEVbjkQQCinSQ2FFBINo5YEbgy
         zRR6nLTiw79JBrHQcMLt74IZMoTEFVmlwPWqopadVK0xJf3LczNQh+Y49m1snt3i7b
         syE9mmlmCoecQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, jernej.skrabec@gmail.com,
        nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 0/2] media: HEVC: RPS clean up
Date:   Tue,  4 Jan 2022 08:38:40 +0100
Message-Id: <20220104073842.1791639-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to clean up Reference Picture Set usage and flags.

Long term flag was named with RPS prefix while it is not used for RPS
but for mark long term references in DBP. Remane it and remove the two
other useless RPS flags.

Clarify documentation about RPS lists content and make sure that Hantro
driver use them correctly (i.e without look up in DBP).

version 4:
- check flags with & and not ==
- remove the 2 last patches which becomes useless since VPU ctrl-blk
  driver introduction.

version 3:
- rebased on top of v5.16-rc1

version 2:
- change DPB field name from rps to flags

GStreamer HEVC plugin merge request can be found here:
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1079

With those piece of code fluster score is 77/147.

Benjamin Gaignard (2):
  media: hevc: Remove RPS named flags
  media: hevc: Embedded indexes in RPS

 .../media/v4l/ext-ctrls-codec.rst             | 14 +++++-----
 .../staging/media/hantro/hantro_g2_hevc_dec.c | 27 +++++--------------
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |  2 +-
 include/media/hevc-ctrls.h                    |  6 ++---
 4 files changed, 16 insertions(+), 33 deletions(-)

-- 
2.30.2

