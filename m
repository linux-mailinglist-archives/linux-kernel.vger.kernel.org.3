Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB2149E4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbiA0Ooh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242575AbiA0Ood (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:44:33 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5752DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:44:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ah7so6379595ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5yz10nLPgMlrkWVAwaUxDSGwjhQp8dD2oPAz5UmbOk=;
        b=IVS9CIB8/AivDcBztvuLvEwbz3QXtRhgtoDxXiXszgbHxkHrkg504y8Qxnch10IXj0
         Op7gy4ZNShKuq90npTDHa82csurg5mNzU8+DzZdfZgGryFslgttHFaJrv2dZZajBRDeZ
         ioI0TvPi6HK9Gy5zoXbxa9C4xM6mxFS7OUjo9z/cP+QTMiYVrUtV2hB+My9mrnGtrpKF
         YJWOPIg3XhTx9BxNjTnQ974KvB+TCscni385gPCl8NrZQVcaDWoYkpoxfhapO/k36r1a
         vHEsYJbh47W2kmvJhFQBVD5+I14Cch1VYuMUrTk7zpIub+ZjYuwTM4VdrBu/yIwge9ez
         ZJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5yz10nLPgMlrkWVAwaUxDSGwjhQp8dD2oPAz5UmbOk=;
        b=I7bvgpgweTqb6a1SCZudD9E5j9n1y0G2yC9mYjd033I/0wx1HVNtIEO4J1dPtz1dlu
         llNj6cJFc/WSGEwwE9xVcEnVx6nz8ws46rSC7/B/6fVqQWY59YcGUYGe12F0u7Iskvjt
         mTebRgfQCIHVtlnaUvHTCT/iuOWqp6mhZwhIJjvTjUWpvFR8hYJYTKkQgJJ6WCxpJRUw
         ZuU5yFPCxLB1YXiqOSQr+sxWc+jlVzMabpK8hIeS3VKgvchYF1monb5erMsjfZ2h7nqg
         tbVfYBi/4Q2Elus2rCHAwVaAunJPGGb+Hl5LT2bQT/DvZ2tXbx56hg16mG9qwT3uclye
         VqhQ==
X-Gm-Message-State: AOAM532QTfpxtwFR1g0mQ96RCT+28oVbqbaO48qWx4Wxi/2E/tmk9dvo
        MKotFRs+txQIklaOc+76sXCuhR8TLJsaBC18Tnw=
X-Google-Smtp-Source: ABdhPJyhkYLBdPSPrB0ft0QUPYqGO8skmRkHbl2vHmKR6f6dE2b2ZXMaMN5A6o/voT0xHWRIunPcxg==
X-Received: by 2002:a17:907:e9e:: with SMTP id ho30mr3084101ejc.648.1643294671950;
        Thu, 27 Jan 2022 06:44:31 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id lo15sm8746533ejb.28.2022.01.27.06.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 06:44:31 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Bos, H.J." <h.j.bos@vu.nl>, Thomas Gleixner <tglx@linutronix.de>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] vt_ioctl: add array_index_nospec to VT_ACTIVATE
Date:   Thu, 27 Jan 2022 15:44:05 +0100
Message-Id: <20220127144406.3589293-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127144406.3589293-1-jakobkoschel@gmail.com>
References: <20220127144406.3589293-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in vt_setactivate an almost identical code path has been patched
with array_index_nospec. In the VT_ACTIVATE path the user input
is from a system call argument instead of a usercopy.
For consistency both code paths should have the same mitigations
applied.

Kasper Acknowledgements: Jakob Koschel, Brian Johannesmeyer, Kaveh
Razavi, Herbert Bos, Cristiano Giuffrida from the VUSec group at VU
Amsterdam.

Co-developed-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/tty/vt/vt_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index e0714a9c9fd7..58013698635f 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -845,6 +845,7 @@ int vt_ioctl(struct tty_struct *tty,
 			return -ENXIO;

 		arg--;
+		arg = array_index_nospec(arg, MAX_NR_CONSOLES);
 		console_lock();
 		ret = vc_allocate(arg);
 		console_unlock();
--
2.25.1

