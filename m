Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33D4B1F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347635AbiBKHNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:13:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347641AbiBKHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:13:32 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B206265A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:13:29 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V47kTem_1644563606;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V47kTem_1644563606)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Feb 2022 15:13:27 +0800
Message-ID: <1644563228.441517-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 09/14] virtio: queue_reset: struct virtio_config_ops add callbacks for queue_reset
Date:   Fri, 11 Feb 2022 15:07:08 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <20220209122901.51790-10-xuanzhuo@linux.alibaba.com>
 <140fc738-3391-5529-dd5a-c46b9e937355@redhat.com>
In-Reply-To: <140fc738-3391-5529-dd5a-c46b9e937355@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 14:49:03 +0800, Jason Wang <jasowang@redhat.com> wrote:
>
> =E5=9C=A8 2022/2/9 =E4=B8=8B=E5=8D=888:28, Xuan Zhuo =E5=86=99=E9=81=93:
> > Performing reset on a queue is divided into four steps:
> >
> > 1. reset_vq: reset one vq
> > 2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> > 3. release the ring of the vq by vring_release_virtqueue()
> > 4. enable_reset_vq: re-enable the reset queue
> >
> > So add two callbacks reset_vq, enable_reset_vq to struct
> > virtio_config_ops.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   include/linux/virtio_config.h | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_confi=
g.h
> > index 4d107ad31149..0d01a64f2576 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -74,6 +74,17 @@ struct virtio_shm_region {
> >    * @set_vq_affinity: set the affinity for a virtqueue (optional).
> >    * @get_vq_affinity: get the affinity for a virtqueue (optional).
> >    * @get_shm_region: get a shared memory region based on the index.
> > + * @reset_vq: reset a queue individually
>
>
> This needs to be marked as optional I think.

OK.

>
>
> > + *	vq: the virtqueue
> > + *	Returns 0 on success or error status
>
>
> It looks to me the caller should also guarantee that the vring is not
> accsed by any functions e.g NAPI.

OK.

>
>
> > + *	After successfully calling this, be sure to call
> > + *	virtqueue_detach_unused_buf() to recycle the buffer in the ring, and
> > + *	then call vring_release_virtqueue() to release the vq ring.
> > + * @enable_reset_vq: enable a reset queue
> > + *	vq: the virtqueue
> > + *	ring_num: specify ring num for the vq to be re-enabled. 0 means use=
 the
> > + *	          default value. MUST be a power of 2.
>
>
> Note that we don't have power of 2 requirement for packed virtqueue.


So the following check here does not seem reasonable. (virtio_pci_modern.c)

static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
				  struct virtio_pci_vq_info *info,
				  unsigned index,
				  void (*callback)(struct virtqueue *vq),
				  const char *name,
				  bool ctx,
				  u16 msix_vec)
{

	struct virtio_pci_modern_device *mdev =3D &vp_dev->mdev;
	struct virtqueue *vq;
	u16 num;
	int err;

	if (index >=3D vp_modern_get_num_queues(mdev))
		return ERR_PTR(-ENOENT);

	/* Check if queue is either not available or already active. */
	num =3D vp_modern_get_queue_size(mdev, index);
	if (!num || vp_modern_get_queue_enable(mdev, index))
		return ERR_PTR(-ENOENT);

	if (num & (num - 1)) {
		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
		return ERR_PTR(-EINVAL);
	}
	^^^^^^^^^^^^^^^^^^^^^^^

>
> And I wonder if it's cleaner to have a find_vq() ops instead to dealing
> with the re-allocation and possible size change, or have a dedicated
> helper to set vring size so driver can do.
>
> reset_vq()
>
> virtqueue_set_vring_size()
>
> enable_reset_vq()

I like to add a dedicated helper.

>
>
> > + *	Returns 0 on success or error status
> >    */
> >   typedef void vq_callback_t(struct virtqueue *);
> >   struct virtio_config_ops {
> > @@ -100,6 +111,8 @@ struct virtio_config_ops {
> >   			int index);
> >   	bool (*get_shm_region)(struct virtio_device *vdev,
> >   			       struct virtio_shm_region *region, u8 id);
> > +	int (*reset_vq)(struct virtqueue *vq);
> > +	int (*enable_reset_vq)(struct virtqueue *vq, u16 ring_num);
>
>
> Note that the current implement is best-effort, so it's not guarantee
> that we can have a vring with ring_num, we may get less under memory
> pressure or even fail. We probably need to have a pamater to mandate the
> ring_num otherwise user may surprise to see a decreased size of the ring
> when a increasing is actually requested.

1. We can add a helper to specify max ring num.
2. Or after specifying ring num, in case of failure, return directly.

I prefer #1

Thanks.

>
> Thanks
>
>
> >   };
> >
> >   /* If driver didn't advertise the feature, it will never appear. */
>
