Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA414C906D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiCAQeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiCAQeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:34:06 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471725FF31
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:33:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x18so14710845pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=peE7sO9c9bIwrLDEH+P5tPx9gsKQOC+ku7JdeqViooo=;
        b=KoTASANrVf5duaFDYBHbeH/9TtHaMvz7i+kkj9juAMUtoR1T5pwMEm3RCMva1Azq0V
         Csx3NzdZZZ/vw0LO/tP1TSd8FA8E1Ss55qaXRBI2my9o1cGn10jS9dADrlWZ0ES9Vjp3
         1wOZJhSniaiD7fRGtnW9d/jgK9KKMD5YIiq0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=peE7sO9c9bIwrLDEH+P5tPx9gsKQOC+ku7JdeqViooo=;
        b=KLfjFIS5nBkk0uhVWora+sp5e9ipI/lKhpypbFRmMu/kLKNNJ6GP1BcdfxlRWTZsEb
         EvmTtexH2X8by3rkMoKvo4P00oY33oK69xUwu8ZeQnKcXcR7HV9Pq42hbjLEA4eEuSAW
         DXBCEbztCkFsnUyZy6oeV8QqIpwDjtfXeXX2WofOvxs5bSUwUhmXaA//3v4B8UTe9/v6
         C6WwS7nfiS5oha1ETxmEvZUBmXwKtFGz12w+3oYNaaA0B1CazuwnyHtKhje+WQeBiwfQ
         WntqZN0c/3wtD7VZzF8hZsxao/L2AwSBuvlN9uZ00ivmQkixSrDxa817ru6G9T9e7VgM
         bsgA==
X-Gm-Message-State: AOAM530U2C9K8gWkjjqrXdqVD+1RFZxWUK63Yd2uHgOPGybFs8jbQ4se
        Zi+b7XQ6W8UAUwmFGE81dIO6zQ==
X-Google-Smtp-Source: ABdhPJzOsZaPH+JussBROy3HgQg618t7zVhdAt+Gn2HqVPRz1lT34TD61D6g5HEnQnaGXPoKXcyJdw==
X-Received: by 2002:a63:d47:0:b0:373:598c:e0aa with SMTP id 7-20020a630d47000000b00373598ce0aamr22407736pgn.243.1646152404787;
        Tue, 01 Mar 2022 08:33:24 -0800 (PST)
Received: from localhost ([2620:15c:202:201:77d:b927:44d6:c9f5])
        by smtp.gmail.com with UTF8SMTPSA id y12-20020a056a00190c00b004f39e28fb87sm18721077pfi.98.2022.03.01.08.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 08:33:24 -0800 (PST)
Date:   Tue, 1 Mar 2022 08:33:22 -0800
From:   "mka@chromium.org" <mka@chromium.org>
To:     "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Tao Wang (Consultant) (QUIC)" <quic_wat@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "ravisadineni@chromium.org" <ravisadineni@chromium.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI0=?= =?utf-8?Q?=3A?= Re: [PATCH v20
 3/5] usb: misc: Add onboard_usb_hub driver
Message-ID: <Yh5K0u3jp4jTXCPi@google.com>
References: <SA1PR02MB86067ACF0C96F18B7306D208903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <SA1PR02MB860660B6F33011E5A97F7930903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhURQAksLKVuzU36@google.com>
 <SA1PR02MB860602E0AC4D9BD0BC4245B5903C9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhXolQDwIMbTi/O2@kroah.com>
 <DM8PR02MB81988555CA6B66BB3FD5E488E3019@DM8PR02MB8198.namprd02.prod.outlook.com>
 <Yh0UZUU9/9Hd6Pc1@google.com>
 <DM8PR02MB8198F2BFE9E933CC8F2C148BE3029@DM8PR02MB8198.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR02MB8198F2BFE9E933CC8F2C148BE3029@DM8PR02MB8198.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 02:30:00AM +0000, Linyu Yuan (QUIC) wrote:
> > From: mka@chromium.org <mka@chromium.org>
> > Sent: Tuesday, March 1, 2022 2:29 AM
> > To: Linyu Yuan (QUIC) <quic_linyyuan@quicinc.com>
> > Cc: gregkh@linuxfoundation.org; Tao Wang (Consultant) (QUIC)
> > <quic_wat@quicinc.com>; balbi@kernel.org; devicetree@vger.kernel.org;
> > dianders@chromium.org; frowand.list@gmail.com; hadess@hadess.net;
> > krzk@kernel.org; linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> > mathias.nyman@intel.com; michal.simek@xilinx.com;
> > peter.chen@kernel.org; ravisadineni@chromium.org; robh+dt@kernel.org;
> > rogerq@kernel.org; stern@rowland.harvard.edu; swboyd@chromium.org
> > Subject: Re: 回复: 回复: Re: [PATCH v20 3/5] usb: misc: Add
> > onboard_usb_hub driver
> > 
> > >
> > > Hi Greg and mka,
> > >
> > > Let's make it clear that we are talking about once this driver is approved
> > into usb tree,
> > > If we use different USB HUB which have VID/PID not defined in this driver,
> > > We need to update this driver.
> > >
> > > But if we defined VID/PID in device tree(for a specific board, manufacture
> > should know VID/PID from HUB it used),
> > > dynamic parsed by the driver,  then we don't need to change this driver
> > (increase VID/PID table).
> > 
> > As per my earlier reply, the kernel/USB core uses the VID:PID reported
> > by the USB device, the compatible string in the device tree is purely
> > informational. That's not something that could be changed by this
> > driver.
> I can't fully understand this comment,  could you please share step if we want to add a new HUB support, what should we do ? nothing ?

Add the VID:PID and compatible strings to onboard_usb_hub.c, analogous
to those for the RTS5411 and RTS5414. More work will be needed if the
hub needs a special power up or power down sequence (multiple regulators,
GPIOs, ...)

> If do nothing, can we remove id_table from  onboard_hub_usbdev_driver  ?
> > 
> > And even if the VID:PID from the device tree was used: how is the
> > kernel supposed to know that the onboard_hub driver should be
> > probed for a given VID:PID from the device tree, without listing
> > the VID:PID (or compatible string) in the driver (which is what
> > you seem to seek to avoid)?
> In my opinion, if it need update VID/PID table in this driver to support a new HUB,
> we can parse VID/PID from device tree and create dynamic VID/PID entry to id_table of onboard_hub_usbdev_driver.
> 
> Hope you can understand what I said.

Not really.

I doubt that what you are suggesting would work. The easiest thing
to convince people would probably be to send a patch (based on this
one) with a working implementation of your idea.
