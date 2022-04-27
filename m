Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A78A5115C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiD0LXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiD0LXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:23:05 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FC52FFCD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:19:54 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R9VNJp101899;
        Wed, 27 Apr 2022 04:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651051883;
        bh=WnkMojl+5yTgWYJKpIINGd1qbrRLPAPKKGmGJon3tAE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J7PxTdJIHETzM3q9K8isnAOHS5u/2SjgbY5cA7/OJuWzStACI5TeR8UHz1ZhVxfRh
         +9DFWpiC8WJUgxQWfHt5VZ7SCUUWfDte6qoo+7ZxJzdPb2W/WZtm2TiJfT/zi9OoJy
         Ji+kWXun+boNLARw4/7aE4Kx3v1mArBBD5mZRvhU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R9VN8q025146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 04:31:23 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 04:31:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 04:31:23 -0500
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R9VKtQ033801;
        Wed, 27 Apr 2022 04:31:21 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Chen-Tsung Hsieh <chentsung@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in spi_nor_write_16bit_sr_and_check()
Date:   Wed, 27 Apr 2022 15:01:18 +0530
Message-ID: <165105175022.2301505.17772932971669614523.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126073227.3401275-1-chentsung@chromium.org>
References: <20220126073227.3401275-1-chentsung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 15:32:26 +0800, Chen-Tsung Hsieh wrote:
> Read back Status Register 1 to ensure that the written byte match the
> received value and return -EIO if read back test failed.
> 
> Without this patch, spi_nor_write_16bit_sr_and_check() only check the
> second half of the 16bit. It causes errors like spi_nor_sr_unlock()
> return success incorrectly when spi_nor_write_16bit_sr_and_check()
> doesn't write SR successfully.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/1] mtd: spi-nor: core: Check written SR value in spi_nor_write_16bit_sr_and_check()
      https://git.kernel.org/mtd/c/70dd83d737

--
Regards,
Pratyush Yadav
Texas Instruments Inc.

