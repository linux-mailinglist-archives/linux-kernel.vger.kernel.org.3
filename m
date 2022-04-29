Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2285156B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiD2VWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiD2VWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:22:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120CE75601;
        Fri, 29 Apr 2022 14:19:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b24so10411478edu.10;
        Fri, 29 Apr 2022 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2J9IpbhSCPKo6hzR7ThFh9qjKVKTI0ZkWcQbeRkMDk=;
        b=PwYEjNaLcUkFL2XGgIJqUNbApGZRjWJnK2K7xbQvY6Uq47p9cQ1QHQbwpSwOrKI2LJ
         bWZEDifkPN25f5ZSWd4wBl9n8dMFaMiwmQvVYMKv75WgJFL52ln6NsWYEjPCrfVjut3t
         oJHXvSS4JZM9DSEhEP2Nm8Y6cg9H9vCOejhy/Ewt17g6u2iNi9tky+7/oHFz8VPuhR3c
         YE+0AGOJLTVy9Q2JFBEAS1wE6Dywv4f7B4HYzQqTgSaYRP30k+wrGoUlO+eLGoLcVj1o
         NNJlsjqwRpUshSLKj+OVjN9UZeKVgj00t3zWpAD/473AVwZI4Qe5ikHPlyV++S+A4O1n
         6sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2J9IpbhSCPKo6hzR7ThFh9qjKVKTI0ZkWcQbeRkMDk=;
        b=NzcX3e6mnd1lR0vlL58LWF6//QNbzrUsP+I8pDofpijFnsUiofNhUEnmQGIPK/KEzu
         1PmIPKsLHdf7v1MmEsoc2pwhjDhXY0TgKlHLLt9lp2uqzky/Hle6QoBkYGf6p/LTmUfh
         9v19KYC9F20MgvRiMBiaMsLETX7vKja3Wge0PqvS/tWIIvETmfPXAF2aeb8voxc/G5o1
         +xqXANST9/lNqEwESJec8HJVRpIo7N35mGsWDKfrcSkZwTP7CXqO6sDc1MwG5W8HWmUJ
         tUGvsLgt+ZuBzquKO15aA0KGZ6KyMrLpMaM9OP7xnYTmPehiRyNPG3ind7tXJjdIoLFc
         Of5g==
X-Gm-Message-State: AOAM532Dxkc6AX2ZaR8LShErNnj++aWxSMKosonj+9jqlHTeAyWLmc3d
        qYqLZY7FB39Z0o6SybopYUY=
X-Google-Smtp-Source: ABdhPJwBRJhQVI/1OpMBYtbw+lNoE/b14U4g6oyC/i7QkEXxzC6xu7jOcyYah4jtZN+gJaUczzEvfw==
X-Received: by 2002:aa7:d4c3:0:b0:425:e26d:aee2 with SMTP id t3-20020aa7d4c3000000b00425e26daee2mr1300785edr.64.1651267155541;
        Fri, 29 Apr 2022 14:19:15 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id hx14-20020a170906846e00b006f3ef214db6sm990143ejc.28.2022.04.29.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:19:15 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 0/2] Add support for unprotected spare data page
Date:   Fri, 29 Apr 2022 23:16:28 +0200
Message-Id: <20220429211630.7812-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some background about this.
On original qsdk ipq8064 based firmware there was a big separation from 
boot partition and user partition. With boot partition we refer to
partition used to init the router (bootloader, spm firmware and other
internal stuff) With user partition we refer to linux partition and data
partition not used to init the router.
When someone had to write to these boot partition a special mode was
needed, to switch the nand driver to this special configuration.

Upstream version of the nandc driver totally dropped this and the result
is that if someone try to read data from these partition a CRC warning
is printed and if someone try to write that (if for example someone
wants to replace the bootloader) result is a broken system as the data
is badly written.

This series comes to fix this.

A user can declare offset and size of these special partition using the
qcom,boot_pages binding.

An initial implementation of this assumed that the boot_pages started
from the start of the nand but we discover that some device have backup
of these special partition and we can have situation where we have this
partition scheme
- APPSBL (require special mode)
- APPSBLENV (doesn't require special mode)
- ART
- APPSBLBK (back of APPSBL require special mode)
- APPSBLENVBK (back of APPSBLENV doesn't require special mode)
With this configuration we need to declare sparse boot page and we can't
assume boot_pages always starts from the start of the nand.

A user can use this form to declare sparse boot pages 
qcom,boot_pages = <0x0 0x0c80000 0x0c80000 0x0500000>;

The driver internally will parse this array, convert it to nand pages
and check internally on every read/write if this special configuration
should used for that page or the normal one.

The reason for all of this is that qcom FOR SOME REASON, disable ECC for
spare data only for these boot partition and we need to reflect this
special configuration to mute these warning and to permit actually
writing to these pages.

Ansuel Smith (2):
  mtd: nand: raw: qcom_nandc: add support for unprotected spare data
    pages
  dt-bindings: mtd: qcom_nandc: document qcom,boot_pages binding

 .../devicetree/bindings/mtd/qcom,nandc.yaml   |  13 ++
 drivers/mtd/nand/raw/qcom_nandc.c             | 148 +++++++++++++++++-
 2 files changed, 156 insertions(+), 5 deletions(-)

-- 
2.34.1

