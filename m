Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4578946FDFD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbhLJJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:42:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236707AbhLJJmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639129116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XkoH926fKH3qs8O4EmU55u9yb4sQFyK9sNPFLJIp6nY=;
        b=MrC1X7WRgymbG2vpQMnUSHF4ONjEmPfZR+ZqGV0wdDsyodEX3rDsPi+NWJyNTumRJ5taYm
        nUxUUdGsB5sqQ43cpG6YigAGEjjbO/O5E7xzjD56FeReoB8zAhrrSmyicR/gMab0sW9+Y9
        g9t4zjtZw9T6+jLVseUSjq6tx1X/VSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-O1ycOhE4O8CtM1_K_GvA5w-1; Fri, 10 Dec 2021 04:38:32 -0500
X-MC-Unique: O1ycOhE4O8CtM1_K_GvA5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 234D9801962;
        Fri, 10 Dec 2021 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id EDDA87A238;
        Fri, 10 Dec 2021 09:38:28 +0000 (UTC)
Received: by localhost.localdomain (sSMTP sendmail emulation); Fri, 10 Dec 2021 10:38:27 +0100
From:   "Jerome Marchand" <jmarchan@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] recordmcount.pl: look for jgnop instruction as well as bcrl on s390
Date:   Fri, 10 Dec 2021 10:38:27 +0100
Message-Id: <20211210093827.1623286-1-jmarchan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390, recordmcount.pl is looking for "bcrl 0,<xxx>" instructions in
the objdump -d outpout. However since binutils 2.37, objdump -d
display "jgnop <xxx>" for the same instruction. Update the
mcount_regex so that it accepts both.

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 scripts/recordmcount.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 7d631aaa0ae1..52a000b057a5 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -219,7 +219,7 @@ if ($arch eq "x86_64") {
 
 } elsif ($arch eq "s390" && $bits == 64) {
     if ($cc =~ /-DCC_USING_HOTPATCH/) {
-	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*brcl\\s*0,[0-9a-f]+ <([^\+]*)>\$";
+	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(bcrl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
 	$mcount_adjust = 0;
     }
     $alignment = 8;
-- 
2.31.1

