Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D04660F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356841AbhLBJ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356913AbhLBJ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638438822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ihb1r64gOGbJUKMXKVMB9tzffqjZmKffkBLeYuYdb9A=;
        b=N+OWXpa5t2FguG9hWTI5R1UbkO7v+PhfYwSAylm2bihgTyzIDrcQc2ktVF6e2/fYwV9Can
        JeYLIa5B+0dw4S95io4RKru7B5mQahmBz4KIHf3jtjOWbYU4EsauIsj+W5BYlS40N3EQfc
        MldzsWKRLnybpi5gR9ElD6nQC8t6yZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-188-kKym0-7TMzqh25HoYg-reQ-1; Thu, 02 Dec 2021 04:53:38 -0500
X-MC-Unique: kKym0-7TMzqh25HoYg-reQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A82EE10151E0;
        Thu,  2 Dec 2021 09:53:37 +0000 (UTC)
Received: from xps-13.redhat.com (unknown [10.39.195.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3804319C46;
        Thu,  2 Dec 2021 09:53:36 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/4] HID: followup of uhid crashes, and couple of core
Date:   Thu,  2 Dec 2021 10:53:30 +0100
Message-Id: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a followup of Greg's series[0].
hid-sony is having a wrong error path leading to unreleased
hidraw nodes, and bigbenff is having a crash when used with
a wrong report descriptor in uhid.

Those 2 first patches should IMO go into 5.16.

The 2 others are some core changes I had locally stacked and
which should be ready to go now. They can be scheduled for 5.16
or 5.17, there is no rush for them.

Cheers,
Benjamin


[0] https://lore.kernel.org/linux-input/20211201183503.2373082-1-gregkh@linuxfoundation.org/


Benjamin Tissoires (4):
  HID: sony: fix error path in probe
  HID: bigbenff: prevent null pointer dereference
  HID: add suspend/resume helpers
  HID: do not inline some hid_hw_ functions

 drivers/hid/hid-bigbenff.c                 |  2 +-
 drivers/hid/hid-core.c                     | 93 ++++++++++++++++++++++
 drivers/hid/hid-sony.c                     | 22 +++--
 drivers/hid/i2c-hid/i2c-hid-core.c         | 15 +---
 drivers/hid/surface-hid/surface_hid_core.c | 25 ++----
 drivers/hid/usbhid/hid-core.c              | 19 ++---
 include/linux/hid.h                        | 78 ++++--------------
 7 files changed, 142 insertions(+), 112 deletions(-)

-- 
2.33.1

