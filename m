Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB394EAE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbiC2Nio convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Mar 2022 09:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiC2Nim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:38:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB94D610;
        Tue, 29 Mar 2022 06:36:58 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KSVtJ61gGz67kMk;
        Tue, 29 Mar 2022 21:35:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 29 Mar 2022 15:36:56 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 14:36:55 +0100
Date:   Tue, 29 Mar 2022 14:36:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Alexandru Ardelean" <ardeleanalex@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 05/12] iio: core: Add new DMABUF interface
 infrastructure
Message-ID: <20220329143653.000057d4@Huawei.com>
In-Reply-To: <VDXG9R.5IH6K0N3FLTA3@crapouillou.net>
References: <20220207125933.81634-1-paul@crapouillou.net>
        <20220207125933.81634-6-paul@crapouillou.net>
        <20220328183701.02884cc3@jic23-huawei>
        <VDXG9R.5IH6K0N3FLTA3@crapouillou.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 19:44:19 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> Le lun., mars 28 2022 at 18:37:01 +0100, Jonathan Cameron 
> <jic23@kernel.org> a écrit :
> > On Mon,  7 Feb 2022 12:59:26 +0000
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >   
> >>  Add the necessary infrastructure to the IIO core to support a new
> >>  optional DMABUF based interface.
> >> 
> >>  The advantage of this new DMABUF based interface vs. the read()
> >>  interface, is that it avoids an extra copy of the data between the
> >>  kernel and userspace. This is particularly userful for high-speed  
> > 
> > useful
> >   
> >>  devices which produce several megabytes or even gigabytes of data 
> >> per
> >>  second.
> >> 
> >>  The data in this new DMABUF interface is managed at the granularity 
> >> of
> >>  DMABUF objects. Reducing the granularity from byte level to block 
> >> level
> >>  is done to reduce the userspace-kernelspace synchronization overhead
> >>  since performing syscalls for each byte at a few Mbps is just not
> >>  feasible.
> >> 
> >>  This of course leads to a slightly increased latency. For this 
> >> reason an
> >>  application can choose the size of the DMABUFs as well as how many 
> >> it
> >>  allocates. E.g. two DMABUFs would be a traditional double buffering
> >>  scheme. But using a higher number might be necessary to avoid
> >>  underflow/overflow situations in the presence of scheduling 
> >> latencies.
> >> 
> >>  As part of the interface, 2 new IOCTLs have been added:
> >> 
> >>  IIO_BUFFER_DMABUF_ALLOC_IOCTL(struct iio_dmabuf_alloc_req *):
> >>   Each call will allocate a new DMABUF object. The return value (if 
> >> not
> >>   a negative errno value as error) will be the file descriptor of 
> >> the new
> >>   DMABUF.
> >> 
> >>  IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *):
> >>   Place the DMABUF object into the queue pending for hardware 
> >> process.
> >> 
> >>  These two IOCTLs have to be performed on the IIO buffer's file
> >>  descriptor, obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.  
> > 
> > Just to check, do they work on the old deprecated chardev route? 
> > Normally
> > we can directly access the first buffer without the ioctl.  
> 
> They do not. I think it's fine this way, since as you said, the old 
> chardev route is deprecated. But I can add support for it with enough 
> peer pressure.
Agreed. Definitely fine to not support the 'old way'.

