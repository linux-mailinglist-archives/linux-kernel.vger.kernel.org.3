Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF9D524DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354394AbiELNLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354302AbiELNLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:11:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7375D30568
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:10:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24CDAcRp044919;
        Thu, 12 May 2022 08:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652361038;
        bh=kpYjg/YJDu1USEjgBhUQOa9ZvfUzQA8K4X6I5hRa6UA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GuwX/IyUVRCIh4HRLZPctUBCIs/o/jUbeobExryJCfMbVzPiBBb4zwtHj/DBs4HwH
         xvwEztC91ipe27tZOoD+YYBD4R+TYCH/iBOLZ1YAhtoOjht+OnXAd5UWnHvSoFptZ7
         UN+FnhLmCakUKrMESAz92WtWdjQnpMjrjyZW1wx8=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24CDAcUT015850
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 May 2022 08:10:38 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 12
 May 2022 08:10:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 12 May 2022 08:10:38 -0500
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24CDAZ7I011087;
        Thu, 12 May 2022 08:10:35 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Walle <michael@walle.cc>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        kernel test robot <lkp@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: debugfs: fix format specifier
Date:   Thu, 12 May 2022 18:40:34 +0530
Message-ID: <165236096308.3070754.3267469990588119006.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512112027.3771734-1-michael@walle.cc>
References: <20220512112027.3771734-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 13:20:27 +0200, Michael Walle wrote:
> The intention was to print the JEDEC ID in the following format:
>   nn nn nn
> 
> In this case format specifier has to be "%*ph". Fix it.
> 
> 

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/1] mtd: spi-nor: debugfs: fix format specifier
      https://git.kernel.org/mtd/c/c474521946

--
Regards,
Pratyush Yadav
Texas Instruments Inc.

