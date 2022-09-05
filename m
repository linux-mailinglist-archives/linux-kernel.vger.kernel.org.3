Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962675ACC40
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiIEHTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbiIEHSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:18:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34584054D;
        Mon,  5 Sep 2022 00:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59372B80E76;
        Mon,  5 Sep 2022 07:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF84CC433C1;
        Mon,  5 Sep 2022 07:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662362026;
        bh=kueKFbaLuUoyBMqpYabhK8xKVW1c17BwckbSdbSAPnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTo/aqFaaL/Yx+uACkf2npR5tRIdwQ2u+rWk5dTeb6hhpsxfT10WJCumyJEC3zj+w
         A4pbVrXISAKPsQ+rimq2f/iTzhlhNpfQbH1DNYNd99W5R9Eo0UtWiDIvmFeenKGSSq
         6HyFPZa5frV8bFP6tnVke2ae7GVJNDuUqBGOj5Uk=
Date:   Mon, 5 Sep 2022 09:13:43 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     guoweibin <guoweibin@inspur.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Fix musb_gadget.c rxstate overflow bug
Message-ID: <YxWhp/QSKUU/utBd@kroah.com>
References: <20220905090212.f0118580ec37bf0aababb53d@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905090212.f0118580ec37bf0aababb53d@inspur.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 09:02:12AM +0800, guoweibin wrote:
> From: guoweibin <guoweibin@inspur.com>
> Date: Mon, 25 Jul 2022 19:27:49 +0800
> Subject: [PATCH] usb: musb: Fix musb_gadget.c rxstate overflow bug

Odd, this shouldn't be in the body of the email if you use 'git
send-email', how did you send it?

> 
> when the rxstate function executes the 'goto buffer_aint_mapped' code
> branch, it will always copy the fifocnt bytes data to request->buf,
> which may cause request->buf out of bounds..
> 
> Fix it by add the length check :
> fifocnt = min_t(unsigned, request->length - request->actual, fifocnt);
> 
> Signed-off-by: guoweibin <guoweibin@inspur.com>

I need a "full" name, not just an email alias as a name for a
signed-off-by:  Please fix that up and resend a v2.

And what commit does this fix?

thanks,

greg k-h
