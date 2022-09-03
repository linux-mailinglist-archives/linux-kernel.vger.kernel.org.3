Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9DC5ABF21
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiICNbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiICNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640E1A805
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662211866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VF4WR22/YCvCHaT1Se0/YxY0BVJERBs0j62JXBy+RbM=;
        b=Fwth8ziU06JmLfyzuXhwdDAc3jSIivrOuERs9BDDSjzc128EwHs8d/A3pDdroamJD91Prt
        nEtSKVnN+7v9yArbzS3d8MF9a6kscD5jI1R/yXmt5/6NZufiuiEBomc0XbGFXFUqDk3SC9
        VkIbwsA96pzDzaXgm58jJoN78CHmdQo=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-270-_HK6ZUoXOPSCqeDE3UmmSg-1; Sat, 03 Sep 2022 09:31:05 -0400
X-MC-Unique: _HK6ZUoXOPSCqeDE3UmmSg-1
Received: by mail-vs1-f71.google.com with SMTP id m129-20020a672687000000b0038ab74e6398so944446vsm.18
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 06:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VF4WR22/YCvCHaT1Se0/YxY0BVJERBs0j62JXBy+RbM=;
        b=UqGBPBCDe/8BL4fMWShE1TqWdekVncPBMr5THypq6ssbv/ib5YEbK2kvQs2ntDaMdf
         vkveDQXPCYZMOIT2AQvKZuKoWQaeOOoQxC/2nNJBqWV+B6LmSYEw1UdEW2jPUDpgdVoF
         lPsDre7DCdDiJpsd6p6qFWuvOiazKsyHQHbJRXfVsPLsrufJ/o7tOwFG8RXfC7hgtzUt
         pDeyepU5oVlCpWLeV6PSDzGK55y6YflCzL4233tbUCx8oJ9e3HXAV9rlLHhj9LH9BcB1
         y9qAwprVYWpNWoKgnLMcl0SNatVeUd93K8yHJmOzBpz7z1yUtDHpDwL5xOxhAqBoTesN
         RadQ==
X-Gm-Message-State: ACgBeo0iDDv5qm43MQTGhBNh1/wxq24UabzRqzLj3or8iaflijnT3nLg
        tuIBijyclxEn1TeMvpMnLgWMZaWgyD+KvUzPQ0Ez8+jD5wGp+Z1gj8DeGVtzHgEH455T5bWPqFL
        tzT64xYPouS3ees3ev08BxYeLv/bLJoQDNuamlpO0
X-Received: by 2002:a67:a40b:0:b0:390:6cfb:c522 with SMTP id n11-20020a67a40b000000b003906cfbc522mr11504753vse.54.1662211864064;
        Sat, 03 Sep 2022 06:31:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4o2rjQb9KexxhrGsPMDpU2L/zVAetBzkDgnzfOhv1havvTEGqAQ45aa5GlHtYApcAC3Xt9oHvFzJXvNfhwL/M=
X-Received: by 2002:a67:a40b:0:b0:390:6cfb:c522 with SMTP id
 n11-20020a67a40b000000b003906cfbc522mr11504749vse.54.1662211863626; Sat, 03
 Sep 2022 06:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com> <20220831155136.23434-6-ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220831155136.23434-6-ZiyangZhang@linux.alibaba.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Sat, 3 Sep 2022 21:30:46 +0800
Message-ID: <CAFj5m9J2vrqh0U11iVtxdDUPcxDWRPA0K+14e9Si61QGySRq8w@mail.gmail.com>
Subject: Re: [RFC PATCH V2 5/6] ublk_drv: consider recovery feature in
 aborting mechanism
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:54 PM ZiyangZhang
<ZiyangZhang@linux.alibaba.com> wrote:
>
> We change the default behavior of aborting machenism. Now monitor_work
> will not be manually scheduled by ublk_queue_rq() or task_work after a
> ubq_daemon or process is dying(PF_EXITING). The monitor work should
> find a dying ubq_daemon or a crash process by itself. Then, it can

Looks you don't consider one dying ubq_daemon as one crash candidate.
Most io implementation is done in the ubq pthread, so it should be
covered by the crash recovery.

> start the aborting machenism. We do such modification is because we want
> to strictly separate the STOP_DEV procedure and monitor_work. More
> specifically, we ensure that monitor_work must not be scheduled after
> we start deleting gendisk and ending(aborting) all inflight rqs. In this
> way we are easy to consider recovery feature and unify it into existing
> aborting mechanism. Really we do not want too many "if can_use_recovery"
> checks.

