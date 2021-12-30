Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C84819FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbhL3GkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhL3GkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:40:17 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7677C061574;
        Wed, 29 Dec 2021 22:40:16 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id t66so10432969qkb.4;
        Wed, 29 Dec 2021 22:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cIwfZaflpoko90f9f+GhHlDJBhzxJLrAZF5pBbIO9G4=;
        b=RVE9HsNJVpxJbw56kR+2/kPop58RE/UyW4Gr34SrTrawr8MZFxmtcbXowFufwdLDFw
         P4ckVnfQD7MVpwxZQwG8mKcTUFiwO3LeAVZ+xtu8mgA4Fd70LE9wgSZXlyN2nArUO5FF
         bQlbuLCXj6u2pEubG2zaGiYvBE96Jx3Kp739lAF5O0rc11Cx5O3LJC5QQ34BaGQQSG6R
         ZjkUODkL/UxoEQJmiESJqbnzcZT5QzN8Tmg7/0YwD0KTXeFEVxMgpZA1uxN5MA9OAl2J
         S2REfqyzchot7bOpcC6pZHe+3q3mvYWvV5u19jNkYYjzg7dPB8L41z/Bsk2v8kSsbMjN
         t74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cIwfZaflpoko90f9f+GhHlDJBhzxJLrAZF5pBbIO9G4=;
        b=gHxQSVMJdFCqjckSnlrbYzJ2WQgmI5totq+pzB7Ahuu8N9oDHKn+y+L9mDWhFryD3Y
         kvSy/isSPNfayye8yXGfcjY6XmtExb+gHVOkQGOPAdYOWtUuoBqYRCz/dLc/T92quXW8
         MLycD6OVGyY2yRtlmX7F4TEwY/mr5jyFiRJWCeW+VZMrawoPVgldIsSdBGylBnMsIQpx
         bUXAe6SxT/qxXKF3g6og6Tr3i9Ar9kM6XR7gGz98pJwmufxOf/gF5iTTpP+gkgdsCRSO
         J8XiFvyYivtKn8H0hQQCLoXUVC8Iiw7i5pPq+9BN1cjxSqG/LULo3wHWasXdlOP63wk8
         cbkg==
X-Gm-Message-State: AOAM533WzIxy4xEG6kn+BvbgbjFGaU4EWT9qBAnTO7scnLbO3YtpBs4V
        0dvJ3on5cqBwqH60cv9sKzg=
X-Google-Smtp-Source: ABdhPJwGglE3byR5Qj3haGEFsEYwVLn33Bqt++T+24NY0IreJjSZFmsnkp0ZGkGY9rxvOji6TIjoTA==
X-Received: by 2002:a05:620a:4251:: with SMTP id w17mr20880502qko.550.1640846416020;
        Wed, 29 Dec 2021 22:40:16 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 8sm20335546qtz.28.2021.12.29.22.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 22:40:15 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux] usb: xhci-ring: Add return if ret is less than 0
Date:   Thu, 30 Dec 2021 06:40:10 +0000
Message-Id: <20211230064010.586496-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

For the robustness of the code, judgment and return should be added here

The clang_analyzer complains as follows:

drivers/usb/host/xhci-ring.c:

Value stored to 'ret' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/usb/host/xhci-ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d0b6806..c4eefe2 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3721,6 +3721,8 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		ret = prepare_transfer(xhci, xhci->devs[slot_id],
 				       ep_index, urb->stream_id,
 				       1, urb, 1, mem_flags);
+		if (unlikely(ret < 0))
+			return ret;
 		urb_priv->td[1].last_trb = ring->enqueue;
 		urb_priv->td[1].last_trb_seg = ring->enq_seg;
 		field = TRB_TYPE(TRB_NORMAL) | ring->cycle_state | TRB_IOC;
-- 
2.15.2


