Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDF2548017
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiFMHEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiFMHEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:04:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9743F32B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655103845; x=1686639845;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lGRslEDBi/r50Yl/I5+hiddSnjAV0vdzr7o76q/W6sk=;
  b=O5rOdsEUd6VrYaQrVfe/IzjzrQMaDhKGg2NqHWSLC+nTFP3K9v6o+Epz
   0ngcYYHpb0VxMdzjh+X0IfKzuKX+XXqj+MILgGOfX1pmB2Iv5JjXaGIH3
   Va8jf3eKKF7K+mBywCLSm68Yt2uQT3LLdwlQPY52pWS6hOlW13Za039BT
   q01t2dyIbn0JYXaEfBytIOi0tt5n4V0sD6WuakB1HuzUS9vcFsUQ8iknW
   tRCpxl1wRcRvHXU4lwgAUlK1yl2vuaeS3FX5LFnJ88a5ezje4Jzdtrozl
   2ntt/JM0VgddyIhsCAhOhO93eSgbx6KwRaBqPbEiD1BWhdnmNUa/Mstrj
   A==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="207825754"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 15:04:04 +0800
IronPort-SDR: t4ah0JnLxME02i3VUWS/Aygd2gVgcERWxTE1Ts6G0SXT2oEYWEFzL6YZORN0CWVk7IQ7lAoifG
 EkYoE782+Q3y2D3TWHObdGK4Umig1vdOcqWmOyfvP5kVqoKM/xKZRrDfmcr8X4h2xWVDgJMZZk
 qCrcBQnRFH9mZJhti82P/r1GbuhRWt7cmIsDbt+LHm45FwWMegXo+f0DD+J5+xo6GecTpL2hce
 VJr1O4tNil+xGfrAFgZw2r57BD3xzZx8+mDk74V419HGgs3vhBrSpqSzSLe9VcDy6+nGobwkRB
 3EzMWxj6vN0VAUuahL+xNFWY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 23:22:44 -0700
IronPort-SDR: 85g9/+IvmZeey4X0sNaW7euWiWvdFWX9vWt8CVJ973lzPeX3jtA5EwbXuLaqHWQ1HqIKy9+NGe
 OatBZgw64pP2mFBBeCcyyHpytIh5IcNa8HEexdzNWzseB4M/tv7T0QgTVY6T7z6EPWEzJFtVhe
 wa9T5d13wWENi5BYd0GAh7hOXaRUFP++UtriKScFivZkTUBs3zPBM6kyWJoaYQ9So391XRFGuU
 qOyJKqceGKuanPeAy9iT3zev4isdpdlN+N37F+JahyoWjJj3HGHhRWG+Zfks8qP9zlksbt4ioK
 8s8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 00:04:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LM2c357lqz1Rwrw
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:04:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655103843; x=1657695844; bh=lGRslEDBi/r50Yl/I5+hiddSnjAV0vdzr7o
        76q/W6sk=; b=VfUEQQtQZE4NilJyxf+D1Gh9F+MO9J6Afadjgu9EDjbtN6JJUUJ
        X2GSvPG8496HUnQBoq9Q8x/5DkUX4gwbUZwBAIbMdmK99rcahx0eQ9FNZbBGOD/k
        hroMu2F5H8WgDGYDnO29AHpA3RBTA0Yja6H2m/xd3xIAMX3LghjpDWI9LV7QMDBR
        URswIVl2Ls1mOx9VYrh5/X8JBY8gDWpcOg6NDBrvYh8M7SCfvi2RQcR7Q9jMqJ0G
        4QP5/QjUAVQaopN/dWjDvj4ZnR4izujQCx89j1OO5dXyYbUfIhnzeddCfAKIF+m7
        a88Pznfo8cKOPrKL4Mpe7WAC4PxNt1AB0Dg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a2Jx724zg9oi for <linux-kernel@vger.kernel.org>;
        Mon, 13 Jun 2022 00:04:03 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LM2c04Yg4z1Rvlc;
        Mon, 13 Jun 2022 00:04:00 -0700 (PDT)
