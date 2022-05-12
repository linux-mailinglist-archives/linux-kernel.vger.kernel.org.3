Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D97524AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352853AbiELKxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348325AbiELKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:53:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B2B5DD07;
        Thu, 12 May 2022 03:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83EA3B8265C;
        Thu, 12 May 2022 10:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0997BC385B8;
        Thu, 12 May 2022 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652352790;
        bh=e62NPVgqEhybp1OxatsTfS3ZQNH3DC4XMp+/mo1hPCc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=eN4gLCJoBG9IVTGVMQm1w6/17W64d5+eovUDht4G6EOtYHeqERHW65ltymhaHtXvm
         4tyAreKLCUZLackUqMCwOGPFGsSEsdsB9k53oZG0p9k0huog1ZiXrQjlFVA+AlZfDq
         ziMwV9frxOipMX0NUPwpVqxSe1IPhEUZwo8hRHSDRHzrSvARXjmaRcBPVgA68BXYt9
         cZF84QpGYq6qE4aTnpN81UGtgd+1EnO8pSmXo6NHSXlMZ6/JQzgI3Im5wmfJ0P7vQI
         52dBAMcMPpWHURzawazZEYV/32mzM2mew0TJ6GLUr0a4JrJu4tW2hLTwDHFLHtrQSa
         HV806O0wLcXIg==
Date:   Thu, 12 May 2022 12:53:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Pablo Ceballos <pceballos@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: Driver for Google Hangouts Meet Speakermic
In-Reply-To: <CAKdAkRQ7yxFFGJg41UxptxapKiP4bmHsfw7dRNE+LPzs1PRk=A@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2205121252090.28985@cbobk.fhfr.pm>
References: <20220405183953.2094007-1-pceballos@google.com> <nycvar.YFH.7.76.2204210947590.30217@cbobk.fhfr.pm> <CAKdAkRQ7yxFFGJg41UxptxapKiP4bmHsfw7dRNE+LPzs1PRk=A@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022, Dmitry Torokhov wrote:

> > > This driver works around a problem with the HID usage sent by this
> > > device for the mute button. It prevents key events from being generated
> > > for that HID usage since they would be incorrect.
> > >
> > > Signed-off-by: Pablo Ceballos <pceballos@google.com>
> >
> > Applied to hid.git#for-5.19/google. Thanks,
> 
> I am curious, could not this be achieved without a kernel driver by
> simply using udev to map this usage code to KEY_RESERVED?

Hmm, good point, using KEY_RESERVED mapping to achieve the key being 
actually ignored didn't immediately occur to me.

Pablo, could you please verify that it behaves in the expected way, and 
confirm that we could drop the 'driver' in favor of udev rule?

Thanks,

-- 
Jiri Kosina
SUSE Labs

