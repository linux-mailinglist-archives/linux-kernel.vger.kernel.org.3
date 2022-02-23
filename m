Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4221E4C116D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbiBWLe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbiBWLex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:34:53 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEBC90FD4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:34:22 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21NBYFUt067880;
        Wed, 23 Feb 2022 05:34:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645616055;
        bh=2LkD5YBwfGax8FSb4kF5KhkTV5+/YMmcx2pkuCKsJLo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=FzfGoYsz8mChcNQvv4DFI4u4gFlQ4pyTZ/I3HCB5tzml3JZyul0LZphnfihl5o4hR
         Ab3exPlovIcti82zderru5bGg0A66gHh2lRWFJSciwNyJLVGO2mUAi3O7pfgHLvfY6
         Lvui4vHLbYGNH5Yxla5uXlnuBHpESHILiSOs5iSk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21NBYFjq067397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 05:34:15 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 05:34:15 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 05:34:15 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21NBYEtb060315;
        Wed, 23 Feb 2022 05:34:15 -0600
Date:   Wed, 23 Feb 2022 17:04:13 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <yaliang.wang@windriver.com>
Subject: Re: [PATCH v4 04/32] mtd: spi-nor: esmt: unify function names
Message-ID: <20220223113413.g6maqnl4d4lew4wj@ti.com>
References: <20220221120809.1531502-1-michael@walle.cc>
 <20220221120809.1531502-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220221120809.1531502-5-michael@walle.cc>
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

On 21/02/22 01:07PM, Michael Walle wrote:
> To avoid name clashes unify all the function and static object names and
> use one of the following prefixes which should be sufficiently unique:
>  - <vendor>_nor_
>  - <flash_family>_nor_
>  - <flash_part>_
> 
> There are no functional changes.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
