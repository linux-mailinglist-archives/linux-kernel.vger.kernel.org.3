Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100F2539592
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346674AbiEaRtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbiEaRtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:49:39 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AE09A9B7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:49:37 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a63so7307955pge.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=up1pTeS33dg3ysfhUrkuWPpoOH7KplpGmQPpid3W8Mk=;
        b=Z18B8MqFP+Ck/tneEl0C52IfN/HxS4s5lO8n20qYuAd1S4G/Vf2OmCpZmca1UUqOrh
         QwMuPuU4Jsp7Mdnt6OhcTZhfz7C0eFfJ4053ttaB+cFMY8IseRTESyK/AdZx/2nYJ+EF
         Hpng4JICoqaOApCdboSO5NIVOeoZAqy2yW2u9Jwf9ySMDxA1tE2Zwh6lXtnsX6xmHzm9
         QetdRkNvYGcv7AsBFV9EqiK8S4LGpSYpgN8NHWxkJgV/vP4CteyJgXFOt+xeg8QROOVK
         U3eje+iymL7gtqTOc7UsEPzlB6jYQW65VABczcItabSpV+T3t0hH4n7phq4VPv2+IEyx
         BUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=up1pTeS33dg3ysfhUrkuWPpoOH7KplpGmQPpid3W8Mk=;
        b=qrUl87eI71CJlLpSoFHsn9oNGa/hu3ebJGWmvYSQvdk/q4Jfxr2UexkWQ3rFsA7RTO
         IZIVvd/XhcPFeGohwZCpCpqe0Al0TaokbGPM36C565wI51w9vnsdfz9y4L6QF4xcysP2
         408gNM7lBDPofff+EVhlPvlQ2N4SaJT8zFWsRhPkU16GN7yPOhi4UXgMMUaLXD5LQYUv
         ja7af2Rq1ZvxAt/hHxRozClw6vQC824ZXBwlJhLVVbNSIbQRElmpl26tj8j6uXe4J0m2
         sn0m0R09IxdvuHRfbyWkXindnx6QiGnTNsNEbJS18Z/fqb5Ut27kYK18pJoDIhl8xFss
         k5EA==
X-Gm-Message-State: AOAM530S0YzVKHaxm4OsVYHqvjthR+xOG/0oRhVw+/Ai92R4pGYm+wI8
        /hj+U82YGUENC/NJB48SOwZS1g==
X-Google-Smtp-Source: ABdhPJwPT21CMLBCqelroEoxkIzSU+nUsU7b6/bESsnttsjXfdDRTNO1bxbXetVBX87qNMSYP2eo6Q==
X-Received: by 2002:a05:6a00:1792:b0:519:80a:9598 with SMTP id s18-20020a056a00179200b00519080a9598mr29316663pfg.10.1654019377442;
        Tue, 31 May 2022 10:49:37 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j16-20020a17090a7e9000b001e32824c452sm2147760pjl.40.2022.05.31.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:49:36 -0700 (PDT)
Date:   Tue, 31 May 2022 11:49:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: Re: [RFC PATCH v5 0/4] remoteproc: restructure the remoteproc VirtIO
 device
Message-ID: <20220531174933.GB531268@p14s>
References: <20220406095446.1187968-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406095446.1187968-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have started looking at this set.  Comments to follow in the coming days.

Thanks,
Mathieu

On Wed, Apr 06, 2022 at 11:54:42AM +0200, Arnaud Pouliquen wrote:
> 1) Update from V4 [1]:
> 
> Minor updates based on Mathieu's comments.
> Updates are listed in the commit message of each patch.
> 
> [1] https://lkml.org/lkml/2022/3/14/1177
> 
> 2) Patchset description:
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
> [2] https://lkml.org/lkml/2020/4/16/1817
> [3] https://lkml.org/lkml/2021/6/23/607
> [4] https://patchwork.kernel.org/project/linux-remoteproc/patch/AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch/
> 
> In term of device tree this would result in such hierarchy (stm32mp1 example with 2 virtio RPMSG):
> 
> 	m4_rproc: m4@10000000 {
> 		compatible = "st,stm32mp1-m4";
> 		reg = <0x10000000 0x40000>,
> 		      <0x30000000 0x40000>,
> 		      <0x38000000 0x10000>;
>         memory-region = <&retram>, <&mcuram>,<&mcuram2>;
>         mboxes = <&ipcc 2>, <&ipcc 3>;
>         mbox-names = "shutdown", "detach";
>         status = "okay";
> 
>         #address-cells = <1>;
>         #size-cells = <0>;
>         
>         vdev@0 {
> 		compatible = "rproc-virtio";
> 		reg = <0>;
> 		virtio,id = <7>;  /* RPMSG */
> 		memory-region = <&vdev0vring0>, <&vdev0vring1>, <&vdev0buffer>;
> 		mboxes = <&ipcc 0>, <&ipcc 1>;
> 		mbox-names = "vq0", "vq1";
> 		status = "okay";
>         };
> 
>         vdev@1 {
> 		compatible = "rproc-virtio";
> 		reg = <1>;
> 		virtio,id = <7>;  /*RPMSG */
> 		memory-region = <&vdev1vring0>, <&vdev1vring1>, <&vdev1buffer>;
> 		mboxes = <&ipcc 4>, <&ipcc 5>;
> 		mbox-names = "vq0", "vq1";
> 		status = "okay";
>         };
> };
> 
> I have divided the work in 4 steps to simplify the review, This series implements only
> the step 1:
> step 1:  redefine the remoteproc VirtIO device as a platform device
>   - migrate rvdev management in remoteproc virtio.c,
>   - create a remotproc virtio config ( can be disabled for platform that not use VirtIO IPC.
> step 2: add possibility to declare and probe a VirtIO sub node
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
>  drivers/remoteproc/remoteproc_core.c     | 154 +++---------------
>  drivers/remoteproc/remoteproc_internal.h |  23 ++-
>  drivers/remoteproc/remoteproc_virtio.c   | 193 ++++++++++++++++++++---
>  include/linux/remoteproc.h               |   6 +-
>  4 files changed, 215 insertions(+), 161 deletions(-)
> 
> -- 
> 2.25.1
> 