Frankly speaking, not sure we need to invent new wheel for the
'aborting' mechanism.

In theory, you needn't change the current monitor work and cancel
dev/queue. What you need is how to handle the dying ubq daemon:

1) without user recovery, delete disk if any ubq daemon is died.

2) with user recovery:
    - quiesce request queue and wait until all inflight requests are
requeued(become IDLE);
    - call io_uring_cmd_done for any active io slot
    - send one kobj_uevent(KOBJ_CHANGE) to notify userspace for handling
      the potential crash; if it is confirmed as crash by userspace,
      userspace will send command to handle it.
    (this way will simplify userspace too, since we can add one utility
    and provide it via udev script for handling rec

Checking one flag lockless is usually not safe, also not sure why we
need such flag here, and the original check is supposed to work.

overy)

>
> With recovery feature disabled and after a ubq_daemon crash:
> (1) monitor_work notices the crash and schedules stop_work

driver can't figure out if it is crash, and it can just see if the
ubq deamon is died or not. And crash detection logic should be done
in userspace, IMO.

> (2) stop_work calls ublk_stop_dev()
> (3) In ublk_stop_dev():
>     (a) It sets 'force_abort', which prevents new rqs in ublk_queue_rq();

Please don't add new flag in fast path lockless, and the original check
is supposed to be reused for recovery feature.

>             If ublk_queue_rq() does not see it, rqs can still be ended(aborted)
>                 in fallback wq.
>         (b) Then it cancels monitor_work;
>         (c) Then it schedules abort_work which ends(aborts) all inflight rqs.
>         (d) At the same time del_gendisk() is called.
>         (e) Finally, we complete all ioucmds.
>
> Note: we do not change the existing behavior with reocvery disabled. Note
> that STOP_DEV ctrl-cmd can be processed without reagrd to monitor_work.
>
> With recovery feature enabled and after a process crash:
> (1) monitor_work notices the crash and all ubq_daemon are dying.
>     We do not consider a "single" ubq_daemon(pthread) crash. Please send
>         STOP_DEV ctrl-cmd which calling ublk_stop_dev() for this case.

Can you consider why you don't consider it as one crash? IMO, most of
userspace block logic is run in ubq_daemon, so it is reasonable to
consider it.

ublk_reinit_dev() is supposed to be run in standalone context, just like
ublk_stop_dev(), we need monitor_work to provide forward progress,
so don't run wait in monitor work.

And please don't change this model for making forward progress.


