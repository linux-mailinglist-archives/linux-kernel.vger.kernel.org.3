Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61D84715CF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhLKTvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:51:16 -0500
Received: from tulikuusama2.dnainternet.net ([83.102.40.151]:49778 "EHLO
        tulikuusama2.dnainternet.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231911AbhLKTvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:51:16 -0500
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Dec 2021 14:51:15 EST
Received: from localhost (localhost [127.0.0.1])
        by tulikuusama2.dnainternet.net (Postfix) with ESMTP id E68BF2A1AB;
        Sat, 11 Dec 2021 21:42:33 +0200 (EET)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Flag: NO
X-Spam-Score: 0.251
X-Spam-Level: 
X-Spam-Status: No, score=0.251 tagged_above=-9999 required=6
        tests=[DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
        SPF_NONE=0.001] autolearn=disabled
Authentication-Results: tulikuusama2.dnainternet.net (DNA Internet);
        dkim=pass (1024-bit key) header.d=anssih.iki.fi
Received: from tulikuusama2.dnainternet.net ([83.102.40.151])
        by localhost (tulikuusama2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id ESKn04tKTPXV; Sat, 11 Dec 2021 21:42:33 +0200 (EET)
Received: from kirsikkapuu2.dnainternet.net (kirsikkapuu2.dnainternet.net [83.102.40.52])
        by tulikuusama2.dnainternet.net (Postfix) with ESMTP id 9038A2A15B;
        Sat, 11 Dec 2021 21:42:33 +0200 (EET)
Received: from mail.onse.fi (87-95-225-209.bb.dnainternet.fi [87.95.225.209])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by kirsikkapuu2.dnainternet.net (Postfix) with ESMTPS id 156953BAF;
        Sat, 11 Dec 2021 21:42:29 +0200 (EET)
Received: by mail.onse.fi (Postfix, from userid 1000)
        id B6D623222F7; Sat, 11 Dec 2021 21:42:29 +0200 (EET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.onse.fi B6D623222F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anssih.iki.fi;
        s=default; t=1639251749;
        bh=dfpAKXsHLovNd5IBRGBtQtckxsVeTIfHXjPHPxwhPaQ=;
        h=From:To:Cc:Subject:From;
        b=YthncdtQzcpVAepZ8OSN41woAeuhD80WiBpk6KaNLjBN1e09B046BcwXHcB8Q8HDw
         j2pK8iJV32+i5XwLswwTzqwhWipsik7Lf5XVdFwmPgvHZtlQKmd4J3Yy0vA9JHYeVP
         zPofmB5Oy/VGkBpTexVnraMFQsxHjYF9BHdvXnVE=
From:   Anssi Hannula <anssi.hannula@iki.fi>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/vm: clarify overcommit amount sysctl behavior
Date:   Sat, 11 Dec 2021 21:41:59 +0200
Message-Id: <20211211194159.3137362-1-anssi.hannula@iki.fi>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/vm/overcommit-accounting.rst says that the overcommit
amount can be set via vm.overcommit_ratio and vm.overcommit_kbytes.

Add a clarification that those only take effect in overcommit handling
mode 2 ("Don't overcommit"), i.e. they do not act as an "additional"
limit that is always enforced.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---

I've had to look this one up in the code enough times already :)


 Documentation/vm/overcommit-accounting.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/overcommit-accounting.rst b/Documentation/vm/overcommit-accounting.rst
index 0dd54bbe4afa..1addb0c374a4 100644
--- a/Documentation/vm/overcommit-accounting.rst
+++ b/Documentation/vm/overcommit-accounting.rst
@@ -34,7 +34,8 @@ The Linux kernel supports the following overcommit handling modes
 The overcommit policy is set via the sysctl ``vm.overcommit_memory``.
 
 The overcommit amount can be set via ``vm.overcommit_ratio`` (percentage)
-or ``vm.overcommit_kbytes`` (absolute value).
+or ``vm.overcommit_kbytes`` (absolute value). These only have an effect
+when ``vm.overcommit_memory`` is set to 2.
 
 The current overcommit limit and amount committed are viewable in
 ``/proc/meminfo`` as CommitLimit and Committed_AS respectively.
-- 
2.31.1

