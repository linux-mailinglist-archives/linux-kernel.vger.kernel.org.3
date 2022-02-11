Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770B04B3106
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353996AbiBKWuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:50:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiBKWuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:50:35 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E5EBF7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:50:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da4so18526789edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcspW8BOC7gprYmbQyCTwvMvOW+ct12yiQT4Y+blshI=;
        b=FXTsVwMOx8ikCAeIkWkk/QrqjhPnrM4OHfZeZCi2VoHpuLBejGYLJ6JtbT4G9mFp9m
         0ZElC/QUl0MwaAMH8hdlTmNO4unJ/eTuL1nC99AwE3BY9jLHubAaRZs4Ef34m+GC4cHb
         +wWwbru//5F495I+vfzOyUavleVOgvWj6WhKxOMZWfiuXnp5gcf5Of6WX9j2jh7vjnts
         +vhMHdqTPcLjAh1Cvs+7jxZ7okghHUpdwvxcT5j35J33zb+WkqKRD+StsXYHhw5kCoVV
         LbsiE4CIr3b5GcSakwwYPnpb6VH9GB+MDMq7tCaPm5pahx6SSMZDrt/I5ToF7U6M2SKs
         xEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcspW8BOC7gprYmbQyCTwvMvOW+ct12yiQT4Y+blshI=;
        b=xfUOqQDkZUdvC/UyYqQKmWPjIJ5fVmnUHJYz1IsThS/AxGuDsIDFS/ujaWGUuTzyli
         GrNKUU0WNUWbF9AIeHu9527JFO4cUS9qXJpb9ayFyd3plqOy+GHzdqFfFX+3w4PDaAiV
         0KFj+xl1JAL8Nq5OPXsToMMaN9JrD8PA5U3D8lzfUm9IprFpLxs4kjn+aMsf4ALMBD2z
         wx8AWasQPiqmGHLkQetyB6mnPYm/LAKccmAKxojtKAwQxaSf0YlG2M3UB3e+rjTONl+a
         BUJW1XkRu6r1u0HWLVc99ZJODfd3p8PSMSJig/f7EGLzKedVcFNCskZp8/j1GgEO9Zz9
         e+gg==
X-Gm-Message-State: AOAM532dN/2eaocTZXJvzY9/ONd8q+bfQMurkC5Md+Bk4bWfcI1ntslP
        FcDk9mkNFmrh7oe+c0Tr5GM=
X-Google-Smtp-Source: ABdhPJyo1mdYTD9Zd4XutbjgPR5bwtuijyP2u8zuY+6DhAIpjt6keclzyjY/Z488UXu5AwDUL3edmA==
X-Received: by 2002:a05:6402:ca8:: with SMTP id cn8mr4176533edb.346.1644619831997;
        Fri, 11 Feb 2022 14:50:31 -0800 (PST)
Received: from localhost (93-41-254-190.ip84.fastwebnet.it. [93.41.254.190])
        by smtp.gmail.com with UTF8SMTPSA id d6sm2997971ejo.224.2022.02.11.14.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 14:50:31 -0800 (PST)
From:   Matteo Martelli <matteomartelli3@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH 1/1] ALSA: usb-audio: revert to IMPLICIT_FB_FIXED_DEV for M-Audio FastTrack Ultra
Date:   Fri, 11 Feb 2022 23:49:13 +0100
Message-Id: <20220211224913.20683-2-matteomartelli3@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211224913.20683-1-matteomartelli3@gmail.com>
References: <20220211224913.20683-1-matteomartelli3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 83b7dcbc51c930fc2079ab6c6fc9d719768321f1 introduced a generic
implicit feedback parser, which fails to execute for M-Audio FastTrack
Ultra sound cards. The issue is with the ENDPOINT_SYNCTYPE check in
add_generic_implicit_fb() where the SYNCTYPE is ADAPTIVE instead of ASYNC.
The reason is that the sync type of the FastTrack output endpoints are
set to adaptive in the quirks table since commit
65f04443c96dbda11b8fff21d6390e082846aa3c.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 sound/usb/implicit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index 70319c822c10..2d444ec74202 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -47,13 +47,13 @@ struct snd_usb_implicit_fb_match {
 static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
 	/* Generic matching */
 	IMPLICIT_FB_GENERIC_DEV(0x0499, 0x1509), /* Steinberg UR22 */
-	IMPLICIT_FB_GENERIC_DEV(0x0763, 0x2080), /* M-Audio FastTrack Ultra */
-	IMPLICIT_FB_GENERIC_DEV(0x0763, 0x2081), /* M-Audio FastTrack Ultra */
 	IMPLICIT_FB_GENERIC_DEV(0x0763, 0x2030), /* M-Audio Fast Track C400 */
 	IMPLICIT_FB_GENERIC_DEV(0x0763, 0x2031), /* M-Audio Fast Track C600 */
 
 	/* Fixed EP */
 	/* FIXME: check the availability of generic matching */
+	IMPLICIT_FB_FIXED_DEV(0x0763, 0x2080, 0x81, 2), /* M-Audio FastTrack Ultra */
+	IMPLICIT_FB_FIXED_DEV(0x0763, 0x2081, 0x81, 2), /* M-Audio FastTrack Ultra */
 	IMPLICIT_FB_FIXED_DEV(0x2466, 0x8010, 0x81, 2), /* Fractal Audio Axe-Fx III */
 	IMPLICIT_FB_FIXED_DEV(0x31e9, 0x0001, 0x81, 2), /* Solid State Logic SSL2 */
 	IMPLICIT_FB_FIXED_DEV(0x31e9, 0x0002, 0x81, 2), /* Solid State Logic SSL2+ */
-- 
2.35.1

