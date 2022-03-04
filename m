Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF3B4CD62C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbiCDOSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiCDOSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:18:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6651302;
        Fri,  4 Mar 2022 06:17:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E8F4612A5;
        Fri,  4 Mar 2022 14:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B12C340E9;
        Fri,  4 Mar 2022 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646403431;
        bh=izdGUeAOWq2bl+EhLfImID5YzNPYUengEQlfFuVgnf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBmuVOpHQDKQEfjSZMeX3V4vQCyYwyRD2am8FKIdSh8fwEo0Ccs2IXCKCKcm8ioht
         IFP/uwCL77HoqJB6CcxqHNAkabIhuzPaa2/8r0ktgvVeBFFahkH7O5ILuTbweRGf8t
         XJUKehhSTYNkJQ/hkIymzBt3k5OGCF3Bf2ZCtchE=
Date:   Fri, 4 Mar 2022 15:17:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mathias.nyman@intel.com, kernel@puri.sm, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: make XHCI_STOP_EP_CMD_TIMEOUT a module
 parameter
Message-ID: <YiIfZFPl9ZqPBKvj@kroah.com>
References: <20220304113057.1477958-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304113057.1477958-1-martin.kepplinger@puri.sm>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 12:30:57PM +0100, Martin Kepplinger wrote:
> On the Librem 5 imx8mq system we've seen the stop endpoint command
> time out regularly which results in the hub dying.
> 
> While on the one hand we see "Port resume timed out, port 1-1: 0xfe3"
> before this and on the other hand driver-comments suggest that the driver
> might be able to recover instead of dying here, Sarah seemed to have a
> workaround for this particulator problem in mind already:
> 
> Make it a module parameter. So while it might not be the root cause for
> the problem, do this to give users a workaround.

This is not the 1990's, sorry, please do not add new module parameters.
They modify code, when you want to modify an individual device.

thanks,

greg k-h
