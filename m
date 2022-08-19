Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF9599AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348674AbiHSL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348105AbiHSL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:28:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982C4A00DF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:28:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 12so3495181pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=1yzawvpM6psLELBlu3zNIRtMo+QXvcoHxz+DdrFs9Fo=;
        b=bCZpD8pZaB4yaFkyaLxpAxa6Jg2CpwJgjhQoSUaaiGa5ZqG1sTWmpCL356S/ld4xas
         uLRYYQB18EQ0TitBFQZvpDq84AxlTAEz53QiPZDylgqxIuBsHjHWJf63cZFVc8/ymnbr
         WDP3iBMRwqgxMebl1dG0MJ1bXAIh6na0IaoqhuzPB/YJ9VP8l923H5ZOsbx69AA3F4fZ
         QKTNaJMe0KVT883qU4VppTt4Of5zHYtc8we5NY9823MsHvkQlvpV8gWInRIPJ4FMxcLn
         VQHJo5jlVb+uhvlKwm+2Lj3EbNOP4wTCFcB8gQAZwAFIVXftgKKdEJzd/HzVJIGppct5
         vxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=1yzawvpM6psLELBlu3zNIRtMo+QXvcoHxz+DdrFs9Fo=;
        b=MvISV33OHIuqXNX91ydyv+/RB0Hw+SKRN27nSd96D5q+VK9wih0KL31loJ4hzTL7XM
         Fz7Q+zNzStz+effT4qC9FLiEPCtd6VvQcGXY8hCGlx5uzr24cZZFhRlRJkQA4cjpRorf
         fqiVNbLO5dWCQ+iVWSzoBAePbB+IHdxu0I50hG/nVRYKRox6R053saW+ajB1hKwwX8u5
         c3NJB6v79qnBQ4rnqFaAERA91TUaSEoWIuMLKNbonve96lB0cixjeG6u4Kow1ILa0l6P
         8dKlNeImtnUIc0/VZvVewgrc3duWAQFqcu68cvgqszms46irSqKi1kwwYtHHtG39SRGT
         oXVw==
X-Gm-Message-State: ACgBeo1Me+A/Hs4SnAv5Fe2ltmETSXlr3YtSDYjkEySq1W4wk5UwKB8x
        sNfpehoLDsbdxG2Mul41i6M=
X-Google-Smtp-Source: AA6agR4M++z361C7Ysh3/+kVqw72y+PXaLblq7d0d+KK7jFpBBdt3lDeTXucOXgVMHI0nMLj65aDnA==
X-Received: by 2002:a05:6a00:a04:b0:534:d8a6:40ce with SMTP id p4-20020a056a000a0400b00534d8a640cemr7502238pfh.15.1660908515978;
        Fri, 19 Aug 2022 04:28:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902f68b00b001709aea1516sm2996120plg.276.2022.08.19.04.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:28:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 04:28:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <20220819112832.GA3106213@roeck-us.net>
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
 <20220816042507.GB1108868@roeck-us.net>
 <YvsoYzIhOtX9DOi2@google.com>
 <20220816111311.GC1108868@roeck-us.net>
 <YvvQOBk9T3J1uX8k@google.com>
 <20220817010559.GA1880847@roeck-us.net>
 <YvxAfiSOrzy7/c1J@google.com>
 <20220818225932.GA3433999@roeck-us.net>
 <Yv7bd6Yl8+thp2CY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv7bd6Yl8+thp2CY@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 05:38:15PM -0700, Isaac Manjarres wrote:
> On Thu, Aug 18, 2022 at 03:59:32PM -0700, Guenter Roeck wrote:
> > Requesting system reboot
> > sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > ci_hdrc ci_hdrc.1: remove, state 4
> > usb usb2: USB disconnect, device number 1
> > ci_hdrc ci_hdrc.1: USB bus 2 deregistered
> > ci_hdrc ci_hdrc.0: remove, state 1
> > usb usb1: USB disconnect, device number 1
> > usb 1-1: USB disconnect, device number 2
> > sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: hostbyte=0x01 driverbyte=DRIVER_OK
> > 
> > [ stuck here until qemu is killed ]
> > 
> Hi Guenter,
> 
> I'm actually observing the behavior described above even without my patch.
> The tip of my tree is currently at 573ae4f13f63 ("tee: add overflow check in
> register_shm_helper()"). I used git bisect to find what commit was
> causing the problem, and narrowed it down to this series[1].
> 
> I reverted all 4 patches in that series, and I no longer see this hang
> with my tree.
> 
> [1]: https://lore.kernel.org/all/20220712221936.1199196-1-bvanassche@acm.org/
> 
> Are these patches part of the tree you're using for testing and
> observing this hang in?
> 

Yes, you are correct. I also see the problem in the mainline kernel,
at SHA 3b06a2755758, and with a large number of boots from usb drive
in various arm emulations. Sorry for the confusion. Too many crashes :-(.

Guenter
