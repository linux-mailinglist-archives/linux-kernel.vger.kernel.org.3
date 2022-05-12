Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2691D5242B7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbiELC1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiELC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7309D3CFD0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652322465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnBUsGH2NSc8mBV35xTwbMtmVCtbQHLIFU4mWOhbey8=;
        b=aqRyTCX7m5X625+1JusOoBqiy9+MBhUijfj9aGANVi33fmIAp00161mtFmKc3HPN6lJ4Bx
        LH1KJI15rdQH57eOERJy3+6X5Wf3e3EXquYjQhpA5d8bo/tUMDamIiPMLtJooJBg0VsKH1
        /ULX7jr9zlMYUOTskQWZ5j7HDLPTyZo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-bATEad7gNz6aRuRGa_iCBg-1; Wed, 11 May 2022 22:27:43 -0400
X-MC-Unique: bATEad7gNz6aRuRGa_iCBg-1
Received: by mail-lf1-f69.google.com with SMTP id bp17-20020a056512159100b00472631eb445so1562395lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnBUsGH2NSc8mBV35xTwbMtmVCtbQHLIFU4mWOhbey8=;
        b=2NMDyeSbprESIZpUKzO0cFnsYZfPZCN9zstPXXfrkWcziu1BxMpGChQBA1tOKqGTZN
         Rdz1ItJmW78TatzS/0V8r8oXieEBzOuNIZd0EeLCDrF8R+QEq2WVMYNf9hp3BI8HR3cv
         nTcUa62Z1Y0xkVDim/5qG3O7/MTAxDUWiNeMNnDeeRPkWb6b2KuRjP2DLcsBkdUu66wO
         iyl3o8/Y8i94XmMDNLHUhGbTFIbEomUt6hqsBnu5oRUBdbTdn8wqVCGQBIc/Pen6DHPW
         QH08d493VT7zOOuezqA6YSXgPIc3rfTLX613ZO20YZ9WQ4ZJ1YzfOZtN/Dssq45FrGu4
         6PXQ==
X-Gm-Message-State: AOAM531/38ZWxbfo83MrSvIevg7fLAo+UFSuGhGwB5XIsx9NcrBm547y
        /y22MpOnHnhM5izhrqZGyf/WIk16Ru3RDHwu+Dkb1fqcbKXf04oYf1DO7mQ4KQyedRp1hD+xn31
        DZn8CBI184Nr+IE+MaEwNdLbzyfdOAUdmPDOp7fkW
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id m17-20020a0565120a9100b00473bb9efc80mr22620078lfu.471.1652322462252;
        Wed, 11 May 2022 19:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx78nboFh642BuCza3MKFLezsqkwyeXvR/9J0hjpBPV1b0Vp7WAm2hs7bcJeSQdqbc3ew1R9svIM8EtpWgkNV4=
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id
 m17-20020a0565120a9100b00473bb9efc80mr22620062lfu.471.1652322461990; Wed, 11
 May 2022 19:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220510112734.205669-1-elic@nvidia.com> <20220510112734.205669-4-elic@nvidia.com>
 <eda33c78-fd39-a5bb-9e9e-06b2c37d3fe5@oracle.com>
