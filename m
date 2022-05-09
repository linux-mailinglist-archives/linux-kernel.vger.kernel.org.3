Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4BC520273
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiEIQdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbiEIQcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:32:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8927924DC5B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 104AC6147C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2068AC385AC;
        Mon,  9 May 2022 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652113737;
        bh=Kpy2f9+84wfDHOQehgRjqLoGX7mLUkGG/CxrJ6fKsng=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Xd4kHP06aDcsQFAOx7eosfyNKwKscjUOfgLzYrVaWeFY3MnoMFZv5vOYlLfPcuhVE
         nAQNrfxjvQ9f5JskUgs7ugPf4r2MnlPN/V6b70579GgvEaiLp5iM3izxjsr7rCVdCG
         t6/OMhTpr3fpAiIYCUzoRw2Of6D2+vGW3D0lL334=
Date:   Mon, 9 May 2022 18:28:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCHv2] speakup: Generate speakupmap.h automatically
Message-ID: <YnlBRt1rAMPKWeYJ@kroah.com>
References: <20220430003934.fkua7vwoz6heigrp@begin>
 <20220430073321.6b4lvrrt7buzh7dp@begin>
 <YnkfeyobcOOgDGkH@kroah.com>
 <20220509140705.n3eei4r5ko6bbex4@begin>
 <Ynki154mxF+2L8WH@kroah.com>
 <20220509142642.gsi5cppgadc2gojy@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509142642.gsi5cppgadc2gojy@begin>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:26:42PM +0200, Samuel Thibault wrote:
> Greg KH, le lun. 09 mai 2022 16:19:03 +0200, a ecrit:
> > On Mon, May 09, 2022 at 04:07:05PM +0200, Samuel Thibault wrote:
> > > Greg KH, le lun. 09 mai 2022 16:04:43 +0200, a ecrit:
> > > > Any reason you can't add the code in utils.c into genmap.c and then
> > > > merge into makemapdata.c to make this a single .c file that does both
> > > > things?
> > > 
> > > Yes: genmap is a tool that end-users can use without needing the Linux
> > > source code, while makemapdata needs it.
> > 
> > But who will run genmap?
> 
> I guess you meant makemapdata?
> 
> Long-term-wise this patchset will need a bit of work to properly install
> the genmap tool so the user can call it.  I'm here mostly making sure
> to put into the Linux kernel how speakupmap.h is generated (rather
> than the currently very magic file), while at the same time keeping
> the separation between makemapdata and genmap that will make sense
> longterm-wise.

Ok, then it's ok to leave it as is.  But the build stuff still needs to
get resolved :)
