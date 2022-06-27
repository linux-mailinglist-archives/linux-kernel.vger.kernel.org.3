Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3D55D1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiF0PNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiF0PMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:12:25 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235BE17E05;
        Mon, 27 Jun 2022 08:12:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25RFC30V089876;
        Mon, 27 Jun 2022 10:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656342723;
        bh=LM44d3M9KfHOsGyY3PknJroHsunJ8s7a74WgsZFUupM=;
        h=From:To:CC:Subject:Date;
        b=oHh8dN7La31yK91qdslFysUKnTyrhSX8XhvUYpBrAF3VSaOi3IKGv0ou+ehTR6FN+
         o9OACFOFBln/4Xq1T0UgOPptMBAJvT7K8HANyn9S5uicfwvuOi0SRvFtEdXGmTKQnQ
         GS2kyHLzF02bnmGuNZ4BRKN+i/xUCZyHU4Qs/N7A=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25RFC3L2002487
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jun 2022 10:12:03 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Jun 2022 10:12:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Jun 2022 10:12:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25RFC2WY118456;
        Mon, 27 Jun 2022 10:12:03 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v3 0/2] Add DSS support for AM625 SoC
Date:   Mon, 27 Jun 2022 20:41:58 +0530
Message-ID: <20220627151200.4693-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new compatible for the DSS IP on TI's AM625
SoC. It further adds the required support for the same in the tidss
driver. The IP is a newer version of the DSS IP available on AM65X SoC,
with a major change being in the addition of another OLDI TX inside it.
With the help of 2 OLDI TXes, this new DSS IP supports OLDI displays
with a resolution of upto 2K. The OLDI support will be added
subsequently.

Changelog:

V3:
  - Changed yaml enum in alphabetical order
  - Corrected a typo

V2:
  - Removed redundant regsiter array

Aradhya Bhatia (2):
  dt-bindings: display: ti,am65x-dss: Add am625 dss compatible
  drm/tidss: Add support for AM625 DSS

 .../bindings/display/ti/ti,am65x-dss.yaml     |  4 +-
 drivers/gpu/drm/tidss/tidss_dispc.c           | 56 ++++++++++++++++++-
 drivers/gpu/drm/tidss/tidss_dispc.h           |  2 +
 drivers/gpu/drm/tidss/tidss_drv.c             |  1 +
 4 files changed, 61 insertions(+), 2 deletions(-)

-- 
2.36.1

