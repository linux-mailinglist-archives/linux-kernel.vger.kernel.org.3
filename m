Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05694E590F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344152AbiCWTXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344222AbiCWTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:23:07 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2895888C0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:21:36 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v15so1878653qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Xf7Anw5O4djNCcchl12jKSadlP2dCVWJF57/u1df4zo=;
        b=y0jR5RXN2RH4a0VWcFoadkrgZPaZmoU9Ebl30/0hX0UV2uvAPC+3vioTphZ9i/BSTl
         jsAJppd03jUg9hU7pKw5v+jDmfCqo3Zf7Ya9EePcbyCs6w9myP9dhFTUVUqWHRlCAPwr
         AfrPMYz2NlV48G0IytnO+f6v7EQNP8sBBqHUQTg08yEMDRit5VHTNEWSOgkPgrwy5MhS
         wDWZvfHQJ9UJHii6mgR2KjSxy/PzQRY6pbUmRuFgc1BDcF1+BsG1vQqmKTamR6agbcdA
         KztaMOH3w0XnBGik65euiRLeoynXbNY9ob3LPkx4NiYO9T0OeYkys5cAVRq/2CgPM+Mo
         r5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Xf7Anw5O4djNCcchl12jKSadlP2dCVWJF57/u1df4zo=;
        b=566HWs/lfRErmv2TryhHhcAnO4j7NupGZggWhq3T9Qrtf17vzjdBgGYTA8T8PrR6KY
         C+a9Py7qrZ+qbyvlxGukKQ7byHKBPCmQ8e+3FzAlU5VA7n7YmPpc1Cv8L+YDu8xDhH8F
         wGzKjAn+HVhRFeLErFDSp1ivf86dq/doNmsuVHWlAJUj+hqwPYGCi5CLh+WGXJWaEVKg
         KLouwAhWGKPHnXM451dutUpqlY8DI5xpatODc998RhnUoB4rxlEzc68Rv3aXBsDr8wNb
         0Eq2BDr8n5JtBxKFdgvr/cZ2QNaXZRipqnVIVM/Cg392opLFpWNvXd9pHouf8iTBSgbd
         3mJQ==
X-Gm-Message-State: AOAM530+QN8qYPSS3uZo8yywfv0DF/aW7XlPW6M0cJCPyNzDx5iK0gND
        4BphLaqqBRkDdbKyDdhmn1n9MQ==
X-Google-Smtp-Source: ABdhPJy8q4bQ8WI0JQA+01J/Tm3G58PH/RVXg19krVNaKHs/7EHV4Eov5WeAwG+dueMU705LSxnpGQ==
X-Received: by 2002:ae9:ed97:0:b0:67b:2755:310f with SMTP id c145-20020ae9ed97000000b0067b2755310fmr1008097qkg.117.1648063295747;
        Wed, 23 Mar 2022 12:21:35 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id c20-20020a05622a025400b002e1dd71e797sm654716qtx.15.2022.03.23.12.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:21:35 -0700 (PDT)
Message-ID: <5be83f0b343c04d877a2c2d805fb5f71ca9973b1.camel@ndufresne.ca>
Subject: Re: [PATCH v1] media: videobuf2: Allow applications customize data
 offsets of capture buffers
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Boris Brezillon <bbrezillon@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Laura Nao <laura.nao@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Date:   Wed, 23 Mar 2022 15:21:34 -0400
In-Reply-To: <9ec970d6-ea09-802c-419b-b2ef26800990@collabora.com>
References: <20220322132329.6527-1-dmitry.osipenko@collabora.com>
         <a7c858461b99de2d4afad22d888acc3a74850240.camel@ndufresne.ca>
         <9ec970d6-ea09-802c-419b-b2ef26800990@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 23 mars 2022 à 17:28 +0300, Dmitry Osipenko a écrit :
