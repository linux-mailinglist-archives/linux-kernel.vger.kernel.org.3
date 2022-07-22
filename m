Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448057DCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiGVIud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbiGVIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:50:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C4927CCF;
        Fri, 22 Jul 2022 01:50:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so3659631pjl.0;
        Fri, 22 Jul 2022 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGvxZvhnTAZBI+rA5TQMHLllkhlUn2KKMKKwFEJoTrQ=;
        b=jmxWGNPrWZotRVEC446wT5rD74ZsGChwiZJLDeQcbQMpgAfjCjqDcEKhf0E4L9rmUL
         eRQM9QL5om8cfKJnR8u+5T3zVqEgDBjybCw9BpnxKPPMgzsWnEdOeK8/uQxiXl4zQmpt
         B76qQHf47ukLTQfQzN8guLuc7Tfoy6GWYRvouvq5f6Yen9Tbr+7ki7Es7w4TFj+scs4G
         WjKaAxIT3sRvipY2U9/Yne+Zi9m96xmqsNPvxIRghhxqGxaAghH3kFp3Sxz+HgXJtZUO
         dR0/YcKs9ToFzF3LKXdDELoKrn63fzPY8wzKVddc1bcYC3N2uQ+4IkHEZL8E/nqymexS
         24+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGvxZvhnTAZBI+rA5TQMHLllkhlUn2KKMKKwFEJoTrQ=;
        b=tgnFJlBFurXCvujJIL1XAHKXkIzmsFKsq85KH9XsbVm/wlkjwh3lirxU0FImY4WZtK
         4IG2Lht9uq3B7+ig5ZkQ3LBGFOXXTqRXcISfa8BVU1KQdoa06UtRDHC9nhGiZGeczDTf
         3P7sWZUkn2S4vS648DZ7yep9vYijtaIKogtf424E7RNrRWTwzW0kHcwSNr2cXK6f4HMz
         iYcRYuOJ8nzAqwPzqmCpUwmXkh/6D+FPB/kxdBsnngyhtUccIgVBVwPdrrqCJ85CqC3N
         d6mSXjgqyPqvlZ0HcldqG6zMTF80uFR7sr/+JpWeaRGJZi/Dw5IJyBVCiLHbpBjQ6mxq
         aJMQ==
X-Gm-Message-State: AJIora+Ur+r5/UvcIfUYpk4ngl2bE38N6hFLYc6sGUp3ZlQgKytqmZ4h
        jc5jIx1Ny2Vu9X4UyRbdHOcCD/QRe+o=
X-Google-Smtp-Source: AGRyM1spRFdtcN9eEyBuRdKIh7Nq4MsnGesl3K9gNf1D2r3l+Pmy8pyBFD+LrMeHnLINbPresm3wHA==
X-Received: by 2002:a17:90a:9a97:b0:1f2:3b4b:cb85 with SMTP id e23-20020a17090a9a9700b001f23b4bcb85mr5889791pjp.15.1658479830053;
        Fri, 22 Jul 2022 01:50:30 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a3f0800b001ef9479373fsm5031082pjc.4.2022.07.22.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:50:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 56935104982; Fri, 22 Jul 2022 15:50:22 +0700 (WIB)
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
Subject: [PATCH 1/8] Documentation: s390: Use note directive for changing mask note
Date:   Fri, 22 Jul 2022 15:49:40 +0700
Message-Id: <20220722084946.22965-2-bagasdotme@gmail.com>
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

The changing mask note uses custom syntax (open asterisks), which triggers
emphasis warnings as Sphinx confuses it as boldface:

Documentation/s390/vfio-ap.rst:684: WARNING: Inline strong start-string without end-string.
Documentation/s390/vfio-ap.rst:684: WARNING: Inline emphasis start-string without end-string.

Use note directive instead.

Link: https://lore.kernel.org/linux-next/20220721205937.10043b5f@canb.auug.org.au/
Fixes: cb269e0aba7c3f ("s390/vfio-ap: update docs to include dynamic config support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/s390/vfio-ap.rst | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/s390/vfio-ap.rst b/Documentation/s390/vfio-ap.rst
index f4b8748ab9a8cd..7aea0afe2ef390 100644
--- a/Documentation/s390/vfio-ap.rst
+++ b/Documentation/s390/vfio-ap.rst
@@ -681,15 +681,17 @@ These are the steps:
 	    default drivers pool:    adapter 0-15, domain 1
 	    alternate drivers pool:  adapter 16-255, domains 0, 2-255
 
-   Note ***:
-   Changing a mask such that one or more APQNs will be taken from a vfio_ap
-   mediated device (see below) will fail with an error (EBUSY). A message
-   is logged to the kernel ring buffer which can be viewed with the 'dmesg'
-   command. The output identifies each APQN flagged as 'in use' and identifies
-   the vfio_ap mediated device to which it is assigned; for example:
+   .. note::
+   
+      Changing a mask such that one or more APQNs will be taken from a vfio_ap
+      mediated device (see below) will fail with an error (EBUSY). A message
+      is logged to the kernel ring buffer which can be viewed with the 'dmesg'
+      command. The output identifies each APQN flagged as 'in use' and
+      identifies the vfio_ap mediated device to which it is assigned; for
+      example::
 
-   Userspace may not re-assign queue 05.0054 already assigned to 62177883-f1bb-47f0-914d-32a22e3a8804
-   Userspace may not re-assign queue 04.0054 already assigned to cef03c3c-903d-4ecc-9a83-40694cb8aee4
+         Userspace may not re-assign queue 05.0054 already assigned to 62177883-f1bb-47f0-914d-32a22e3a8804
+         Userspace may not re-assign queue 04.0054 already assigned to cef03c3c-903d-4ecc-9a83-40694cb8aee4
 
 Securing the APQNs for our example
 ----------------------------------
-- 
An old man doll... just what I always wanted! - Clara

