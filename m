Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656255792C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiGSFwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGSFv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:51:58 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848513340E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:51:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p8so1246516plq.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGreb3otYXicSc9AyATwfdoBfIrCHzGc1xh2ozqtBEs=;
        b=OYOtd68a+OLe314P9GifUJZ4m5i3HRORK2DfvIerbUosILabyXspkzeS5vIBIQ/jrS
         oc+68fW3haoF+noCVEKxfrQah/IRqa25Db3KLUH/emzoGOXrD0QeqQIfxECtcGeLdmZy
         rRUHe8JfuFS6HO3DzmsbPX0wme1xbPcSqO31gbBoanjWiOAp0YNcCgO9wuL2rk37hY6z
         0QmsZy6GRnkyOXNVfFNwGsf+fnqmwt7N/iwEXOPDt94a7QTd3C9uWlFTCDtZLAiSy7SW
         pRP5qX1sDDYxNb687kR0UccQEfflolGuhkAfr12k441kpCaS1umwfOUk9zBrHn9CR9TA
         KASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGreb3otYXicSc9AyATwfdoBfIrCHzGc1xh2ozqtBEs=;
        b=5LTNa+mHoAKEZoLuvNPhtXpv5VxlC4oQ3HwL06DEX8AVOM9A915KsjsblDG4tbjRDx
         d87q3eQkPZiUzmCjyvpaXbe/u2bzY0UEtFeB1aVRlTVLfwPEsPGGYQnODBTFeN7dB4yF
         CXkY4VV25eDHRFOhA5HgPPYChJ6DwO1l5mbMkSKc/QL9b+81r293ZXW7k1Ei9nl0G456
         0MS3Lhx6og0Lzcqgh4dsC6ePvXkLLVB+3MeL9IwKIrRHaGAGT3sU9FGxUtyIOOnX1J4f
         k2kupRnZiQlkOwu+zRWl4VpVYmVl68D0InvKcnr+AEHeXga5b4uHSK+kpI/blAWhtgSH
         lDvg==
X-Gm-Message-State: AJIora9mrFgZtSQ3XyH8VHmSFgSxJ3W+oCKCseFPh6ltJcVOvO3ZEN8+
        IDfkjVOy2IBLSioHAcJMPKE=
X-Google-Smtp-Source: AGRyM1sX9nh7byGS6CEA4k7+qgl41c1iGJZdTnsJrRtnXvbhEqxKSuT1A3hHcenz54XRD4jULoHh1w==
X-Received: by 2002:a17:90a:bc8c:b0:1ef:91ca:1c24 with SMTP id x12-20020a17090abc8c00b001ef91ca1c24mr42539239pjr.81.1658209916771;
        Mon, 18 Jul 2022 22:51:56 -0700 (PDT)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:33db:e37c:7ee3:662b])
        by smtp.googlemail.com with ESMTPSA id a16-20020a170902ecd000b0016c20d40ee7sm10709338plh.174.2022.07.18.22.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:51:56 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     dan.carpenter@oracle.com, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2 0/3] staging: rtl8192u: fix rmmod warn when wlan0 is renamed
Date:   Mon, 18 Jul 2022 22:50:35 -0700
Message-Id: <20220719055047.322355-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718120149.GD2338@kadam>
References: <20220718120149.GD2338@kadam>
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

There are 4 debug files created under /proc/net/[Devname]. Devname could
be wlan0 initially, however it could be renamed later to e.g. enx00e04c000002.
This will cause problem during debug file teardown since it uses
netdev->name which is no longer wlan0. To solve this problem, add a
notifier to handle device renaming.

Also, due to this is purely for debuging as files are created read only,
move this to debugfs like other NIC drivers do instead of using procfs.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Tested-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>

v2: break down patch and fix pointer check

Tong Zhang (3):
  staging: rtl8192u: move debug stuff to its own file
  staging: rtl8192u: move debug files to debugfs
  staging: rtl8192u: fix rmmod warn when wlan0 is renamed

 drivers/staging/rtl8192u/Makefile         |   1 +
 drivers/staging/rtl8192u/r8192U.h         |   6 +
 drivers/staging/rtl8192u/r8192U_core.c    | 223 ++++------------------
 drivers/staging/rtl8192u/r8192U_debugfs.c | 188 ++++++++++++++++++
 4 files changed, 235 insertions(+), 183 deletions(-)
 create mode 100644 drivers/staging/rtl8192u/r8192U_debugfs.c

-- 
2.25.1

