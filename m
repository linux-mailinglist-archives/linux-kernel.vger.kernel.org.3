Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9554C786A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbiB1S7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbiB1S7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:59:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079EA51323
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:58:38 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qx21so26734256ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcZlL4PzkcLfzw14Q74Ote4Q8IMmE2Fk4hGp2ISoEdo=;
        b=WdRUjk2Wkg810LP3k7olro81leEyesMLlWm31uRmWkqSC8emyK0tjyBzqzoYqf459z
         zK5fHn5/3pMQaBuwTxoafl6DsJu5Dy6q5zwHOBvkGHnxpB0dtu2VAOIp6R35QGZKGlq2
         O+h5EkorUYrsIJLdbXKqKFG2W6nADYHd78hLsmjleE3EBKXYQ4Tt+tOzlJm/jK4j3DJ5
         0+CG/MABCZ0+LxNKutOoJTGARQhzI4De8dMANGMuDY0A5T1BFkAcZNknZedSgZ2/TAgA
         kSEypAPVveBgr5DqFghsbKCIvz0It9MysbqmzMrZoWVtr3INDgd4qSrd5TEnlDzwvdSz
         sI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcZlL4PzkcLfzw14Q74Ote4Q8IMmE2Fk4hGp2ISoEdo=;
        b=rWT34zsxn3uBOUGq/JGWYdUnLXVIy9AUHULCwD/Zz3K6FCzgI0mRtCRxMC663VjLhY
         rpYk5UF+SAd8AQRVE+KV9oImnWvBWB8bczLKDKOSjr8HZPF8acyB0IG9jHQzH7Ot+c+j
         MnAwevR4BIToUrhigxqiv+sCdghD6V65IUJAsDjiyl5SnYE1+PIKyNxKk6c3hn4/cUA4
         iWRRp3QVCNIeAMS/Y53xQ/hNFHQhF9nsIy797ppc2+SQL+LXf/kkvNMLH1yJtFMOY/T5
         M3WXevb5ws9KMYMi2lmAsyda0syARqpcyJ6lQDzPas3PkWqZK55EEcMuCvUNIF3hcZhA
         wMAg==
X-Gm-Message-State: AOAM531JE6Lkxs7F6WqQn0tNen5ZfNdpNvfoXTPRnFOTR6wni5bat+Af
        aopIeo5S/gsqANQQHpUvMKxUY1mJ0havbXl22Pf40g==
X-Google-Smtp-Source: ABdhPJyh7jLKXpSx+Hqmu/q9GANsQIGoyjbz6Ti7qWQqObW5EF0tPGnVYs94iJuG2ZVkOzW1cnUw8/JrFS0OxXgPOz8=
X-Received: by 2002:a17:906:4cd2:b0:6c8:7a90:9c7 with SMTP id
 q18-20020a1709064cd200b006c87a9009c7mr16175087ejt.439.1646074716386; Mon, 28
 Feb 2022 10:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20220126162405.1131323-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220126162405.1131323-1-arnaud.pouliquen@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 28 Feb 2022 11:58:25 -0700
Message-ID: <CANLsYkzEhh2bCLQN-vqSqTfYvpR6VuYJYZNeUVCDSZ3VSAshhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/4] remoteproc: restructure the remoteproc VirtIO device
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

On Wed, 26 Jan 2022 at 09:24, Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> Update from V2 [1]:
> In order to better handle error cases and to have something more symmetrical between
> the functions in charge of rvdev initialization/deletion, the patchset has been reworked.
>  - Introduction in the first patch, of rproc_vdev_data structure which allows to better
>    decorrelate the rproc from the management of the rvdev structure. This structure is reused
>    in the last patch of the series for the creation of the remoteproc virtio platform device.
>  - In addition to the previous version, the management of the vring lifecycle has been fully
>    migrated to the remoteproc_virtio.c (rproc_parse_vring, rproc_alloc_vring, rproc_free_vring)
>
> [1] https://lkml.org/lkml/2021/12/22/111
>
> Patchset description:
>
> This series is a part of the work initiated a long time ago in
> the series "remoteproc: Decorelate virtio from core"[2]
>
> Objective of the work:
> - Update the remoteproc VirtIO device creation (use platform device)
> - Allow to declare remoteproc VirtIO device in DT
>     - declare resources associated to a remote proc VirtIO
>     - declare a list of VirtIO supported by the platform.
> - Prepare the enhancement to more VirtIO devices (e.g I2C, audio, video, ...).
>   For instance be able to declare a I2C device in a virtio-i2C node.
> - Keep the legacy working!
> - Try to improve the picture about concerns reported by Christoph Hellwing [3][4]
>

