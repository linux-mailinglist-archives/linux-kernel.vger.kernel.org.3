Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D248F4B9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 05:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiAOEYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 23:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiAOEYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 23:24:31 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92D8C061746
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 20:24:30 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t32so4417016pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 20:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cfHd7InBKggohreeo6TzAmVAoKc+zClbIDJTEU/k7sE=;
        b=SX9u92+/2fJvDeBP2v8rFZN7fVMouG3mSDO3/wvSgAKaHI7Sv4H5a3JXMMJYqtZqqN
         3LwAuXYOJpDOspW7oaqoPw4VnQQ+fwj7zTQbA05VfYMvECM4M/vY/vs++jrmO0kOjILC
         +CHQZIp6+AEjd4vB2HXahvrW+QCb/eSagFd7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cfHd7InBKggohreeo6TzAmVAoKc+zClbIDJTEU/k7sE=;
        b=5bBltNC+sm+NPWSUO8Rn1tTO+zWWfm90MorI7HeIcXYQZcnudcCHMRo1Q2pGkgKhCE
         sw4v8OwGe/qfoeOBQbOv1fgNyTxcVMHlhF3PlQXC2l5RpqSUiNgEF9gTBMILydbKWk8X
         5sS/oWa+lxzlqOJS3+r7hg/sB9ogNjyIHezuW7MuGx1+d3wUZB3ypoaeLdYPPTspm6oW
         rGKGjBBE0djjCMrIv4GaCSlgB0S8qciUoGB3aTkAGitmG/My+WUK8UIIccAizTMimvnU
         EwBId86+kV49cnn1GYHVO8fpdIh1GusMu+IkiVmtuag0kyZkWpvCFaD/Ve7CAsQ2sKLQ
         rnPA==
X-Gm-Message-State: AOAM532jyGfzvcTq09iIoeZQ60TEHbU6FZFNMJCnnVsF66ApDyoM55gq
        nWYyC+MjDFoeI8hxQpI74csqFw==
X-Google-Smtp-Source: ABdhPJz9ih5ar8BWOxTELabdEWwF47rVOKy8bBcgJeO3O07v8K/TCocM/wzrxtuBchFZGqNxpR41LQ==
X-Received: by 2002:a63:ad0e:: with SMTP id g14mr10490719pgf.408.1642220669588;
        Fri, 14 Jan 2022 20:24:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8sm12177412pjs.47.2022.01.14.20.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 20:24:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Joe Perches <joe@perches.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/3 v2] staging: rtl*: Check for NULL header value
Date:   Fri, 14 Jan 2022 20:24:24 -0800
Message-Id: <20220115042427.824542-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2346; h=from:subject; bh=0//lkO/0wFXg2CJ7H8evHpq6JQek92k7+udPsATuwMQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh4kx6IoojX1My8JDm3s8RTZJRNnwTPi665D4rHLZS ZBQR7imJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYeJMegAKCRCJcvTf3G3AJv+9D/ 9Ynz91Nz2s14j7d43+u9u8iqDnSN9MWomqbv810lPS7N8T8hC5EZlnk1nbFxvrPDhHw+uPR9PuiKxr t2WRtrzegBAU64+lA5YZdq2ruByk9frXDx/+1pi8eitLVZwUIQJbtYZO2o3XQ0R+EHmoAerTXpdnXS Y+llUjStu73BkWFtMg4AVRC4jagtnF2R0xVXT8LlAzp6z6RHj1LggNlPT+MB1PS7KDb6HmfMtz1Adu b1cDSLqFv2jZWJfzXf2UUCB9BsXMOkNsnT7iPPLN96osQN9U/TVNXqG3IUdtn4X7iBMjcmMowpaXTr 677AZM9KHQJYsJfCcCp6xPHzd7ueJwlAKcXH9kE+hw7/NZV82AWRpuaMcQwiSqfpWIAj03PVKEMbI9 wnpPnBWDPK/8XH+gYuCWYKr1HDgEHmUsR3Ej287pXviHivGPUwJ88v5yWPMjKGQr+Z/2EAIgh1yurq wS1HLipnYH30uQlf1fbQOFA9Cc3UnQ26Vle1WrZH/Qrxjw8rUSdUUbfJxs/oR5gQMlM+VZ0/tS5V13 iMqZTpVjbmAa6+x4kHRZS6/4vr1HMqOCGUhGdtv2aSWSqcz4m6RKLnQ+D68bpENAIXv//dMdLkcN5Y rUDjxw0tlTTkJjXCm5ZTUBXLhJ2OmxJOSLrQdiex/hK0KQ5iHqNRqNrWZjvA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When building with -Warray-bounds, the following warning is emitted:

In file included from ./include/linux/string.h:253,
                 from ./arch/x86/include/asm/page_32.h:22,
                 from ./arch/x86/include/asm/page.h:14,
                 from ./arch/x86/include/asm/thread_info.h:12,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/rcupdate.h:27,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/sched/signal.h:5,
                 from ./drivers/staging/rtl8723bs/include/drv_types.h:17,
                 from drivers/staging/rtl8723bs/core/rtw_recv.c:7:
In function 'memcpy',
    inlined from 'wlanhdr_to_ethhdr' at drivers/staging/rtl8723bs/core/rtw_recv.c:1554:2:
./include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' offset [0, 5] is out of the bounds [0, 0] [-Warray-bounds]
   41 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^

This is due to various paths to the memcpy() where the compile could
see the destination buffer having a NULL value. This series fixes this
by both eliminating cases where NULL returns were impossible and adding
missing NULL checks where values were possible.

Thanks!

-Kees

v1: https://lore.kernel.org/lkml/20220113002001.3498383-1-keescook@chromium.org/
v2:
 - drop get_recvframe_data()
 - add missing NULL checks to r8188eu and rtl8723bs (already present in rtl8712)

Kees Cook (3):
  staging: r8188eu: Drop get_recvframe_data()
  staging: rtl8723bs: Drop get_recvframe_data()
  staging: rtl8712: Drop get_recvframe_data()

 drivers/staging/r8188eu/core/rtw_recv.c        |  6 +++++-
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c  |  4 +---
 drivers/staging/r8188eu/include/rtw_recv.h     |  9 ---------
 drivers/staging/rtl8712/rtl871x_recv.c         |  4 ++--
 drivers/staging/rtl8712/rtl871x_recv.h         |  8 --------
 drivers/staging/rtl8723bs/core/rtw_recv.c      | 11 ++++++++---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c |  3 +--
 drivers/staging/rtl8723bs/include/rtw_recv.h   | 11 -----------
 8 files changed, 17 insertions(+), 39 deletions(-)

-- 
2.30.2

