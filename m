Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56F055D79B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245226AbiF1GFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiF1GFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:05:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AEF2315F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 445D4B81C0A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9156AC3411D;
        Tue, 28 Jun 2022 06:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656396332;
        bh=g9rhB9H8oevN7a+b0FfHpZ1E3BFNquzA4JDUj25ke08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBV6+KiwrBFj2ENCV7xu5kuJcnwvb/8IpmcWPRPyDggALm5qgdcwZ1JiuiGldjwMI
         wt9Yy0y21aEGRVfnCDCdWTMv1iQbhn+hRaR5k9hBl9549z0RZBVjwH58cySikN1rs1
         snTWIF5tWIxDPTrW8RhzN4hvefoJa9sySrWS6nWI=
Date:   Tue, 28 Jun 2022 08:05:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     rkovhaev@gmail.com, dmatlack@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/tags.sh: Include tools directory in tags
 generation
Message-ID: <YrqaKpdVDl8DBl4g@kroah.com>
References: <20220618005457.2379324-1-vipinsh@google.com>
 <CAHVum0euKMV+rCLXMQ4NuDAqowyeCkO1LheSafR2tm=R4aUfJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0euKMV+rCLXMQ4NuDAqowyeCkO1LheSafR2tm=R4aUfJw@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:47:35AM -0700, Vipin Sharma wrote:
> On Fri, Jun 17, 2022 at 5:55 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > Add tools directory in generating tags and quiet the "No such file or
> > directory" warnings.
> >
> > It reverts the changes introduced in commit 162343a876f1
> > ("scripts/tags.sh: exclude tools directory from tags generation") while
> > maintainig the original intent of the patch to get rid of the warnings.
> > This allows the root level cscope files to include tools source code
> > besides kernel and a single place to browse the code for both.
> >
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
> >
> > I have found myself many times to browse tools and other part of the
> > kernel code together. Excluding tools from the root level cscope makes
> > it difficult to efficiently move between files and find user api
> > definitions.
> >
> > Root cause of these warning is due to generated .cmd files which use
> > relative paths in some files, I am not sure how to make them absolute
> > file paths which can satisfy realpath warnings. Also, not sure if those
> > warnings are helpful and should be kept. Passing "-q" to realpath seems
> > easier solution. Please, let me know if there is a better alternative.
> >
> > Thanks
> >
> >  scripts/tags.sh | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/scripts/tags.sh b/scripts/tags.sh
> > index 01fab3d4f90b5..e137cf15aae9d 100755
> > --- a/scripts/tags.sh
> > +++ b/scripts/tags.sh
> > @@ -25,13 +25,6 @@ else
> >         tree=${srctree}/
> >  fi
> >
> > -# ignore userspace tools
> > -if [ -n "$COMPILED_SOURCE" ]; then
> > -       ignore="$ignore ( -path ./tools ) -prune -o"
> > -else
> > -       ignore="$ignore ( -path ${tree}tools ) -prune -o"
> > -fi
> > -
> >  # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
> >  if [ "${ALLSOURCE_ARCHS}" = "" ]; then
> >         ALLSOURCE_ARCHS=${SRCARCH}
> > @@ -100,7 +93,7 @@ all_compiled_sources()
> >                 find $ignore -name "*.cmd" -exec \
> >                         grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
> >                 awk '!a[$0]++'
> > -       } | xargs realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
> > +       } | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
> >         sort -u
> >  }
> >
> > --
> > 2.37.0.rc0.104.g0611611a94-goog
> >
> 
> Hi Greg,
> 
> Any update on the patch?

Nope!

I don't really think we should add back in the tools to this, as if you
want to search them, then can't you just generate the needed tags for
the tools directory?

But as I don't even use this script ever, it feels odd for me to be the
one "owning" it, so it would be great if others could chime in who
actually use it.

thanks,

greg k-h
