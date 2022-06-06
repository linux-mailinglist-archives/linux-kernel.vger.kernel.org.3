Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6096653E601
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiFFPOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbiFFPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:14:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB51102753;
        Mon,  6 Jun 2022 08:14:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq6so16560459ejb.11;
        Mon, 06 Jun 2022 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WxVflAaLaQGVLZDTYjr1bfsD9KjPcYDpao0PwOqVUc=;
        b=NX12efPEOw77FAgI0EpL6qcSUxPue8/LVvXK9QbgUpJVaK3qv88l6h2tQZVbnbB2yu
         GkUeXNMCDyVgA20UpT/iVnJJh2DbilU2A4w0kZ/5TbMWW0dHYHtOE/+hf/TIyZtvkQvT
         ZrNjULLfeEcahHtbhykUyy3jAshh3eZ5fvFT7Q5Zo6YvZtT2e+sYo6064RPK035zjsTP
         fgggUgPCL2iVeSboRaM7hx1BUvODAzevS127njr+aQ38c/S5umEU7holMW9+LOuB2/o3
         sFacaOC2y8MBEVOZKS/QDowghmgaZfRvZdvaS+F2dsJyzjwB4AmGiy3fGKC1atVySPLA
         KTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WxVflAaLaQGVLZDTYjr1bfsD9KjPcYDpao0PwOqVUc=;
        b=qbdX6IG0EEWU5yaGdPhUhQ7lCJAoGKhAp1OzUnqdCvG+W5wx9ANQ5A8zHhquUvDKQ2
         7DiZ5CKUbirICIzisouqrXhC8LHDg7bnf16/vVB4gqVb5DkEwRBSHCSs3yzaiXrT5vu8
         HPrmRLYkl84ZHv8f3Jgv7xcQLvb3/OZnN2f4mDcK0cInGmJtglKqxFfMiLMT2J6njUj+
         pFYU7aNgIhWoVTllKOtN7/hJzEoeneT9Qfr9j9bKsN9BO7WSOeFqlL8STKkR7OIE+vx4
         6Rvtsil9E/8vc2uj2SG0hdOEajCFFpL7wX37UVaXf32nX6psQ1HFE2FjIOYHflBml/qM
         Vu5Q==
X-Gm-Message-State: AOAM533IjENfQAuyBxFDsHAPeYZpFyl3A2W7Fba/yJfAVH708jqwNxYy
        qjX+1VFuHH9ZteJ2jeUbYtE=
X-Google-Smtp-Source: ABdhPJzC2ZhN+QbDcpWKYpFgwCGWZ7LbwPJodBLMvxR8aDpwq5PrY9LNFc4iVQOSLjC5nm14Djgxuw==
X-Received: by 2002:a17:907:608f:b0:6f6:1155:99ab with SMTP id ht15-20020a170907608f00b006f6115599abmr21289023ejc.306.1654528479498;
        Mon, 06 Jun 2022 08:14:39 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id be5-20020a0564021a2500b0042e09f44f81sm7494001edb.38.2022.06.06.08.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:14:38 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        =?UTF-8?q?=EF=BF=BDecki?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Add nvmem support for dynamic partitions
Date:   Mon,  6 Jun 2022 17:14:14 +0200
Message-Id: <20220606151417.19227-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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
will automagically find the OF node and cells will be works based on the
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

v5:
- Simplify Documentation and move it generic partition.yaml
- Split commit and move smem example to dedicated commit.
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

Ansuel Smith (3):
  dt-bindings: mtd: partitions: Support label only partition
  dt-bindings: mtd: partitions: add additional example for
    qcom,smem-part
  mtd: core: introduce of support for dynamic partitions

 .../bindings/mtd/partitions/partition.yaml    | 16 +++++-
 .../mtd/partitions/qcom,smem-part.yaml        | 27 ++++++++++
 drivers/mtd/mtdcore.c                         | 49 +++++++++++++++++++
 3 files changed, 90 insertions(+), 2 deletions(-)

-- 
2.36.1