> (2) The monitor_work quiesces request queue.
> (3) The monotor_work checks if there is any inflight rq with
>     UBLK_IO_FLAG_ACTIVE unset. If so, we give up and schedule monitor_work
>         later to retry. This is because we have to wait these rqs requeued(IDLE)
>         and we are safe to complete their ioucmds later. Otherwise we may cause
>         UAF on ioucmd in fallback wq.
> (4) If check in (3) passes, we should requeue/abort inflight rqs issued
>     to the crash ubq_daemon before. If UBLK_F_USER_RECOVERY_REISSUE is set,
>         rq is requeued. Otherwise it is aborted.
> (5) All ioucmds are completed by calling io_uring_cmd_done().
> (6) monitor_work set ub's state to UBLK_S_DEV_RECOVERING. It does not
>     scheduled itself anymore. Now we are ready for START_USER_RECOVERY.
>
> Note: If (3) fails, monitor_work schedules itself and retires (3). We allow
> user to manually start STOP_DEV procedure without reagrd to monitor_work.
> STOP_DEV can cancel monitor_work, unquiesce request queue and drain all
> requeued rqs. More importantly, STOP_DEV can safely complete all ioucmds
> since monitor_work has been canceled at that moment.
>
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 222 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 202 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 296b9d80f003..0e185d1fa2c4 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -156,7 +156,7 @@ struct ublk_device {
>
>         struct completion       completion;
>         unsigned int            nr_queues_ready;
> -       atomic_t                nr_aborted_queues;
> +       bool    force_abort;
>
>         /*
>          * Our ubq->daemon may be killed without any notification, so
> @@ -164,6 +164,7 @@ struct ublk_device {
>          */
>         struct delayed_work     monitor_work;
>         struct work_struct      stop_work;
> +       struct work_struct      abort_work;
>  };
>
>  /* header of ublk_params */
> @@ -643,9 +644,13 @@ static void ublk_complete_rq(struct request *req)
>   */
>  static void __ublk_fail_req(struct ublk_io *io, struct request *req)
>  {
> +       struct ublk_queue *ubq = req->mq_hctx->driver_data;
> +
>         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
>
>         if (!(io->flags & UBLK_IO_FLAG_ABORTED)) {
> +               pr_devel("%s: abort rq: qid %d tag %d io_flags %x\n",
> +                               __func__, ubq->q_id, req->tag, io->flags);
>                 io->flags |= UBLK_IO_FLAG_ABORTED;
>                 blk_mq_end_request(req, BLK_STS_IOERR);
>         }
> @@ -664,6 +669,8 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
>
>         /* tell ublksrv one io request is coming */
>         io_uring_cmd_done(io->cmd, res, 0);
> +       pr_devel("%s: complete ioucmd: res %d io_flags %x\n",
> +                       __func__, res, io->flags);
>  }
>
>  #define UBLK_REQUEUE_DELAY_MS  3
> @@ -675,11 +682,6 @@ static inline void __ublk_rq_task_work(struct request *req)
>         int tag = req->tag;
>         struct ublk_io *io = &ubq->ios[tag];
>         unsigned int mapped_bytes;
> -
> -       pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
> -                       __func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
> -                       ublk_get_iod(ubq, req->tag)->addr);
> -
>         /*
>          * Task is exiting if either:
>          *
> @@ -700,10 +702,13 @@ static inline void __ublk_rq_task_work(struct request *req)
>                 } else {
>                         blk_mq_end_request(req, BLK_STS_IOERR);
>                 }
> -               mod_delayed_work(system_wq, &ub->monitor_work, 0);
>                 return;
>         }
>
> +       pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
> +                       __func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
> +                       ublk_get_iod(ubq, req->tag)->addr);
> +
>         if (ublk_need_get_data(ubq) &&
>                         (req_op(req) == REQ_OP_WRITE ||
>                         req_op(req) == REQ_OP_FLUSH)) {
> @@ -782,6 +787,11 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>         struct ublk_io *io = &ubq->ios[rq->tag];
>         blk_status_t res;
>
> +       if (unlikely(ubq->dev->force_abort)) {
> +               pr_devel("%s: abort q_id %d tag %d io_flags %x.\n",
> +                               __func__, ubq->q_id, rq->tag, io->flags);
> +               return BLK_STS_IOERR;
> +       }

Checking one flag lockless is usually not safe, also not sure why we
need such flag here, and the original check is supposed to work.

>         /* fill iod to slot in io cmd buffer */
>         res = ublk_setup_iod(ubq, rq);
>         if (unlikely(res != BLK_STS_OK))
> @@ -789,13 +799,15 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>
>         blk_mq_start_request(bd->rq);
>
> +       pr_devel("%s: start rq: q_id %d tag %d io_flags %x.\n",
> +                       __func__, ubq->q_id, rq->tag, io->flags);
> +
>         if (unlikely(ubq_daemon_is_dying(ubq))) {
>   fail:
>                 pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
>                                 (ublk_can_use_recovery(ubq->dev)) ? "requeue" : "abort",
>                                 ubq->q_id, rq->tag, io->flags);
>
> -               mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
>                 if (ublk_can_use_recovery(ubq->dev)) {
>                         /* We cannot process this rq so just requeue it. */
>                         blk_mq_requeue_request(rq, false);
> @@ -880,6 +892,7 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
>         if (test_and_set_bit(UB_STATE_OPEN, &ub->state))
>                 return -EBUSY;
>         filp->private_data = ub;
> +       pr_devel("%s: open /dev/ublkc%d\n", __func__, ub->dev_info.dev_id);
>         return 0;
>  }
>
> @@ -888,6 +901,7 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
>         struct ublk_device *ub = filp->private_data;
>
>         clear_bit(UB_STATE_OPEN, &ub->state);
> +       pr_devel("%s: release /dev/ublkc%d\n", __func__, ub->dev_info.dev_id);
>         return 0;
>  }
>
> @@ -971,37 +985,180 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>                          * will do it
>                          */
>                         rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
> -                       if (rq)
> +                       if (rq && blk_mq_request_started(rq))
>                                 __ublk_fail_req(io, rq);
>                 }
>         }
>         ublk_put_device(ub);
>  }
>
> -static void ublk_daemon_monitor_work(struct work_struct *work)
> +
> +
> +static void ublk_abort_work_fn(struct work_struct *work)
>  {
>         struct ublk_device *ub =
> -               container_of(work, struct ublk_device, monitor_work.work);
> +               container_of(work, struct ublk_device, abort_work);
> +
> +       int i;
> +
> +       for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +               struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +               if (ubq_daemon_is_dying(ubq))
> +                       ublk_abort_queue(ub, ubq);
> +       }
> +
> +       if (ub->force_abort)
> +               schedule_work(&ub->abort_work);
> +}
> +
> +static void ublk_reinit_queue(struct ublk_device *ub,
> +               struct ublk_queue *ubq)

