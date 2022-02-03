Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F884A863B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351183AbiBCOcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351159AbiBCOco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643898764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=egIsbiIb1ZlNhNb4hCbsTFlrt0lfVor171N2GRt1Ifc=;
        b=RlIjvuSGPDR9M8kivIxUIw4xiedJlzFh5Fef2i3axo2HfYFqpDpdYD6v1xKR5JoAn9jI3o
        AfjONA89enr3TmduCuwVsq2Tr5wA1q3FkrjNNT22bkeEdJh4VlT2EYyDipCGcq/9mO+TGA
        mwKJudGEzN3A8TtBb3OtKuxLo/vkjuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-57np-K2gOqKEZ8Jj3ep6zA-1; Thu, 03 Feb 2022 09:32:41 -0500
X-MC-Unique: 57np-K2gOqKEZ8Jj3ep6zA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A020835B4B;
        Thu,  3 Feb 2022 14:32:39 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17BF57D5B4;
        Thu,  3 Feb 2022 14:32:30 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 00/12] HID: fix for generic input processing
Date:   Thu,  3 Feb 2022 15:32:14 +0100
Message-Id: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the v2 of my series which reworks the HID report processing.

I took Ping's comments into account, and amended my MR with the
regression tests[0].
More specifically, the tests (and thus this new version of the series)
enforces that only one BTN_TOOL_* event gets forwarded between each
EV_SYN frame, and that BTN_TOUCH are properly translated too.

This also magivally solved some worrying transitions we had in the
pen state machine where the pen was jumping from "eraser" to "in
contact". This new behavior enforces a "out-of-range" state in the
middle, making it easier for userspace to understand now.

Again, tests are welcome :)

Cheers,
Benjamin

[0] https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/127

Benjamin Tissoires (12):
  HID: core: statically allocate read buffers
  HID: core: de-duplicate some code in hid_input_field()
  HID: core: split data fetching from processing in hid_input_field()
  HID: input: tag touchscreens as such if the physical is not there
  HID: input: rework spaghetti code with switch statements
  HID: input: move up out-of-range processing of input values
  HID: compute an ordered list of input fields to process
  HID: core: for input reports, process the usages by priority list
  HID: input: enforce Invert usage to be processed before InRange
  HID: input: remove the need for HID_QUIRK_INVERT
  HID: input: accommodate priorities for slotted devices
  Input: docs: add more details on the use of BTN_TOOL

 Documentation/input/event-codes.rst |   6 +-
 drivers/hid/hid-core.c              | 280 ++++++++++++++++++---
 drivers/hid/hid-input.c             | 364 ++++++++++++++++++++++------
 include/linux/hid.h                 |  23 +-
 4 files changed, 568 insertions(+), 105 deletions(-)

-- 
2.33.1

