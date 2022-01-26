Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2842649CF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiAZQSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:18:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236266AbiAZQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643213929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AaYnGiY3O4S1GK7QGkRQQYwgVS03Cw39e2G4A+OpC+Q=;
        b=cYlxZn1EVSdtWHdZzIXp188iYRURm/fRWBJgXubO7OYi7h8JS3jITxVZpjOcim34KOU+Vx
        A8xCokaS4y4Jjxc3P03EfmQ6yelrH55osZQQMJj+Ec459ZtXJrgJgqcY0X1ioAIDKoxzGA
        hoaO+cWbrgqJosAfZtZlwzGTlgdJz/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-V2eAc93KPpKf-uqMLrnveg-1; Wed, 26 Jan 2022 11:18:46 -0500
X-MC-Unique: V2eAc93KPpKf-uqMLrnveg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE7371091DA1;
        Wed, 26 Jan 2022 16:18:43 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D81679A1F;
        Wed, 26 Jan 2022 16:18:41 +0000 (UTC)
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
Subject: [PATCH 00/12] HID: fix for generic input processing
Date:   Wed, 26 Jan 2022 17:18:20 +0100
Message-Id: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a followup of the discussion we had between Wacom and
the maintainers, and a followup of those 2 patch series:

https://lore.kernel.org/r/20211022232837.18988-1-ping.cheng@wacom.com/
https://lore.kernel.org/r/2ca91ac7cf92e3048a236db3cd519f04e12c1e61.1615224800.git.nabijaczleweli@nabijaczleweli.xyz/

It took me a while to get it right, but I finally can submit the
series:

- the first 8 patches are some cleanup in the hid-input.c and
  hid-core.c code. They also create a list of input fields that
  is then used to process the event, in the priority we think
  is good.

  For instance, on multitouch devices, it is better to have
  Contact Count before processing all touches, and in each
  touch, having Contact ID first is better. This series doesn't
  cover hid-multitouch, but I have a series on top of this one that
  does cover it.

  Anyway, in our case, here, we need to process Invert before
  In Range for tablets so we can make a decision whether the user
  has the intend to erase or not.

- patch 9 enforces the invert usage before In Range as mentioned
  above

- patch 10 is the actual bulk of processing that should fix the
  generic tablet handling. Now that we have a reliable ordering
  of the fields, we can compute the state of the tool in a reliable
  way, and be kinder to userspace by not sending to it 2 tools at
  the same time.

  This patch has been extensively tested by hid-tools with the new
  MR I submitted that add tests for tablets [0].

- patch 11 is a nice to have that I need for my second series regarding
  hid-multitouch. It is not mandatory with that series, but given
  that it changes the format of the priorities in hid-input.c I thought
  it would be best to send it as part of this series.

  Note that now we are tagging the *reports* and the individual fields
  when they are part of a multitouch collection, which should help
  the drivers that implement this processing (hid-multitouch and wacom).

- last, patch 12 is an attempt at fixing the documentation regarding
  BTN_TOOL_* (requested by Peter).

  Dmitry, feel free to take this one through your tree if you prefer
  to do so (and if you are happy with it), otherwise we can take it
  through the hid tree.

As mentioned above, I have a followup series not entirely tidied up
that implements the processing of Win8 mutltiouch devices in
hid-input.c.
There are several benefits for that: we should be able to drop the
multitouch code in wacom.ko, we can simplify part of hid-multitouch,
and we will be able to quirk a particular device in a separate module,
without touching at the generic code (in hid-multitouch or hid-input).

Anyway, I am missing a few bits for that so that's coming in later.

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

 Documentation/input/event-codes.rst |   5 +-
 drivers/hid/hid-core.c              | 280 ++++++++++++++++++++---
 drivers/hid/hid-input.c             | 330 ++++++++++++++++++++++------
 include/linux/hid.h                 |  23 +-
 4 files changed, 533 insertions(+), 105 deletions(-)

-- 
2.33.1

