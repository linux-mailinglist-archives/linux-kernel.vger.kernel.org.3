Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AAF4EB28F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbiC2RTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiC2RS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:18:59 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D632B82E0;
        Tue, 29 Mar 2022 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1648574227; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7roBy7uoBfdb5m6R7PcumBhuO07YUhoYYbpN+FJczY=;
        b=00O46YohI6oR3v+zIR5mYpSwRNZ/OOUFnQM6+Syf0C2OnRUwnJ8CNWfeg318ShsHzJaKeu
        VPCKpzt6eXPelKmSWDoX6jYZCuKBm5f6UXKM2gtIdKUoSEofYbrfcbvpCnMPbVGKYlr08m
        jhTBD6n7TaZ32H3B7+eqI7xqBZszsa8=
Date:   Tue, 29 Mar 2022 18:16:56 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 00/12] iio: buffer-dma: write() and new DMABUF based
 API
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>
Message-Id: <80OI9R.QH1992Y5TBBX1@crapouillou.net>
In-Reply-To: <YkMTZLea4+X39Fp8@phenom.ffwll.local>
References: <20220207125933.81634-1-paul@crapouillou.net>
        <20220213184616.669b490b@jic23-huawei>
        <N8XC7R.5FP2M8552CGT3@crapouillou.net> <YkLEXJzs8ukrxG8s@phenom.ffwll.local>
        <QI1I9R.GDPWLM86I45S@crapouillou.net> <YkMTZLea4+X39Fp8@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-13; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Le mar., mars 29 2022 at 16:10:44 +0200, Daniel Vetter=20
<daniel@ffwll.ch> a =E9crit :
> On Tue, Mar 29, 2022 at 10:11:14AM +0100, Paul Cercueil wrote:
>>  Hi Daniel,
>>=20
>>  Le mar., mars 29 2022 at 10:33:32 +0200, Daniel Vetter=20
>> <daniel@ffwll.ch> a
>>  =E9crit :
>>  > On Tue, Feb 15, 2022 at 05:43:35PM +0000, Paul Cercueil wrote:
>>  > >  Hi Jonathan,
>>  > >
>>  > >  Le dim., f=E9vr. 13 2022 at 18:46:16 +0000, Jonathan Cameron
>>  > >  <jic23@kernel.org> a =E9crit :
>>  > >  > On Mon,  7 Feb 2022 12:59:21 +0000
>>  > >  > Paul Cercueil <paul@crapouillou.net> wrote:
>>  > >  >
>>  > >  > >  Hi Jonathan,
>>  > >  > >
>>  > >  > >  This is the V2 of my patchset that introduces a new=20
>> userspace
>>  > >  > > interface
>>  > >  > >  based on DMABUF objects to complement the fileio API, and=20
>> adds
>>  > >  > > write()
>>  > >  > >  support to the existing fileio API.
>>  > >  >
>>  > >  > Hi Paul,
>>  > >  >
>>  > >  > It's been a little while. Perhaps you could summarize the=20
>> various
>>  > > view
>>  > >  > points around the appropriateness of using DMABUF for this?
>>  > >  > I appreciate it is a tricky topic to distil into a brief=20
>> summary
>>  > > but
>>  > >  > I know I would find it useful even if no one else does!
>>  > >
>>  > >  So we want to have a high-speed interface where buffers of=20
>> samples
>>  > > are
>>  > >  passed around between IIO devices and other devices (e.g. USB=20
>> or
>>  > > network),
>>  > >  or made available to userspace without copying the data.
>>  > >
>>  > >  DMABUF is, at least in theory, exactly what we need. Quoting=20
>> the
>>  > >  documentation
>>  > > =20
>> (https://www.kernel.org/doc/html/v5.15/driver-api/dma-buf.html):
>>  > >  "The dma-buf subsystem provides the framework for sharing=20
>> buffers
>>  > > for
>>  > >  hardware (DMA) access across multiple device drivers and
>>  > > subsystems, and for
>>  > >  synchronizing asynchronous hardware access. This is used, for
>>  > > example, by
>>  > >  drm =B4prime=A1 multi-GPU support, but is of course not=20
>> limited to GPU
>>  > > use
>>  > >  cases."
>>  > >
>>  > >  The problem is that right now DMABUF is only really used by=20
>> DRM,
>>  > > and to
>>  > >  quote Daniel, "dma-buf looks like something super generic and
>>  > > useful, until
>>  > >  you realize that there's a metric ton of gpu/accelerator bagage
>>  > > piled in".
>>  > >
>>  > >  Still, it seems to be the only viable option. We could add a=20
>> custom
>>  > >  buffer-passing interface, but that would mean implementing the=20
>> same
>>  > >  buffer-passing interface on the network and USB stacks, and=20
>> before
>>  > > we know
>>  > >  it we re-invented DMABUFs.
>>  >
>>  > dma-buf also doesn't support sharing with network and usb stacks,=20
>> so I'm
>>  > a
>>  > bit confused why exactly this is useful?
>>=20
>>  There is an attempt to get dma-buf support in the network stack,=20
>> called
>>  "zctap". Last patchset was sent last november. USB stack does not=20
>> support
>>  dma-buf, but we can add it later I guess.
>>=20
>>  > So yeah unless there's some sharing going on with gpu stuff (for=20
>> data
>>  > processing maybe) I'm not sure this makes a lot of sense really.=20
>> Or at
>>  > least some zero-copy sharing between drivers, but even that would
>>  > minimally require a dma-buf import ioctl of some sorts. Which I=20
>> either
>>  > missed or doesn't exist.
>>=20
>>  We do want zero-copy between drivers, the network stack, and the=20
>> USB stack.
>>  It's not just about having a userspace interface.
>=20
> I think in that case we need these other pieces too. And we need acks=20
> from
> relevant subsystems that these other pieces are a) ready for upstream
> merging and also that the dma-buf side of things actually makes sense.

