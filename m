Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCD5389B1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbiEaBmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiEaBmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:42:14 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BE642A19;
        Mon, 30 May 2022 18:42:12 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 31 May
 2022 09:40:23 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 31 May
 2022 09:40:21 +0800
Message-ID: <0578e737-86de-610b-038f-4bdada7f962e@meizu.com>
Date:   Tue, 31 May 2022 09:40:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] scsi: hpsa: Fix pointer dereferenced before checking
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <storagedev@microchip.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1653899188-26544-1-git-send-email-baihaowen@meizu.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <1653899188-26544-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/5/30 下午4:26, Haowen Bai 写道:
> The dev->raid_map is dereferencing before null checking, so move
>  it after checking.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/scsi/hpsa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index a47bcce3c9c7..fa785f60b1e6 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -5104,7 +5104,7 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
>  {
>  	struct scsi_cmnd *cmd = c->scsi_cmd;
>  	struct hpsa_scsi_dev_t *dev = cmd->device->hostdata;
> -	struct raid_map_data *map = &dev->raid_map;
> +	struct raid_map_data *map;
>  	struct raid_map_disk_data *dd = &map->data[0];
>  	int is_write = 0;
>  	u32 map_index;
> @@ -5137,6 +5137,8 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_info *h,
>  	if (!dev)
>  		return -1;
>  
> +	map = &dev->raid_map;
> +
>  	if (dev->in_reset)
>  		return -1;
>  

Sorry, plz ignore this patch.

dev->raid_map is dereferenced, &dev->raid_map is just a pointer math for pointer address offset, so it would not cause a bug(dereferencing null pointer).

-- 
Haowen Bai

