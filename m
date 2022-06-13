Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B50E54807A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbiFMHXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239214AbiFMHW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:22:58 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBB61AF2C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655104975; x=1686640975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KRf8Nx4WWfj1E8H1UaCkxU+OW/prlnMmWW8uAdir3Ps=;
  b=k67/BIajNQHvJDThd4Y04lgJ/ZDvquiBF44HNs1O9x7bp9X75ABIp1LA
   W32+1qTZjwJNteyRjA4wlqunQpcR54DHJFtoZTVNq7GLiZnX5qXkcHaGS
   JIzfXq+dTIqbz2SVNB7NAzp84/Sza70Zh4bSO1XdQPzVIeD+IrjwO7AXF
   IPxSIqU2iNTEBV+5ObZoxdQ2CQryRDQbknZcuucKwzm4w7CKtvIihjGTN
   /dyu90vvm//8Ph6CDVB+hl9/8gUOXuXHrK4q/Ot7W+4s/326UqvJbcP2/
   kP6taC0QouKi4FqFJBr6TJ60cE/q2HYA2ugOZ9Wm5C64G0Exh+ihxaNeq
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="203742700"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 15:22:51 +0800
IronPort-SDR: j0k52itu356SUCOnSBlKQSvB80QYKc/rkN335FswZcz13+BbWWyehFjYMtzsBR72ncIjyQ/Aq/
 TAGRvBUtKrvhwbcZDWUGLsyfzRCfsZQEg6SSMTmRssZBnsJmd0L9MSjJ/RcZP4DugoL/39NCHK
 5N+qziLMI/p7C3c4+S26GEa6xO5P25gQnluiZ8Hn2bm+ic0utsYB/4MroW3uzgk1m3WLDQeY4m
 NH+Ef6N7GpkcE7ZRxZe/0qaaSfhs1o+yggjZP5zsFP+dE48R6EvA87ymIBl3fL7XX/wpi+Jds/
 gaOBSoCcRRD87gLPI9EDX7El
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 23:41:31 -0700
IronPort-SDR: xCMWZ00sTmG5PBDkSj9SNsvt0+fL657n795pjtnJ4d8k9H+/lBbwzNiUH/c4I60kBSIeZFYjGQ
 8wrZmox/YhumFjM4LhXc/Lc8fOHLChtBJxZ3lwpP1XxjRp1DEaFQ5f+L/W2G7dP4yfnD40Y90H
 NLkZNpJgaTMn6lOdCSePDwGgApaA0hKyx40iD5mMnvIqfoxiJY8UgEnJMdBufjEq8AbYbBAle6
 b6jD7rdBO96gBYFVXl9gH9NI5N59jobC7mBPBT7WDhoRgz5qOeZF5vCKYPqOu95cWJ/dwNo6sA
 jDQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 00:22:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LM31k3scWz1SHwl
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:22:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655104969; x=1657696970; bh=KRf8Nx4WWfj1E8H1UaCkxU+OW/prlnMmWW8
        uAdir3Ps=; b=P9htuM/mt818zD5f2wj3iPLOEgN1cTV77qh91MA22JWJud8ApO6
        8DRqgN+uHmRoWO/3OPfpDye1Nc1eRdPYe0nuEZO9GQ8611OlWOXAbx+vQnbgcL8e
        ZUsmh1iEI8O6c1w+Z8AXVU6WlUyKTDL36VVrV0qp3cxVnKNjnaHwcfpo4vGeufD4
        27FfjeySZojqOHuTa1H4GFFTEf8LaOEHQUVZ3T2CcTmqFlF0inxLmsOTVN3EulCz
        vdYxTXYeF9Gezj0cmmcFukjRlf3ch5LhWZHAtiG/SADHIt8pfh3yN/c8zkeU3N+Q
        Rkc1vcBvXgImeFSwZhba+DlyvwGxkL/c9iw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 79lTfPo8cZKP for <linux-kernel@vger.kernel.org>;
        Mon, 13 Jun 2022 00:22:49 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LM31f1VWnz1Rvlc;
        Mon, 13 Jun 2022 00:22:45 -0700 (PDT)
