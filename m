Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7641146735F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379253AbhLCIpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244591AbhLCIpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:45:33 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941E0C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 00:42:09 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id r138so2331975pgr.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 00:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oNl1dPsoonmN0wsntitOn+ywp8tL5gZtZEHtz49A/+A=;
        b=dpRsKXdhMLY+7J369KC/2xcL+pc75roCldPVjIPMO3zy+hyxM1Pxdiu4I77GR9ZqIQ
         VFzh48VFnezn3FvHBU2lHnmGhv+AHqCbvRbctg0EMtFwaW4q6Y/baZP567PH6nHPADKm
         hVz9kLZwP36rkdTQxClon+HMpqlc2CrG1EmwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oNl1dPsoonmN0wsntitOn+ywp8tL5gZtZEHtz49A/+A=;
        b=E0RU30XLhR3mT3SVr31uPtYja4oys3HTV5x4SIqAmemko6kTLNGDtCG3KAvLN0lUyv
         /VASbLzAPH3OLO3qZ1erOLNDqveWUJ7YRJ7f+79Emcruk45cChCF7CLCT9r7IKeFuJBI
         y8M7ogMUuO/nQJLibHke9iF8uTcvIIZ+dbwxFe0+JC2GIQngsn0ArF/K3W3vJCPZUfzp
         3zJXBtPgh/4lVMU7hSMfdS39P1hABnAj0W0FmCv8nrLmeWkTeoKNJubQkmuHZ1Rqt3O9
         SD8PSLz9sgDDX9cOyWAVaa31W5N6EfbSdK30thMwfCq+Z3e2NKkf510qGmo3jM/OnaSJ
         Bxrg==
X-Gm-Message-State: AOAM533q5GgpKn1pqcdCLMn97qeFTf5l/kmMzM3NLxsfEgFyeKpX3oG4
        jzeoepP681JeezcdS4k+aGLRBA==
X-Google-Smtp-Source: ABdhPJyOy8ffZZnS+s5ovtWMxYJu6Vzj9ztrrcFa0AOJOrmQvAq2vmGVBsOci68ApP5tbeSnFIYuAg==
X-Received: by 2002:a63:e4f:: with SMTP id 15mr3592692pgo.336.1638520929127;
        Fri, 03 Dec 2021 00:42:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i191sm1767486pgd.90.2021.12.03.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 00:42:08 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] char/mwave: Adjust io port register size
Date:   Fri,  3 Dec 2021 00:42:06 -0800
Message-Id: <20211203084206.3104326-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; h=from:subject; bh=5T/cb6qBbQUM3Yq2Kyl3dwrDm/iPoU3ceF6IrYcyUWc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhqdhdV8aZb3Pa0k+gkAxlBz7ZOATIJYlBCUcs0gjH jZo/Ky6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYanYXQAKCRCJcvTf3G3AJlUkD/ 9FJHxNsM5brHv0iTkRs5cQf2XcRsTnhCb3zlFsIbloaJKIs/LId8HcpBvhLD5srf0sGO+rkH8qSWZ2 D+Q2xUXXcd7VceJpWU+8rvqf8nudvR+cx8FtGnQ/EDj0EP+2CM6q1OnwxRy02u5NQpuQQAXo4izkmR t57W18HeKbaVPU9IYVY68rCvYFM49HrbPGO1d+d6IL7Th/smpVndSMmM+EKdsDkZo4ydxWT6zpxGIj eofAQ+PkMANDh+rvyFxQ1I42enGMC2zklWfy/L4tZVXTCZo09gBMkg4N7kTPwUssN+UGlBr81O4oxy DF3GFivbKldbEAnjIEXA1nJmim9f9BCYQ0badB4Goh/hlYCsJHs06F28gAGyt2fbh6He4iTM9Zoqm2 kAYfM+3fU34/C5ANTLXJCwQmTaxxlnMfj9ZJgPfBjuTHddRkNPuNw2AimqqQgv9xXaIpCyL1pjehaq qp6UmB8M7ndbJE6g7TpOBq+xYqnndthOUO9WJSberG8uq7xU9IgeVRinyNIM4kzLN1snzM028+uXSD Au2l8AHwkVRf5ZxqzGMU+UbhJiGZaYLYcoozn/B/AzUayQP5OPUnlJTAE+bGbAfTdGh4NWrnuJqMhU p9rVuel7wR04sHDU9yGz4cz0s7ZZlcrkw2WdUBrIn1tZ47n9nov30kA14UqQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using MKWORD() on a byte-sized variable results in OOB read. Expand the
size of the reserved area so both MKWORD and MKBYTE continue to work
without overflow. Silences this warning on a -Warray-bounds build:

drivers/char/mwave/3780i.h:346:22: error: array subscript 'short unsigned int[0]' is partly outside array bounds of 'DSP_ISA_SLAVE_CONTROL[1]' [-Werror=array-bounds]
  346 | #define MKWORD(var) (*((unsigned short *)(&var)))
      |                     ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/char/mwave/3780i.h:356:40: note: in definition of macro 'OutWordDsp'
  356 | #define OutWordDsp(index,value)   outw(value,usDspBaseIO+index)
      |                                        ^~~~~
drivers/char/mwave/3780i.c:373:41: note: in expansion of macro 'MKWORD'
  373 |         OutWordDsp(DSP_IsaSlaveControl, MKWORD(rSlaveControl));
      |                                         ^~~~~~
drivers/char/mwave/3780i.c:358:31: note: while referencing 'rSlaveControl'
  358 |         DSP_ISA_SLAVE_CONTROL rSlaveControl;
      |                               ^~~~~~~~~~~~~

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/char/mwave/3780i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/mwave/3780i.h b/drivers/char/mwave/3780i.h
index 9ccb6b270b07..95164246afd1 100644
--- a/drivers/char/mwave/3780i.h
+++ b/drivers/char/mwave/3780i.h
@@ -68,7 +68,7 @@ typedef struct {
 	unsigned char ClockControl:1;	/* RW: Clock control: 0=normal, 1=stop 3780i clocks */
 	unsigned char SoftReset:1;	/* RW: Soft reset 0=normal, 1=soft reset active */
 	unsigned char ConfigMode:1;	/* RW: Configuration mode, 0=normal, 1=config mode */
-	unsigned char Reserved:5;	/* 0: Reserved */
+	unsigned short Reserved:13;	/* 0: Reserved */
 } DSP_ISA_SLAVE_CONTROL;
 
 
-- 
2.30.2

