Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021B75188E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiECPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiECPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:47:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80902D1C6;
        Tue,  3 May 2022 08:43:28 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso1639250wma.0;
        Tue, 03 May 2022 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDRsFXOwSjFyheRf7X8Ao9DHLOFKA24q9h+KTiwDV0I=;
        b=ltwqrEm9oTa8rQE4hyHa3WE6OHpLPVxWC0GPdC+pt5u+pcdgfiXouVFdeGxLhCLcPW
         ZrNdvzIuMJA4ipYxZ78e1va4fhIDbPq7Yki00W2CpHTx8Ybs0Eu4eHu5I/SC5sZazUgM
         8Pt1NQwJf/c+spyJ52x+bpCrkTZzyA583vwVEWJWdHMMVzq73hZaBcESP+CHkj26wXf6
         uMHZv1EKVL0GoYMqFPMbPPbk6/T7gVd+AEEEBZM4cpZbXq5buc7JhjuEjfnTFuAkTOTc
         O/2IEC2C4Ih14963WwgQp5B+ed44pAc6jWbMzruU4uSuu9wowL2DFGTVCWW04E/o2RMD
         w4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDRsFXOwSjFyheRf7X8Ao9DHLOFKA24q9h+KTiwDV0I=;
        b=kiA9iLPv9EcrrY0zUEFApJm8jqnMCVMOAQ4nBEColpvCTCeISjzGPlHeUpe2lxz/hr
         B6C9lSki7HkgJogZyx+K+D6iV8xxhGoQl+ipzn6jjoYGof0VsUA+5kgmQziC9rgy6AwE
         dK45iuSfGJC/Lj+EFjnlqsBhzXcLx7q3Gpz+jC3Lb0OCkgE2rCE9r9mC7qhg2Uatw65d
         Cr602OkbDs3qkJaPEsgV9AWF8h8vHigMtaTTNwTfVm8gxlWFsxJO5BEEl1esL+lwCG8f
         ohVxu05V3M2FLCzI69PtAX8OAxzITS3yp7kURlzv5UptjUk7dbE2RrpqB3WxVAjKYVJh
         +BpQ==
X-Gm-Message-State: AOAM532Slw7RuEPVDzqrjuc1y17ZQdavcPlw5rDUAWOidsKMthU9d+Qv
        moeM7DlGPapK6P98C/magRA=
X-Google-Smtp-Source: ABdhPJzppyR4INFUGT75DtjAs3oxm7d+Z9BwGCumSgCdVVuDEp5F34+RwxOinhQoVLSlOtY3aLLd6Q==
X-Received: by 2002:a1c:ac44:0:b0:38e:a7df:3179 with SMTP id v65-20020a1cac44000000b0038ea7df3179mr3994322wme.61.1651592607267;
        Tue, 03 May 2022 08:43:27 -0700 (PDT)
Received: from vmu1804.lan ([2a06:a003:501a:a7ce::887])
        by smtp.googlemail.com with ESMTPSA id l20-20020a05600c1d1400b003942a244ed1sm2254912wms.22.2022.05.03.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:43:26 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v3 0/3] mtd: parsers: add support for Sercomm partitions
Date:   Tue,  3 May 2022 15:42:54 +0000
Message-Id: <20220503154254.2339744-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for Sercomm mtd partition table parser. It's
used in some Beeline, Netgear and Sercomm routers. The Sercomm partition
map table contains real partition offsets, which may differ from device to
device depending on the number and location of bad blocks on NAND.

Changes since:
v2:
 - Fix mistakes in dt-binding
 - Add patch for new vendor prefix
 - Add vendor prefix to scpart-id property

v1:
 - Add dt-binding in a separate patch
 - Remove redundant braces and logical NOT operator
 - Define pr_fmt
 - Replace kcalloc by kzalloc
 - Use of_get_child_count() and alloc big enough array before the
   for_each_child_of_node()

Mikhail Zhilkin (3):
  dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix
  dt-bindings: mtd: partitions: Extend fixed-partitions binding
  mtd: parsers: add support for Sercomm partitions

 .../mtd/partitions/fixed-partitions.yaml      |  55 +++-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/mtd/parsers/Kconfig                   |   9 +
 drivers/mtd/parsers/Makefile                  |   1 +
 drivers/mtd/parsers/scpart.c                  | 240 ++++++++++++++++++
 5 files changed, 305 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mtd/parsers/scpart.c

-- 
2.25.1