Ok...

>>  > If there's none of that then just hand-roll your buffer handling=20
>> code
>>  > (xarray is cheap to use in terms of code for this), you can=20
>> always add
>>  > dma-buf import/export later on when the need arises.
>>  >
>>  > Scrolling through patches you only have dma-buf export, but no
>>  > importing,
>>  > so the use-case that works is with one of the existing subsystems=20
>> that
>>  > supporting dma-buf importing.
>>  >
>>  > I think minimally we need the use-case (in form of code) that=20
>> needs the
>>  > buffer sharing here.
>>=20
>>  I'll try with zctap and report back.
>=20
> Do you have a link for this? I just checked dri-devel on lore, and=20
> it's
> not there. Nor anywhere else.

The code is here: https://github.com/jlemon/zctap_kernel

I know Jonathan Lemon (Cc'd) was working on upstreaming it, I saw a few=20
patchsets.

Cheers,
-Paul

> We really need all the pieces, and if block layer reaction is=20
> anything to
> judge by, dma-buf wont happen for networking either. There's some=20
> really
> nasty and fairly fundamental issues with locking and memory reclaim=20
> that
> make this utter pain or outright impossible.
> -Daniel
>=20
>>=20
>>  Cheers,
>>  -Paul
>>=20
>>  > >  > >
>>  > >  > >  Changes since v1:
>>  > >  > >
>>  > >  > >  - the patches that were merged in v1 have been (obviously)
>>  > > dropped
>>  > >  > > from
>>  > >  > >    this patchset;
>>  > >  > >  - the patch that was setting the write-combine cache=20
>> setting
>>  > > has
>>  > >  > > been
>>  > >  > >    dropped as well, as it was simply not useful.
>>  > >  > >  - [01/12]:
>>  > >  > >      * Only remove the outgoing queue, and keep the=20
>> incoming
>>  > > queue,
>>  > >  > > as we
>>  > >  > >        want the buffer to start streaming data as soon as=20
>> it is
>>  > >  > > enabled.
>>  > >  > >      * Remove IIO_BLOCK_STATE_DEQUEUED, since it is now
>>  > > functionally
>>  > >  > > the
>>  > >  > >        same as IIO_BLOCK_STATE_DONE.
>>  > >  > >  - [02/12]:
>>  > >  > >      * Fix block->state not being reset in
>>  > >  > >        iio_dma_buffer_request_update() for output buffers.
>>  > >  > >      * Only update block->bytes_used once and add a comment
>>  > > about
>>  > >  > > why we
>>  > >  > >        update it.
>>  > >  > >      * Add a comment about why we're setting a different=20
>> state
>>  > > for
>>  > >  > > output
>>  > >  > >        buffers in iio_dma_buffer_request_update()
>>  > >  > >      * Remove useless cast to bool (!!) in=20
>> iio_dma_buffer_io()
>>  > >  > >  - [05/12]:
>>  > >  > >      Only allow the new IOCTLs on the buffer FD created=20
>> with
>>  > >  > >      IIO_BUFFER_GET_FD_IOCTL().
>>  > >  > >  - [12/12]:
>>  > >  > >      * Explicitly state that the new interface is optional=20
>> and
>>  > > is
>>  > >  > >        not implemented by all drivers.
>>  > >  > >      * The IOCTLs can now only be called on the buffer FD
>>  > > returned by
>>  > >  > >        IIO_BUFFER_GET_FD_IOCTL.
>>  > >  > >      * Move the page up a bit in the index since it is core
>>  > > stuff
>>  > >  > > and not
>>  > >  > >        driver-specific.
>>  > >  > >
>>  > >  > >  The patches not listed here have not been modified since=20
>> v1.
>>  > >  > >
>>  > >  > >  Cheers,
>>  > >  > >  -Paul
>>  > >  > >
>>  > >  > >  Alexandru Ardelean (1):
>>  > >  > >    iio: buffer-dma: split iio_dma_buffer_fileio_free()=20
>> function
>>  > >  > >
>>  > >  > >  Paul Cercueil (11):
>>  > >  > >    iio: buffer-dma: Get rid of outgoing queue
>>  > >  > >    iio: buffer-dma: Enable buffer write support
>>  > >  > >    iio: buffer-dmaengine: Support specifying buffer=20
>> direction
>>  > >  > >    iio: buffer-dmaengine: Enable write support
>>  > >  > >    iio: core: Add new DMABUF interface infrastructure
>>  > >  > >    iio: buffer-dma: Use DMABUFs instead of custom solution
>>  > >  > >    iio: buffer-dma: Implement new DMABUF based userspace=20
>> API
>>  > >  > >    iio: buffer-dmaengine: Support new DMABUF based=20
>> userspace API
>>  > >  > >    iio: core: Add support for cyclic buffers
>>  > >  > >    iio: buffer-dmaengine: Add support for cyclic buffers
>>  > >  > >    Documentation: iio: Document high-speed DMABUF based API
>>  > >  > >
>>  > >  > >   Documentation/driver-api/dma-buf.rst          |   2 +
>>  > >  > >   Documentation/iio/dmabuf_api.rst              |  94 +++
>>  > >  > >   Documentation/iio/index.rst                   |   2 +
>>  > >  > >   drivers/iio/adc/adi-axi-adc.c                 |   3 +-
>>  > >  > >   drivers/iio/buffer/industrialio-buffer-dma.c  | 610
>>  > >  > > ++++++++++++++----
>>  > >  > >   .../buffer/industrialio-buffer-dmaengine.c    |  42 +-
>>  > >  > >   drivers/iio/industrialio-buffer.c             |  60 ++
>>  > >  > >   include/linux/iio/buffer-dma.h                |  38 +-
>>  > >  > >   include/linux/iio/buffer-dmaengine.h          |   5 +-
>>  > >  > >   include/linux/iio/buffer_impl.h               |   8 +
>>  > >  > >   include/uapi/linux/iio/buffer.h               |  30 +
>>  > >  > >   11 files changed, 749 insertions(+), 145 deletions(-)
>>  > >  > >   create mode 100644 Documentation/iio/dmabuf_api.rst
>>  > >  > >
>>  > >  >
>>  > >
>>  > >
>>  >
>>  > --
>>  > Daniel Vetter
>>  > Software Engineer, Intel Corporation
>>  > http://blog.ffwll.ch
>>=20
>>=20
>=20
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch


