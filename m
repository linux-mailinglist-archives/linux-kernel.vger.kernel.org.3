Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99ED249D1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbiAZSV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:21:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233537AbiAZSVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643221311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=41Yq0Jiu/p4386qMAQJe5Ihi0AXyzAek0DT2V3OPlfI=;
        b=HJbAk2z7127CFsMMr8lZAZ0/twu5VnePO+7b4rdqPuEcwoOQ/VaB8e+0atYDg3lN5MPVGr
        Flg4zY0YmUp2aoPjzvV216/dg2/R94flt9P86+DRr4Z8CXeOaSBVFb6dtUmRSupDN5CDyB
        v71Ryj8Ur/ReJCs6TKCNugsJLEXVD0o=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-2gLVIMFBOcGCiXoMMk_JJA-1; Wed, 26 Jan 2022 13:21:50 -0500
X-MC-Unique: 2gLVIMFBOcGCiXoMMk_JJA-1
Received: by mail-oo1-f71.google.com with SMTP id r25-20020a4ae5d9000000b002c9ad00c5a5so206682oov.22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=41Yq0Jiu/p4386qMAQJe5Ihi0AXyzAek0DT2V3OPlfI=;
        b=G+oJ6GZ5tyk3xO2jVlx1b2z+dRvJyVIQs6xQcdS8wc4/V/Sz4EwzbrBofnnrazh7hP
         31NdLa/qw1NqFl2mgPYZPkAO8eYbpBhx2Twe2P0G995vBFJ9tfsf0reKh2MzP/mnaijT
         k9T+sOKeTNxRONf6NAATJD+1mmDoPcNyg1ri3tWr/sy3ACD1j7k3oYV6p/NUSpfS2naD
         okSKl1xu7RaEwQsKmjFmtH28knz9RyM/1QN0bwe3pRypgbVn8/dAT938KG+NYV+nSFel
         oRT1FQZF81WPnPSZ0weVEDyrFpsi1FwWMHfzauPXRlTPIvklolRR+YA0ix2FGgGALWeG
         kGvQ==
X-Gm-Message-State: AOAM5305eSkVyRPOKpS2Fk1unbDAsKHYWdz3rYPzKMUQ+OTH4p3JFuw9
        jA9NqguIs+2Amw9E+20NHhZ20P/IRdbm5kUd3GDNQ7kMfRsfnFGppGhEBLd8dDgnnl0Ck5LIbwi
        ERpHtzvHdJ9WJkmYI30nsL0D0
X-Received: by 2002:a05:6808:2107:: with SMTP id r7mr4948677oiw.18.1643221309971;
        Wed, 26 Jan 2022 10:21:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEM82EpXlXd4VOeoPb1JwrJ3tw7RGrD/fSFwmY+6hFf0R10tOQz6ajGuRba8/BQVR+U0tLxQ==
X-Received: by 2002:a05:6808:2107:: with SMTP id r7mr4948668oiw.18.1643221309819;
        Wed, 26 Jan 2022 10:21:49 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h1sm3748002otl.37.2022.01.26.10.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:21:49 -0800 (PST)
From:   trix@redhat.com
To:     perex@perex.cz, tiwai@suse.com, nathan@kernel.org,
        ndesaulniers@google.com, kai.heng.feng@canonical.com,
        jiapeng.chong@linux.alibaba.com, giun7a@gmail.com,
        colin.king@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: usb-audio: initialize variables that could ignore errors
Date:   Wed, 26 Jan 2022 10:21:42 -0800
Message-Id: <20220126182142.1184819-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this representative issue
mixer.c:1548:35: warning: Assigned value is garbage or undefined
        ucontrol->value.integer.value[0] = val;
                                         ^ ~~~

The filter_error() macro allows errors to be ignored.
If errors can be ignored, initialize variables
so garbage will not be used.

Fixes: 48cc42973509 ("ALSA: usb-audio: Filter error from connector kctl ops, too")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/usb/mixer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index e8f3f8d622ec5..630766ba259fd 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1527,6 +1527,10 @@ static int get_connector_value(struct usb_mixer_elem_info *cval,
 		usb_audio_err(chip,
 			"cannot get connectors status: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
 			UAC_GET_CUR, validx, idx, cval->val_type);
+
+		if (val)
+			*val = 0;
+
 		return filter_error(cval, ret);
 	}
 
-- 
2.26.3

