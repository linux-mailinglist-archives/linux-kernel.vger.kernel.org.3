Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA535AB4EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiIBPUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiIBPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:20:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D06110D92;
        Fri,  2 Sep 2022 07:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E1D6B82C4F;
        Fri,  2 Sep 2022 14:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB30C433D7;
        Fri,  2 Sep 2022 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662130375;
        bh=2nsqhytIadgt0yVsKmvIq8R/PDqbSS7Zny3Nh5gwWMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0uAPsfVL/EPbSnsrzxjIoo9Vj03dtq8el44F980fwZklNXH9iaGfEh96nTFOW3+KB
         W/xjrZuVANL2pJXr0SdhyAEDicdaJ5mNzACUmRvoR6Au2fcR0GVh3ZRRyJr339FKty
         FW7QnIvk75oZqiZmwynvXq6r5al/oB61Jy3rLl4M=
Date:   Fri, 2 Sep 2022 16:52:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v3] USB: serial: ftdi_sio: Convert to use dev_groups
Message-ID: <YxIYxDQ/vLi4Eq38@kroah.com>
References: <20220902143346.4120012-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902143346.4120012-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:33:46PM +0800, Jiasheng Jiang wrote:
> On Fri, Sep 02, 2022 at 05:56:13PM +0800, Greg KH wrote:
> >>  drivers/usb/serial/ftdi_sio.c | 101 +++++++++++++++++-----------------
> >>  1 file changed, 51 insertions(+), 50 deletions(-)
> >> 
> >> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> >> index d5a3986dfee7..479c3a5caaf8 100644
> >> --- a/drivers/usb/serial/ftdi_sio.c
> >> +++ b/drivers/usb/serial/ftdi_sio.c
> >> @@ -1107,11 +1107,40 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base);
> >>  static u32 ftdi_232bm_baud_to_divisor(int baud);
> >>  static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
> >>  static u32 ftdi_2232h_baud_to_divisor(int baud);
> >> +static umode_t ftdi_sio_attr_is_visible(struct kobject *kobj,
> >> +					 struct attribute *attr, int idx);
> >> +static ssize_t latency_timer_store(struct device *dev,
> >> +				   struct device_attribute *attr,
> >> +				   const char *valbuf, size_t count);
> >> +static ssize_t event_char_store(struct device *dev,
> >> +	struct device_attribute *attr, const char *valbuf, size_t count);
> >> +static ssize_t latency_timer_show(struct device *dev,
> >> +				  struct device_attribute *attr, char *buf);
> >> +
> > 
> > Please work with the code so that you do not have to pre-define these
> > functions.  It should be possible.  Worst case, you pre-define the
> > structure for the driver, that should be it.
> 
> Without pre-definition of the functions, compilation errors will occur,
> such as 'ftdi_sio_attr_is_visible' undeclared here.
> I have no idea why they are not necessary.

If you move the code around that asks for those functions, you will not
need to define them.

> > And again, have you tested this change?
> 
> Every time I change the code, I recomplie it and check whether there are
> errors.
> Are there any other tests I need to do?

Yes, boot with the device and make sure that the sysfs files are still
there.  You do have access to one of these devices, right?  They are
very very common.

thanks,

greg k-h
