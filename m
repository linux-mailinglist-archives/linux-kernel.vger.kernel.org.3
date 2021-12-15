Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB9475B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbhLOPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243715AbhLOPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:10:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD69C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:10:25 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639581023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=DlAuCxADJdDedhOdaQ3XkarOK9iIv0+wbxsXvUHhZUQ=;
        b=SoQP/nH11FTR3gJIz9VCS5MbyNwEIACT6FlivUQRXwVMrx0FchPhjYviW9y5b4JnrCfW7G
        xP2Z81/lhP83oL4ilnIGpFAOUnhnjaUrhCnJPHF5vsYwsT4RejUXUDl8Muci+Xzm38FmPC
        df8BEpJm3qC760T02Q16qBiYrPDni7xyB07L5nJaW7N0DsqlGOz8RmUYjJUc39xQoN2ZBY
        6ZEeNip+Y10c0NBCk0LTOg5D2jpDYve//VQ7xjza33+bJ6S3wvbUR3GysbsUMsNMIlpwa/
        TEt1/j59h3wgivXzJCv9xsApqe6YK0GH2RArkwDVCuE2YrwPT7ysVyRsowXopg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639581023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=DlAuCxADJdDedhOdaQ3XkarOK9iIv0+wbxsXvUHhZUQ=;
        b=d3GVDNPOL2OhiwyLPhGHPOdIfW3MW9emdEf9DoQxobGM31EIrvKo+ZIcj7l80VP1spxQip
        fTNqLnn5nDkNNiCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/gdb: lx-dmesg: read records individually
Date:   Wed, 15 Dec 2021 16:16:22 +0106
Message-ID: <874k79c3a9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the gdb command lx-dmesg, the entire descriptor, info, and text
data regions are read into memory before printing any records. For
large kernel log buffers, this not only causes a huge delay before
seeing any records, but it may also lead to python errors of too
much memory allocation.

Rather than reading in all these regions in advance, read them as
needed and only read the regions for the particular record that is
being printed.

The gdb macro "dmesg" in Documentation/admin-guide/kdump/gdbmacros.txt
already prints out the kernel log buffer like this.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 scripts/gdb/linux/dmesg.py | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
index a92c55bd8de5..d5983cf3db7d 100644
--- a/scripts/gdb/linux/dmesg.py
+++ b/scripts/gdb/linux/dmesg.py
@@ -44,19 +44,17 @@ class LxDmesg(gdb.Command):
         sz = prb_desc_ring_type.get_type().sizeof
         desc_ring = utils.read_memoryview(inf, addr, sz).tobytes()
 
-        # read in descriptor array
+        # read in descriptor count, size, and address
         off = prb_desc_ring_type.get_type()['count_bits'].bitpos // 8
         desc_ring_count = 1 << utils.read_u32(desc_ring, off)
         desc_sz = prb_desc_type.get_type().sizeof
         off = prb_desc_ring_type.get_type()['descs'].bitpos // 8
-        addr = utils.read_ulong(desc_ring, off)
-        descs = utils.read_memoryview(inf, addr, desc_sz * desc_ring_count).tobytes()
+        desc_addr = utils.read_ulong(desc_ring, off)
 
-        # read in info array
+        # read in info size and address
         info_sz = printk_info_type.get_type().sizeof
         off = prb_desc_ring_type.get_type()['infos'].bitpos // 8
-        addr = utils.read_ulong(desc_ring, off)
-        infos = utils.read_memoryview(inf, addr, info_sz * desc_ring_count).tobytes()
+        info_addr = utils.read_ulong(desc_ring, off)
 
         # read in text data ring structure
         off = printk_ringbuffer_type.get_type()['text_data_ring'].bitpos // 8
@@ -64,12 +62,11 @@ class LxDmesg(gdb.Command):
         sz = prb_data_ring_type.get_type().sizeof
         text_data_ring = utils.read_memoryview(inf, addr, sz).tobytes()
 
-        # read in text data
+        # read in text data size and address
         off = prb_data_ring_type.get_type()['size_bits'].bitpos // 8
         text_data_sz = 1 << utils.read_u32(text_data_ring, off)
         off = prb_data_ring_type.get_type()['data'].bitpos // 8
-        addr = utils.read_ulong(text_data_ring, off)
-        text_data = utils.read_memoryview(inf, addr, text_data_sz).tobytes()
+        text_data_addr = utils.read_ulong(text_data_ring, off)
 
         counter_off = atomic_long_type.get_type()['counter'].bitpos // 8
 
@@ -102,17 +99,20 @@ class LxDmesg(gdb.Command):
             desc_off = desc_sz * ind
             info_off = info_sz * ind
 
+            desc = utils.read_memoryview(inf, desc_addr + desc_off, desc_sz).tobytes()
+
             # skip non-committed record
-            state = 3 & (utils.read_u64(descs, desc_off + sv_off +
-                                        counter_off) >> desc_flags_shift)
+            state = 3 & (utils.read_u64(desc, sv_off + counter_off) >> desc_flags_shift)
             if state != desc_committed and state != desc_finalized:
                 if did == head_id:
                     break
                 did = (did + 1) & desc_id_mask
                 continue
 
-            begin = utils.read_ulong(descs, desc_off + begin_off) % text_data_sz
-            end = utils.read_ulong(descs, desc_off + next_off) % text_data_sz
+            begin = utils.read_ulong(desc, begin_off) % text_data_sz
+            end = utils.read_ulong(desc, next_off) % text_data_sz
+
+            info = utils.read_memoryview(inf, info_addr + info_off, info_sz).tobytes()
 
             # handle data-less record
             if begin & 1 == 1:
@@ -125,16 +125,17 @@ class LxDmesg(gdb.Command):
                 # skip over descriptor id
                 text_start = begin + utils.get_long_type().sizeof
 
-                text_len = utils.read_u16(infos, info_off + len_off)
+                text_len = utils.read_u16(info, len_off)
 
                 # handle truncated message
                 if end - text_start < text_len:
                     text_len = end - text_start
 
-                text = text_data[text_start:text_start + text_len].decode(
-                    encoding='utf8', errors='replace')
+                text_data = utils.read_memoryview(inf, text_data_addr + text_start,
+                                                  text_len).tobytes()
+                text = text_data[0:text_len].decode(encoding='utf8', errors='replace')
 
-            time_stamp = utils.read_u64(infos, info_off + ts_off)
+            time_stamp = utils.read_u64(info, ts_off)
 
             for line in text.splitlines():
                 msg = u"[{time:12.6f}] {line}\n".format(

base-commit: 0bafb8f3ebc84525d0ae0fcea22d12151b99312f
-- 
2.30.2
