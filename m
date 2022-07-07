Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE6569C91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiGGIEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiGGIEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:04:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C20F25C5;
        Thu,  7 Jul 2022 01:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A02ADB81F50;
        Thu,  7 Jul 2022 08:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3100C341C8;
        Thu,  7 Jul 2022 08:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657181070;
        bh=i3ubyFnOD3zhjC1AIUILsyZXAyE/N1coKv+uqBVa8Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xXCqNLAfXYa38ck54PvLEFvRVCNtD/7EEsqBmJZU/dy5P8udEd3TfpR8pDo79XQKq
         UKxBKT4lfdaqth7MXIz5qMOQJV9ag0Tmm7vMq0yN64MK8GuLDSalGxiI9nrLFqRJCE
         UkSEYCLninFNnTT8zdP4zQQIx4738L7Bpwpt7mhk=
Date:   Thu, 7 Jul 2022 10:04:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Oliver Neukum <oneukum@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsaTi14Ymd9xA9re@kroah.com>
References: <YsL5pUuydMWJ9dSQ@kroah.com>
 <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
 <5665ccb2-b92b-9e1f-8bb5-a950986450ec@I-love.SAKURA.ne.jp>
 <YsRHwy6+5gask+KT@kroah.com>
 <064bbe2a-c18e-203e-9e01-b32fe9baa390@I-love.SAKURA.ne.jp>
 <7ddb25ff-60e5-75be-8080-2a7465cca68c@I-love.SAKURA.ne.jp>
 <YsUtBERm94k/iZTy@kroah.com>
 <a6d98824-56c8-6d92-bb1b-eb065b57cb81@I-love.SAKURA.ne.jp>
 <815866b5-842e-4829-5ed8-26a5f1e856a4@suse.com>
 <22c61a75-8140-c62d-ffe0-efd6e9fa38ee@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22c61a75-8140-c62d-ffe0-efd6e9fa38ee@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 02:06:38PM +0900, Tetsuo Handa wrote:
> On 2022/07/06 20:04, Oliver Neukum wrote:
> > 
> > 
> > On 06.07.22 12:26, Tetsuo Handa wrote:
> >> On 2022/07/06 15:34, Greg KH wrote:
> >>> On Wed, Jul 06, 2022 at 03:21:15PM +0900, Tetsuo Handa wrote:
> >>>> How should we fix this problem?
> >>>
> >>> We can decrease the timeout in usb_stor_msg_common().  I imagine that if
> >>> that timeout is ever hit in this sequence, then all will recover, right?
> > 
> > Not really. The timeout there is supposed to come from the SCSI layer
> > in the general case.
> 
> I couldn't catch. usb_stor_msg_common() belongs to USB subsystem, doesn't it?
> 
> How does SCSI layer matter here?
> Does USB storage device shows up as if SCSI disk (e.g. /dev/sdb) relevant?

Yes.  USB storage is a very tiny wrapper around the whole SCSI protocol,
it is a SCSI disk for all all intensive purposes.

thanks,

greg k-h
