Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E4C4759D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbhLONmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:42:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:34641 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242923AbhLONmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:42:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="226509014"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226509014"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:42:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="518774307"
Received: from cdobraun-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.212.15])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:42:32 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [RFCv5 0/2] HID: Add USI support
Date:   Wed, 15 Dec 2021 15:42:18 +0200
Message-Id: <20211215134220.1735144-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These two patches add the missing pieces for HID USI support. First one
adds the HID core changes to support the new Misc events for pen ID,
line color and line style. The second patch adds a BPF program on top of
the HID-BPF driver which adds support for writing the Pen parameters
from userspace, and to add filtering of HID low level events for ELAN
USI controller. The BPF programs are not built by the kernel as of now
(there are no Makefile changes), as there is a plan to most likely
integrate these to a kernel external repository. I have tested these in
my own external build setup though, and I can provide the makefile for
that if needed. Also a sample client program is provided for
communicating with the D-BUS server.

I have also a kernel testing branch available at [1], which contains a
few fix patches on top of Benjamin's HID-BPF driver work, and is rebased
on top of latest hid/for-next. The HID-BPF fixes have been cleaned up a
bit compared to previous setup. There are also a couple of new patches
for adding support for a delayed_work BPF program on top of the
hid-bpf driver; this is used to execute the raw_requests in non-irq
context.

-Tero

[1] https://github.com/t-kristo/linux/tree/usi-5.16-v5-bpf


