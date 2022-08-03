Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA95887F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiHCHaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiHCHal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:30:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5E6453;
        Wed,  3 Aug 2022 00:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9D27B82160;
        Wed,  3 Aug 2022 07:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C46C433D6;
        Wed,  3 Aug 2022 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659511836;
        bh=ZOVE5U7SmeP3Je9gS9zhmhPnptosHiQ0OmhkTlqr8cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpHEdZXxPknXrXhlL/LGHuMNMPXxbWn2i+ZP7ycgBH1Fsp8iY/qJX6kYu7pcLvcu0
         HHWfUUSpMZSqAXTEIHSG9TDmJ2dTnKLwIbjV9yoKDHtxSgm55bX1sz1QbDDyzO0SG3
         dBAnb63N7pfE38X3dfLssl5W269hLyNE05tqKH+Q=
Date:   Wed, 3 Aug 2022 09:30:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Dan Robertson <daniel.robertson@starlab.io>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?iso-8859-1?B?TOlv?= Lanteri Thauvin 
        <leseulartichaut@gmail.com>, Niklas Mohrin <dev@niklasmohrin.de>,
        Gioh Kim <gurugio@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        =?iso-8859-1?Q?N=E1ndor_Istv=E1n_Kr=E1cser?= <bonifaido@gmail.com>,
        David Gow <davidgow@google.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v8 17/31] rust: add `kernel` crate
Message-ID: <YuokGYe1Htj0+D37@kroah.com>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-18-ojeda@kernel.org>
 <Yukn3vNJ8iGuXgiz@kroah.com>
 <CANiq72kzoVcMNeJgDc+rQ_0S+5u2RB9UkCx-SZUAxm=Km=gjrQ@mail.gmail.com>
 <Yuk2aSxydi37eRXq@kroah.com>
 <CANiq72=24xycLU0UU1oxn-7=Vk4hZBvZYh_RsnXFP1c5FyyxhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=24xycLU0UU1oxn-7=Vk4hZBvZYh_RsnXFP1c5FyyxhQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 04:53:17PM +0200, Miguel Ojeda wrote:
> On Tue, Aug 2, 2022 at 4:36 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > I did?  Maybe I didn't realize we would end up with 15k lines of code
> > from different parts of the kernel like amba bus and filesystem apis all
> > in a single commit.  If so, my fault, but as other parts of this
> > discussion show, it is going to be required to get the subsystem
> > maintainers to be able to review the interfaces to their code in order
> > to get any further.
> 
> No worries at all! Probably a misunderstanding on my side too.
> 
> I am more than happy to spit it into quite a few patches, and it will
> also help with the C-d-b's.
> 
> As for reviewing -- since we keep adding abstractions and new features
> to show how things may work, we would be chasing new reviews all the
> time. Would it be better to drop some of those for the moment and get
> the "core" in first?

Yes, it would be good to drop almost all of these for now, anything you
do not have an in-tree user for, should not be present in anything you
submit upstream.

> That way we can merge each subsystem part by part later, send it to
> the proper MLs as smaller patches, get maintainers on board, etc.
> etc., and it would be more manageable for everyone.

Yes, that would be the normal review process.

thanks,

greg k-h