ublk_reinit_queue() is bad name, it is called during aborting, what
we need is to shutdown them completely. And reinit or reset will
be done when you start to recovery, at that time, you can reinit
or reset the queue really.

> +{
> +       int i;
> +
> +       for (i = 0; i < ubq->q_depth; i++) {
> +               struct ublk_io *io = &ubq->ios[i];
> +
> +               if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
> +                       struct request *rq = blk_mq_tag_to_rq(
> +                                       ub->tag_set.tags[ubq->q_id], i);
> +
> +                       WARN_ON_ONCE(!rq);
> +                       pr_devel("%s: %s rq: qid %d tag %d io_flags %x\n",
> +                                       __func__,
> +                                       ublk_can_use_recovery_reissue(ub) ? "requeue" : "abort",
> +                                       ubq->q_id, i, io->flags);
> +                       if (ublk_can_use_recovery_reissue(ub))
> +                               blk_mq_requeue_request(rq, false);
> +                       else
> +                               __ublk_fail_req(io, rq);
> +
> +               } else {
> +                       io_uring_cmd_done(io->cmd,
> +                                       UBLK_IO_RES_ABORT, 0);
> +                       io->flags &= ~UBLK_IO_FLAG_ACTIVE;
> +                       pr_devel("%s: send UBLK_IO_RES_ABORT: qid %d tag %d io_flags %x\n",
> +                               __func__, ubq->q_id, i, io->flags);
> +               }
> +               ubq->nr_io_ready--;
> +       }
> +       WARN_ON_ONCE(ubq->nr_io_ready);
> +}
> +
> +static bool ublk_check_inflight_rq(struct request *rq, void *data)
> +{
> +       struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> +       struct ublk_io *io = &ubq->ios[rq->tag];
> +       bool *busy = data;
> +
> +       if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> +               *busy = true;
> +               return false;
> +       }
> +       return true;
> +}
> +
> +static void ublk_reinit_dev(struct ublk_device *ub)

bad name too.

