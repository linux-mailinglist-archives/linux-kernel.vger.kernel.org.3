Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2EF47E41C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348658AbhLWNbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:31:14 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:22408 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243693AbhLWNbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640266273; x=1671802273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YoDSXtV6rvarkWTyXxeMntGyoYZrqMPACoSb3VC2mL4=;
  b=vc1PxbrBE69FvAJLplmRO9XFbn8ivQazs1651xM1Bn6eoMm3oaAHnLKU
   hVqbXow5vpca7cy818ao+KiWidNs6qnsh4DUv2UdPW2jVTYQ0wdDMHolb
   6l//jQ4Rsl/yNv3LLbnk4UcoG4sy1tUr4CyHrrk7kjtOAeUlaDX++ZdCS
   fPI7CcsxCgsV9nAxQDTKI1LmhmUnjJ+aCBJjrmDI6k6PSMDCG6H+iuS9S
   GBZUhugRID4h2XsIMLmAhdGO7mr3Q8L0YfMdAgK9rPKJYCFYdZKTCJoPF
   2uTP0pyMnDw3S3wuaaML/3DsIiw2rSfo5bwum6RfGSvIcXk5qtRMjRmSG
   g==;
IronPort-SDR: rB9GO1hyF7ANxWThvzaHFPXpcCJwHOmJl6R52U2hsKsWO8hEk7AftzCyrE+DgkMRm4tyVyuJEx
 e6llV6TsIiZNuPAB5+lDd3bLaFvslWR+qad5UbksDRIZ+aJARzN05oxrbH0DLvynjhjdH88LAi
 QoiQ4RF9pTmlg6D/liy9XjpV/y4s0ZwiPuQ3GICVAMjKINGTWL29f6pV4XokvhpwW+H2E+0kWT
 k8+73kEatNIBxFr8Y6AZgfZFIblT9kxPy15Wv8F1sXbsy0WvuRo0cLPO3thKpeFTzbZ1GZT2gx
 lCj1E/KvaIql3kLPzTgaRbjU
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="80492374"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 06:31:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 06:31:12 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 23 Dec 2021 06:31:10 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        "Richard Weinberger" <richard@nod.at>, <linux-spi@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: (subset) Re: [PATCH v2 0/6] Avoid odd length/address read/writes in 8D-8D-8D mode.
Date:   Thu, 23 Dec 2021 15:31:08 +0200
Message-ID: <164026605398.210110.7825546754254895590.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531181757.19458-1-p.yadav@ti.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 23:47:51 +0530, Pratyush Yadav wrote:
> On Octal DTR flashes like Micron Xcella or Cypress S28 family, reads or
> writes cannot start at an odd address in 8D-8D-8D mode. Neither can they
> be odd bytes long. Upper layers like filesystems don't know what mode
> the flash is in, and hence don't know the read/write address or length
> limitations. They might issue reads or writes that leave the flash in an
> error state. In fact, using UBIFS on top of the flash was how I first
> noticed this problem.
> 
> [...]

Applied to spi-nor/next, thanks!

[1/6] mtd: spi-nor: core: use 2 data bytes for template ops
      https://git.kernel.org/mtd/c/0d051a49829a
[2/6] mtd: spi-nor: spansion: write 2 bytes when disabling Octal DTR mode
      https://git.kernel.org/mtd/c/63017068a6d9
[3/6] mtd: spi-nor: micron-st: write 2 bytes when disabling Octal DTR mode
      https://git.kernel.org/mtd/c/9de3cb1cc95b

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