> Hi Nicolas,
> 
> On 3/23/22 16:05, Nicolas Dufresne wrote:
> > Hi Dmitry,
> > 
> > thanks for giving a second look a this issue.
> > 
> > Le mardi 22 mars 2022 à 16:23 +0300, Dmitry Osipenko a écrit :
> > > Use data offsets provided by applications for multi-planar capture
> > > buffers. This allows V4L to import and use dma-bufs exported by other
> > > subsystems in cases where application wants to customize data offsets
> > > of capture buffers in order to meet hardware alignment requirements of
> > > both dma-buf exporter and importer.
> > > 
> > > This feature is wanted for providing a better support of media hardware
> > > found on Chromebooks. In particular display and camera ISP hardware of
> > > Rockchip and MediaTek SoCs require special handling by userspace because
> > > display h/w has specific alignment requirements that don't match default
> > > alignments expected by V4L and there is a need to customize the data
> > > offsets in case of multi-planar formats.
> > > 
> > > Some drivers already have preliminary support for data offsets
> > > customization of capture buffers, like NVIDIA Tegra video decoder driver
> > > for example, and V4L allows applications to provide data offsets for
> > > multi-planar output buffers, let's support such customization for the
> > > capture buffers as well.
> > > 
> > > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > ---
> > >  Documentation/userspace-api/media/v4l/buffer.rst | 9 ++++++++-
> > >  drivers/media/common/videobuf2/videobuf2-v4l2.c  | 7 +++++++
> > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
> > > index 4638ec64db00..75b1929e2acb 100644
> > > --- a/Documentation/userspace-api/media/v4l/buffer.rst
> > > +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> > > @@ -369,13 +369,20 @@ struct v4l2_plane
> > >        - ``data_offset``
> > >        - Offset in bytes to video data in the plane. Drivers must set this
> > >  	field when ``type`` refers to a capture stream, applications when
> > > -	it refers to an output stream.
> > > +	it refers to an output or capture stream.
> > 
> > There is a clear contradiction in this paragraph. Both the driver and the
> > application MUST set the data_offset.
> 
> I'm not sure where the contradiction is. Application must initialize the
> data_offset and driver must set data_offset too, if it's appropriate to
> do that for a particular driver.
> 
> > Would it be possible to demo your idea by implementing this in a virtual driver
> > ? vivid already have data_offset for capture in some cases, you could verify if
> > your idea works without any conflict in this scenario.
> 
> I actually considered implementing it in the vivid driver, but vivid
> driver already sets the data_offset to fixed values [1], so I decided
> that not to change it.
> 
> But maybe we actually could extend the vivid driver by accepting
> data_offset from userspace for the cases where the fixed offset value is
> zero in the driver.. not sure.

The is the core of the issue, how do you represent both a driver use of
data_offset and a userland provided data_offset at the same time. Contradiction
might be the wrong term, but minimally there is a large gap in the specification
for which I don't have an easy answer.

> 
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/media/test-drivers/vivid/vivid-vid-cap.c#L172
> 
> I verified my idea using the NVIDIA Tegra video decoder driver, which
> already takes data_offsets for capture planes [3] and libvdpau-tegra
> imports DRM dma-bufs into the V4L driver [4][5].
> 
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/media/platform/nvidia/tegra-vde/v4l2.c#n236
> [4]
> https://github.com/grate-driver/libvdpau-tegra/blob/master/src/decoder.c#L685
> [5]
> https://github.com/grate-driver/libvdpau-tegra/blob/master/src/v4l2.c#L359
> 
> The plan is to extend RK ISP driver with support of data_offsets next,
> once we'll agree that this acceptable approach and we don't actually
> need go back to implementing the new VIDIOC_EXT_QBUF ioctl [6].
> 
> [6]
> https://patchwork.linuxtv.org/project/linux-media/cover/20210114180738.1758707-1-helen.koike@collabora.com/
> 
> This patch solves the problem for userspace when it wants to import
> buffers into V4L in case of multi-planar formats, but it doesn't cover
> all other possible cases that may require offsets customization too. On
> the other hand, it's easy to start accepting data_offset for the capture
> MPLANES without introducing new UAPIs, so I decided that will be best to
> start easy with the simplest solution.