> +{
> +       int i;
> +       bool busy = false;
> +
> +       if (!ublk_get_device(ub))
> +               return;
> +
> +       /* If we have quiesced q, all ubq_daemons are dying */
> +       if (blk_queue_quiesced(ub->ub_disk->queue))
> +               goto check_inflight;
> +
> +       /* Recovery feature is for 'process' crash. */
> +       for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +               struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +               if (!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)))
> +                       goto out;
> +       }
> +
> +       pr_devel("%s: all ubq_daemons(nr: %d) are dying.\n",
> +                       __func__, ub->dev_info.nr_hw_queues);
> +
> +       /* Now all ubq_daemons are PF_EXITING, let's quiesce q. */
> +       blk_mq_quiesce_queue(ub->ub_disk->queue);
> +       pr_devel("%s: queue quiesced.\n", __func__);
> + check_inflight:
> +       /* All rqs have to be requeued(and stay in queue now) */
> +       blk_mq_tagset_busy_iter(&ub->tag_set, ublk_check_inflight_rq, &busy);
> +       if (busy) {
> +               pr_devel("%s: still some inflight rqs, retry later...\n",
> +                               __func__);
> +               goto out;
> +       }
> +
> +       pr_devel("%s: all inflight rqs are requeued.\n", __func__);
> +
> +       for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +               struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +               ublk_reinit_queue(ub, ubq);
> +       }
> +       /* So monitor_work won't be scheduled anymore */
> +       ub->dev_info.state = UBLK_S_DEV_RECOVERING;
> +       pr_devel("%s: convert state to UBLK_S_DEV_RECOVERING\n",
> +                       __func__);
> + out:
> +       ublk_put_device(ub);
> +}
> +
> +static void ublk_kill_dev(struct ublk_device *ub)
> +{
>         int i;
>
>         for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
>                 struct ublk_queue *ubq = ublk_get_queue(ub, i);
>
>                 if (ubq_daemon_is_dying(ubq)) {
> +                       pr_devel("%s: ubq(%d) is dying, schedule stop_work now\n",
> +                                       __func__, i);
>                         schedule_work(&ub->stop_work);
> -
> -                       /* abort queue is for making forward progress */
> -                       ublk_abort_queue(ub, ubq);
>                 }
>         }
> +}
> +
> +static void ublk_daemon_monitor_work(struct work_struct *work)
> +{
> +       struct ublk_device *ub =
> +               container_of(work, struct ublk_device, monitor_work.work);
> +
> +       pr_devel("%s: mode(%s) running...\n",
> +                       __func__,
> +                       ublk_can_use_recovery(ub) ? "recovery" : "kill");
> +       /*
> +        * We can't schedule monitor work if:
> +        * (1) The state is DEAD.
> +        *     The gendisk is not alive, so either all rqs are ended
> +        *     or request queue is not created.
> +        *
> +        * (2) The state is RECOVERYING.
> +        *     The process crashed, all rqs were requeued and request queue
> +        *     was quiesced.
> +        */
> +       WARN_ON_ONCE(ub->dev_info.state != UBLK_S_DEV_LIVE);
>
> +       if (ublk_can_use_recovery(ub))
> +               ublk_reinit_dev(ub);

ublk_reinit_dev() is supposed to be run in standalone context, just like
ublk_stop_dev(), we need monitor_work to provide forward progress,
so don't run wait in monitor work.

And please don't change this model of making forward progress.

> +       else
> +               ublk_kill_dev(ub);
>         /*
> -        * We can't schedule monitor work after ublk_remove() is started.
> +        * No need ub->mutex, monitor work are canceled after ub is marked
> +        * as force_abort which is observed reliably.
> +        *
> +        * Note:
> +        * All incoming rqs are aborted in ublk_queue_rq ASAP. Then
> +        * we will hang on del_gendisk() and wait for all inflight rqs'
> +        * completion.
>          *
> -        * No need ub->mutex, monitor work are canceled after state is marked
> -        * as DEAD, so DEAD state is observed reliably.
>          */
> -       if (ub->dev_info.state != UBLK_S_DEV_DEAD)
> +       if (ub->dev_info.state == UBLK_S_DEV_LIVE && !ub->force_abort)
>                 schedule_delayed_work(&ub->monitor_work,
>                                 UBLK_DAEMON_MONITOR_PERIOD);
>  }
> @@ -1058,10 +1215,35 @@ static void ublk_cancel_dev(struct ublk_device *ub)
>  static void ublk_stop_dev(struct ublk_device *ub)
>  {
>         mutex_lock(&ub->mutex);
> -       if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> +       if (ub->dev_info.state == UBLK_S_DEV_DEAD)
>                 goto unlock;
>
> +       /*
> +        * All incoming rqs are aborted in ublk_queue_rq ASAP. Then
> +        * we will hang on del_gendisk() and wait for all inflight rqs'
> +        * completion.
> +        */
> +       ub->force_abort = true;
> +       /* wait until monitor_work is not scheduled */
> +       cancel_delayed_work_sync(&ub->monitor_work);
> +       pr_devel("%s: monitor work is canceled.\n", __func__);
> +       /* unquiesce q and let all inflight rqs' be aborted */
> +       if (blk_queue_quiesced(ub->ub_disk->queue)) {
> +               blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +               pr_devel("%s: queue unquiesced.\n", __func__);
> +       }
> +       /* requeued requests will be aborted ASAP because of 'force_abort' */
> +       blk_mq_kick_requeue_list(ub->ub_disk->queue);
> +       /* forward progress */
> +       schedule_work(&ub->abort_work);
> +       pr_devel("%s: abort work is scheduled, start delete gendisk...\n",
> +                       __func__);
> +       pr_devel("%s: gendisk is deleted.\n", __func__);
>         del_gendisk(ub->ub_disk);
> +       pr_devel("%s: gendisk is deleted.\n", __func__);
> +       ub->force_abort = false;
> +       cancel_work_sync(&ub->abort_work);
> +       pr_devel("%s: abort work is canceled.\n", __func__);
>         ub->dev_info.state = UBLK_S_DEV_DEAD;
>         ub->dev_info.ublksrv_pid = -1;
>         put_disk(ub->ub_disk);

ublk_stop_dev() isn't supposed to be changed so much, and it can be just
for handling non-recovery, but it can be renamed as ublk_delete_disk().

For recovery, you can add one function of ublk_quiesce_disk() for
preparing for recovering.

thanks
Ming

