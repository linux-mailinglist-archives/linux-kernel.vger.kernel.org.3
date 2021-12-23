Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A284D47E1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbhLWKr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:47:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49522 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347769AbhLWKr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:47:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0948FB81F72;
        Thu, 23 Dec 2021 10:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B91C36AE9;
        Thu, 23 Dec 2021 10:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640256474;
        bh=k2GYSCIim6frgUrJ93DRrTdLbD6S7l660eTmklvEXZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAkKdp/JW4PZ94NHXpXS7c+Bb08pWpVSVvFKQdlh8bKMzgVNKn7n65R7Q7VcEfFty
         qhgW1fWqYvKoOtEhu/TIrHxfuh+PwEqEmxEGagubgLlxTmhUL4dAxTjMObEOf16PMQ
         17UgtA7iNmWDHIj1KyLH1+5f6841LIIoa09Df17o=
Date:   Thu, 23 Dec 2021 11:47:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Enrico Granata <egranata@android.com>
Cc:     Enrico Granata <egranata@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio_blk: Add support for lifetime feature
Message-ID: <YcRT030F31kKyx/T@kroah.com>
References: <20211207175518.1703314-1-egranata@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207175518.1703314-1-egranata@android.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[note, your original post had the to: line messed up, which caused any
response to this to not work well in many email clients, this is a
resend...]

On Tue, Dec 07, 2021 at 10:55:17AM -0700, Enrico Granata wrote:
> From: Enrico Granata <egranata@google.com>
> 
> The VirtIO TC has adopted a new feature in virtio-blk enabling
> discovery of lifetime information.
> 
> This commit adds support for the VIRTIO_BLK_T_LIFETIME command
> to the virtio_blk driver, and adds new attributes to the
> sysfs entry for virtio_blk:
> * pre_eol_info
> * life_time_a
> * life_time_b
> 
> which are defined in the VirtIO specification.
> 
> Signed-off-by: Enrico Granata <egranata@google.com>
> ---
> Changes in v3:
>  - Split life_time attribute in two
>  - Made VirtIO specification independent of eMMC
>  - Adopted newer APIs to mirror surrounding code
> 
>  drivers/block/virtio_blk.c      | 106 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h |  11 ++++
>  2 files changed, 113 insertions(+), 4 deletions(-)

You seem to be missing new Documentation/ABI/ entries for these new
sysfs files you are adding.  That is required.

> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6ae38776e30e..c50f5d9a173b 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -213,7 +213,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  				      struct virtblk_req *vbr)
>  {
>  	bool unmap = false;
> -	u32 type;
> +	u32 type = 0;

VIRTIO_BLK_T_GET_ID?

And why isn't this an enum?

>  
>  	vbr->out_hdr.sector = 0;
>  
> @@ -239,14 +239,14 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  		unmap = !(req->cmd_flags & REQ_NOUNMAP);
>  		break;
>  	case REQ_OP_DRV_IN:
> -		type = VIRTIO_BLK_T_GET_ID;
> -		break;
> +		break; /* type already set for custom requests */
>  	default:
>  		WARN_ON_ONCE(1);
>  		return BLK_STS_IOERR;
>  	}
>  
> -	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
> +	if (req_op(req) != REQ_OP_DRV_IN)
> +		vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
>  	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
>  
>  	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES) {
> @@ -374,11 +374,14 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>  	struct virtio_blk *vblk = disk->private_data;
>  	struct request_queue *q = vblk->disk->queue;
>  	struct request *req;
> +	struct virtblk_req *vbr;
>  	int err;
>  
>  	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
> +	vbr = blk_mq_rq_to_pdu(req);
> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
>  
>  	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
>  	if (err)
> @@ -391,6 +394,35 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>  	return err;
>  }
>  
> +static int virtblk_get_lifetime(struct gendisk *disk, struct virtio_blk_lifetime *lifetime)
> +{
> +	struct virtio_blk *vblk = disk->private_data;
> +	struct request_queue *q = vblk->disk->queue;
> +	struct request *req;
> +	struct virtblk_req *vbr;
> +	int err;
> +
> +	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
> +		return -EOPNOTSUPP;
> +
> +	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +	vbr = blk_mq_rq_to_pdu(req);
> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_LIFETIME);
> +
> +	err = blk_rq_map_kern(q, req, lifetime, sizeof(*lifetime), GFP_KERNEL);
> +	if (err)
> +		goto out;
> +
> +	blk_execute_rq(vblk->disk, req, false);
> +	err = blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
> +out:
> +	blk_mq_free_request(req);
> +	return err;
> +}
> +
> +
>  static void virtblk_get(struct virtio_blk *vblk)
>  {
>  	refcount_inc(&vblk->refs);
> @@ -499,6 +531,68 @@ static ssize_t serial_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(serial);
>  
> +static ssize_t pre_eol_info_show(struct device *dev,
> +								 struct device_attribute *attr,
> +								 char *buf)

Please fix your editor to properly set the tab spacing for kernel
changes (hint 8).

> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct virtio_blk_lifetime lft;
> +	int err;
> +
> +	/* sysfs gives us a PAGE_SIZE buffer */
> +	BUILD_BUG_ON(sizeof(lft) >= PAGE_SIZE);

That's crazy, and wrong here, please remove.  It has nothing to do with
this function operating properly or not.

> +
> +	err = virtblk_get_lifetime(disk, &lft);
> +	if (err)
> +		return 0;

Please return the error.

> +
> +	return sprintf(buf, "0x%02x\n", le16_to_cpu(lft.pre_eol_info));

sysfs_emit() for all new sysfs show functions.

> +}

Why are you mixing sysfs files with a new uapi function in the same
patch?  Shouldn't this be at least 2 patches as part of a series?

thanks,

greg k-h
