Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9A4E807E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiCZKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCZKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:43:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CEF17C428;
        Sat, 26 Mar 2022 03:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA22AB80092;
        Sat, 26 Mar 2022 10:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A9C340E8;
        Sat, 26 Mar 2022 10:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648291310;
        bh=xZlqMQzbCehxyiw/2qVRxOkQ4fbRXjYYQYkq9DJvrmk=;
        h=From:To:Cc:Subject:Date:From;
        b=qiAsocXDmguA8lIiNPnNwP9a4acGqVo5i7MA3DdFFEsdMoOsR12SIOv6lQdzXaduL
         DzJ41+2ktcMf0VQ6cirHh/7iEoCGlgieIW7Gzv49tGi/Zfl4NV20G9AVzLFjf9kcwj
         oLzKmrsrSvuDNEEbrgrQinXAfJne1/w9N6uOxsxW8uFbs289+i5K0qzCeKGj9iFiJ7
         mk2AWHu4+ssUM6sP8Y21Ttd5YTR1PCB5j5uAaotsj0fDvdOD+JUHd/2hgsIAHVhbC0
         HSL8akFCiRrvM8UOkgGIvDDkfn6xJ7/ReifxKuHzuQnXHwZ+nqdrDYxvJkz3VMg4G/
         JSxxqizXeva9w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nY3rg-00CpK6-4G; Sat, 26 Mar 2022 11:41:48 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/bitmap.c make bitmap_print_bitmask_to_buf parseable
Date:   Sat, 26 Mar 2022 11:41:46 +0100
Message-Id: <f6372a2f880c6e8597a8f070eb031d4cd451d37e.1648291287.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of such function is not on a proper ReST format,
as reported by Sphinx:

    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:532: WARNING: Unexpected indentation.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:526: WARNING: Inline emphasis start-string without end-string.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:532: WARNING: Inline emphasis start-string without end-string.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:532: WARNING: Inline emphasis start-string without end-string.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:533: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:536: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:542: WARNING: Unexpected indentation.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:536: WARNING: Inline emphasis start-string without end-string.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:536: WARNING: Inline emphasis start-string without end-string.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:543: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:552: WARNING: Unexpected indentation.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:545: WARNING: Inline emphasis start-string without end-string.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:545: WARNING: Inline emphasis start-string without end-string.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:552: WARNING: Inline emphasis start-string without end-string.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:552: WARNING: Inline emphasis start-string without end-string.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:554: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:556: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/core-api/kernel-api:81: ./lib/bitmap.c:580: WARNING: Unexpected indentation.

So, the produced output at:

	https://www.kernel.org/doc/html/latest/core-api/kernel-api.html?#c.bitmap_print_bitmask_to_buf

is broken. Fix it by adding spaces and marking the literal blocks.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 lib/bitmap.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 0d5c2ece0bcb..8ebe508580ea 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -527,33 +527,39 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
  * cpumap_print_to_pagebuf() or directly by drivers to export hexadecimal
  * bitmask and decimal list to userspace by sysfs ABI.
  * Drivers might be using a normal attribute for this kind of ABIs. A
- * normal attribute typically has show entry as below:
- * static ssize_t example_attribute_show(struct device *dev,
+ * normal attribute typically has show entry as below::
+ *
+ *   static ssize_t example_attribute_show(struct device *dev,
  * 		struct device_attribute *attr, char *buf)
- * {
+ *   {
  * 	...
  * 	return bitmap_print_to_pagebuf(true, buf, &mask, nr_trig_max);
- * }
+ *   }
+ *
  * show entry of attribute has no offset and count parameters and this
  * means the file is limited to one page only.
  * bitmap_print_to_pagebuf() API works terribly well for this kind of
- * normal attribute with buf parameter and without offset, count:
- * bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
+ * normal attribute with buf parameter and without offset, count::
+ *
+ *   bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
  * 			   int nmaskbits)
- * {
- * }
+ *   {
+ *   }
+ *
  * The problem is once we have a large bitmap, we have a chance to get a
  * bitmask or list more than one page. Especially for list, it could be
  * as complex as 0,3,5,7,9,... We have no simple way to know it exact size.
  * It turns out bin_attribute is a way to break this limit. bin_attribute
- * has show entry as below:
- * static ssize_t
- * example_bin_attribute_show(struct file *filp, struct kobject *kobj,
+ * has show entry as below::
+ *
+ *   static ssize_t
+ *   example_bin_attribute_show(struct file *filp, struct kobject *kobj,
  * 		struct bin_attribute *attr, char *buf,
  * 		loff_t offset, size_t count)
- * {
+ *   {
  * 	...
- * }
+ *   }
+ *
  * With the new offset and count parameters, this makes sysfs ABI be able
  * to support file size more than one page. For example, offset could be
  * >= 4096.
@@ -577,6 +583,7 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
  * This function is not a replacement for sprintf() or bitmap_print_to_pagebuf().
  * It is intended to workaround sysfs limitations discussed above and should be
  * used carefully in general case for the following reasons:
+ *
  *  - Time complexity is O(nbits^2/count), comparing to O(nbits) for snprintf().
  *  - Memory complexity is O(nbits), comparing to O(1) for snprintf().
  *  - @off and @count are NOT offset and number of bits to print.
-- 
2.35.1

