Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F85587E36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbiHBOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiHBOgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:36:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D7215704;
        Tue,  2 Aug 2022 07:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D66BEB81F38;
        Tue,  2 Aug 2022 14:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F34C43470;
        Tue,  2 Aug 2022 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659450988;
        bh=+PJ10EgQjsPT7oxrxxYmU/pdwHPBRJXP/f0aFyyVyCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYRkGnkk7ynHJXIZFQNM2lzIiYDPvGvdardxlgv3WKP3YjAqplJP37mAp0Er0wzyU
         +wRwq7q3iMcx63hti66TQjI5tRc9OUyo/KMpUGYUcIBOJ7gBIzd7xm9eyI1H5g0mOj
         DFr1Y1gO3rGXxJnsArwmoO64yJh/a+kBiJ1h108I=
Date:   Tue, 2 Aug 2022 16:36:25 +0200
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
Message-ID: <Yuk2aSxydi37eRXq@kroah.com>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-18-ojeda@kernel.org>
 <Yukn3vNJ8iGuXgiz@kroah.com>
 <CANiq72kzoVcMNeJgDc+rQ_0S+5u2RB9UkCx-SZUAxm=Km=gjrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kzoVcMNeJgDc+rQ_0S+5u2RB9UkCx-SZUAxm=Km=gjrQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 04:33:17PM +0200, Miguel Ojeda wrote:
> Hi Greg,
> 
> On Tue, Aug 2, 2022 at 3:34 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is huge for a single commit, and pretty much impossible to review
> > as-is.
> >
> > Any chance you can turn this into a series of commits, that starts with
> > the basics and builds on top of that?  Right now you are mixing many
> > many different subsystems all at once into one commit, guaranteeing that
> > no one can review the whole thing properly :(
> 
> Yeah, of course, I am happy to do that -- I did it for the `sync`
> module, but stopped splitting further since I understood you wanted it
> this way from what you told me on February.

I did?  Maybe I didn't realize we would end up with 15k lines of code
from different parts of the kernel like amba bus and filesystem apis all
in a single commit.  If so, my fault, but as other parts of this
discussion show, it is going to be required to get the subsystem
maintainers to be able to review the interfaces to their code in order
to get any further.

thanks,

greg k-h
