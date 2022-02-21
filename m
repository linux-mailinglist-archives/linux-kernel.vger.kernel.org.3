Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB04BE805
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353195AbiBUKXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:23:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354666AbiBUKXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:23:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2684E60AA8;
        Mon, 21 Feb 2022 01:43:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A45CB611DF;
        Mon, 21 Feb 2022 09:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B612C340E9;
        Mon, 21 Feb 2022 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645436585;
        bh=8T3rysmCgKhyEMuBv35XJTIZyAHXxJuTW7V46yHSUCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mU6czVroTn5L8wCZ2EbeWasitEeMgRoNiRni5rHEl9Z9hUMaykW1QndZ9aBDmV1tw
         yJB+Md8nlmPUjJocgl8MzXBO/zhziaBvg++WM9aVnE6MFKDiAjc7Vl6bWVF1F6g4b0
         6JemQ59+8bV2hgsXy9ncO0dJfRrzzY5uSXFzESRTccc0cuYGrmu+lzeItE9BoxFr3d
         F4DGYx+W3B6XEsOy/Rtgsv7vapdg80NFROwjKMc9BRYPa/QrDyBWoqfcJG0dEct92B
         pERWMi4B8jGh2cH1PsYhxHIlkLLEc631Ny2WU1tO2kYtuu90/oYc49QM1bju7gZgol
         2lFIUW9LjHOrw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nM5Di-0007Ai-DT; Mon, 21 Feb 2022 10:43:02 +0100
Date:   Mon, 21 Feb 2022 10:43:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] USB: serial: option: add support for DW5829e
Message-ID: <YhNepjwXJQH+Koof@hovoldconsulting.com>
References: <20220209031535.9668-1-slark_xiao@163.com>
 <YgPPNVzyg7Gypzv9@hovoldconsulting.com>
 <62feaf3.248f.17ee1ac3017.Coremail.slark_xiao@163.com>
 <YhNWV5lXm0d7lyfL@hovoldconsulting.com>
 <14f5bdc0.3675.17f1b94b947.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f5bdc0.3675.17f1b94b947.Coremail.slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 05:20:05PM +0800, Slark Xiao wrote:

 >> >> @@ -1063,6 +1065,10 @@ static const struct usb_device_id option_ids[] = {
> >> >>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> >> >>  	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5821E_ESIM),
> >> >>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> >> >> +	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_5829E, 0xff),
> >> >> +	  .driver_info = RSVD(6) },
> >> >> +	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM, 0xff),
> >> >> +	  .driver_info = RSVD(6) },
> >> >
> >> >It looks like these entries will cause the driver to bind also to the
> >> >QMI port however.
> >> >
> >
> >> Actually not,  currently RMNET port would load the qmi_wwan driver
> >> successfully even the class of QMI is also 0xff.
> >
> >That's not guaranteed so RMNET mode could break depending on probe
> >order with the above entries.
> >
> >> Do you mean I should add RSVD(0) to reduce confusion?
> >
> >You need to reserve it for correctness (or restructure the entries in
> >some other way to achieve the same result).
> > 
> Yes, so I re-send a V2 version to reserve interface 0,1,6. Please help take a look on that.

There's no need to reserve interface 1 since it's not vendor class in
any configuration. I've already fixed up and applied your v2.

Also, in the future, please make sure to wrap the lines of your mails at
72 column or so.

Johan
