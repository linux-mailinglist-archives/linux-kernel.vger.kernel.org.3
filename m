Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AFD584A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiG2Dxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiG2DxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:53:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805047E83C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:52:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bh13so3078920pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqJty/jAzkS9ddhZQ1LDWqDzmo4hUT9KrNKCMusTL4A=;
        b=FlPfntePR/J/cEvMPOmNckBJmON2t0BOxiMCZwbuKxVMJVJ3RL9U0W+4++BtQa0ZaI
         3+OJoGYekSFqxNRUOyokFw4gHIrslHTMLcNnUffuKSWwwGhcB4t31Un5lj0ibI/4S6gF
         m0fdAPM4OlSHLsKBbcCh1Yp21moOKqU4FIVJapUqSca0nlEgdvtBZGoy/gjMRMtJ3JFX
         0zJ4F1mU8PIDkCONY9XMxkuKo36NE4ntbSwaWgCBgxrCh5CNFkjQwDmhfg0ZNiPC2bDK
         7gkM4XSuUptSl/i8Px/id6GOslM4VcO4Qz04h2j+c/s4ejnETiyk4VLV9Iq51ywnOx1Z
         aO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqJty/jAzkS9ddhZQ1LDWqDzmo4hUT9KrNKCMusTL4A=;
        b=LZQZop/iqa8+pSPxPwa6iyeT47l3AEyE+Bv+deNOrLI9k/lqJzpVYzrvUuDvJAH7gf
         +5cz7XqT0XpnfZlyTZtxxZn0E6vraAv6ToIf4UGo3mbKOn+dznVCQ7sX0rlednqZx+H3
         J/5LVg+TelOINHxaJw/lxK1fuCS1wD6Kq+V1nTO/Vpocbd03IWOMlWuceIEtYCiqUVsJ
         NeX1sUBSI4wKdCOoFoNDVsQQs1GcBWsJRiUs9yDXlXJCLmxbluhZ7Ho8QF1DnqSkMKhi
         cU+yi0jKUWrEVYsgdk9lSgpa8dKuPQ7Ty+iXCsQDEPDaTmmtFPEHALGHCApCK4g0HSGK
         FvaA==
X-Gm-Message-State: AJIora/Wzgyi5WvLMAMxLdi+83+SStoOcYHZLoXyyFbSIIYLh0nX95mk
        l8rACpUbvwF49z9q2m4uEmbScXqv0Wyw+g==
X-Google-Smtp-Source: AGRyM1sIJs3Dnljo1GEigT/XZ3kQLINUljpQF9FQob2GwqnjrXIMkOa8h/tRyK4fRHE6hRi8QVGmkA==
X-Received: by 2002:a63:d64e:0:b0:41a:b83d:1b2a with SMTP id d14-20020a63d64e000000b0041ab83d1b2amr1429057pgj.122.1659066761783;
        Thu, 28 Jul 2022 20:52:41 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:a06b:5560:ec65:277f])
        by smtp.googlemail.com with ESMTPSA id h14-20020a170902680e00b0016d2d2c7df1sm2135478plk.188.2022.07.28.20.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 20:52:41 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v3 0/3] staging: rtl8192u: fix rmmod warn when device is renamed
Date:   Thu, 28 Jul 2022 20:52:17 -0700
Message-Id: <20220729035230.226172-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YuDdHMaB6jWARQzA@kroah.com>
References: <YuDdHMaB6jWARQzA@kroah.com>
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

Tong Zhang (3):
  staging: rtl8192u: move debug stuff to its own file
  staging: rtl8192u: move debug files to debugfs
  staging: rtl8192u: fix rmmod warn when device is renamed

 drivers/staging/rtl8192u/Makefile         |   1 +
 drivers/staging/rtl8192u/r8192U.h         |   9 +
 drivers/staging/rtl8192u/r8192U_core.c    | 226 ++++------------------
 drivers/staging/rtl8192u/r8192U_debugfs.c | 189 ++++++++++++++++++
 4 files changed, 242 insertions(+), 183 deletions(-)
 create mode 100644 drivers/staging/rtl8192u/r8192U_debugfs.c

-- 
2.25.1

