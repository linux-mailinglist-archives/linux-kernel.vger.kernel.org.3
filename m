Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D92585849
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbiG3DeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiG3DeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:34:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C86BD62
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:34:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id iw1so6121639plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2Kumxoqs7AvCSJdhNcNxhF7BApmJfZRgV7qFRKrYcUE=;
        b=hmXTRIA69MzhV74YEMUufK9wSgn3Edu17dSLeKTg60rUDBDPGw6WDGkCvrU6HA3Phg
         gwajv/4uoyfPPZBsuwBW65VfdQyl9GAzy4Tanf/VmpXhMkcbpOz1Dfdhosx2FhSvPHBt
         gjfdZ4ocXiyrsJIdgZ+uETLcucHUV7+GRTQXidxxFQQ79VI9yrBhwe4K3ZOwidKYppjH
         leYx+zMrJsnt5F47O9SAoWd6XDgVsUkOUzUvsH2FK+9rvv9GdDeeDX9AZ9LKOQwWqSNV
         knB/4dzKRtJyeJe4pqfwjy8gY/j/OqJwdgS8mtwuuKny/xLLw7IBz2UPOH76pC3rHuZk
         mtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2Kumxoqs7AvCSJdhNcNxhF7BApmJfZRgV7qFRKrYcUE=;
        b=Jr9i8cSx6Xn0AGpwLf3iUY7KGAPBHXkwQhrgjtxkHkfVZiHn+f9k0FqcHahzcNsnJg
         Q21wQPbJBa1JNz2c2FfIiJnTgFUTTkwLpUnk2dN8qGDIiYtHimWqnfazXaCPs+j/y1Og
         eP/2Ii37MwHIcqX9mv+TAwJ3geposjenPWP50giEIWXZoFucxLZBhV2qKRI3TP6DAash
         MhKEUZlKVi+CcPdyvoPd7FLR5XatUgQRGPVzHt85wFCRKMMpddJRaxBaIeQurHfBbKx6
         o6wJMPxVH52pp3dQbXrz55emxBB417PMRVNaGb8WOYkkdgWU6z+qoJ/cGmiO/r4s/m2p
         UC3g==
X-Gm-Message-State: ACgBeo0PjF3zO/2Va5jDsGcd8bTCujgMYukF+fhN8oSjtGCE1Kjoj5ap
        JamoZ/PkTLWLqPwIeyhoInE=
X-Google-Smtp-Source: AA6agR6wabXPHPGmRpggvNsopcw/KJSlTV4qOHdg3UtL38sXWVKODrDtwk6vWpe4OJxwQo4NQelRTA==
X-Received: by 2002:a17:90b:4b4f:b0:1f3:19ed:37b5 with SMTP id mi15-20020a17090b4b4f00b001f319ed37b5mr7913275pjb.108.1659152042180;
        Fri, 29 Jul 2022 20:34:02 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:f0d:9a23:40c8:9423])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170902f54300b0016a3248376esm4441555plf.181.2022.07.29.20.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 20:34:01 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v4 0/4] staging: rtl8192u: fix rmmod warn when device is renamed
Date:   Fri, 29 Jul 2022 20:33:20 -0700
Message-Id: <20220730033335.74153-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YuOLybUZ8cBWntY/@kroah.com>
References: <YuOLybUZ8cBWntY/@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 debug files created under /proc/net/[Devname] by
rtl8192u_usb. Devname could be wlan0 initially, however it could be
renamed later to e.g. enx00e04c000002. This will cause problem during
debug file teardown since it uses netdev->name which is no longer wlan0.
To solve this problem, add a notifier to handle device renaming.

Also, due to this is purely for debuging as files are created read only,
move this to debugfs like other NIC drivers do instead of using procfs.

The directory structure after this patch set will be like the following

  /sys/kernel/debug/r8192u_usb/wlan0/stats-rx
  /sys/kernel/debug/r8192u_usb/wlan0/stats-rx
  /sys/kernel/debug/r8192u_usb/wlan0/stats-ap
  /sys/kernel/debug/r8192u_usb/wlan0/registers

Also note that we cannot simply do debugfs_lookup to find out old dentry
since by the time the notifier is called, netdev->name is already changed
to new name. So here we still save the original dentry.


Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Tested-by: Zheyu Ma <zheyuma97@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>

v2: break down patch and fix pointer check
v3: removed unnecessary checks, casts and move debug files under module's
own directory, only minor change compared to v2
v4: move cast fix to one commit. use KBUILD_MODNAME for debugfs dir name

Tong Zhang (4):
  staging: rtl8192u: move debug stuff to its own file
  staging: rtl8192u: remove unnecessary cast
  staging: rtl8192u: move debug files to debugfs
  staging: rtl8192u: fix rmmod warn when device is renamed

 drivers/staging/rtl8192u/Makefile         |   1 +
 drivers/staging/rtl8192u/r8192U.h         |   9 +
 drivers/staging/rtl8192u/r8192U_core.c    | 226 ++++------------------
 drivers/staging/rtl8192u/r8192U_debugfs.c | 188 ++++++++++++++++++
 4 files changed, 241 insertions(+), 183 deletions(-)
 create mode 100644 drivers/staging/rtl8192u/r8192U_debugfs.c

-- 
2.25.1

