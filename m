Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966B0586F01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiHAQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiHAQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:49:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7C33FA00;
        Mon,  1 Aug 2022 09:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67AABB815FB;
        Mon,  1 Aug 2022 16:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D34C433C1;
        Mon,  1 Aug 2022 16:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659372590;
        bh=P883It5YVowJfcyCU/QWFfyJXtJA1AFMHQowLt1JIl4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kVjDu68O+0I2NQkzu+hMiZwq/Rq/roLiZBWQP+DrhuQCCVMZz7m295yrpmnCqPdDD
         HKoqoDHDi9icC1K2rM18BOMyyAOWRmKv0JEkvjWgn2nHmDuF/qJWW4dZYXjwGLoKvW
         KWi+/RQczHAxQ5qBVN5ZdP8s6bD9tuaigCtMkwn7U7zWayfG4NaeVilVtGgYWQ9FO9
         gkuK8BFwWuusyMEhunjO6PuP5N+ymbUkqZXlNcysI1kecFT6UlVRjqA3fEkv02AEiX
         54HGVIbGE1WEomtwn0UVaAGTAr6F6o4rwUejc97muQeBlYpXr+JnKw33tqze8UzmAY
         gbDhtr3Q4CLBg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ef5380669cso115110187b3.9;
        Mon, 01 Aug 2022 09:49:50 -0700 (PDT)
X-Gm-Message-State: ACgBeo1YicYIGMh4KumL7jrENsf+k3Yp3ojSQsELPZj6WetDMbcK8Aa2
        +n91R+Z/oNafjnFXRzFxWATvC+Es64KDJ638USE=
X-Google-Smtp-Source: AA6agR6T41AREGnMmu8ZDNtERtiRRL9ZxRMHB7myyN8yb1s3Xn3/FURZIUL0z80R+NcAVL0C4QVTbE/7WUfFuvkY+Es=
X-Received: by 2002:a0d:d890:0:b0:31f:3957:2f49 with SMTP id
 a138-20020a0dd890000000b0031f39572f49mr14643173ywe.130.1659372589204; Mon, 01
 Aug 2022 09:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220727210600.120221-1-logang@deltatee.com> <20220727210600.120221-2-logang@deltatee.com>
 <YuKZmloAcZWY5of8@infradead.org> <CAPhsuW4jtiuNPzC2aK-Jo80X15AWdYi7HQ2n7YWqVP6Uux3hYg@mail.gmail.com>
 <215E9FEF-69F9-44AB-A5B0-FD3C8335E985@deltatee.com>
In-Reply-To: <215E9FEF-69F9-44AB-A5B0-FD3C8335E985@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 1 Aug 2022 09:49:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4r2nz3Q62Q9CpouHmy2JNwgJZsn=ZHT3q82DE6ddhXtA@mail.gmail.com>
Message-ID: <CAPhsuW4r2nz3Q62Q9CpouHmy2JNwgJZsn=ZHT3q82DE6ddhXtA@mail.gmail.com>
Subject: Re: [PATCH 1/5] md/raid5: Refactor raid5_get_active_stripe()
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 4:48 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On July 29, 2022 7:48:48 PM ADT, Song Liu <song@kernel.org> wrote:
> >On Thu, Jul 28, 2022 at 7:13 AM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> On Wed, Jul 27, 2022 at 03:05:56PM -0600, Logan Gunthorpe wrote:
> >> > Refactor the raid5_get_active_stripe() to read more linearly in
> >> > the order it's typically executed.
> >> >
> >> > The init_stripe() call is called if a free stripe is found and the
> >> > function is exited early which removes a lot of if (sh) checks and
> >> > unindents the following code.
> >> >
> >> > Remove the while loop in favour of the 'goto retry' pattern, which
> >> > reduces indentation further. And use a 'goto wait_for_stripe' instead
> >> > of an additional indent seeing it is the unusual path and this makes
> >> > the code easier to read.
> >> >
> >> > No functional changes intended. Will make subsequent changes
> >> > in patches easier to understand.
> >>
> >> I find the new loop even more confusing than the old one.  I'd go
> >> with something like the version below (on top of the whol md-next tree
> >> that pulled this in way too fast..)
> >
> >This looks good to me. Christoph, would you mind send official patch
> >for this?
> >
> >Thanks,
> >Song
>
> I'm on vacation this week, but I'd be happy to send patches addressing Christoph's feedback when I'm back next week.

We are in the merge window right now. So the timing is a little tricky. I will
try to send pull requests with this set as-is. Then we can do follow-ups.

Thanks,
Song
