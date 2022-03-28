Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EEB4E9D13
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244408AbiC1RLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiC1RLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E460120F6E;
        Mon, 28 Mar 2022 10:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 711CC60B60;
        Mon, 28 Mar 2022 17:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1C5C340F0;
        Mon, 28 Mar 2022 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648487371;
        bh=oCtqENZsA9xmE/aUzsGysdGfo0sSAd6M0OVrV65PQGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANn73/tBHo8HgNrDb6u3OBvKw7gq7pWuGEU9i01xwmeL4zP5+1ltHwtSCziAp1mfS
         EN0i7leC6j376PY0Dj76wpv08ALRaQr1GQhze9jKBFq+LfacN5RsjYubH0uAPAHyeD
         USIb6C11EvBflFNVF6upatiy23HmXQ0CpTZpm78W579pFZaVllfXebXFhRYIkuPAe4
         hmpUYhAW/EYQvfb5M4SGmjMwJSux4Lt/YaLf694mHN0ACOpsK311AF6Do73aP+euXA
         cx9lopYGKlQxcZBOBAccl8SM1Quau5vtDs2kGejsD5DWDlCW5WolVjbcmiSMk+cCnf
         rmVBg3DhGjh1g==
Date:   Mon, 28 Mar 2022 18:17:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 01/12] iio: buffer-dma: Get rid of outgoing queue
Message-ID: <20220328181706.4148e08b@jic23-huawei>
In-Reply-To: <20220207125933.81634-2-paul@crapouillou.net>
References: <20220207125933.81634-1-paul@crapouillou.net>
        <20220207125933.81634-2-paul@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Feb 2022 12:59:22 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> The buffer-dma code was using two queues, incoming and outgoing, to
> manage the state of the blocks in use.
> 
> While this totally works, it adds some complexity to the code,
> especially since the code only manages 2 blocks. It is much easier to
> just check each block's state manually, and keep a counter for the next
> block to dequeue.
> 
> Since the new DMABUF based API wouldn't use the outgoing queue anyway,
> getting rid of it now makes the upcoming changes simpler.
> 
> With this change, the IIO_BLOCK_STATE_DEQUEUED is now useless, and can
> be removed.
> 
> v2: - Only remove the outgoing queue, and keep the incoming queue, as we
>       want the buffer to start streaming data as soon as it is enabled.
>     - Remove IIO_BLOCK_STATE_DEQUEUED, since it is now functionally the
>       same as IIO_BLOCK_STATE_DONE.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Hi Paul,

In the interests of moving things forward / simplifying what people need
to look at: This change looks good to me on it's own.

Lars had some comments on v1.  Lars, could you take look at this and
verify if this versions addresses the points you raised (I think it does
but they were your comments so better you judge)