J
> 
> >> 
> >>  To access the data stored in a block by userspace the block must be
> >>  mapped to the process's memory. This is done by calling mmap() on 
> >> the
> >>  DMABUF's file descriptor.
> >> 
> >>  Before accessing the data through the map, you must use the
> >>  DMA_BUF_IOCTL_SYNC(struct dma_buf_sync *) ioctl, with the
> >>  DMA_BUF_SYNC_START flag, to make sure that the data is available.
> >>  This call may block until the hardware is done with this block. Once
> >>  you are done reading or writing the data, you must use this ioctl 
> >> again
> >>  with the DMA_BUF_SYNC_END flag, before enqueueing the DMABUF to the
> >>  kernel's queue.
> >> 
> >>  If you need to know when the hardware is done with a DMABUF, you can
> >>  poll its file descriptor for the EPOLLOUT event.
> >> 
> >>  Finally, to destroy a DMABUF object, simply call close() on its file
> >>  descriptor.
> >> 
> >>  A typical workflow for the new interface is:
> >> 
> >>    for block in blocks:
> >>      DMABUF_ALLOC block
> >>      mmap block
> >> 
> >>    enable buffer
> >> 
> >>    while !done
> >>      for block in blocks:
> >>        DMABUF_ENQUEUE block
> >> 
> >>        DMABUF_SYNC_START block
> >>        process data
> >>        DMABUF_SYNC_END block
> >> 
> >>    disable buffer
> >> 
> >>    for block in blocks:
> >>      close block  
> > 
> > Given my very limited knowledge of dma-buf, I'll leave commenting
> > on the flow to others who know if this looks 'standards' or not ;)
> > 
> > Code looks sane to me..  
> 
> Thanks.
> 
> Cheers,
> -Paul
> 
> >> 
> >>  v2: Only allow the new IOCTLs on the buffer FD created with
> >>      IIO_BUFFER_GET_FD_IOCTL().
> >> 
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>   drivers/iio/industrialio-buffer.c | 55 
> >> +++++++++++++++++++++++++++++++
> >>   include/linux/iio/buffer_impl.h   |  8 +++++
> >>   include/uapi/linux/iio/buffer.h   | 29 ++++++++++++++++
> >>   3 files changed, 92 insertions(+)
> >> 
> >>  diff --git a/drivers/iio/industrialio-buffer.c 
> >> b/drivers/iio/industrialio-buffer.c
> >>  index 94eb9f6cf128..72f333a519bc 100644
> >>  --- a/drivers/iio/industrialio-buffer.c
> >>  +++ b/drivers/iio/industrialio-buffer.c
> >>  @@ -17,6 +17,7 @@
> >>   #include <linux/fs.h>
> >>   #include <linux/cdev.h>
> >>   #include <linux/slab.h>
> >>  +#include <linux/mm.h>
> >>   #include <linux/poll.h>
> >>   #include <linux/sched/signal.h>
> >> 
> >>  @@ -1520,11 +1521,65 @@ static int iio_buffer_chrdev_release(struct 
> >> inode *inode, struct file *filep)
> >>   	return 0;
> >>   }
> >> 
> >>  +static int iio_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
> >>  +				     struct iio_dmabuf __user *user_buf)
> >>  +{
> >>  +	struct iio_dmabuf dmabuf;
> >>  +
> >>  +	if (!buffer->access->enqueue_dmabuf)
> >>  +		return -EPERM;
> >>  +
> >>  +	if (copy_from_user(&dmabuf, user_buf, sizeof(dmabuf)))
> >>  +		return -EFAULT;
> >>  +
> >>  +	if (dmabuf.flags & ~IIO_BUFFER_DMABUF_SUPPORTED_FLAGS)
> >>  +		return -EINVAL;
> >>  +
> >>  +	return buffer->access->enqueue_dmabuf(buffer, &dmabuf);
> >>  +}
> >>  +
> >>  +static int iio_buffer_alloc_dmabuf(struct iio_buffer *buffer,
> >>  +				   struct iio_dmabuf_alloc_req __user *user_req)
> >>  +{
> >>  +	struct iio_dmabuf_alloc_req req;
> >>  +
> >>  +	if (!buffer->access->alloc_dmabuf)
> >>  +		return -EPERM;
> >>  +
> >>  +	if (copy_from_user(&req, user_req, sizeof(req)))
> >>  +		return -EFAULT;
> >>  +
> >>  +	if (req.resv)
> >>  +		return -EINVAL;
> >>  +
> >>  +	return buffer->access->alloc_dmabuf(buffer, &req);
> >>  +}
> >>  +
> >>  +static long iio_buffer_chrdev_ioctl(struct file *filp,
> >>  +				    unsigned int cmd, unsigned long arg)
> >>  +{
> >>  +	struct iio_dev_buffer_pair *ib = filp->private_data;
> >>  +	struct iio_buffer *buffer = ib->buffer;
> >>  +	void __user *_arg = (void __user *)arg;
> >>  +
> >>  +	switch (cmd) {
> >>  +	case IIO_BUFFER_DMABUF_ALLOC_IOCTL:
> >>  +		return iio_buffer_alloc_dmabuf(buffer, _arg);
> >>  +	case IIO_BUFFER_DMABUF_ENQUEUE_IOCTL:
> >>  +		/* TODO: support non-blocking enqueue operation */
> >>  +		return iio_buffer_enqueue_dmabuf(buffer, _arg);
> >>  +	default:
> >>  +		return IIO_IOCTL_UNHANDLED;
> >>  +	}
> >>  +}
> >>  +
> >>   static const struct file_operations iio_buffer_chrdev_fileops = {
> >>   	.owner = THIS_MODULE,
> >>   	.llseek = noop_llseek,
> >>   	.read = iio_buffer_read,
> >>   	.write = iio_buffer_write,
> >>  +	.unlocked_ioctl = iio_buffer_chrdev_ioctl,
> >>  +	.compat_ioctl = compat_ptr_ioctl,
> >>   	.poll = iio_buffer_poll,
> >>   	.release = iio_buffer_chrdev_release,
> >>   };
> >>  diff --git a/include/linux/iio/buffer_impl.h 
> >> b/include/linux/iio/buffer_impl.h
> >>  index e2ca8ea23e19..728541bc2c63 100644
> >>  --- a/include/linux/iio/buffer_impl.h
> >>  +++ b/include/linux/iio/buffer_impl.h
> >>  @@ -39,6 +39,9 @@ struct iio_buffer;
> >>    *                      device stops sampling. Calles are balanced 
> >> with @enable.
> >>    * @release:		called when the last reference to the buffer is 
> >> dropped,
> >>    *			should free all resources allocated by the buffer.
> >>  + * @alloc_dmabuf:	called from userspace via ioctl to allocate one 
> >> DMABUF.
> >>  + * @enqueue_dmabuf:	called from userspace via ioctl to queue this 
> >> DMABUF
> >>  + *			object to this buffer. Requires a valid DMABUF fd.
> >>    * @modes:		Supported operating modes by this buffer type
> >>    * @flags:		A bitmask combination of INDIO_BUFFER_FLAG_*
> >>    *
> >>  @@ -68,6 +71,11 @@ struct iio_buffer_access_funcs {
> >> 
> >>   	void (*release)(struct iio_buffer *buffer);
> >> 
> >>  +	int (*alloc_dmabuf)(struct iio_buffer *buffer,
> >>  +			    struct iio_dmabuf_alloc_req *req);
> >>  +	int (*enqueue_dmabuf)(struct iio_buffer *buffer,
> >>  +			      struct iio_dmabuf *block);
> >>  +
> >>   	unsigned int modes;
> >>   	unsigned int flags;
> >>   };
> >>  diff --git a/include/uapi/linux/iio/buffer.h 
> >> b/include/uapi/linux/iio/buffer.h
> >>  index 13939032b3f6..e4621b926262 100644
> >>  --- a/include/uapi/linux/iio/buffer.h
> >>  +++ b/include/uapi/linux/iio/buffer.h
> >>  @@ -5,6 +5,35 @@
> >>   #ifndef _UAPI_IIO_BUFFER_H_
> >>   #define _UAPI_IIO_BUFFER_H_
> >> 
> >>  +#include <linux/types.h>
> >>  +
> >>  +#define IIO_BUFFER_DMABUF_SUPPORTED_FLAGS	0x00000000
> >>  +
> >>  +/**
> >>  + * struct iio_dmabuf_alloc_req - Descriptor for allocating IIO 
> >> DMABUFs
> >>  + * @size:	the size of a single DMABUF
> >>  + * @resv:	reserved
> >>  + */
> >>  +struct iio_dmabuf_alloc_req {
> >>  +	__u64 size;
> >>  +	__u64 resv;
> >>  +};
> >>  +
> >>  +/**
> >>  + * struct iio_dmabuf - Descriptor for a single IIO DMABUF object
> >>  + * @fd:		file descriptor of the DMABUF object
> >>  + * @flags:	one or more IIO_BUFFER_DMABUF_* flags
> >>  + * @bytes_used:	number of bytes used in this DMABUF for the data 
> >> transfer.
> >>  + *		If zero, the full buffer is used.
> >>  + */
> >>  +struct iio_dmabuf {
> >>  +	__u32 fd;
> >>  +	__u32 flags;
> >>  +	__u64 bytes_used;
> >>  +};
> >>  +
> >>   #define IIO_BUFFER_GET_FD_IOCTL			_IOWR('i', 0x91, int)
> >>  +#define IIO_BUFFER_DMABUF_ALLOC_IOCTL		_IOW('i', 0x92, struct 
> >> iio_dmabuf_alloc_req)
> >>  +#define IIO_BUFFER_DMABUF_ENQUEUE_IOCTL		_IOW('i', 0x93, struct 
> >> iio_dmabuf)
> >> 
> >>   #endif /* _UAPI_IIO_BUFFER_H_ */  
> >   
> 
> 

