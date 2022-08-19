Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558F95991D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244625AbiHSAi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbiHSAiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:38:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94D481C5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:38:22 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 202so2528812pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=uaAY5FUxLbVgPNlfLoUfupM+nmBQ9ZGafJzO117nq8g=;
        b=SLUqj/6euaOatuUK2NC8fjYNbAO12r/sSxk2TtkwGMM7Xx2rQR27VYEKj7w49p0n4U
         ttYCxyHLD4dZR0AmOpfJkFnXTmJ5H21keIGDnNJXUVed41jpFXIagRmgLgXP3Uo59Xuf
         dAlnZiAyCxWA4MWqIgtOhjU7MePRskq3ExKT4WrMQ65vfcBcZDtfdJvcm3q1DbsiO6Hf
         Rozuxk+w5mbS0KABkqeb3/5gkmRrFST9zT1cH33rWP/4vZKrkER0PwkGve4H+QyebxZH
         Ptv9zZ2RvNY+5MeHJzKsz/yBgT+g5u7q5YP/RKvOe5XrLQknNyPeKCex9IjWDysGyVvV
         D1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uaAY5FUxLbVgPNlfLoUfupM+nmBQ9ZGafJzO117nq8g=;
        b=0gw2VJ9ulAK5W/vOjXwVNcqbuyuFyGGNnP/kUS53JUG+r0M3V9gQHFyFty7CtcuMV+
         8M/CY0RgC9GgQDHhXpHl4QZt0n7Pzy8qnfIT3q1TZMpekjEqaP9P6G9aM7IZqfeafsNZ
         qO5nDZSZE3BE6QQSfT3M6R27D6SJvEE6Lk6APoEoHepi6OOBIEXLIp+J3UDheXcT7nth
         tB1bmUOk2RM2894hH1ELLioQp5L290qQ7IPHMP5eRTpiMrvMjOIZICWNUS6jiY1v4rKh
         ark3Xi9G7XnUwXpepJXp89Ni522tX5X8q9TEaer+iAQm6JgEjL4qCf1/NcerTQEDziay
         Xfbw==
X-Gm-Message-State: ACgBeo1daEf9rIlfrUYA8Oa5jfUmHaxsVA7Y7DN89nMa3mMQVJXrcQ/5
        mHoy4RZqg8ietVru5ofH/NYfUQ==
X-Google-Smtp-Source: AA6agR7VoOScTbEohs79Z6ARtks3G0b8GoE1/AMSLubyc3KzeWbFzZ5sGd4VVQK3EfMvWLsInL3IPA==
X-Received: by 2002:a63:505a:0:b0:421:a16a:d286 with SMTP id q26-20020a63505a000000b00421a16ad286mr4318375pgl.441.1660869501835;
        Thu, 18 Aug 2022 17:38:21 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:aa25:fe91:7e28:16bc])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b0016a6caacaefsm1952248pld.103.2022.08.18.17.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 17:38:21 -0700 (PDT)
Date:   Thu, 18 Aug 2022 17:38:15 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <Yv7bd6Yl8+thp2CY@google.com>
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
 <20220816042507.GB1108868@roeck-us.net>
 <YvsoYzIhOtX9DOi2@google.com>
 <20220816111311.GC1108868@roeck-us.net>
 <YvvQOBk9T3J1uX8k@google.com>
 <20220817010559.GA1880847@roeck-us.net>
 <YvxAfiSOrzy7/c1J@google.com>
 <20220818225932.GA3433999@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818225932.GA3433999@roeck-us.net>
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

On Thu, Aug 18, 2022 at 03:59:32PM -0700, Guenter Roeck wrote:
> Requesting system reboot
> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> ci_hdrc ci_hdrc.1: remove, state 4
> usb usb2: USB disconnect, device number 1
> ci_hdrc ci_hdrc.1: USB bus 2 deregistered
> ci_hdrc ci_hdrc.0: remove, state 1
> usb usb1: USB disconnect, device number 1
> usb 1-1: USB disconnect, device number 2
> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: hostbyte=0x01 driverbyte=DRIVER_OK
> 
> [ stuck here until qemu is killed ]
> 
Hi Guenter,

I'm actually observing the behavior described above even without my patch.
The tip of my tree is currently at 573ae4f13f63 ("tee: add overflow check in
register_shm_helper()"). I used git bisect to find what commit was
causing the problem, and narrowed it down to this series[1].

I reverted all 4 patches in that series, and I no longer see this hang
with my tree.

[1]: https://lore.kernel.org/all/20220712221936.1199196-1-bvanassche@acm.org/

Are these patches part of the tree you're using for testing and
observing this hang in?

Thanks,
Isaac
