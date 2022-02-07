Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B074ABF5E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448770AbiBGNMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386697AbiBGNFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:05:33 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA03C043181;
        Mon,  7 Feb 2022 05:05:33 -0800 (PST)
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 00/12] iio: buffer-dma: write() and new DMABUF based API
Date:   Mon,  7 Feb 2022 12:59:21 +0000
Message-Id: <20220207125933.81634-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

This is the V2 of my patchset that introduces a new userspace interface
based on DMABUF objects to complement the fileio API, and adds write()
support to the existing fileio API.

Changes since v1:

- the patches that were merged in v1 have been (obviously) dropped from
  this patchset;
- the patch that was setting the write-combine cache setting has been
  dropped as well, as it was simply not useful.
- [01/12]: 
    * Only remove the outgoing queue, and keep the incoming queue, as we
      want the buffer to start streaming data as soon as it is enabled.
    * Remove IIO_BLOCK_STATE_DEQUEUED, since it is now functionally the
      same as IIO_BLOCK_STATE_DONE.
- [02/12]:
    * Fix block->state not being reset in
      iio_dma_buffer_request_update() for output buffers.
    * Only update block->bytes_used once and add a comment about why we
      update it.
    * Add a comment about why we're setting a different state for output
      buffers in iio_dma_buffer_request_update()
    * Remove useless cast to bool (!!) in iio_dma_buffer_io()
- [05/12]:
    Only allow the new IOCTLs on the buffer FD created with
    IIO_BUFFER_GET_FD_IOCTL().
- [12/12]:
    * Explicitly state that the new interface is optional and is
      not implemented by all drivers.
    * The IOCTLs can now only be called on the buffer FD returned by
      IIO_BUFFER_GET_FD_IOCTL.
    * Move the page up a bit in the index since it is core stuff and not
      driver-specific.

The patches not listed here have not been modified since v1.

Cheers,
-Paul

Alexandru Ardelean (1):
  iio: buffer-dma: split iio_dma_buffer_fileio_free() function

Paul Cercueil (11):
  iio: buffer-dma: Get rid of outgoing queue
  iio: buffer-dma: Enable buffer write support
  iio: buffer-dmaengine: Support specifying buffer direction
  iio: buffer-dmaengine: Enable write support
  iio: core: Add new DMABUF interface infrastructure
  iio: buffer-dma: Use DMABUFs instead of custom solution
  iio: buffer-dma: Implement new DMABUF based userspace API
  iio: buffer-dmaengine: Support new DMABUF based userspace API
  iio: core: Add support for cyclic buffers
  iio: buffer-dmaengine: Add support for cyclic buffers
  Documentation: iio: Document high-speed DMABUF based API

 Documentation/driver-api/dma-buf.rst          |   2 +
 Documentation/iio/dmabuf_api.rst              |  94 +++
 Documentation/iio/index.rst                   |   2 +
 drivers/iio/adc/adi-axi-adc.c                 |   3 +-
 drivers/iio/buffer/industrialio-buffer-dma.c  | 610 ++++++++++++++----
 .../buffer/industrialio-buffer-dmaengine.c    |  42 +-
 drivers/iio/industrialio-buffer.c             |  60 ++
 include/linux/iio/buffer-dma.h                |  38 +-
 include/linux/iio/buffer-dmaengine.h          |   5 +-
 include/linux/iio/buffer_impl.h               |   8 +
 include/uapi/linux/iio/buffer.h               |  30 +
 11 files changed, 749 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/iio/dmabuf_api.rst

-- 
2.34.1