Message-ID: <502b2148-ca81-9fc8-c6b3-0cc25bf354a6@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 16:22:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 08/18] libata: Queue ATA internal commands as
 requests
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-9-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1654770559-101375-9-git-send-email-john.garry@huawei.com>
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
> Follow the normal path for requests and queue through the block layer.
> 
> We hold the qc pointer in the scmd host scribble, which is less than
> ideal. In future we can hold the ata_queued_cmd in the scmd priv_data,
> allowing for easy lookup.
> 
> We need to use the shost sdev to queue these requests. That is because we
> initially do not have the target disk scsi_device allocated yet when
> queueing internal commands. This is less than ideal, and makes it hard for
> libsas to know when queueing an internal command whether it is a ATA
> internal command or not.
> 
> Also make ata_exec_internal_sg() static - there are no users outside
> libata-core.c
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/ata/libata-core.c | 137 +++++++++++++++++++++-----------------
>  drivers/ata/libata-sata.c |   5 +-
>  drivers/ata/libata.h      |   4 --
>  3 files changed, 80 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 40e816419f48..6b1aaeccb253 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1438,9 +1438,18 @@ unsigned long ata_id_xfermask(const u16 *id)
>  }
>  EXPORT_SYMBOL_GPL(ata_id_xfermask);
>  
> -static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
> +void ata_qc_complete_internal(struct ata_queued_cmd *qc)
>  {
> -	struct completion *waiting = qc->private_data;
> +	struct scsi_cmnd *scmd = qc->scsicmd;
> +
> +	scsi_done(scmd);
> +}
> +
> +static void ata_internal_end_rq(struct request *rq, blk_status_t error)
> +{
> +	struct completion *waiting = rq->end_io_data;
> +
> +	rq->end_io_data = (void *)(uintptr_t)error;
>  
>  	complete(waiting);
>  }
> @@ -1467,52 +1476,74 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
>   *	RETURNS:
>   *	Zero on success, AC_ERR_* mask on failure
>   */
> -unsigned ata_exec_internal_sg(struct ata_device *dev,
> +static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  			      struct ata_taskfile *tf, const u8 *cdb,
> -			      int dma_dir, struct scatterlist *sgl,
> -			      unsigned int n_elem, unsigned long timeout)
> +			      int dma_dir, void *buf, unsigned int buflen,
> +			      unsigned long timeout)
>  {
>  	struct ata_link *link = dev->link;
>  	struct ata_port *ap = link->ap;
> +	struct Scsi_Host *scsi_host = ap->scsi_host;
> +	struct scsi_device *sdev = scsi_host->sdev;
>  	u8 command = tf->command;
>  	int auto_timeout = 0;
>  	struct ata_queued_cmd *qc;
> -	unsigned int preempted_tag;
> -	u32 preempted_sactive;
> -	u64 preempted_qc_active;
> -	int preempted_nr_active_links;
>  	DECLARE_COMPLETION_ONSTACK(wait);
>  	unsigned long flags;
>  	unsigned int err_mask;
> +	struct scsi_cmnd *scmd;
> +	struct request *req;
>  	int rc;
>  
> -	spin_lock_irqsave(ap->lock, flags);
> +	/*
> +	 * We only support a single reserved command, so this guarantees
> +	 * serialization. However the code already assumed that (we are
> +	 * serialized here per-port).
> +	 */
> +	req = scsi_alloc_request(sdev->request_queue,
> +			dma_dir == DMA_TO_DEVICE ?
> +			REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
> +			BLK_MQ_REQ_RESERVED);
> +	if (IS_ERR(req))
> +		return AC_ERR_OTHER;
>  
> -	/* no internal command while frozen */
> -	if (ap->pflags & ATA_PFLAG_FROZEN) {
> -		spin_unlock_irqrestore(ap->lock, flags);
> -		return AC_ERR_SYSTEM;
> +
> +	if (!timeout) {
> +		if (ata_probe_timeout)
> +			timeout = ata_probe_timeout * 1000;
> +		else {
> +			timeout = ata_internal_cmd_timeout(dev, command);
> +			auto_timeout = 1;
> +		}
>  	}
>  
> -	/* initialize internal qc */
> +	scmd = blk_mq_rq_to_pdu(req);
> +	scmd->allowed = 0;
> +	req->timeout = timeout;
> +	//TODO: Hook up timeout handler
> +	req->rq_flags |= RQF_QUIET;
> +	scmd->device = sdev;
>  	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
>  
> +	/* Do this until we can hold ata_queued_cmd in the SCMD priv data */
> +	scmd->host_scribble = (unsigned char *)qc;
> +
> +	if (buflen) {
> +		int ret = blk_rq_map_kern(sdev->request_queue, req,
> +					  buf, buflen, GFP_NOIO);
> +		if (ret) {
> +			blk_mq_free_request(req);
> +			return AC_ERR_OTHER;
> +		}
> +	}
> +
>  	qc->tag = ATA_TAG_INTERNAL;
>  	qc->hw_tag = 0;
> -	qc->scsicmd = NULL;
> +	qc->scsicmd = scmd;
>  	qc->ap = ap;
>  	qc->dev = dev;
>  	ata_qc_reinit(qc);
>  
> -	preempted_tag = link->active_tag;
> -	preempted_sactive = link->sactive;
> -	preempted_qc_active = ap->qc_active;
> -	preempted_nr_active_links = ap->nr_active_links;
> -	link->active_tag = ATA_TAG_POISON;
> -	link->sactive = 0;
> -	ap->qc_active = 0;
> -	ap->nr_active_links = 0;
> -
>  	/* prepare & issue qc */
>  	qc->tf = *tf;
>  	if (cdb)
> @@ -1525,32 +1556,14 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
>  
>  	qc->flags |= ATA_QCFLAG_RESULT_TF;
>  	qc->dma_dir = dma_dir;
> -	if (dma_dir != DMA_NONE) {
> -		unsigned int i, buflen = 0;
> -		struct scatterlist *sg;
> -
> -		for_each_sg(sgl, sg, n_elem, i)
> -			buflen += sg->length;
> -
> -		ata_sg_init(qc, sgl, n_elem);
> -		qc->nbytes = buflen;
> -	}
>  
> -	qc->private_data = &wait;
> +	qc->private_data = ap;
>  	qc->complete_fn = ata_qc_complete_internal;
>  
> -	ata_qc_issue(qc);
> -
> -	spin_unlock_irqrestore(ap->lock, flags);
> +	req->end_io_data = &wait;
> +	req->end_io = ata_internal_end_rq;
>  
> -	if (!timeout) {
> -		if (ata_probe_timeout)
> -			timeout = ata_probe_timeout * 1000;
> -		else {
> -			timeout = ata_internal_cmd_timeout(dev, command);
> -			auto_timeout = 1;
> -		}
> -	}
> +	blk_execute_rq_nowait(req, true);

How do you get guarantee that this req ends up being issued with
ATA_TAG_INTERNAL as the tag ? Because you have the reserved commands *in
addition to can queue* ? I can see how that works if can_queue is indeed
32, but what if the user changes the max qd ? That breaks, no ?

>  
>  	if (ap->ops->error_handler)
>  		ata_eh_release(ap);
> @@ -1610,13 +1623,15 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
>  	err_mask = qc->err_mask;
>  
>  	ata_qc_free(qc);
> -	link->active_tag = preempted_tag;
> -	link->sactive = preempted_sactive;
> -	ap->qc_active = preempted_qc_active;
> -	ap->nr_active_links = preempted_nr_active_links;
> +	link->active_tag = link->preempted_tag;
> +	link->sactive = link->preempted_sactive;
> +	ap->qc_active = ap->preempted_qc_active;
> +	ap->nr_active_links = ap->preempted_nr_active_links;
>  
>  	spin_unlock_irqrestore(ap->lock, flags);
>  
> +	blk_mq_free_request(req);
> +
>  	if ((err_mask & AC_ERR_TIMEOUT) && auto_timeout)
>  		ata_internal_cmd_timed_out(dev, command);
>  
> @@ -1647,18 +1662,20 @@ unsigned ata_exec_internal(struct ata_device *dev,
>  			   int dma_dir, void *buf, unsigned int buflen,
>  			   unsigned long timeout)
>  {
> -	struct scatterlist *psg = NULL, sg;
> -	unsigned int n_elem = 0;
> +	/* buf may not be aligned, so copy to/from an aligned buffer */
> +	void *tmpbuf = kmemdup(buf, buflen, GFP_KERNEL);
> +	unsigned res;
>  
> -	if (dma_dir != DMA_NONE) {
> -		WARN_ON(!buf);
> -		sg_init_one(&sg, buf, buflen);
> -		psg = &sg;
> -		n_elem++;
> -	}
> +	if (!tmpbuf)
> +		return AC_ERR_OTHER;
>  
> -	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem,
> +	res = ata_exec_internal_sg(dev, tf, cdb, dma_dir, tmpbuf, buflen,
>  				    timeout);
> +
> +	memcpy(buf, tmpbuf, buflen);
> +	kfree(tmpbuf);
> +
> +	return res;
>  }
>  
>  /**
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 7a5fe41aa5ae..3cecc45d54ab 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1258,9 +1258,10 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
>  {
>  	int rc = 0;
>  
> -	if (likely(ata_dev_enabled(ap->link.device)))
> +	if (likely(ata_dev_enabled(ap->link.device)) ||
> +		scsi_is_reserved_cmd(cmd)) {
>  		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
> -	else {
> +	} else {
>  		cmd->result = (DID_BAD_TARGET << 16);
>  		scsi_done(cmd);
>  	}
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 926a7f41303d..1446a482835d 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -53,10 +53,6 @@ extern unsigned ata_exec_internal(struct ata_device *dev,
>  				  struct ata_taskfile *tf, const u8 *cdb,
>  				  int dma_dir, void *buf, unsigned int buflen,
>  				  unsigned long timeout);
> -extern unsigned ata_exec_internal_sg(struct ata_device *dev,
> -				     struct ata_taskfile *tf, const u8 *cdb,
> -				     int dma_dir, struct scatterlist *sg,
> -				     unsigned int n_elem, unsigned long timeout);
>  extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
>  			  int (*check_ready)(struct ata_link *link));
>  extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,


-- 
Damien Le Moal
Western Digital Research