I started working on this set - comments to follow throughout the week.

Thanks,
Mathieu

> [2] https://lkml.org/lkml/2020/4/16/1817
> [3] https://lkml.org/lkml/2021/6/23/607
> [4] https://patchwork.kernel.org/project/linux-remoteproc/patch/AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch/
>
> In term of device tree this would result in such hiearchy (stm32mp1 example with 2 virtio RPMSG):
>
>         m4_rproc: m4@10000000 {
>                 compatible = "st,stm32mp1-m4";
>                 reg = <0x10000000 0x40000>,
>                       <0x30000000 0x40000>,
>                       <0x38000000 0x10000>;
>         memory-region = <&retram>, <&mcuram>,<&mcuram2>;
>         mboxes = <&ipcc 2>, <&ipcc 3>;
>         mbox-names = "shutdown", "detach";
>         status = "okay";
>
>         #address-cells = <1>;
>         #size-cells = <0>;
>
>         vdev@0 {
>                 compatible = "rproc-virtio";
>                 reg = <0>;
>                 virtio,id = <7>;  /* RPMSG */
>                 memory-region = <&vdev0vring0>, <&vdev0vring1>, <&vdev0buffer>;
>                 mboxes = <&ipcc 0>, <&ipcc 1>;
>                 mbox-names = "vq0", "vq1";
>                 status = "okay";
>         };
>
>         vdev@1 {
>                 compatible = "rproc-virtio";
>                 reg = <1>;
>                 virtio,id = <7>;  /*RPMSG */
>                 memory-region = <&vdev1vring0>, <&vdev1vring1>, <&vdev1buffer>;
>                 mboxes = <&ipcc 4>, <&ipcc 5>;
>                 mbox-names = "vq0", "vq1";
>                 status = "okay";
>         };
> };
>
> I have divided the work in 4 steps to simplify the review, This series implements only
> the step 1:
> step 1:  redefine the remoteproc VirtIO device as a platform device
>   - migrate rvdev management in remoteproc virtio.c,
>   - create a remotproc virtio config ( can be disabled for platform that not use VirtIO IPC.
> step 2: add possibility to declare and prob a VirtIO sub node
>   - VirtIO bindings declaration,
>   - multi DT VirtIO devices support,
>   - introduction of a remote proc virtio bind device mechanism ,
> => https://github.com/arnopo/linux/commits/step2-virtio-in-DT
> step 3: Add memory declaration in VirtIO subnode
> => https://github.com/arnopo/linux/commits/step3-virtio-memories
> step 4: Add mailbox declaration in VirtIO subnode
> => https://github.com/arnopo/linux/commits/step4-virtio-mailboxes
>
> Arnaud Pouliquen (4):
>   remoteproc: core: Introduce virtio device add/remove functions
>   remoteproc: core: Introduce rproc_register_rvdev function
>   remoteproc: Move rproc_vdev management to remoteproc_virtio.c
>   remoteproc: virtio: Create platform device for the remoteproc_virtio
>
>  drivers/remoteproc/remoteproc_core.c     | 159 +++----------------
>  drivers/remoteproc/remoteproc_internal.h |  33 +++-
>  drivers/remoteproc/remoteproc_virtio.c   | 193 ++++++++++++++++++++---
>  include/linux/remoteproc.h               |   6 +-
>  4 files changed, 227 insertions(+), 164 deletions(-)
>
> --
> 2.25.1
>
