Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BA54B3102
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353089AbiBKWuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:50:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349567AbiBKWuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:50:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED8CE8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:50:15 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k25so25717513ejp.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XILlkk2L3b07v1N1F7CzmrlG0VmkJzs2REfoQvxKppI=;
        b=pKauQUHfJvUX4QTi9jiOV07/eUcBuqN4NR6Px+vcOPx7BsXola8J0RAymaEv4wK0eF
         WssHdIv67sK6ZZ2CL/mMr0+3ei1DPoz0jR1ROq1ami/WpU1gBAB+Ys77IGfqUzETneUs
         +hDc9gLghp5FfD19rdne4gBfPStWjf9+5NF3a7jGrSEmeTV84qoFBl6ihHm+ji3kMuDz
         hwlkjWmftC3yr8RMH19RGaPA3G3gMVL9cWH4SsCqKrps3aDsfIHt9hTJzbLRX1gfwxh8
         SiusyHCLcOuBiablb3UmfQ1cQISaMZZi/wtWqBHiySaaFWZlzPHczsQKi564dhhgqQ83
         Rz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XILlkk2L3b07v1N1F7CzmrlG0VmkJzs2REfoQvxKppI=;
        b=hZcEUqFhI84sO5XrdF8OSEsf0Ge9OL8SxOYKnNRQ9snXni/2KaEQmW8Lva/mi26x7r
         uV/uT1PTEYC3vSG6D4uyJ23fGYQWZ2Qx9gOg4XeJSua+jsMtUWjnfBZu6AU9ZmNk/WGj
         7D2KiuXgynm6sC5m7EDM4AFxp1NxLGpHyInJBmtK0wpOe1sm8rwV9gsAaRPP3JDr/5GW
         ksuLka/2OwzmRRudFCoCVEVqzrX94ewQPW3vf2eGlcnTuLAvxGot2PHJD0RsbdzQh6NT
         dFvdqz65/GwMZPTOs+oBJjTcjM1h8NefR01In1+4mVxBixf+5jvt+Z2M83bL6ImLVQrp
         uEzw==
X-Gm-Message-State: AOAM532VsHzxfVAjcBgAfAZCBT4ovR9qkb1RPgqDCj6fLDHFC8BBXhDI
        tcObZy3JSOcdVvFs/J4wGwI=
X-Google-Smtp-Source: ABdhPJyAQuvS6yGH2VIWjZic1mtTOhV8arsxLXgIRvxWgmx+CKb8x2OdL/bVxke/qq8SwlNR3TlVtw==
X-Received: by 2002:a17:907:3d8f:: with SMTP id he15mr3026001ejc.246.1644619814588;
        Fri, 11 Feb 2022 14:50:14 -0800 (PST)
Received: from localhost (93-41-254-190.ip84.fastwebnet.it. [93.41.254.190])
        by smtp.gmail.com with UTF8SMTPSA id q13sm4814631eji.2.2022.02.11.14.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 14:50:14 -0800 (PST)
From:   Matteo Martelli <matteomartelli3@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH 0/1] ALSA: usb-audio: generic implicit fb parser fails with M-Audio FastTrack Ultra
Date:   Fri, 11 Feb 2022 23:49:12 +0100
Message-Id: <20220211224913.20683-1-matteomartelli3@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Hello, I've recently started to experience periodic XRUNs with my M-Audio
FastTrack Ultra while using JACK.
The XRUNs come systematically at precise intervals, where the period
varies from around 1 min to 6 min depending on the jackd buffer settings.
I found out that issue is reproducible since commit
83b7dcbc51c930fc2079ab6c6fc9d719768321f1.

It looks like the problem is in the add_generic_implicit_fb() function
where (fmt->ep_attr & USB_ENDPOINT_SYNCTYPE) is USB_ENDPOINT_SYNC_ADAPTIVE
instead of the expected USB_ENDPOINT_SYNC_ASYNC. This leads to the
failure of the snd_usb_parse_implicit_fb_quirk(), so I guess the
implicit feedback feature is not used at all, resulting to periodic
XRUNs. However, by retrieving the endpoint descriptor with the
get_endpoint(alts, 0) macro, the endpoint mbAttributes are correct and
match the USB_ENDPOINT_SYNC_ASYNC sync type. Also, the attributes
printed by lsusb are again correct showing the "Asynchronous" type.
In fact, the sync type is set to adaptive for the M-Audio FastTrack
Ultra in the quirks-table.h header file. This was done by the commit
65f04443c96dbda11b8fff21d6390e082846aa3c to work around a playback
issue.

I tested my 0x2080 device with the 5.17-rc1, 5.16, 5.11-rc1, 5.10.
The issue is reproducible with all of them except for the 5.10 where the
implicit feedback was still declared as "fixed".
I also had the chance to have the 0x2081 device tested with kernel
5.16, same issue there.
The following patch is to revert the implicit feedback to "fixed" for the
M-Audio FastTrack Ultra cards until the issue is not entirely covered.

Matteo Martelli (1):
  ALSA: usb-audio: revert to IMPLICIT_FB_FIXED_DEV for M-Audio FastTrack
    Ultra

 sound/usb/implicit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.35.1

