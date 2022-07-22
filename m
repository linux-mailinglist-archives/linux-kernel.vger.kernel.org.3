Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA357DCEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiGVIvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiGVIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:50:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F52E28E33;
        Fri, 22 Jul 2022 01:50:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gn24so3814673pjb.3;
        Fri, 22 Jul 2022 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHPADm0+jI7FAaPRhILrrh5k8cQJVDYd8IToScSIdm4=;
        b=izz6djKSQTtceEafrVo7QxdMb2Wd4uy11VI+7JvM9USfvwZt+bHKyMow6PP6klgalD
         VLAi36H+fo2EvuUB/fcIxTCcGYQwMZCZ4+YL03pDCyG+acz+/rL3OxFKL65qkWSNOYFD
         hW0XaxvvgllBme5khczEKLkGMCrSq6imrM1TSYiq0Q2TPONLYwC2/BTzBfOVhg3gTG3Z
         f2KjIJjEgr2owaqClB2O84adnJ4ka6uxCbUMlF+/RIy++0LR229iBGgg46rQN1rlmuDJ
         wWNjawg7wWHUhMyFcTxo10HHqewAKB7kS9bMyhuDs5qC1UQEkytiRPBuESgUMqTc8um4
         vL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHPADm0+jI7FAaPRhILrrh5k8cQJVDYd8IToScSIdm4=;
        b=Zm8KaEFAE75EdwqTdnCjKrh7y8ifeuuOj6tORAppI7VUJyBb5Ax7V+vbHTkUJWDcxt
         39oSO700G06dn/A/esf3oq8yqwLxuxJvCdUQZJUfaaNhdUln6nHWqCofhlayAFzvWQxe
         Fgp/QgInQh6WIoVWdjDBg0K6QYAfDGyaEM9Ir+ex16cA678f7jBY7H/pQE5wRlfA7CD4
         rU+pBw6JzaLGbcT9l+xbldRCFilyDC1BSAlgq/9sx58YJEVa95PHTPHo32keBpFOHS+5
         8CZF2Loqp4U7xUeNNaVlN3mamcyge3uoNOBe6goepKBp2SxH/AG9Pq40RZ7RC/JpaAgL
         wA7w==
X-Gm-Message-State: AJIora9afFjdQLxOr5DFzCKRp2QdabASAg0PzuwCJd+iWgmlq3Up+GAr
        XW84LHpVUHb8A3DfOMitxaY=
X-Google-Smtp-Source: AGRyM1vuI+wWNr7WhC5ccsl4JgLjSx5Fk9RToyt2DQtUj2jgzGYrI2asEV3Gfto7fiwX0ux2dwT7Lw==
X-Received: by 2002:a17:903:1c4:b0:16c:4e45:38a3 with SMTP id e4-20020a17090301c400b0016c4e4538a3mr2340164plh.41.1658479830700;
        Fri, 22 Jul 2022 01:50:30 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902ce0400b0016d42244886sm717506plg.94.2022.07.22.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:50:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B4B291039A0; Fri, 22 Jul 2022 15:50:23 +0700 (WIB)
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
Subject: [PATCH 7/8] Documentation: s390: extend underline for matrix devices lock
Date:   Fri, 22 Jul 2022 15:49:46 +0700
Message-Id: <20220722084946.22965-8-bagasdotme@gmail.com>
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

The underline heading for "The Matrix Devices Lock" section is off-short
by a dash, hence:

Documentation/s390/vfio-ap-locking.rst:15: WARNING: Title underline too short.

The Matrix Devices Lock (drivers/s390/crypto/vfio_ap_private.h)
--------------------------------------------------------------

Extend the underline to match heading text length.

Link:https://lore.kernel.org/linux-next/20220721201058.2a276286@canb.auug.org.au/
Fixes: e32d3827f3d5b2 ("s390/Docs: new doc describing lock usage by the vfio_ap device driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/s390/vfio-ap-locking.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/s390/vfio-ap-locking.rst b/Documentation/s390/vfio-ap-locking.rst
index cfbb661ea72e63..ab41b0e5dca40e 100644
--- a/Documentation/s390/vfio-ap-locking.rst
+++ b/Documentation/s390/vfio-ap-locking.rst
@@ -12,7 +12,7 @@ will be used to denote instances of the structures herein described::
    struct kvm *kvm;
 
 The Matrix Devices Lock (drivers/s390/crypto/vfio_ap_private.h)
---------------------------------------------------------------
+---------------------------------------------------------------
 
 ::
 
-- 
An old man doll... just what I always wanted! - Clara

