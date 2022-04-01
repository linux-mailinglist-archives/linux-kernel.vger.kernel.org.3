Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38DF4EEBE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbiDAK5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244943AbiDAK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:57:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8953A141FD6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:55:15 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 231AsuXu124777;
        Fri, 1 Apr 2022 05:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648810496;
        bh=4HIXpALjFZpmMLhAmSpJsQ6CIq1LSBSVmVQUaofI1I0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QmdRXub247mCr9A3y6Nq3ypnVs+jJ+f67zJkGnLeB+Gylg9IkXdYAJkz3DztARsUO
         KjA6RAgMSDq178rcAv3Wc2mF7SvpWdtAD0veDWqlgGUbYDZ7eBO95avga+ZOoSF2nC
         9ck6B+YOJEII66H8dUZSd3FRgdtO/4+AvRRklGwk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 231AsuZi130439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Apr 2022 05:54:56 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 1
 Apr 2022 05:54:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 1 Apr 2022 05:54:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 231AstgX011130;
        Fri, 1 Apr 2022 05:54:55 -0500
Date:   Fri, 1 Apr 2022 16:24:54 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2 1/4] mtd: spi-nor: Parse BFPT to determine the 4-Byte
 Address Mode methods
Message-ID: <20220401105454.7qfkoq2li36m3qyk@ti.com>
References: <20220309144215.179449-1-tudor.ambarus@microchip.com>
 <20220309144215.179449-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220309144215.179449-2-tudor.ambarus@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/22 04:42PM, Tudor Ambarus wrote:
> BFPT[DWORD(16)] defines the methods to enter and exit the 4-Byte Address
> Mode. Parse BFPT to determine the method. Will rename the methods with
> generic names in a further patch, to keep things trackable in this one.
> 
> Some regressions may be introduced by this patch, because the
> params->set_4byte_addr_mode method that was set either in
> spi_nor_init_default_params() or later overwritten in default_init() hooks,
> may now be overwritten with a different value based on the BFPT data. If
> that's the case, the fix is to introduce a post_bfpt fixup hook where one
> should fix the wrong BFPT info.

Okay. Let's try to queue this series (and its dependencies) early in the 
rc cycle to give some time to catch bugs.

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
