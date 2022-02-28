Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A374C7B36
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiB1U7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiB1U7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:59:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2469369F5;
        Mon, 28 Feb 2022 12:59:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 601AAB8165B;
        Mon, 28 Feb 2022 20:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DB6C340F1;
        Mon, 28 Feb 2022 20:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646081951;
        bh=9DFC8+ejskEuUZnsxASmagFdYxR7Vh6yUJxTxyJU0xE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tzy0WmcNphDKxKnlaRvvOyPdgQBhuO0l/KoeJ7U6GP4aZf9Mh4WP7YcIkQdI9MFzh
         49Z4FcShoqj5QXNuByQCBzPR3Zt9GN8p404dvaCWnNY4HP44O8BVnjQ40n5gYrBcrb
         WGe87xcp5dnQgIp90N36AsWlRfaCX5S6k4mhnq9U=
Date:   Mon, 28 Feb 2022 21:59:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <Yh03nCTcDGqReEGs@kroah.com>
References: <CACsaVZ+mt3CfdXV0_yJh7d50tRcGcRZ12j3n6-hoX2cz3+njsg@mail.gmail.com>
 <20220219210354.GF59715@dread.disaster.area>
 <CACsaVZ+LZUebtsGuiKhNV_No8fNLTv5kJywFKOigieB1cZcKUw@mail.gmail.com>
 <YhN76/ONC9qgIKQc@silpixa00400314>
 <CACsaVZJFane88cXxG_E1VkcMcJm8YVN+GDqQ2+tRYNpCf+m8zA@mail.gmail.com>
 <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
 <Yh0y75aegqS4jIP7@silpixa00400314>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh0y75aegqS4jIP7@silpixa00400314>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 08:39:11PM +0000, Giovanni Cabiddu wrote:
> On Mon, Feb 28, 2022 at 11:25:49AM -0800, Linus Torvalds wrote:
> > On Mon, Feb 28, 2022 at 12:18 AM Kyle Sanderson <kyle.leet@gmail.com> wrote:
> > >
> > > Makes sense - this kernel driver has been destroying users for many
> > > years. I'm disappointed that this critical bricking failure isn't
> > > searchable for others.
> > 
> > It does sound like we should just disable that driver entirely until
> > it is fixed.
> > 
> > Or at least the configuration that can cause problems, if there is
> > some particular sub-case.
> The dm-crypt + QAT use-case is already disabled since kernel 5.10 due to
> a different issue.
> Is it an option to port those patches to stable till I provide a fix for
> the driver? I drafted already few alternatives for the fix and I am aiming
> for a final set by end of week.

If the existing situation is broken, yes, those patches are fine for
stable releases.

thanks,

greg k-h
