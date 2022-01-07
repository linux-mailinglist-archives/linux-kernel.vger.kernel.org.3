Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422C44879F4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348158AbiAGPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:55:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41682 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348145AbiAGPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:55:05 -0500
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:21c7:4f13:8afa:4f9f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A575C1F4649A;
        Fri,  7 Jan 2022 15:55:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641570904;
        bh=JnP8ldrXuGP6Z9VtKebQAcp4jKsdWLuoyiXQLwhWEP8=;
        h=From:To:Cc:Subject:Date:From;
        b=bEz3SFMy1UKdFwO9JqK7VzOJZtaKPE+ltUmdOHd5tzgdYUa+yW3FpcM1WLzhX4Ape
         /qalMd7Sca8mexxEoTAkygsK8CA+2dh7AJysC+7XYbo6C4LNJPy4JM5dlScOW5TnEd
         yaJsCFwdOTf0EmR5ZBk2HrS7U7xKsVAyPUYv7epYQWFeP03B7KmCJaYG62gzTBprZZ
         0fPJfDRgt/SIzGVm363XM+VbdGgLalKPVN76ZsRQFE2shbAAyJgqVPsx/VZpI2373i
         /Mta0sXiHlbhJud0JEHW7d2V1mBrEm+RhCIXBs9sSgmHpE2x7LgiDTRPfWxOHl2lk2
         pn2R4OuVwVlFQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, jernej.skrabec@gmail.com,
        nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v5 0/2] media: HEVC: RPS clean up
Date:   Fri,  7 Jan 2022 16:54:53 +0100
Message-Id: <20220107155455.604536-1-benjamin.gaignard@collabora.com>
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

version 5:
- rework commit message as suggested by Ezequiel
- improve V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE documentation
  with reference to HEVC ITU spec.
- add review-by tags from Jernej and Ezequiel

version 4:
- check flags with & and not ==
- remove the 2 last patches which becomes useless since VPU ctrl-blk
  driver introduction.

version 3:
- rebased on top of v5.16-rc1

version 2:
- change DPB field name from rps to flags


Benjamin Gaignard (2):
  media: hevc: Remove RPS named flags
  media: hevc: Embedded indexes in RPS

 .../media/v4l/ext-ctrls-codec.rst             | 16 +++++------
 .../staging/media/hantro/hantro_g2_hevc_dec.c | 27 +++++--------------
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |  2 +-
 include/media/hevc-ctrls.h                    |  6 ++---
 4 files changed, 18 insertions(+), 33 deletions(-)

-- 
2.30.2