In-Reply-To: <eda33c78-fd39-a5bb-9e9e-06b2c37d3fe5@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 12 May 2022 10:27:31 +0800
Message-ID: <CACGkMEuvN2SSdcn5fY7TZr_-Aj8UFMshrrmFn4dcJPTH94cLSw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] vdpa/mlx5: Add support for reading descriptor statistics
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Eli Cohen <elic@nvidia.com>, mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 1:26 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 5/10/2022 4:27 AM, Eli Cohen wrote:
> > Implement the get_vq_stats calback of vdpa_config_ops to return the
> > statistics for a virtqueue.
> >
> > The statistics are provided as vendor specific statistics where the
> > driver provides a pair of attribute name and attribute value.
> >
> > In addition to the attribute name/attribute value pair, the driver
> > returns the negotiated features and max virtqueue pairs for userspace
> > can decide for a given queue index whether it is a data or control
> > virtqueue.
> >
> > Currently supported are received descriptors and completed descriptors.
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > v4 -> v5:
> >   Remove numq_lock mutex. Use reslock instread.
> >
> >
> >   drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 165 +++++++++++++++++++++++++++++
> >   include/linux/mlx5/mlx5_ifc.h      |   1 +
> >   include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++++
> >   4 files changed, 207 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > index daaf7b503677..44104093163b 100644
> > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > @@ -61,6 +61,8 @@ struct mlx5_control_vq {
> >       struct vringh_kiov riov;
> >       struct vringh_kiov wiov;
> >       unsigned short head;
> > +     unsigned int received_desc;
> > +     unsigned int completed_desc;
> >   };
> >
> >   struct mlx5_vdpa_wq_ent {
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 79001301b383..99b0621e7a87 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -119,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
> >       struct mlx5_vdpa_umem umem2;
> >       struct mlx5_vdpa_umem umem3;
> >
> > +     u32 counter_set_id;
> >       bool initialized;
> >       int index;
> >       u32 virtq_id;
> > @@ -164,6 +165,7 @@ struct mlx5_vdpa_net {
> >       struct notifier_block nb;
> >       struct vdpa_callback config_cb;
> >       struct mlx5_vdpa_wq_ent cvq_ent;
> > +     /* sync access to virtqueues statistics */
> Dangling code change?
>
> >   };
> >
> >   static void free_resources(struct mlx5_vdpa_net *ndev);
> > @@ -822,6 +824,12 @@ static u16 get_features_12_3(u64 features)
> >              (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
> >   }
> >
> > +static bool counters_supported(const struct mlx5_vdpa_dev *mvdev)
> > +{
> > +     return MLX5_CAP_GEN_64(mvdev->mdev, general_obj_types) &
> > +            BIT_ULL(MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> > +}
> > +
> >   static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> >   {
> >       int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
> > @@ -876,6 +884,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> >       MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> >       MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
> >       MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> > +     if (counters_supported(&ndev->mvdev))
> > +             MLX5_SET(virtio_q, vq_ctx, counter_set_id, mvq->counter_set_id);
> >
> >       err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
> >       if (err)
> > @@ -1139,6 +1149,47 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> >       return err;
> >   }
> >
> > +static int counter_set_alloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> > +{
> > +     u32 in[MLX5_ST_SZ_DW(create_virtio_q_counters_in)] = {};
> > +     u32 out[MLX5_ST_SZ_DW(create_virtio_q_counters_out)] = {};
> > +     void *cmd_hdr;
> > +     int err;
> > +
> > +     if (!counters_supported(&ndev->mvdev))
> > +             return 0;
> > +
> > +     cmd_hdr = MLX5_ADDR_OF(create_virtio_q_counters_in, in, hdr);
> > +
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
> > +
> > +     err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
> > +     if (err)
> > +             return err;
> > +
> > +     mvq->counter_set_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> > +
> > +     return 0;
> > +}
> > +
> > +static void counter_set_dealloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> > +{
> > +     u32 in[MLX5_ST_SZ_DW(destroy_virtio_q_counters_in)] = {};
> > +     u32 out[MLX5_ST_SZ_DW(destroy_virtio_q_counters_out)] = {};
> > +
> > +     if (!counters_supported(&ndev->mvdev))
> > +             return;
> > +
> > +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.opcode, MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
> > +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_id, mvq->counter_set_id);
> > +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.uid, ndev->mvdev.res.uid);
> > +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> > +     if (mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out)))
> > +             mlx5_vdpa_warn(&ndev->mvdev, "dealloc counter set 0x%x\n", mvq->counter_set_id);
> > +}
> > +
> >   static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> >   {
> >       u16 idx = mvq->index;
> > @@ -1166,6 +1217,10 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> >       if (err)
> >               goto err_connect;
> >
> > +     err = counter_set_alloc(ndev, mvq);
> > +     if (err)
> > +             goto err_counter;
> > +
> >       err = create_virtqueue(ndev, mvq);
> >       if (err)
> >               goto err_connect;
> > @@ -1183,6 +1238,8 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> >       return 0;
> >
> >   err_connect:
> > +     counter_set_dealloc(ndev, mvq);
> > +err_counter:
> >       qp_destroy(ndev, &mvq->vqqp);
> >   err_vqqp:
> >       qp_destroy(ndev, &mvq->fwqp);
> > @@ -1227,6 +1284,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
> >
> >       suspend_vq(ndev, mvq);
> >       destroy_virtqueue(ndev, mvq);
> > +     counter_set_dealloc(ndev, mvq);
> >       qp_destroy(ndev, &mvq->vqqp);
> >       qp_destroy(ndev, &mvq->fwqp);
> >       cq_destroy(ndev, mvq->index);
> > @@ -1681,6 +1739,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >               if (read != sizeof(ctrl))
> >                       break;
> >
> > +             cvq->received_desc++;
> >               switch (ctrl.class) {
> >               case VIRTIO_NET_CTRL_MAC:
> >                       status = handle_ctrl_mac(mvdev, ctrl.cmd);
> > @@ -1704,6 +1763,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >               if (vringh_need_notify_iotlb(&cvq->vring))
> >                       vringh_notify(&cvq->vring);
> >
> > +             cvq->completed_desc++;
> >               queue_work(mvdev->wq, &wqent->work);
> >               break;
> >       }
> > @@ -2323,6 +2383,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> >       mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >       ndev->mvdev.status = 0;
> >       ndev->cur_num_vqs = 0;
> > +     ndev->mvdev.cvq.received_desc = 0;
> > +     ndev->mvdev.cvq.completed_desc = 0;
> >       memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
> >       ndev->mvdev.actual_features = 0;
> >       ++mvdev->generation;
> > @@ -2442,6 +2504,108 @@ static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
> >       return mvdev->actual_features;
> >   }
> >
> > +static int counter_set_query(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq,
> > +                          u64 *received_desc, u64 *completed_desc)
> > +{
> > +     u32 in[MLX5_ST_SZ_DW(query_virtio_q_counters_in)] = {};
> > +     u32 out[MLX5_ST_SZ_DW(query_virtio_q_counters_out)] = {};
> > +     void *cmd_hdr;
> > +     void *ctx;
> > +     int err;
> > +
> > +     if (!counters_supported(&ndev->mvdev))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
> > +             return -EAGAIN;
> > +
> > +     cmd_hdr = MLX5_ADDR_OF(query_virtio_q_counters_in, in, hdr);
> > +
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_QUERY_GENERAL_OBJECT);
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_id, mvq->counter_set_id);
> > +
> > +     err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
> > +     if (err)
> > +             return err;
> > +
> > +     ctx = MLX5_ADDR_OF(query_virtio_q_counters_out, out, counters);
> > +     *received_desc = MLX5_GET64(virtio_q_counters, ctx, received_desc);
> > +     *completed_desc = MLX5_GET64(virtio_q_counters, ctx, completed_desc);
> > +     return 0;
> > +}
> > +
> > +static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> > +                                      struct sk_buff *msg,
> > +                                      struct netlink_ext_ack *extack)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > +     struct mlx5_vdpa_virtqueue *mvq;
> > +     struct mlx5_control_vq *cvq;
> > +     u64 received_desc;
> > +     u64 completed_desc;
> > +     int err = 0;
> > +     u16 max_vqp;
> > +
> > +     mutex_lock(&ndev->reslock);
> I wonder if we can change this lock to r/w semaphore too, otherwise it
> almost defeats the merit of converting vdpa_dev_mutex to the same. This
> change would benefit multiple parallel readers.
> > +     if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> > +             NL_SET_ERR_MSG_MOD(extack, "feature negotiation not complete");
> > +             err = -EAGAIN;
> > +             goto out_err;
> > +     }
> > +
> > +     if (!is_index_valid(mvdev, idx)) {
> > +             NL_SET_ERR_MSG_MOD(extack, "virtqueue index is not valid");
> > +             err = -EINVAL;
> > +             goto out_err;
> > +     }
> > +
> > +     if (idx == ctrl_vq_idx(mvdev)) {
> > +             cvq = &mvdev->cvq;
> > +             received_desc = cvq->received_desc;
> > +             completed_desc = cvq->completed_desc;
> > +             goto out;
> > +     }
> > +
> > +     mvq = &ndev->vqs[idx];
> > +     err = counter_set_query(ndev, mvq, &received_desc, &completed_desc);
> > +     if (err) {
> > +             NL_SET_ERR_MSG_MOD(extack, "failed to query hardware");
> > +             goto out_err;
> > +     }
> > +
> > +out:
> > +     err = -EMSGSIZE;
> > +     if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
> > +                           mvdev->actual_features, VDPA_ATTR_PAD))
> > +             goto out_err;
> > +
> > +     max_vqp = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> > +     if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
> > +             goto out_err;
> Your userspace reference patch doesn't actually use this attribute, but
> instead calls the VDPA_CMD_DEV_CONFIG_GET in prior to get this
> information, which will break consistency. Is it your plan to change the
> userspace code to accommodate what's already piggybacked here and
> display stat query in just one atomic call? Hope all the available attrs
> here would satisfy the userspace need.

