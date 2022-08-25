Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F26A5A12DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiHYOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbiHYOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:01:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D763BF55;
        Thu, 25 Aug 2022 07:01:29 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:01:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661436087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pq8rmsfzjWKCQ10lO6gHelYjo9VGTLZFuhq8IJQzu5c=;
        b=29ZmrT6qXeyYUG4l2Q3ycjknbTykeSWK36XB+vMD5+CTKoGBA83b/BeFFGvdhkpztSJ5o2
        luLdYeTQ1HEgagfZmXqmoGpD4CeShZ5wwWbI9oV9lPnxpMU9ajpAIy5WkRFR0a7Urd+Bvt
        OOjuDdVMYwLUaszwXtdIMRXusMvkXNLZ3pZ/K+g7lmEkkov0MPMkDnYbjPOlaNwOkUP5tA
        VEz5DJOguN0tlx7T7u0kivM+XVoCJicZGAbjNOmV+rPon+d8QvyJoXfM7tp9aXcSo8VR26
        DrERRRB31CNfp2zTQSc6a1Ue80Hl0TvXIu+Ac8g3QZEYem2GBZoMG6YmkVtI2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661436087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pq8rmsfzjWKCQ10lO6gHelYjo9VGTLZFuhq8IJQzu5c=;
        b=P0nmH+CVM6K91RrSfBwQ22GIqw61KrQmTu9p+kxFXKK39trngjKi3IhMjV5AFlYMfkZWvR
        jWUbLQzbWI2HuOAw==
From:   "tip-bot2 for Salvatore Bonaccorso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Documentation/ABI: Mention retbleed vulnerability
 info file for sysfs
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220801091529.325327-1-carnil@debian.org>
References: <20220801091529.325327-1-carnil@debian.org>
MIME-Version: 1.0
Message-ID: <166143608548.401.16561885968810772241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     00da0cb385d05a89226e150a102eb49d8abb0359
Gitweb:        https://git.kernel.org/tip/00da0cb385d05a89226e150a102eb49d8abb0359
Author:        Salvatore Bonaccorso <carnil@debian.org>
AuthorDate:    Mon, 01 Aug 2022 11:15:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 25 Aug 2022 15:55:02 +02:00

Documentation/ABI: Mention retbleed vulnerability info file for sysfs

While reporting for the AMD retbleed vulnerability was added in

  6b80b59b3555 ("x86/bugs: Report AMD retbleed vulnerability")

the new sysfs file was not mentioned so far in the ABI documentation for
sysfs-devices-system-cpu. Fix that.

Fixes: 6b80b59b3555 ("x86/bugs: Report AMD retbleed vulnerability")
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220801091529.325327-1-carnil@debian.org
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 5bf6188..760c889 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -523,6 +523,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
 		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/retbleed
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
