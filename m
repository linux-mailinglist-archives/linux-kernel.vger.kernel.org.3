Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C067948CF9E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiAMAUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiAMAUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:20:04 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA042C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 16:20:03 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo8232958pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 16:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaHXL0g0eKQR6hRmhIzmoxXK0XO1p+VEaXguQt2Tkks=;
        b=JVNXCkvrxBESUN0CKJrgF0SJzNWzpaIBfJkeuFdHCgA/d1BXVhIs25ErIZTYLSxNtA
         nmx9OSpv437Jx5CU0rCZ3iDGdwJdQ0kbwub7YBF0Ul3cLmBUEwwq8XMBwP0G/O5a/oeP
         7HLQmmVLSVY2Xb49NyNDlMjEZP20md1l0Jkrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaHXL0g0eKQR6hRmhIzmoxXK0XO1p+VEaXguQt2Tkks=;
        b=HN2hdq68ZOfDtXtpqTPcQ2ARPXE38sFhsYp5jQC9SBwdHyCK1NcYgHXzoOWs1g4CF1
         YLLLN/MxtuWjS0NaNv6Fks1j/tjwNsEPmVv/YeSLRFd8tMOdfydbJQejabp5TH3kBuSA
         veMsj0ai3J9h51WmBWV49DNdHo+6fPE2utskEw+b0dMMOu3EHl0YdGLE/Fm2AwWi8kD5
         Fj/kx/X4aeeXBDGU95vC7TVA3daCk58TDpHas7scJ/XYpCJj51dzDlO765wZwm6sP4z8
         5U/4i93xHgn0da+ippqo3dN7s0htKR890dlUpWXRGBax+yCj2CM00/lSwBp4EEoDUxNM
         laIw==
X-Gm-Message-State: AOAM532S6fXgXbk2Tr39n0rD8Kd0dRSHrarV6d07IPTAwmCQtwBYo/AG
        LCLf2IMMI3+uGHdd1Ha4ighsRg==
X-Google-Smtp-Source: ABdhPJwOYD9vshi0Ef8EpsArms2vdaSwLTGVCrtUcdc4kAN6XpVcPubs6RW23KUYpshWYnXBB/VUug==
X-Received: by 2002:a17:90a:bf0d:: with SMTP id c13mr794809pjs.163.1642033203378;
        Wed, 12 Jan 2022 16:20:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d13sm709919pfj.135.2022.01.12.16.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 16:20:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Check for NULL header value
Date:   Wed, 12 Jan 2022 16:20:01 -0800
Message-Id: <20220113002001.3498383-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2355; h=from:subject; bh=eZoIMIPDEwovbeMilW7xqcbbc0G/FfamXhovBEiFFuI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh33AwJm5wI02T1wLY2ibgKRRU1VCKSQ05kH2jPHr4 P6w5YDaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYd9wMAAKCRCJcvTf3G3AJmMkD/ 4/KAPImvAVAfBWfs6pD4KryQTF0ClSiEXSUIF7/J8A7QmvwZxmZTSW0J6MvDTdAqk+eLGU9wVN//vG 6kUvTKY54H7k35r0p3V2+7FLYQ7rXp1aSikZfv6OnYLsXVkUJCOdjlNH2kpGYPj8qHvwuhLFBQjW5c qkTVsx561ft+zf3rFg88/hJILjC5jtc967bZ2WxVC68LyPsqP362PffqBfgQU/4FPLNDC0sg85KxLf B8f1D71iC9LwnNq4Z9oyVs8xXgHXL+1A9kSIB4BX9fcDHJGgTlPfyxAFc7ZBqxru1+HcdpIrIV71yB 5c/oWHUOayBYNW/HzAhcqX/XNcgHK95KoLy7p4znQGGkbH6fSjHihrZFOx3n5beGjgrpsUGaBoOhDX h6mAHxT+SFAPO5youTJcyLiVhVzsrf8MFar/Ggq2Xie9+ZAdBTmv+vmefR1N63KGdFB3iNh066X9Wr P+AsOjG2o396jQEVi7/FP+D1FV2uMHFK2dBmnx4sf72rMp9fdV7XLFMDASSCSeUF2n4DAMTCdmz48y 4GempSyetrAOY/F6z5/vzwOjwYUa+sfRJ16O/lQnqOabMNhczxp6Of8VRmhf0Uq3d0WWIKuH9+XLeS okKTJ9k4NPzlnF4Y8zazLiuoSuXPzxEoCECICvY78oDGdxLLIZlr8+Omt+oQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This is because the compiler sees it is possible for "ptr" to be a NULL
value, and concludes that it has zero size and attempts to copy to it
would overflow. Instead, detect the NULL return and error out early.

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Straube <straube.linux@gmail.com>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 41bfca549c64..61135c49322b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1513,6 +1513,9 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	u8 *ptr = get_recvframe_data(precvframe) ; /*  point to frame_ctrl field */
 	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
 
+	if (!ptr)
+		return _FAIL;
+
 	if (pattrib->encrypt)
 		recvframe_pull_tail(precvframe, pattrib->icv_len);
 
-- 
2.30.2