Right, I mentioned this in V4. If we depend on the vendor driver to
report the negotiated features, we will end up driver specific code in
the userspace which is sub-optimal.

I think we need to do this in the vdpa core so userspace knows for
sure it can get this.

THanks

>
> Thanks,
> -Siwei
>
> > +
> > +     if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "received_desc"))
> > +             goto out_err;
> > +
> > +     if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, received_desc,
> > +                           VDPA_ATTR_PAD))
> > +             goto out_err;
> > +
> > +     if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "completed_desc"))
> > +             goto out_err;
> > +
> > +     if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, completed_desc,
> > +                           VDPA_ATTR_PAD))
> > +             goto out_err;
> > +
> > +     err = 0;
> > +out_err:
> > +     mutex_unlock(&ndev->reslock);
> > +     return err;
> > +}
> > +
> >   static const struct vdpa_config_ops mlx5_vdpa_ops = {
> >       .set_vq_address = mlx5_vdpa_set_vq_address,
> >       .set_vq_num = mlx5_vdpa_set_vq_num,
> > @@ -2451,6 +2615,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> >       .get_vq_ready = mlx5_vdpa_get_vq_ready,
> >       .set_vq_state = mlx5_vdpa_set_vq_state,
> >       .get_vq_state = mlx5_vdpa_get_vq_state,
> > +     .get_vendor_vq_stats = mlx5_vdpa_get_vendor_vq_stats,
> >       .get_vq_notification = mlx5_get_vq_notification,
> >       .get_vq_irq = mlx5_get_vq_irq,
> >       .get_vq_align = mlx5_vdpa_get_vq_align,
> > diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> > index 49a48d7709ac..1d193d9b6029 100644
> > --- a/include/linux/mlx5/mlx5_ifc.h
> > +++ b/include/linux/mlx5/mlx5_ifc.h
> > @@ -94,6 +94,7 @@ enum {
> >   enum {
> >       MLX5_OBJ_TYPE_GENEVE_TLV_OPT = 0x000b,
> >       MLX5_OBJ_TYPE_VIRTIO_NET_Q = 0x000d,
> > +     MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS = 0x001c,
> >       MLX5_OBJ_TYPE_MATCH_DEFINER = 0x0018,
> >       MLX5_OBJ_TYPE_MKEY = 0xff01,
> >       MLX5_OBJ_TYPE_QP = 0xff02,
> > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > index 1a9c9d94cb59..4414ed5b6ed2 100644
> > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > @@ -165,4 +165,43 @@ struct mlx5_ifc_modify_virtio_net_q_out_bits {
> >       struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
> >   };
> >
> > +struct mlx5_ifc_virtio_q_counters_bits {
> > +     u8    modify_field_select[0x40];
> > +     u8    reserved_at_40[0x40];
> > +     u8    received_desc[0x40];
> > +     u8    completed_desc[0x40];
> > +     u8    error_cqes[0x20];
> > +     u8    bad_desc_errors[0x20];
> > +     u8    exceed_max_chain[0x20];
> > +     u8    invalid_buffer[0x20];
> > +     u8    reserved_at_180[0x280];
> > +};
> > +
> > +struct mlx5_ifc_create_virtio_q_counters_in_bits {
> > +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> > +     struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
> > +};
> > +
> > +struct mlx5_ifc_create_virtio_q_counters_out_bits {
> > +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> > +     struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
> > +};
> > +
> > +struct mlx5_ifc_destroy_virtio_q_counters_in_bits {
> > +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> > +};
> > +
> > +struct mlx5_ifc_destroy_virtio_q_counters_out_bits {
> > +     struct mlx5_ifc_general_obj_out_cmd_hdr_bits hdr;
> > +};
> > +
> > +struct mlx5_ifc_query_virtio_q_counters_in_bits {
> > +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> > +};
> > +
> > +struct mlx5_ifc_query_virtio_q_counters_out_bits {
> > +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> > +     struct mlx5_ifc_virtio_q_counters_bits counters;
> > +};
> > +
> >   #endif /* __MLX5_IFC_VDPA_H_ */
>

