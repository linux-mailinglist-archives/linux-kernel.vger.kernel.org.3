Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832F8579645
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiGSJ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiGSJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:26:23 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797B31FCD5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:26:21 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id wxSG2700S4C55Sk06xSGow; Tue, 19 Jul 2022 11:26:18 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oDjUZ-004Dzd-3y; Tue, 19 Jul 2022 11:26:11 +0200
Date:   Tue, 19 Jul 2022 11:26:06 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     Bart Van Assche <bvanassche@acm.org>
cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-scsi@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
In-Reply-To: <20220630195703.10155-3-bvanassche@acm.org>
Message-ID: <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
References: <20220630195703.10155-1-bvanassche@acm.org> <20220630195703.10155-3-bvanassche@acm.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hoi Bart,

On Thu, 30 Jun 2022, Bart Van Assche wrote:
> For some technologies, e.g. an ATA bus, resuming can take multiple
> seconds. Waiting for resume to finish can cause a very noticeable delay.
> Hence this patch that restores the behavior from before patch "scsi:
> core: pm: Rely on the device driver core for async power management" for
> most SCSI devices.
>
> This patch introduces a behavior change: if the START command fails, do
> not consider this as a SCSI disk resume failure.
>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: John Garry <john.garry@huawei.com>
> Cc: ericspero@icloud.com
> Cc: jason600.groome@gmail.com
> Tested-by: jason600.groome@gmail.com
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215880
> Fixes: a19a93e4c6a9 ("scsi: core: pm: Rely on the device driver core for async power management")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks for your patch, which is now commit 88f1669019bd62b3 ("scsi: sd:
Rework asynchronous resume support") in scsi/for-next.

On the Salvator-XS development board[1] with a SATA hard drive
connected, accessing the hard drive after resume from s2idle hangs.
I have bisected this to the aformentioned commit, and reverting this
commit fixes the issue.

[1] arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dts

> ---
> drivers/scsi/sd.c | 84 +++++++++++++++++++++++++++++++++++++----------
> drivers/scsi/sd.h |  5 +++
> 2 files changed, 71 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 895b56c8f25e..84696b3652ee 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -103,6 +103,7 @@ static void sd_config_discard(struct scsi_disk *, unsigned int);
> static void sd_config_write_same(struct scsi_disk *);
> static int  sd_revalidate_disk(struct gendisk *);
> static void sd_unlock_native_capacity(struct gendisk *disk);
> +static void sd_start_done_work(struct work_struct *work);
> static int  sd_probe(struct device *);
> static int  sd_remove(struct device *);
> static void sd_shutdown(struct device *);
> @@ -3463,6 +3464,7 @@ static int sd_probe(struct device *dev)
> 	sdkp->max_retries = SD_MAX_RETRIES;
> 	atomic_set(&sdkp->openers, 0);
> 	atomic_set(&sdkp->device->ioerr_cnt, 0);
> +	INIT_WORK(&sdkp->start_done_work, sd_start_done_work);
>
> 	if (!sdp->request_queue->rq_timeout) {
> 		if (sdp->type != TYPE_MOD)
> @@ -3585,12 +3587,69 @@ static void scsi_disk_release(struct device *dev)
> 	kfree(sdkp);
> }
>
> +/* Process sense data after a START command finished. */
> +static void sd_start_done_work(struct work_struct *work)
> +{
> +	struct scsi_disk *sdkp = container_of(work, typeof(*sdkp),
> +					      start_done_work);
> +	struct scsi_sense_hdr sshdr;
> +	int res = sdkp->start_result;
> +
> +	if (res == 0)
> +		return;
> +
> +	sd_print_result(sdkp, "Start/Stop Unit failed", res);
> +
> +	if (res < 0)
> +		return;
> +
> +	if (scsi_normalize_sense(sdkp->start_sense_buffer,
> +				 sdkp->start_sense_len, &sshdr))
> +		sd_print_sense_hdr(sdkp, &sshdr);
> +}
> +
> +/* A START command finished. May be called from interrupt context. */
> +static void sd_start_done(struct request *req, blk_status_t status)
> +{
> +	const struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
> +	struct scsi_disk *sdkp = scsi_disk(req->q->disk);
> +
> +	sdkp->start_result = scmd->result;
> +	WARN_ON_ONCE(scmd->sense_len > SCSI_SENSE_BUFFERSIZE);
> +	sdkp->start_sense_len = scmd->sense_len;
> +	memcpy(sdkp->start_sense_buffer, scmd->sense_buffer,
> +	       ARRAY_SIZE(sdkp->start_sense_buffer));
> +	WARN_ON_ONCE(!schedule_work(&sdkp->start_done_work));
> +}
> +
> +/* Submit a START command asynchronously. */
> +static int sd_submit_start(struct scsi_disk *sdkp, u8 cmd[], u8 cmd_len)
> +{
> +	struct scsi_device *sdev = sdkp->device;
> +	struct request_queue *q = sdev->request_queue;
> +	struct request *req;
> +	struct scsi_cmnd *scmd;
> +
> +	req = scsi_alloc_request(q, REQ_OP_DRV_IN, BLK_MQ_REQ_PM);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +
> +	scmd = blk_mq_rq_to_pdu(req);
> +	scmd->cmd_len = cmd_len;
> +	memcpy(scmd->cmnd, cmd, cmd_len);
> +	scmd->allowed = sdkp->max_retries;
> +	req->timeout = SD_TIMEOUT;
> +	req->rq_flags |= RQF_PM | RQF_QUIET;
> +	req->end_io = sd_start_done;
> +	blk_execute_rq_nowait(req, /*at_head=*/true);
> +
> +	return 0;
> +}
> +
> static int sd_start_stop_device(struct scsi_disk *sdkp, int start)
> {
> 	unsigned char cmd[6] = { START_STOP };	/* START_VALID */
> -	struct scsi_sense_hdr sshdr;
> 	struct scsi_device *sdp = sdkp->device;
> -	int res;
>
> 	if (start)
> 		cmd[4] |= 1;	/* START */
> @@ -3601,23 +3660,10 @@ static int sd_start_stop_device(struct scsi_disk *sdkp, int start)
> 	if (!scsi_device_online(sdp))
> 		return -ENODEV;
>
> -	res = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL, &sshdr,
> -			SD_TIMEOUT, sdkp->max_retries, 0, RQF_PM, NULL);
> -	if (res) {
> -		sd_print_result(sdkp, "Start/Stop Unit failed", res);
> -		if (res > 0 && scsi_sense_valid(&sshdr)) {
> -			sd_print_sense_hdr(sdkp, &sshdr);
> -			/* 0x3a is medium not present */
> -			if (sshdr.asc == 0x3a)
> -				res = 0;
> -		}
> -	}
> +	/* Wait until processing of sense data has finished. */
> +	flush_work(&sdkp->start_done_work);
>
> -	/* SCSI error codes must not go to the generic layer */
> -	if (res)
> -		return -EIO;
> -
> -	return 0;
> +	return sd_submit_start(sdkp, cmd, sizeof(cmd));
> }
>
> /*
> @@ -3644,6 +3690,8 @@ static void sd_shutdown(struct device *dev)
> 		sd_printk(KERN_NOTICE, sdkp, "Stopping disk\n");
> 		sd_start_stop_device(sdkp, 0);
> 	}
> +
> +	flush_work(&sdkp->start_done_work);
> }
>
> static int sd_suspend_common(struct device *dev, bool ignore_stop_errors)
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
> index 5eea762f84d1..b89187761d61 100644
> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -150,6 +150,11 @@ struct scsi_disk {
> 	unsigned	urswrz : 1;
> 	unsigned	security : 1;
> 	unsigned	ignore_medium_access_errors : 1;
> +
> +	int		start_result;
> +	u32		start_sense_len;
> +	u8		start_sense_buffer[SCSI_SENSE_BUFFERSIZE];
> +	struct work_struct start_done_work;
> };
> #define to_scsi_disk(obj) container_of(obj, struct scsi_disk, disk_dev)
>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
