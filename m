Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088E1511977
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiD0Nch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiD0Ncc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:32:32 -0400
Received: from mo-csw.securemx.jp (mo-csw1515.securemx.jp [210.130.202.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6422D2BEC;
        Wed, 27 Apr 2022 06:29:18 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 23RDSs89009903; Wed, 27 Apr 2022 22:28:54 +0900
X-Iguazu-Qid: 34tMbOxKTy7RKtoKbU
X-Iguazu-QSIG: v=2; s=0; t=1651066134; q=34tMbOxKTy7RKtoKbU; m=S20lVmlaMRvIdZ7s5PtXo0QvAorFu/Sfmvlyb+fSM/U=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1510) id 23RDSrPY023236
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 22:28:53 +0900
X-SA-MID: 3264136
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v2 0/4] Add Toshiba Visconti AFFINE image processing accelerator driver
Date:   Wed, 27 Apr 2022 22:23:41 +0900
X-TSB-HOP2: ON
Message-Id: <20220427132345.27327-1-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the AFFINE image processing accelerator driver for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation, device driver, MAINTAINER files.

The second patch "soc: visconti: Add Toshiba Visconti image processing accelerator common source"
is commonly used among acclerator drivers (affine, dnn, dspif, pyramid).

Best regards,
Yuji

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html
  
  dt-bindings: soc: visconti: Add Toshiba Visconti AFFINE image
    v1 -> v2:
      - No update

  soc: visconti: Add Toshiba Visconti image processing accelerator common source
    v1 -> v2:
      - apply checkpatch.pl --strict
  
  soc: visconti: Add Toshiba Visconti AFFINE image processing accelerator
    v1 -> v2:
      - apply checkpatch.pl --strict
      - rename hwd_AFFINE_xxxx to hwd_affine_xxxx

  MAINTAINERS: Add entries for Toshiba Visconti AFFINE image processing accelerator
    v1 -> v2:
      - No update

Change in V2:
  - apply checkpatch.pl --strict
  - rename hwd_AFFINE_xxxx to hwd_affine_xxxx

Yuji Ishikawa (4):
  dt-bindings: soc: visconti: Add Toshiba Visconti AFFINE image
    processing accelerator bindings
  soc: visconti: Add Toshiba Visconti image processing accelerator
    common source
  soc: visconti: Add Toshiba Visconti AFFINE image processing
    accelerator
  MAINTAINERS: Add entries for Toshiba Visconti AFFINE image processing
    accelerator

 .../soc/visconti/toshiba,visconti-affine.yaml |  53 ++
 MAINTAINERS                                   |   2 +
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/visconti/Kconfig                  |   7 +
 drivers/soc/visconti/Makefile                 |   8 +
 drivers/soc/visconti/affine/Makefile          |   6 +
 drivers/soc/visconti/affine/affine.c          | 451 ++++++++++++++++++
 drivers/soc/visconti/affine/hwd_affine.c      | 206 ++++++++
 drivers/soc/visconti/affine/hwd_affine.h      |  83 ++++
 drivers/soc/visconti/affine/hwd_affine_reg.h  |  45 ++
 drivers/soc/visconti/ipa_common.c             |  55 +++
 drivers/soc/visconti/ipa_common.h             |  18 +
 drivers/soc/visconti/uapi/affine.h            |  87 ++++
 drivers/soc/visconti/uapi/ipa.h               |  88 ++++
 15 files changed, 1111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-affine.yaml
 create mode 100644 drivers/soc/visconti/Kconfig
 create mode 100644 drivers/soc/visconti/Makefile
 create mode 100644 drivers/soc/visconti/affine/Makefile
 create mode 100644 drivers/soc/visconti/affine/affine.c
 create mode 100644 drivers/soc/visconti/affine/hwd_affine.c
 create mode 100644 drivers/soc/visconti/affine/hwd_affine.h
 create mode 100644 drivers/soc/visconti/affine/hwd_affine_reg.h
 create mode 100644 drivers/soc/visconti/ipa_common.c
 create mode 100644 drivers/soc/visconti/ipa_common.h
 create mode 100644 drivers/soc/visconti/uapi/affine.h
 create mode 100644 drivers/soc/visconti/uapi/ipa.h

-- 
2.17.1


