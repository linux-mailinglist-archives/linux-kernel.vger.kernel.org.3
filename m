Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647A85612AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiF3Gmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbiF3Gmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:42:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171E22F679
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 34F16CE2BCE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226C2C341CA;
        Thu, 30 Jun 2022 06:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656571350;
        bh=n8/aWzfP7FAsvJoeycNZ8swGQKCwTxKT/KxY3fF1rME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/w9h8s30n5rRj4CENTPEQ9ppa+/Y8reiGW8vKWs058A0NgwggYfxNDqtVr9SPGBb
         41c8CqRABfz1wZfEjb5eTE8mhvScJcd3SKFd/RxqEaUBPQ5gVrBJqEoVWlG8gumBt8
         oexpmWmYP0VHV4UTVzVIxhLINjw9KN1TY6liANjY=
Date:   Thu, 30 Jun 2022 08:42:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Vipin Sharma <vipinsh@google.com>, rkovhaev@gmail.com,
        zackary.liu.pro@gmail.com, ripxorip@gmail.com,
        masahiroy@kernel.org, xujialu@vimux.org,
        "drjones@redhat.com" <drjones@redhat.com>, dmatlack@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/tags.sh: Include tools directory in tags
 generation
Message-ID: <Yr1F0xKlrFsuJWWA@kroah.com>
References: <20220618005457.2379324-1-vipinsh@google.com>
 <CAHVum0euKMV+rCLXMQ4NuDAqowyeCkO1LheSafR2tm=R4aUfJw@mail.gmail.com>
 <YrqaKpdVDl8DBl4g@kroah.com>
 <CAHVum0f=_7kh_OrOqiTH=UZuvr3ZbxNcZeUSbT66x5r0q2XEgQ@mail.gmail.com>
 <b1b5666a-67a7-469c-d6c7-e585cf59c632@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b5666a-67a7-469c-d6c7-e585cf59c632@collabora.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 01:54:00AM +0300, Cristian Ciocaltea wrote:
> 
> On 6/30/22 01:18, Vipin Sharma wrote:
> > On Mon, Jun 27, 2022 at 11:05 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > 
> > > On Mon, Jun 27, 2022 at 10:47:35AM -0700, Vipin Sharma wrote:
> > > > On Fri, Jun 17, 2022 at 5:55 PM Vipin Sharma <vipinsh@google.com> wrote:
> > > > > 
> > > > > Add tools directory in generating tags and quiet the "No such file or
> > > > > directory" warnings.
> > > > > 
> > > > > It reverts the changes introduced in commit 162343a876f1
> > > > > ("scripts/tags.sh: exclude tools directory from tags generation") while
> > > > > maintainig the original intent of the patch to get rid of the warnings.
> > > > > This allows the root level cscope files to include tools source code
> > > > > besides kernel and a single place to browse the code for both.
> > > > > 
> > > > > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > > > > ---
> > > > > 
> > > > > I have found myself many times to browse tools and other part of the
> > > > > kernel code together. Excluding tools from the root level cscope makes
> > > > > it difficult to efficiently move between files and find user api
> > > > > definitions.
> > > > > 
> > > > > Root cause of these warning is due to generated .cmd files which use
> > > > > relative paths in some files, I am not sure how to make them absolute
> > > > > file paths which can satisfy realpath warnings. Also, not sure if those
> > > > > warnings are helpful and should be kept. Passing "-q" to realpath seems
> > > > > easier solution. Please, let me know if there is a better alternative.
> > > > > 
> > > > > Thanks
> > > > > 
> > > > >   scripts/tags.sh | 9 +--------
> > > > >   1 file changed, 1 insertion(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/scripts/tags.sh b/scripts/tags.sh
> > > > > index 01fab3d4f90b5..e137cf15aae9d 100755
> > > > > --- a/scripts/tags.sh
> > > > > +++ b/scripts/tags.sh
> > > > > @@ -25,13 +25,6 @@ else
> > > > >          tree=${srctree}/
> > > > >   fi
> > > > > 
> > > > > -# ignore userspace tools
> > > > > -if [ -n "$COMPILED_SOURCE" ]; then
> > > > > -       ignore="$ignore ( -path ./tools ) -prune -o"
> > > > > -else
> > > > > -       ignore="$ignore ( -path ${tree}tools ) -prune -o"
> > > > > -fi
> > > > > -
> > > > >   # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
> > > > >   if [ "${ALLSOURCE_ARCHS}" = "" ]; then
> > > > >          ALLSOURCE_ARCHS=${SRCARCH}
> > > > > @@ -100,7 +93,7 @@ all_compiled_sources()
> > > > >                  find $ignore -name "*.cmd" -exec \
> > > > >                          grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
> > > > >                  awk '!a[$0]++'
> > > > > -       } | xargs realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
> > > > > +       } | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
> > > > >          sort -u
> > > > >   }
> > > > > 
> > > > > --
> > > > > 2.37.0.rc0.104.g0611611a94-goog
> > > > > 
> > > > 
> > > > Hi Greg,
> > > > 
> > > > Any update on the patch?
> > > 
> > > Nope!
> > > 
> > > I don't really think we should add back in the tools to this, as if you
> > > want to search them, then can't you just generate the needed tags for
> > > the tools directory?
> > > 
> > 
> > Some folders in the tools directory do provide cscope rules. However,
> > those tags can only be used when I open the vim in those directories.
> > For example, if I am writing a KVM selftest and I want to explore code
> > related to certain ioctl in kernel as well as some code in KVM
> > selftest library, I cannot use two cscope files (one in the kernel
> > root dir and another in tools/testing/selftests/kvm) in a single VIM
> > instance. It starts having issues with the file paths. If the root
> > level cscope file includes tools directory then all of the tags will
> > be at one place and makes it very easy to browse tools code along with
> > the rest of the kernel.
> > 
> > > But as I don't even use this script ever, it feels odd for me to be the
> > > one "owning" it, so it would be great if others could chime in who
> > > actually use it.
> > > 
> 
> Since the tools directory has been excluded just to get rid of those
> warnings, I think there is no obvious reason to not add it back - at least
> the use case described above is perfectly valid.

So is that an "Acked-by:"?

