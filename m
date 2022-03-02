Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B1F4CA489
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241703AbiCBMPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiCBMPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:15:15 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663036E33
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646223271; x=1677759271;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=st7VlNZfsQedcZfoXbBc4FhTRPPMwwLWFLadNwX0BdE=;
  b=i7jRs6GGJX1O0QezOtpdDQRwZhGvodsTbivsqiKyMjt7kTmhE8u6CymE
   cQGyzMD8QTgRrePhjuOA3PUH67FYd1SJrUJDvap3VMDAf3FSSC0rvSxtj
   sFVqVjTZun2+wfw5qm9Ykk6FlPsgCnTG0KfKz8YNEo3yfiuLLB34ZtWAX
   HcRnpxWfB/+qJyaJrqQsI5E5h9JI+bwxOTElZ35rD/pARXHEV//0CvHbO
   tYUwfjcllNV9uKeMp+/4ahrO3fAQGidvCGwLqomAeLGRPj9m+jh6PNvNE
   PtHFeQRSVIegsfCq6z5KW1PzqsZstsN3Ig9e+MM6LLJyXlRBJIs/tEbHK
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,148,1643644800"; 
   d="scan'208";a="194288544"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2022 20:14:31 +0800
IronPort-SDR: J0UhQK55uF/xX6UB6bfSnqJvxa7NpLewf3HbZizSP9YEYmOAynS+PYz2xfQRN0wwkb3eR/iuay
 BVWJRC/Z4Pj/ECtF9gbq+nOcka7xgWxB64PQPl+9zaM82ADEe0iUMvsL/nvagJaDyc/nVa1OIn
 pu5VvccOpm+tYOCPKrDL/V2wD4Wg9q8X3ahRG7/XygkDLxP+Mw228Lmgn/QWg3zViZLPlDBJo3
 ogJg4KZgdoWqNiSZJD2B1rCo//LswxOM/Lfdy0PYw/GmnFph8RBIrluRqm7F3hUhWBBKLviQYi
 8ASw2KHjM9WD1Nma1SDhro78
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:46:57 -0800
IronPort-SDR: ktqZozwHTZ2Hk4TD7DpRZ/JdqMUUpcs7B6TI3PV7nPi1+lPVwvBhhGALFODwIGrO9bJKLxo3WA
 CBT+tm5XDBNZ9JG8zqJjDGkZswNHoE1n52vPUoRxlBSw/MobUv7F/kzxjoAhCBeKHh5d7FVx7k
 iR/wY+pQBSDPE7nV96qSR2XbAvc1Cgf2PFfCxOieE8c0wcpQWlll/qgTYTEtLyxchG1qsIpUb1
 w5Tf2ZP9cn6Lg99/YTR2+YslFzjMSPMgta9+IZPeC8MUdYnvM7PA+j+FLOP2AubJse98tbakrW
 RWk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 04:14:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K7tMq14hWz1SVny
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:14:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646223270; x=1648815271; bh=st7VlNZfsQedcZfoXbBc4FhTRPPMwwLWFLa
        dNwX0BdE=; b=O/Xqlmd6L9ZYxVWuxfR7//vQFr6cu+V9IZCqSsUSG9mKBN0c+OM
        1TgcokNV4wTCyoZwGM54aSKvgzQRi3kkt3k24oo5kBBwYp9pQ8DyKTEDC2FQyEyn
        cQl9CIaWqJ2UA/1asVX3livd2GhNNQPvNeeO5CFbsNS4o71YYi+kMvjIH+dTzqs9
        2j8/U9vm+t7heVa9v1z877eIlSHyx5XIKCNq5dWukQyTIUFISkKCAbtElji6/fJP
        X2GBYkPwysF34vjfViFYoVrKo8eeopUG52Ut/u54i+YbHU3cet0lG4q35zqiHbJN
        2lcby5a4aBon7Nw5M3Xwo9LPs+pIYrzr+tg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 71_Au9fEXuo0 for <linux-kernel@vger.kernel.org>;
        Wed,  2 Mar 2022 04:14:30 -0800 (PST)
Received: from [10.112.1.94] (c02drav6md6t.wdc.com [10.112.1.94])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K7tMn1p73z1Rvlx;
        Wed,  2 Mar 2022 04:14:28 -0800 (PST)
Message-ID: <3ae1eef4-1617-5202-a893-16a9b49638c3@opensource.wdc.com>
Date:   Wed, 2 Mar 2022 14:14:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/3] ata: ahci: Rename board_ahci_mobile
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        pmenzel@molgen.mpg.de, hdegoede@redhat.com
References: <20220225172319.846891-1-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220225172319.846891-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/02/25 19:23, Mario Limonciello wrote:
> This board definition was originally created for mobile devices to
> designate default link power managmeent policy to influence runtime
> power consumption.
> 
> As this is interesting for more than just mobile designs, rename the
> board to `board_ahci_low_power` to make it clear it is about default
> policy.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> changes from v2->v3
>  * Add tags
>  * Move new board ID name to correct location in the enum
>  drivers/ata/ahci.c | 96 +++++++++++++++++++++++-----------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
