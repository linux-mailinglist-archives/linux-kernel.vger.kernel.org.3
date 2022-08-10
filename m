Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4116E58EE74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiHJOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:36:16 -0400
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1114.securemx.jp [210.130.202.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543F43E7B;
        Wed, 10 Aug 2022 07:36:13 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1114) id 27ADYBGu020076; Wed, 10 Aug 2022 22:34:12 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 27ADXWhZ014082; Wed, 10 Aug 2022 22:33:32 +0900
X-Iguazu-Qid: 2wHHz477PyFEYarLUG
X-Iguazu-QSIG: v=2; s=0; t=1660138411; q=2wHHz477PyFEYarLUG; m=E9rBbVvUdv6UzhKaYRBXrg+ovzk64kCsispHtHAspvg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1110) id 27ADXUWd034960
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Aug 2022 22:33:30 +0900
X-SA-MID: 40425323
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v3 0/4] Add Toshiba Visconti Video Input Interface driver
Date:   Wed, 10 Aug 2022 22:28:18 +0900
X-TSB-HOP2: ON
Message-Id: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the Video Input Interface driver
for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation,
device driver, documentation and MAINTAINER files.

A visconti VIIF driver instance exposes
1 media control device file and 3 video device files
for a VIIF hardware. 
Detailed HW/SW are described in documentation directory.
The VIIF hardware has CSI2 receiver,
image signal processor and DMAC inside.
The subdevice for image signal processor provides
vendor specific V4L2 controls.

The device driver depends on two other drivers under development;
clock framework driver and IOMMU driver.
Corresponding features will be added later.

Best regards,
Yuji

Changelog v2:
- Resend v1 because a patch exceeds size limit.

Changelog v3:
- Add documentation to describe SW and HW
- Adapted to media control framework
- Introduced ISP subdevice, capture device
- Remove private IOCTLs and add vendor specific V4L2 controls
- Change function name avoiding camelcase and uppercase letters

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

Yuji Ishikawa (4):
  dt-bindings: media: platform: visconti: Add Toshiba Visconti Video
    Input Interface bindings
  media: platform: visconti: Add Toshiba Visconti Video Input Interface
    driver
  documentation: media: add documentation for Toshiba Visconti Video
    Input Interface driver
  MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface

 .../bindings/media/toshiba,visconti-viif.yaml |  103 +
 .../driver-api/media/drivers/index.rst        |    1 +
 .../media/drivers/visconti-viif.rst           |  455 +++
 MAINTAINERS                                   |    3 +
 drivers/media/platform/Kconfig                |    2 +
 drivers/media/platform/Makefile               |    4 +
 drivers/media/platform/visconti/Kconfig       |    9 +
 drivers/media/platform/visconti/Makefile      |    9 +
 drivers/media/platform/visconti/hwd_viif.c    | 1791 +++++++++++
 drivers/media/platform/visconti/hwd_viif.h    |  701 +++++
 .../media/platform/visconti/hwd_viif_csi2rx.c |  723 +++++
 .../platform/visconti/hwd_viif_internal.h     |  348 ++
 .../media/platform/visconti/hwd_viif_l1isp.c  | 2727 ++++++++++++++++
 .../media/platform/visconti/hwd_viif_reg.h    | 2802 +++++++++++++++++
 drivers/media/platform/visconti/viif.c        |  479 +++
 drivers/media/platform/visconti/viif.h        |  195 ++
 .../media/platform/visconti/viif_capture.c    | 1215 +++++++
 .../media/platform/visconti/viif_controls.c   | 1149 +++++++
 drivers/media/platform/visconti/viif_isp.c    |  852 +++++
 include/uapi/linux/visconti_viif.h            | 1724 ++++++++++
 20 files changed, 15292 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
 create mode 100644 Documentation/driver-api/media/drivers/visconti-viif.rst
 create mode 100644 drivers/media/platform/visconti/Kconfig
 create mode 100644 drivers/media/platform/visconti/Makefile
 create mode 100644 drivers/media/platform/visconti/hwd_viif.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_l1isp.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
 create mode 100644 drivers/media/platform/visconti/viif.c
 create mode 100644 drivers/media/platform/visconti/viif.h
 create mode 100644 drivers/media/platform/visconti/viif_capture.c
 create mode 100644 drivers/media/platform/visconti/viif_controls.c
 create mode 100644 drivers/media/platform/visconti/viif_isp.c
 create mode 100644 include/uapi/linux/visconti_viif.h

-- 
2.17.1


