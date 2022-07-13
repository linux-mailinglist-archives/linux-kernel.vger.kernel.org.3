Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCD6573AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbiGMP4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiGMP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:56:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30B14F6AB;
        Wed, 13 Jul 2022 08:56:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso4310173pjh.1;
        Wed, 13 Jul 2022 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jKAUXPLBrNevdC9OiqEXv5Wg4h8+PAmTG/9uIdwRKNA=;
        b=aBupZpHtg8XwLvVKFAXLuBmAAWVRVghrIn9ZNgreYANgaU0v/qCvdDEIc9xI6H79sA
         NZ9TpP6vHRQfG0DdPuQH99iG2Or/tN6/USEXUEs94hwwJ9T1Ot0kdHuLklolhFTu1Vu9
         cKQ6OXNFiSNTWdoo8iVDnSAn3mrj0hegvaqHgYgwIMTY9yydRqsECiJY8UoWpnWVLHDN
         FcDZGik/5xc59Zm0aKoHj/wl6bramtnIqRkQpLRP/6gZglOCfL9cKd2/o7COVFIMV6Dd
         Uj8Nj+baniaDNUtmjMqcutA/zmMl6wqmPchds9edCbIIq6IseZdbXIU74IjSddrpobOK
         BVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jKAUXPLBrNevdC9OiqEXv5Wg4h8+PAmTG/9uIdwRKNA=;
        b=Y0bw9kq1lRhusmzgx1Vf5LWmHFXydV5++nTTjED6ZZtM24KrDsVQEgBOFmz4MS3odt
         Zvhmju0AGGWu2Uk80LNukVti+0+vLKW3kYKCwDgixlDNeciYQ0tT//Uztz2VInm1Lie0
         ovL/YhpGDf2BqT1Y0ZATdbvjDtDO7oMwf3A/pZHgqOYFDOLEwrAGTQYyKZwwIkCb6XKK
         9fjJ/3FC+ZoOhHr1yoWhQZk211TDfuE84fztU1WkDIM1EbW/YhdIQTg6mIJtjB6hYYlc
         Gj41bpbdj2TFCOrjTjI+qHLlyaIRS6MApLXGl/3a/5qkNPu8qlFl5PpcqMUCCYtKjH51
         o05Q==
X-Gm-Message-State: AJIora/iN7oz30snwaLnF/jCHgSOBd/MpPhZjRrBCA97k/x+5M42wJ09
        Id44Alw1uY1JMWsIMQceDrP4tjpx7rlfmA==
X-Google-Smtp-Source: AGRyM1uztx7H1jzf5s+TTvAW1XBZNKgEQoYqHpqn6WNTf/pSYOGA8xIgngVh0T1SEhc5aR5zpYFJEA==
X-Received: by 2002:a17:902:7106:b0:16c:6c95:6153 with SMTP id a6-20020a170902710600b0016c6c956153mr3706590pll.166.1657727776276;
        Wed, 13 Jul 2022 08:56:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902a38a00b001678ce9080dsm8962079pla.258.2022.07.13.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:56:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jul 2022 08:56:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v16 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Message-ID: <20220713155613.GA2194204@roeck-us.net>
References: <20220712090534.2783494-1-xji@analogixsemi.com>
 <0bd85140-f006-8b29-0a43-500733f1654c@roeck-us.net>
 <Ys16lEvhVSSSRMP7@kroah.com>
 <20220713062845.GB2788915@anxtwsw-Precision-3640-Tower>
 <Ys5oBTeIcLjf7gnX@kroah.com>
 <20220713064818.GA2789090@anxtwsw-Precision-3640-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713064818.GA2789090@anxtwsw-Precision-3640-Tower>
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

On Wed, Jul 13, 2022 at 02:48:18PM +0800, Xin Ji wrote:
> On Wed, Jul 13, 2022 at 08:36:53AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 13, 2022 at 02:28:45PM +0800, Xin Ji wrote:
> > > On Tue, Jul 12, 2022 at 03:43:48PM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Jul 12, 2022 at 06:31:22AM -0700, Guenter Roeck wrote:
> > > > > On 7/12/22 02:05, Xin Ji wrote:
> > > > > > USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> > > > > > and a port controller (TCPC) - may require that the driver for the PD
> > > > > > controller accesses directly also the on-chip port controller in some cases.
> > > > > > 
> > > > > > Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> > > > > > 
> > > > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > > 
> > > > > > ---
> > > > > > V9 -> V10: Rebase on the latest code
> > > > > > V8 -> V9 : Add more commit message
> > > > > > V7 -> V8 : Fix Guanter's comment, remove unnecessary explain
> > > > > 
> > > > > We are now at v16. The change log has not been updated since v10,
> > > > > making it all but worthless.
> > > > 
> > > > It's also already in my tree for a while, so I have no idea what this is
> > > > being generated against :(
> > > Hi all, I'm little confused, do I need update change log from v11 to
> > > v16? There is no changes since v10.
> > 
> > I'm confused, why are you sending a patch over that is already in my
> > tree and in linux-next?  You got an email saying it was merged, see
> > commit 7963d4d71011 ("usb: typec: tcpci: move tcpci.h to
> > include/linux/usb/").
> > 
> > thanks,
> > 
> > greg k-h
> Hi greg k-h, sorry for that, this serial has 3 patches, so I just think
> need update all 3 patches in each upstream.

If you resend patches as part of a series, please explain in the change
log that this patch was unchanged.

Guenter
