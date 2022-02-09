Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3DD4AF49B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiBIPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbiBIPBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:01:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07C53C061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644418901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yOENEFAxeV6WDUDDmj8Y/MC+cvCFTJP4OBxZd3XquaY=;
        b=F+TEaLQaLfLqilmyfIX1yjaWOgSwSDMcSVKR1JI9Sib/eFpzBxKIfpGYOWjmwRXEVHoEia
        ALEl2kuASuFp++7UqhmXoLOGG43sCCW1nKA7OMwh3ooViI+KUJYU+/86F4gQhLQ2RMhbHe
        5CEZP5wcz3kerad/gweX33eibRaduqU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-BgK3Oxj_OrO2MXQbZgQ_Qg-1; Wed, 09 Feb 2022 10:01:40 -0500
X-MC-Unique: BgK3Oxj_OrO2MXQbZgQ_Qg-1
Received: by mail-qv1-f72.google.com with SMTP id cg14-20020a05621413ce00b0042c2706a4beso1739435qvb.23
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 07:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOENEFAxeV6WDUDDmj8Y/MC+cvCFTJP4OBxZd3XquaY=;
        b=2H6/jqEwxQ9r+3aha0s+VERTS8eEk01c0rl+5TpAq0AMtxWxePRjNX3fpY9sIh9I3x
         qocCQtc3+i80eXDnJgeeU3V3gXPTUY8MfXlkSWxYQZ7F7Th+P9lmONagLKUNENhubW56
         Yvq2k9Eg4IdJTo5awoCGyUxvL/79gn6f/E1t9VJAeo1paWEZxoFRvBXM8lZDmQpoNC12
         TWEI6j5J9hJNPP/BJdIVP/WCSFSNMvGzEZhQG4UREBzh4kgJGkSn9Ub0n4Mix3ppbJrW
         HJldcNov4M6GY+sKU/BwS4ltxupGym98pU5osaLNSz5O5eisDAShfSwjtuOmiN3EDhjQ
         mxRg==
X-Gm-Message-State: AOAM532XMz31IxynmAmknYP7Dm3LHJNJOjw1xye3ugQY+fFibvGbD7m+
        0JXXAQagPUQ/Usd03OCjGZZTUgt/Y9DQY60vcplSiVpMiBHkvCSmksFgwwZJrHg1ZlCHO9Py/dh
        OrWf4qG7qdRzz4vHapB1mRsrg
X-Received: by 2002:a05:622a:14d2:: with SMTP id u18mr1562517qtx.615.1644418898987;
        Wed, 09 Feb 2022 07:01:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcj4EjGhN8CzP3asDDyVKZTAdwOuO5eNnV9Dsmlc5T8QSbtReodIbPMN5JR/u4AgiHxsMgYg==
X-Received: by 2002:a05:622a:14d2:: with SMTP id u18mr1562499qtx.615.1644418898824;
        Wed, 09 Feb 2022 07:01:38 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g21sm9338111qtb.70.2022.02.09.07.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:01:37 -0800 (PST)
From:   trix@redhat.com
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: cleanup double word in comment
Date:   Wed,  9 Feb 2022 07:01:33 -0800
Message-Id: <20220209150133.2291856-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'device'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/sound/hda_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/hda_verbs.h b/include/sound/hda_verbs.h
index e36b77531c5c3..006d358acce25 100644
--- a/include/sound/hda_verbs.h
+++ b/include/sound/hda_verbs.h
@@ -461,7 +461,7 @@ enum {
 #define AC_DE_ELDV			(1<<1)
 #define AC_DE_IA			(1<<2)
 
-/* device device types (0x0-0xf) */
+/* device types (0x0-0xf) */
 enum {
 	AC_JACK_LINE_OUT,
 	AC_JACK_SPEAKER,
-- 
2.26.3

