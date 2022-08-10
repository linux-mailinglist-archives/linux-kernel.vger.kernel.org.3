Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB8758E69B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 07:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiHJFIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 01:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiHJFHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:07:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA1083F00;
        Tue,  9 Aug 2022 22:07:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z22so17598533edd.6;
        Tue, 09 Aug 2022 22:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=/QGtQjFwrpxqvD/2kl5l0yjrJcEXf60xBhPRPT4PMoA=;
        b=GAe7/3paFERirxke/DBRSvzvyfo3gWidABn7thm95giMW+HV2HqKwT8qUQuiRWv1XN
         ue5u3oJgkxX8+vB5ZTCuGdckZVwFAxgEKMwUB/reIkdRp8E8fhaerBfHmKkgcTvuPKEv
         c8ZDZOgYd4avspD/J2GsUOFl/nv+GlXPY43wEkeZtmJpqBBWGRYUPdG3JwIL8WiCftml
         40p0mA/44jsByBfIJsZxzxi0uZ3w8XW/lAAo5wrPUTXTdsm80pN1fASSj0ohcPkvmVqf
         a77AyZl8o26lasym7opxdvnGs2Hw30CUAvzh+e7vOPAyesecgnFzDfI0wcCvG7+BzBgC
         88Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=/QGtQjFwrpxqvD/2kl5l0yjrJcEXf60xBhPRPT4PMoA=;
        b=dlVgY8S5fkc3r/MKlhkvdPWADtDGe78vUZLOQE1A2WxJe6f3wpd6uGI4bqHtJ5XIV3
         s07X/bnT6QAwtXVa2x6EheeJmeuphGcB03s/KVwLnpSqqVJ/3LFrV0Ib/rW8FkXtCc77
         KjQw86FAYjHa35V8wOUVEXJoZ0q8Rptd6MaCV3mqPgMbXegpQtVqCXYou7n53wi0KZDG
         LeqJWBti60feGb96X6K8OdvKEPXW9kST71YmP+6/CinuxhuQUjUQQLVSLaw+lwJxVocn
         hZrSlfFbkLys8R7fd3FaDfG49gH1rR0OA/dW7U9J+NVygGx9l1jLcxh812SlYcIf8ixQ
         Vefg==
X-Gm-Message-State: ACgBeo1iXEQ9Lzla39k/KeWw2du799nCforn23Y1wdUR/ZwwSX8xIzfk
        /5CgxY7kO9793+uk3sDYhrs=
X-Google-Smtp-Source: AA6agR50NrhEtvIkwWAt2TLZ2+KyugoS0bLjK72bNnhhj6ZmZeHTbWPqCbTWKO6YhrfRBVfwhckfCA==
X-Received: by 2002:a05:6402:c45:b0:442:c549:8e6b with SMTP id cs5-20020a0564020c4500b00442c5498e6bmr865379edb.123.1660108063872;
        Tue, 09 Aug 2022 22:07:43 -0700 (PDT)
Received: from felia.fritz.box (200116b826504800504e9aff21bf95aa.dip.versatel-1u1.de. [2001:16b8:2650:4800:504e:9aff:21bf:95aa])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b0043bbbaa323dsm7009781edb.0.2022.08.09.22.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 22:07:43 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/4] xen: remove XEN_SCRUB_PAGES in xen.config
Date:   Wed, 10 Aug 2022 07:07:10 +0200
Message-Id: <20220810050712.9539-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
References: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 197ecb3802c0 ("xen/balloon: add runtime control for scrubbing
ballooned out pages") changed config XEN_SCRUB_PAGES to config
XEN_SCRUB_PAGES_DEFAULT. As xen.config sets 'XEN_BALLOON=y' and
XEN_SCRUB_PAGES_DEFAULT defaults to yes, there is no further need to set
this config in the xen.config file.

Remove setting XEN_SCRUB_PAGES in xen.config, which is without
effect since the commit above anyway.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/configs/xen.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/configs/xen.config b/kernel/configs/xen.config
index ff756221f112..436f806aa1ed 100644
--- a/kernel/configs/xen.config
+++ b/kernel/configs/xen.config
@@ -34,7 +34,6 @@ CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
 CONFIG_XEN_SCSI_FRONTEND=m
 # others
 CONFIG_XEN_BALLOON=y
-CONFIG_XEN_SCRUB_PAGES=y
 CONFIG_XEN_DEV_EVTCHN=m
 CONFIG_XEN_BLKDEV_FRONTEND=m
 CONFIG_XEN_NETDEV_FRONTEND=m
-- 
2.17.1

