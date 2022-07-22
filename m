Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD72157DCD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiGVIul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiGVIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:50:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ACA21241;
        Fri, 22 Jul 2022 01:50:30 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f65so3882949pgc.12;
        Fri, 22 Jul 2022 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zGY0EXAaXQ+D8hequJI3ImESjKlfXSgshYgeHZe/nM=;
        b=RI8ihRBDPebahs9PUDIqNYR7E7I+kJbknc2A8FVQMgB+P9c1vNE5LThfv641xmDm2B
         HkDuOfylWouR7+oCvIGy1wSrsdZD03DO961g0lnFmIPRkQTNinthv15OOB2ybpF8Lm1c
         s0198ttdOK99r7X4VCHnXiJi8hTdTfrGuYExpZSQAZrzJVa89EoJ5CvQVdZbe1n+X5Wm
         qyulq0yPEaIwiYI+qhUqEL1oDGKnS6D3y9PX1QN942iLszGMeVuj6z6aipJYTZK+qTjj
         ekOfwFYzFutL6S7xY+vuQGEl6cwlb+NQaUj4jpSR7tkC80bMmVtH6oTtSKUf2Yz05c27
         6AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zGY0EXAaXQ+D8hequJI3ImESjKlfXSgshYgeHZe/nM=;
        b=MSFCsezpAoNTD/5pYjMumshY4AgUpf3kn63wnL1+6dzXnLr0nZa7VBsofFKDNqW2r9
         GjZ1Fgx4YL3NUAyTOp1SzCQ6e3IetUPUs/71OiXw9eIh9Zbxglz/mBzehA532W/2SXwN
         1hgArMR+3Z5hGJecgPvgtGrCL5FozPKw3BusG6+RanM54owCpc5NdZC4n/9dcZogGfjF
         f2XAldguLbkGI1Ub6Xxx4Z5toMLc7QVxhi1dKnVKK9m0p8F8fXQ0wHtva/WIdutGvknp
         ygRD7EM3+NL4BCD1ZRtSh1pukMBWAp3q9BmFbu8kuXEVbITKtDBKuPBMQy/cdESvhoGB
         9QTw==
X-Gm-Message-State: AJIora8habRSp7If1Pnk8oyzDBvRnT37aAcZ1TfNXim7KTPxeK36tynX
        Py9T8ep++kUIvH1f56KEYSY=
X-Google-Smtp-Source: AGRyM1t9IwkGIEkdbuMN5EJsIH776t47ap0HBwKQPSqDE+9kdCorey9HPDwdlsww8N0OJRCh7SDDnw==
X-Received: by 2002:a62:16ce:0:b0:528:c4c7:972f with SMTP id 197-20020a6216ce000000b00528c4c7972fmr2375812pfw.55.1658479830384;
        Fri, 22 Jul 2022 01:50:30 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902b58b00b0016c1e006b63sm3102172pls.64.2022.07.22.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:50:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3EC2A104984; Fri, 22 Jul 2022 15:50:22 +0700 (WIB)
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
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/8] Documentation: s390: documentation fixes for vfio_ap driver
Date:   Fri, 22 Jul 2022 15:49:39 +0700
Message-Id: <20220722084946.22965-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Here is documentation fixes for vfio_ap driver, as recently reported in
linux-next.

This series is based on next-20220721.

Bagas Sanjaya (8):
  Documentation: s390: Use note directive for changing mask note
  Documentation: s390: use note directive for remaining notes
  Documentation: s390: sync heading underlines
  Documentation: s390: use code blocks for virsh and qemu output
  Documentation: s390: use code block for structs
  Documentation: s390: escape *kvm->arch.crypto.pqap_hook pointer inside
    inline code
  Documentation: s390: extend underline for matrix devices lock
  Documentation: s390: add vfio-ap-locking documentation to table of
    contents index

 Documentation/s390/index.rst           |   1 +
 Documentation/s390/vfio-ap-locking.rst |  68 +++++-----
 Documentation/s390/vfio-ap.rst         | 164 ++++++++++++++-----------
 3 files changed, 132 insertions(+), 101 deletions(-)


base-commit: a3fd3ca134d9485a0f9a7bdcffd7f8bae27f79d3
-- 
An old man doll... just what I always wanted! - Clara

