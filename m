Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC152C792
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiERXdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 19:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiERXdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 19:33:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2B1B41EC;
        Wed, 18 May 2022 16:33:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so4796308wrg.3;
        Wed, 18 May 2022 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOEp7RuGCpmLRx/E7Nt8xZm5egHCz2H71jctvM4CMtU=;
        b=qhgQtSrVoznPTJ+ZFRprLIIpBY1SHJija0hAAQY7o8uCU9zz94MDCktqqv5uFqE0QO
         lND1XzQt3XTi6Wg/NitNHyJ37tyTHPof5jSDZ4mXKEBkiAWSIizlX5q7+k5QjnwTIyBQ
         Dx3jfJvFbGIRekI6xdigOTfL/arroPyf6YQ2cAJ9Dv30zr5NJWa7aP7sBPJ+QoIzlzpZ
         EO3ur7ts9JMdZUE9aQBViZme7sVO0cNLJUGhH+9R55Fv7hTV5PvEiIqW+4bGqLlzQ/MA
         pEee1RnbjTADgtrT3C4AAgKvfs4Kg/bJxsEf1JOp/4OekCIO2nZO/6/DB+RZWucI0vTM
         0CkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOEp7RuGCpmLRx/E7Nt8xZm5egHCz2H71jctvM4CMtU=;
        b=WqDplRgVQ5UTv2tP7VyU3q/JNHBFZIhwbxtWY3dyfPBEW7EymvP21g3p680IaU1wG1
         cpvNgmpuBJgDfDmI6lulbW5pgQJ65dQiJsnJL/c3DkZu3grigscd/+3fSkcoHnj/tIiK
         XoLtctxIV7E3qHHuHDE+WphI+DXDB2sdlrZaH+VQVlooO7DjnoNOCUWhWxQGkhcD2VvY
         BU+d1R9ZJuX57gxmgHwA950prWigMbP1NXudCFmNOaqOdwO0ezLEdH3GaHNHDEQlZr9i
         VEzUx0GgJ9OgLXrut72im/LJZWdeySWR15EUPj3IEn3J0+mIEWXw/qNFJ83qcEfzorXS
         ZY5A==
X-Gm-Message-State: AOAM530XYXFjyMlX/rdfuleZ3MCTBb7PKDlu0vYB8UXNdA88/uT3owCi
        WMxyf3cgh9nr55xg/bSdl6c=
X-Google-Smtp-Source: ABdhPJxnhCEpQNzOwxft4SfMBdFkTWxgzGUXIdSBsEze3n6hW95e9mj6mnEnEYKXsw1PeBxB8A2Axg==
X-Received: by 2002:a5d:5342:0:b0:20d:597:3953 with SMTP id t2-20020a5d5342000000b0020d05973953mr1581233wrv.310.1652916790893;
        Wed, 18 May 2022 16:33:10 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id j25-20020adfa799000000b0020d042efd11sm3217476wrc.61.2022.05.18.16.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:33:10 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add nvmem support for dynamic partitions
Date:   Thu, 19 May 2022 01:32:56 +0200
Message-Id: <20220518233258.5483-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This very small series comes to fix the very annyoing problem of
partitions declared by parser at runtime NOT supporting nvmem cells
definition.

The current implementation is very generic. The idea is to provide an of
node if defined for everyone and not strictly limit this to nvmem stuff.
But still the actual change is done only for nvmem-cells mtd. (just to
make sure) This can totally change by removing the compatible check.

The idea here is that a user can still use these dynamic parsers
instead of declaring a fixed-partition and also declare how nvmem-cells
are defined for the partition.
This live with the assumption that dynamic partition have always the
same name and they are known. (this is the case for smem-part partition
that would require a bootloader reflash to change and for parsers like
cmdlinepart where the name is always the same.)
With this assumption, it's easy to fix this problem. Just introduce a
new partition node that will declare just these special partition.
Mtdcore then will check if these special declaration are present and
connect the dynamic partition with the OF node present in the dts. Nvmem
will automagically fin the OF node and cells will be works based on the
data provided by the parser.

The initial idea was to create a special nvmem driver with a special
compatible where a user would declare the mtd partition name and this
driver would search it and register the nvmem cells but that became
difficult really fast, mtd notifier system is problematic for this kind
of stuff. So here is the better implementation. A variant of this is
already tested on openwrt where we have devices that use cmdlinepart.
(that current variant have defined in the dts the exact copy of
cmdlinepart in the fixed-partition scheme and we patched the cmdlinepart
parser to scan this fixed-partition node (that is ignored as cmdlinepart
have priority) and connect the dynamic partition with the dts node)

I provided an example of this in the documentation commit.
In short it's needed to add to the partitions where the compatible parser
is declared, a partition with just the label declared (instead of the reg).
Then declare some nvmem-cells and it will all work at runtime.
Mtdcore will check if a node with the same label is present and assign an
OF node to the MTD.

I currently tested this on my device that have smem-part and the
gmac driver use nvmem to get the mac-address. This works correctly and
the same address is provided.

v4:
- Make it simple. No suffix. Make label mandatory again.
- Update Documentation with new implementation.
- Rename files to a better and correct name
v3:
- Fix warning from bot (function not declared as static)
- Updated code to support also node name
- Made partition label optional
v2:
- Simplify this. Drop dynamic-partition
- Fix problem with parser with ko
- Do not pollude mtd_get_of_node
- Fix problem with Documentation

Ansuel Smith (2):
  dt-bindings: mtd: partitions: Document new dynamic-partition nodes
  mtd: core: introduce of support for dynamic partitions

 .../mtd/partitions/dynamic-partition.yaml     | 57 +++++++++++++++++++
 .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
 drivers/mtd/mtdcore.c                         | 49 ++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml

-- 
2.34.1