Thanks,

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c | 44 ++++++++++----------
>  include/linux/iio/buffer-dma.h               |  7 ++--
>  2 files changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index d348af8b9705..1fc91467d1aa 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -179,7 +179,7 @@ static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
>  	}
>  
>  	block->size = size;
> -	block->state = IIO_BLOCK_STATE_DEQUEUED;
> +	block->state = IIO_BLOCK_STATE_DONE;
>  	block->queue = queue;
>  	INIT_LIST_HEAD(&block->head);
>  	kref_init(&block->kref);
> @@ -191,16 +191,8 @@ static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
>  
>  static void _iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
>  {
> -	struct iio_dma_buffer_queue *queue = block->queue;
> -
> -	/*
> -	 * The buffer has already been freed by the application, just drop the
> -	 * reference.
> -	 */
> -	if (block->state != IIO_BLOCK_STATE_DEAD) {
> +	if (block->state != IIO_BLOCK_STATE_DEAD)
>  		block->state = IIO_BLOCK_STATE_DONE;
> -		list_add_tail(&block->head, &queue->outgoing);
> -	}
>  }
>  
>  /**
> @@ -261,7 +253,6 @@ static bool iio_dma_block_reusable(struct iio_dma_buffer_block *block)
>  	 * not support abort and has not given back the block yet.
>  	 */
>  	switch (block->state) {
> -	case IIO_BLOCK_STATE_DEQUEUED:
>  	case IIO_BLOCK_STATE_QUEUED:
>  	case IIO_BLOCK_STATE_DONE:
>  		return true;
> @@ -317,7 +308,6 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>  	 * dead. This means we can reset the lists without having to fear
>  	 * corrution.
>  	 */
> -	INIT_LIST_HEAD(&queue->outgoing);
>  	spin_unlock_irq(&queue->list_lock);
>  
>  	INIT_LIST_HEAD(&queue->incoming);
> @@ -456,14 +446,20 @@ static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
>  	struct iio_dma_buffer_queue *queue)
>  {
>  	struct iio_dma_buffer_block *block;
> +	unsigned int idx;
>  
>  	spin_lock_irq(&queue->list_lock);
> -	block = list_first_entry_or_null(&queue->outgoing, struct
> -		iio_dma_buffer_block, head);
> -	if (block != NULL) {
> -		list_del(&block->head);
> -		block->state = IIO_BLOCK_STATE_DEQUEUED;
> +
> +	idx = queue->fileio.next_dequeue;
> +	block = queue->fileio.blocks[idx];
> +
> +	if (block->state == IIO_BLOCK_STATE_DONE) {
> +		idx = (idx + 1) % ARRAY_SIZE(queue->fileio.blocks);
> +		queue->fileio.next_dequeue = idx;
> +	} else {
> +		block = NULL;
>  	}
> +
>  	spin_unlock_irq(&queue->list_lock);
>  
>  	return block;
> @@ -539,6 +535,7 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
>  	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buf);
>  	struct iio_dma_buffer_block *block;
>  	size_t data_available = 0;
> +	unsigned int i;
>  
>  	/*
>  	 * For counting the available bytes we'll use the size of the block not
> @@ -552,8 +549,15 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
>  		data_available += queue->fileio.active_block->size;
>  
>  	spin_lock_irq(&queue->list_lock);
> -	list_for_each_entry(block, &queue->outgoing, head)
> -		data_available += block->size;
> +
> +	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +		block = queue->fileio.blocks[i];
> +
> +		if (block != queue->fileio.active_block
> +		    && block->state == IIO_BLOCK_STATE_DONE)
> +			data_available += block->size;
> +	}
> +
>  	spin_unlock_irq(&queue->list_lock);
>  	mutex_unlock(&queue->lock);
>  
> @@ -617,7 +621,6 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
>  	queue->ops = ops;
>  
>  	INIT_LIST_HEAD(&queue->incoming);
> -	INIT_LIST_HEAD(&queue->outgoing);
>  
>  	mutex_init(&queue->lock);
>  	spin_lock_init(&queue->list_lock);
> @@ -645,7 +648,6 @@ void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
>  			continue;
>  		queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
>  	}
> -	INIT_LIST_HEAD(&queue->outgoing);
>  	spin_unlock_irq(&queue->list_lock);
>  
>  	INIT_LIST_HEAD(&queue->incoming);
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index 6564bdcdac66..18d3702fa95d 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -19,14 +19,12 @@ struct device;
>  
>  /**
>   * enum iio_block_state - State of a struct iio_dma_buffer_block
> - * @IIO_BLOCK_STATE_DEQUEUED: Block is not queued
>   * @IIO_BLOCK_STATE_QUEUED: Block is on the incoming queue
>   * @IIO_BLOCK_STATE_ACTIVE: Block is currently being processed by the DMA
>   * @IIO_BLOCK_STATE_DONE: Block is on the outgoing queue
>   * @IIO_BLOCK_STATE_DEAD: Block has been marked as to be freed
>   */
>  enum iio_block_state {
> -	IIO_BLOCK_STATE_DEQUEUED,
>  	IIO_BLOCK_STATE_QUEUED,
>  	IIO_BLOCK_STATE_ACTIVE,
>  	IIO_BLOCK_STATE_DONE,
> @@ -73,12 +71,15 @@ struct iio_dma_buffer_block {
>   * @active_block: Block being used in read()
>   * @pos: Read offset in the active block
>   * @block_size: Size of each block
> + * @next_dequeue: index of next block that will be dequeued
>   */
>  struct iio_dma_buffer_queue_fileio {
>  	struct iio_dma_buffer_block *blocks[2];
>  	struct iio_dma_buffer_block *active_block;
>  	size_t pos;
>  	size_t block_size;
> +
> +	unsigned int next_dequeue;
>  };
>  
>  /**
> @@ -93,7 +94,6 @@ struct iio_dma_buffer_queue_fileio {
>   *   list and typically also a list of active blocks in the part that handles
>   *   the DMA controller
>   * @incoming: List of buffers on the incoming queue
> - * @outgoing: List of buffers on the outgoing queue
>   * @active: Whether the buffer is currently active
>   * @fileio: FileIO state
>   */
> @@ -105,7 +105,6 @@ struct iio_dma_buffer_queue {
>  	struct mutex lock;
>  	spinlock_t list_lock;
>  	struct list_head incoming;
> -	struct list_head outgoing;
>  
>  	bool active;
>  

