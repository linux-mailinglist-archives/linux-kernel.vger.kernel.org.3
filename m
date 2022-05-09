Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE851FB0E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiEILPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiEILP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:15:28 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916BA1A8DD1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:11:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 249BB9jj066312;
        Mon, 9 May 2022 06:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652094669;
        bh=vndduWuikymFtFGeCUAaA7OplM3JUKbgEoaQpyTwuks=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=psp1b+YQ1WB1VttDrtd1COkZtrj3a+2LUuZ6/N4eYky9zFfEWCNUPcVTCgmX20jaj
         /8Hp0dVCXRe63VNZHXbzcev1L9PtjPYtkqPpovD5hAdcZuG3CbWC+1Ee6PsX3p91cg
         2jJ7X76PjOFTmKY/7heJXYd9U8eo/siEF9OEbyWI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 249BB911020080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 May 2022 06:11:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 9
 May 2022 06:11:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 9 May 2022 06:11:08 -0500
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 249BB6Cj002174;
        Mon, 9 May 2022 06:11:07 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2] mtd: spi-nor: move spi_nor_write_ear() to winbond module
Date:   Mon, 9 May 2022 16:41:05 +0530
Message-ID: <165209461431.3971394.16610033211689877768.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429100153.2338501-1-michael@walle.cc>
References: <20220429100153.2338501-1-michael@walle.cc>
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

On Fri, 29 Apr 2022 12:01:53 +0200, Michael Walle wrote:
> The "Extended Address Register" is winbond specific. If the flash is
> larger than 16MiB and is used in 3 byte address mode, it is used to set
> the remaining address bits. Move the write_ear() function, the opcode
> macros and the spimem op template into the winbond module and rename
> them accordingly.
> 
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/1] mtd: spi-nor: move spi_nor_write_ear() to winbond module
      (no commit info)

--
Regards,
Pratyush Yadav
Texas Instruments Inc.

