Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA0F55D428
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiF0KO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiF0KO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:14:26 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63EA6410
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:14:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25RAE1CH062963;
        Mon, 27 Jun 2022 05:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656324841;
        bh=9bMmTKVjcLPMKrJJxAuSuYuZPxEu3volikjsDyd5Roo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fsMYmNDTiPs/+9+ya+HH1/wAEhnPBxUkqbqeIzGwij5SNjCONvbqQcnvahiIRZUOL
         cQn3MCPMXgMNh+6ACpv+P/POw5Zg9UDB3OTQrpZaKIJsmR1RmtFhVAeVtHnV5dW9i8
         HrzVyfb/t+uZESzxOXW5vjAycVo2fQYb3zMQFPdU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25RAE1al113300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jun 2022 05:14:01 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Jun 2022 05:14:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Jun 2022 05:14:00 -0500
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25RADw0T055445;
        Mon, 27 Jun 2022 05:13:58 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] mtd: spi-nor: move SECT_4K_PMC special handling
Date:   Mon, 27 Jun 2022 15:43:57 +0530
Message-ID: <165632480084.4063881.11417937215807229649.b4-ty@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220418112650.2791459-1-michael@walle.cc>
References: <20220418112650.2791459-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 18 Apr 2022 13:26:50 +0200, Michael Walle wrote:
> The SECT_4K_PMC flag will set a device specific opcode for the 4k sector
> erase. Instead of handling it in the core, we can move it to a
> late_init(). In that late init, loop over all erase types, look for the
> 4k size and replace the opcode.
> 
> 

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/1] mtd: spi-nor: move SECT_4K_PMC special handling
      https://git.kernel.org/mtd/c/77d4ac6d38

--
Regards,
Pratyush Yadav
Texas Instruments Inc.

