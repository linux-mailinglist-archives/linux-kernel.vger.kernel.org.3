Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797E557DCDF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiGVIuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiGVIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:50:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC7A28E0B;
        Fri, 22 Jul 2022 01:50:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 12so3677843pga.1;
        Fri, 22 Jul 2022 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pgt3B8Mk6hzHexkwWSUpURVE6bVjaRrgC1Jzib8Uvgo=;
        b=fuAfY/jrnEl/zT0Bkg422Q0EGBqVY533MZMJ25gpLsnPu/y46yqy0mgm9jo5fQjUGO
         JGhkasnCK3MjhEFLNW2AWfQX96zMsmF5Se0vVP7cmSAKbFBmXyYPF0NBSpQ8sIY/rcPX
         5NhDFZrlqxa1wXWMibumin+li4rRtBsyWteLsowMBxifs+lijwcqu3nVGQajxG739eO/
         UNcNoUgpG5JjsBPKf56VBGovilrg+xy7tunGAo6YFSdQwB6FCpMnGgxaokTuAJtOJQCZ
         r25xNLEhcpcrpuya2aq3dPvjxNxcZPefVlshKl08NZC8HtnjNm58ate7aN526NJEofBa
         mq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pgt3B8Mk6hzHexkwWSUpURVE6bVjaRrgC1Jzib8Uvgo=;
        b=8MnKOYrU6cWZTuC83ycfv2zXDi/WUGxGCjB5kFldQCcTZBY6+c8qcb/0pbDN0qojar
         qtN4yRq2Dx+lxtCFQVspFlFO/1pBSm28Hzqlapc/EFlXkhHd/i7b/qFNwI65JlsE68fk
         bD4UuQwv8j0f7pfhFXl7ehbINXB+EBJToZBZ7kVYrvW/4AVV8Bls3t1Tc4CogG0TRazf
         k1PbCCu6ih5064ay95Cl33+3tX3AjRmPJLinXXr065c6aZzqGSHws5mF1tA+yoBGYJmx
         KvXhO2XhrBpnjHoR6NcuxFKEj5r/FZp4uoALlqJnshqaVIsRiGnFLvLR4V1lNE7UiiuZ
         M5ig==
X-Gm-Message-State: AJIora/Xv/0qSbql/oe0vJ/0A5fhEbPSlsLvQ22o9/p9djG5bnBsPUog
        NPOZCeBO37ass40NM0bD0Gs=
X-Google-Smtp-Source: AGRyM1sZaNj+EkBrXdBDlKIqFWzl1zSDddu0Blwgj8QuUbuhYX8EsqNQEEkmPyRipLOpnTiv2xpbYw==
X-Received: by 2002:a63:594f:0:b0:412:96c7:26f7 with SMTP id j15-20020a63594f000000b0041296c726f7mr2414112pgm.110.1658479830555;
        Fri, 22 Jul 2022 01:50:30 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090a744300b001f24dfedb94sm733678pjk.53.2022.07.22.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:50:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 35E9A104985; Fri, 22 Jul 2022 15:50:23 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/8] Documentation: s390: sync heading underlines
Date:   Fri, 22 Jul 2022 15:49:42 +0700
Message-Id: <20220722084946.22965-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722084946.22965-1-bagasdotme@gmail.com>
References: <20220722084946.22965-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two section headings ("Hot plug/unplug support" and "Overprovisioning ...")
have too short underlines compared to the heading length, hence trigger
repeated warnings:

Documentation/s390/vfio-ap.rst:943: WARNING: Title underline too short.

Hot plug/unplug support:
================
Documentation/s390/vfio-ap.rst:943: WARNING: Title underline too short.

Hot plug/unplug support:
================
Documentation/s390/vfio-ap.rst:965: WARNING: Title underline too short.

Over-provisioning of AP queues for a KVM guest:
==============================================
Documentation/s390/vfio-ap.rst:965: WARNING: Title underline too short.

Over-provisioning of AP queues for a KVM guest:
==============================================

Adjust the underlines length to match the text. While at it, strip trailing
colon on headings since these are redundant.

Link:https://lore.kernel.org/linux-next/20220721205937.10043b5f@canb.auug.org.au/
Fixes: cb269e0aba7c3f ("s390/vfio-ap: update docs to include dynamic config support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/s390/vfio-ap.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/s390/vfio-ap.rst b/Documentation/s390/vfio-ap.rst
index 5bf15d117c4ba0..c0d76a959ed583 100644
--- a/Documentation/s390/vfio-ap.rst
+++ b/Documentation/s390/vfio-ap.rst
@@ -952,8 +952,9 @@ remove it if no guest will use it during the remaining lifetime of the linux
 host. If the vfio_ap mdev is removed, one may want to also reconfigure
 the pool of adapters and queues reserved for use by the default drivers.
 
-Hot plug/unplug support:
-================
+Hot plug/unplug support
+=======================
+
 An adapter, domain or control domain may be hot plugged into a running KVM
 guest by assigning it to the vfio_ap mediated device being used by the guest if
 the following conditions are met:
@@ -974,7 +975,7 @@ An adapter, domain or control domain may be hot unplugged from a running KVM
 guest by unassigning it from the vfio_ap mediated device being used by the
 guest.
 
-Over-provisioning of AP queues for a KVM guest:
+Over-provisioning of AP queues for a KVM guest
 ==============================================
 Over-provisioning is defined herein as the assignment of adapters or domains to
 a vfio_ap mediated device that do not reference AP devices in the host's AP
-- 
An old man doll... just what I always wanted! - Clara