Message-ID: <3f519a72-bb43-b1f0-c85d-a2ea4596f2f2@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 16:03:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 04/18] scsi: core: Add support to send reserved
 commands
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-5-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1654770559-101375-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 19:29, John Garry wrote:
> Add a method to queue reserved commands.
> 
> TODO:
> - fix timeout handler to call into reserved commands
> - We don't clear host_scribble for libata qc, but we should be able to drop
>   this if we store libata qc in the scsi cmnd priv_data
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/hosts.c     |  6 ++++++
>  drivers/scsi/scsi_lib.c  | 32 ++++++++++++++++++++++++++++++++
>  include/scsi/scsi_cmnd.h |  5 +++++
>  include/scsi/scsi_host.h |  1 +
>  4 files changed, 44 insertions(+)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index 27296addaf63..5c9b05a8fec8 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -221,6 +221,12 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>  		goto fail;
>  	}
>  
> +	if (shost->nr_reserved_cmds && !sht->reserved_queuecommand) {
> +		shost_printk(KERN_ERR, shost,
> +			"nr_reserved_cmds set but no method to queue\n");
> +		goto fail;

This would be a driver implementation bug. So what about a WARN() here ?

> +	}
> +
>  	/* Use min_t(int, ...) in case shost->can_queue exceeds SHRT_MAX */
>  	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
>  				   shost->can_queue);
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index f6e53c6d913c..8c8b4c6767d9 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1422,6 +1422,16 @@ static void scsi_complete(struct request *rq)
>  	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
>  	enum scsi_disposition disposition;
>  
> +	if (scsi_is_reserved_cmd(cmd)) {
> +		struct scsi_device *sdev = cmd->device;
> +
> +		scsi_mq_uninit_cmd(cmd);
> +		scsi_device_unbusy(sdev, cmd);
> +		__blk_mq_end_request(rq, 0);
> +
> +		return;
> +	}
> +
>  	INIT_LIST_HEAD(&cmd->eh_entry);
>  
>  	atomic_inc(&cmd->device->iodone_cnt);
> @@ -1706,6 +1716,28 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	WARN_ON_ONCE(cmd->budget_token < 0);
>  
> +	if (scsi_is_reserved_cmd(cmd)) {
> +		unsigned char *host_scribble = cmd->host_scribble;
> +
> +		if (!(req->rq_flags & RQF_DONTPREP)) {
> +			ret = scsi_prepare_cmd(req);
> +			if (ret != BLK_STS_OK) {
> +

Stray blank line.

> +				goto out_dec_host_busy;
> +			}

No need for the curly brackets here.

> +
> +			req->rq_flags |= RQF_DONTPREP;
> +		} else {
> +			clear_bit(SCMD_STATE_COMPLETE, &cmd->state);
> +		}
> +
> +		cmd->host_scribble = host_scribble;
> +
> +		blk_mq_start_request(req);
> +
> +		return shost->hostt->reserved_queuecommand(shost, cmd);
> +	}
> +
>  	/*
>  	 * If the device is not in running state we will reject some or all
>  	 * commands.
> diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> index 1e80e70dfa92..e47df5836070 100644
> --- a/include/scsi/scsi_cmnd.h
> +++ b/include/scsi/scsi_cmnd.h
> @@ -152,6 +152,11 @@ static inline void *scsi_cmd_priv(struct scsi_cmnd *cmd)
>  	return cmd + 1;
>  }
>  
> +static inline bool scsi_is_reserved_cmd(struct scsi_cmnd *cmd)
> +{
> +	return blk_mq_is_reserved_rq(scsi_cmd_to_rq(cmd));
> +}
> +
>  void scsi_done(struct scsi_cmnd *cmd);
>  void scsi_done_direct(struct scsi_cmnd *cmd);
>  
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 149dcbd4125e..88c8504395c8 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -73,6 +73,7 @@ struct scsi_host_template {
>  	 * STATUS: REQUIRED
>  	 */
>  	int (* queuecommand)(struct Scsi_Host *, struct scsi_cmnd *);
> +	int (* reserved_queuecommand)(struct Scsi_Host *, struct scsi_cmnd *);
>  
>  	/*
>  	 * The commit_rqs function is used to trigger a hardware


-- 
Damien Le Moal
Western Digital Research
