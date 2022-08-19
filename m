Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79559A4CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349870AbiHSR7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiHSR7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:59:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134721659A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:45:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z187so4900849pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=cYKLxzS8mdsne4T9+LkqQmo+81QPljtfwRLC/rxss24=;
        b=jIlWkwwxTb16NyF6jTA0qo6xr86HgbMzsUf1fsVarVZPWenkP1s+4XpVsoh/JzoPTD
         3JRuR+9wVdGp70rMhiXDPyskvl9c1PG4hUClNAkDaU92XvbB9gEXyprseXHwLyHrM+Wu
         xdPBwjni1qjJ1jPij5DFbzEWKNlpsY/KI10O7SsGhcd40NrS//EtU5rBhrwMIZIFxqa+
         /KItM8RZsNM1G0T/o8l7cbEaI6fSzMJLdMh1qAIMTJaLD/PhQSVDqH6MEh8jRqjCVaBw
         D9Jsl0yupjOU8XcUYUrN1vvb6rjabMCEYHH0X9aD2wek2wwCcwrrKxZVYm8FtQnC1YQz
         Cb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=cYKLxzS8mdsne4T9+LkqQmo+81QPljtfwRLC/rxss24=;
        b=hox3Z8v4PRKJDKWW3DRvFmzZ2EWfZE1tbrYUNmQxI7Kn31Xbcc7pHvZ9HifG4CocqP
         ESHyVepF3SqIKQaA96iW67ZJhqUHuV3Ytw63/VEARiSPQrlOVNFB0YMeMZ3CpRUOBH4G
         qmpsMBl+CH92cX6gukbkS/bT4UDIlAHMZNabVsvZUsW8kZUOm6SgGUMEC8Pu/H2z+h9R
         VIyjA51K8wRo9qVYWrBYCD/1uKp9pCkIvH91WpSxLQMUfgvtq0eaQUABuMugZ7rrnITK
         IfXJd+CYuGs/ZZVERasAihKqPkwNjUD/xflshC5XopnsBec08qWfF/QpYfXxpborx0bp
         uwEg==
X-Gm-Message-State: ACgBeo1Cnr4UBu1kgnFh4hM2oQHsgZuo9qL78WIwon+1qOrknHf3Ix24
        WvzqEs0nS1ipDtOuPmTXZXEOzg==
X-Google-Smtp-Source: AA6agR4hTHDffXLin9WcvMM4cSaZZ6d075dMHXt+c3wV/gHSpK/yGIt+nNUqSc9rkTVP2d6S9QB6PQ==
X-Received: by 2002:a63:1342:0:b0:422:5e7a:2a8f with SMTP id 2-20020a631342000000b004225e7a2a8fmr7006374pgt.425.1660931122343;
        Fri, 19 Aug 2022 10:45:22 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:4a9e:3b14:a2f3:77cf])
        by smtp.gmail.com with ESMTPSA id d5-20020a623605000000b0052b94e757ecsm3685154pfa.213.2022.08.19.10.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:45:21 -0700 (PDT)
Date:   Fri, 19 Aug 2022 10:45:15 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <Yv/MKymRC9O04Nqu@google.com>
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
 <20220816042507.GB1108868@roeck-us.net>
 <YvsoYzIhOtX9DOi2@google.com>
 <20220816111311.GC1108868@roeck-us.net>
 <YvvQOBk9T3J1uX8k@google.com>
 <20220817010559.GA1880847@roeck-us.net>
 <YvxAfiSOrzy7/c1J@google.com>
 <20220818225932.GA3433999@roeck-us.net>
 <Yv7bd6Yl8+thp2CY@google.com>
 <20220819112832.GA3106213@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819112832.GA3106213@roeck-us.net>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 04:28:32AM -0700, Guenter Roeck wrote:
> On Thu, Aug 18, 2022 at 05:38:15PM -0700, Isaac Manjarres wrote:
> > On Thu, Aug 18, 2022 at 03:59:32PM -0700, Guenter Roeck wrote:
> > > Requesting system reboot
> > > sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > > ci_hdrc ci_hdrc.1: remove, state 4
> > > usb usb2: USB disconnect, device number 1
> > > ci_hdrc ci_hdrc.1: USB bus 2 deregistered
> > > ci_hdrc ci_hdrc.0: remove, state 1
> > > usb usb1: USB disconnect, device number 1
> > > usb 1-1: USB disconnect, device number 2
> > > sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > > sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: hostbyte=0x01 driverbyte=DRIVER_OK
> > > 
> > > [ stuck here until qemu is killed ]
> > > 
> > Hi Guenter,
> > 
> > I'm actually observing the behavior described above even without my patch.
> > The tip of my tree is currently at 573ae4f13f63 ("tee: add overflow check in
> > register_shm_helper()"). I used git bisect to find what commit was
> > causing the problem, and narrowed it down to this series[1].
> > 
> > I reverted all 4 patches in that series, and I no longer see this hang
> > with my tree.
> > 
> > [1]: https://lore.kernel.org/all/20220712221936.1199196-1-bvanassche@acm.org/
> > 
> > Are these patches part of the tree you're using for testing and
> > observing this hang in?
> > 
> 
> Yes, you are correct. I also see the problem in the mainline kernel,
> at SHA 3b06a2755758, and with a large number of boots from usb drive
> in various arm emulations. Sorry for the confusion. Too many crashes :-(.
> 
> Guenter

No worries, thanks for confirming.

Hi Bart,

It seems that the patches mentioned in [1] are causing a hang during
reboot for various ARM emulations when booting from USB. Can you please
take a look? There's more information about what defconfig, rootfs, and
qemu commandline to use at [2].

[1]: https://lore.kernel.org/all/20220712221936.1199196-1-bvanassche@acm.org/
[2]: https://lore.kernel.org/all/20220818225932.GA3433999@roeck-us.net/

Thanks,
Isaac
