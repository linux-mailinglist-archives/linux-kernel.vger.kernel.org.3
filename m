Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CFA50AC50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442770AbiDUXvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiDUXux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:50:53 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D231F3524C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650584882; x=1682120882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aLnaWWW4HT7zs56Y0tP2WjF+Iqt8JvrkaqoMfHMqaqM=;
  b=ko/gYzl9eWRLuQlUsMx0JtaMMY61zZDSAI7ZqtiCMGyJJXA4YrY/WcyB
   iYjNHEipuyxSuuQHpFkMisCzDf25TJpXN3zjgVHrRyeReldynD6PY8/aQ
   HdQHv9EDdwVxxlEMOdPwAF6CEyrxhHay2ksIhV9da/M6DGDQrfzT0c5up
   31Mwz0+U94egizsq+VWxCvcKY46Txfz9dbuQTFE21Sv4M1rCcVjlfxryt
   UrtMW42F+9VDIkmdYIzvoXVkl13o/9N+LG4UQIG7OW2XYwSm/vffHp4q5
   STG6jYHgiv2Xq3IdmJfO3lDpwXej/CShIjTs9Q161xhJaqBUBfwRxreVb
   w==;
X-IronPort-AV: E=Sophos;i="5.90,280,1643644800"; 
   d="scan'208";a="310479700"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2022 07:48:02 +0800
IronPort-SDR: o4oWasI44w3wVw8s86vsbFPJ832zNuRmolafolVEBY8cFxmCoCFWQVoDp5ER37PA0QQVJZ1wfn
 Acd661vAXlqhL86tUqsWx8tWaWRwwkYwEVVzvB+1xXkcxBMrwmnjYZL0W1RCh93JLYOAyTUclh
 wRL1uF1UDi3X3/ec24FdHtIeE8JqWVNYm/RnHvTxaZsRkJnMBPgGcqUzyXPDUpSt6Ay7nGODk5
 uZ38xVghkpOSNJBZq5Xko9Hz5O9lFPqvnLTmWCXdSJIdDeU9xqDlNuKv4b7oFnBZVwOBdO/tBa
 2aR9oLbQfQ7TX/RPo6x0K3lK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:18:19 -0700
IronPort-SDR: rxOYNsRw0kcaz18hBKcnX3BY579VkDIzjw1V5xaP9IHYlub+9TDu+AGaVDyOL7J6E1M7GBEp4l
 MvYnlqwIgOuua7Yd0ylF9DWosSM4xJ1kOYQtD8S7kAMspZc/D8b/mF0ciWbHJiSUxEiMHDN0I2
 GrLDFv+fRX8hu9OsDDUVHHMjOAuOkipCSQ/2uvkNTqc61OyNrPLx5cXgYXGc/DOA3+f6sQ96fF
 dptvs4c4GlnWvyaTMtxOhGKQvNBDGhEAsrk2fS8F1hhV9uKVZ68NBfC9TeSqU4BRKEIZbPg+d/
 JP8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:48:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkvNx5CYFz1Rwrw
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:48:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650584881; x=1653176882; bh=aLnaWWW4HT7zs56Y0tP2WjF+Iqt8Jvrkaqo
        MfHMqaqM=; b=NAMCH+UC0tb+DPeaNhocqv2wZz7RvZoDiuoJQoJeGAWfaL3k1BE
        LuUkl4N7GTrUVV6l+HnS7W+Z9UEDCH5l2XGUfwIqjzaE5z1ftHCwQ+oUk1x4Plb/
        UYbZs2r8UlnnTQooYEEqPuwn9k0LuUlC6eTDtwa4Wto/djwYQw9PP3STJURB36S6
        738nyT0lFgbvMmlGE2OFxb2tkAS08ikveBE9v8NlPd0q9Bi7OSmyTONyqZonqcp/
        XjrDOK/wlu0bCAf2gVD9gLqd1KpaEcUTXma5ltHeq/Rembr0yzjVJTDTp/Ul8m8C
        kfuzXvJvTSMr3xkARW6Rtvc5uhtM7CGKpng==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cXKAGtklJYEW for <linux-kernel@vger.kernel.org>;
        Thu, 21 Apr 2022 16:48:01 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkvNw4pZNz1Rvlx;
        Thu, 21 Apr 2022 16:48:00 -0700 (PDT)
Message-ID: <e29fd64e-62ea-746e-f0fb-02ce86b4e61e@opensource.wdc.com>
Date:   Fri, 22 Apr 2022 08:47:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] ata: pata_marvell: Check the 'bmdma_addr' beforing
 reading
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220421013920.3503034-1-zheyuma97@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220421013920.3503034-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 10:39, Zheyu Ma wrote:
> Before detecting the cable type on the dma bar, the driver should check
> whether the 'bmdma_addr' is zero, which means the adapter does not
> support DMA, otherwise we will get the following error:
> 
> [    5.146634] Bad IO access at port 0x1 (return inb(port))
> [    5.147206] WARNING: CPU: 2 PID: 303 at lib/iomap.c:44 ioread8+0x4a/0x60
> [    5.150856] RIP: 0010:ioread8+0x4a/0x60
> [    5.160238] Call Trace:
> [    5.160470]  <TASK>
> [    5.160674]  marvell_cable_detect+0x6e/0xc0 [pata_marvell]
> [    5.161728]  ata_eh_recover+0x3520/0x6cc0
> [    5.168075]  ata_do_eh+0x49/0x3c0
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---Changes in v2:
>      - Delete the useless 'else'

Note for future contributions: The change log should be placed *after* 
the "---" that comes before the "diff" line below. Otherwise, the change 
log pollutes the commit message.

I fixed that and applied to for-5.18-fixes. Thanks.

> ---
>   drivers/ata/pata_marvell.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
> index 0c5a51970fbf..014ccb0f45dc 100644
> --- a/drivers/ata/pata_marvell.c
> +++ b/drivers/ata/pata_marvell.c
> @@ -77,6 +77,8 @@ static int marvell_cable_detect(struct ata_port *ap)
>   	switch(ap->port_no)
>   	{
>   	case 0:
> +		if (!ap->ioaddr.bmdma_addr)
> +			return ATA_CBL_PATA_UNK;
>   		if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)
>   			return ATA_CBL_PATA40;
>   		return ATA_CBL_PATA80;


-- 
Damien Le Moal
Western Digital Research
