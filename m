Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35817555562
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 22:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiFVU1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFVU1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 16:27:02 -0400
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jun 2022 13:26:59 PDT
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8595369E6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:26:59 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 981EE72C8B1;
        Wed, 22 Jun 2022 23:19:02 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7AB604A474C;
        Wed, 22 Jun 2022 23:19:02 +0300 (MSK)
Date:   Wed, 22 Jun 2022 23:19:02 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Mikhail Gordeev <obirvalger@altlinux.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/1 FYI] perf trace beauty: Fix generation of errno
 id->str table on ALT Linux
Message-ID: <20220622201902.j5owuabe4nwpi3jm@altlinux.org>
References: <YrNCLzNGsvizMhdW@kernel.org>
 <20220622191308.GA2045@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220622191308.GA2045@altlinux.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry, Arnaldo,

On Wed, Jun 22, 2022 at 10:13:09PM +0300, Dmitry V. Levin wrote:
> Hi,
> 
> On Wed, Jun 22, 2022 at 01:24:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > Fyi, I'm carrying this on my perf tools tree to keep building on:
> > 
> > [perfbuilder@five sisyphus]$ podman pull alt:sisyphus
> > Trying to pull docker.io/library/alt:sisyphus...
> > Getting image source signatures
> > Copying blob 2b39ef1520dd skipped: already exists
> > Copying blob 12717fd4baa0 skipped: already exists
> > Copying config 6d48f46445 done
> > Writing manifest to image destination
> > Storing signatures
> > 6d48f4644518cd96ffe1de6cd0333d2abc8312c0e4449e03b58b1d480f0f5905
> > [perfbuilder@five sisyphus]$ dsh .
> > sh-4.4# bash
> > [root@b8318c77142b /]# cat /etc/os-release
> > NAME="starter kit"
> > VERSION="p10 (Hypericum)"
> > ID=altlinux
> > VERSION_ID=p10
> > PRETTY_NAME="ALT Starterkit (Hypericum)"
> > ANSI_COLOR="1;33"
> > CPE_NAME="cpe:/o:alt:starterkit:p10"
> > HOME_URL="http://en.altlinux.org/starterkits"
> > BUG_REPORT_URL="https://bugs.altlinux.org/"
> > [root@b8318c77142b /]# rpm -qi bash
> > Name        : bash
> > Version     : 4.4.23
> > Release     : alt1
> > DistTag     : sisyphus+221902.500.4.1
> > Architecture: noarch
> > Install Date: Fri Jun  3 23:03:32 2022
> > Group       : Shells
> > Size        : 0
> > License     : None
> > Signature   : DSA/SHA1, Tue Feb 19 14:40:44 2019, Key ID 95c584d5ae4ae412
> > Source RPM  : bash-defaults-4.4.23-alt1.src.rpm
> > Build Date  : Tue Feb 19 14:40:42 2019
> > Build Host  : ldv-sisyphus.hasher.altlinux.org
> > Relocations : (not relocatable)
> > Packager    : Dmitry V. Levin <ldv@altlinux.org>
> > Vendor      : ALT Linux Team
> > Summary     : The GNU Bourne Again SHell (/bin/bash)
> > Description :
> > This package provides default setup for the GNU Bourne Again SHell (/bin/bash).
> > [root@b8318c77142b /]#
> > 
> > Perf uses that script to generate an id->str errno table for all arches,
> > implemented in:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0337cf74ccf2a43437bff2e23b278e4f2dc4c6e2
> > 
> > But it is failing on:
> > 
> >   10    62.99 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
> >   11    91.50 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
> >   12    89.80 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
> >   13     8.99 alt:sisyphus                  : FAIL gcc version 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) (GCC)
> >         |         ^~~~
> >     442 |         case 47: return "EL3RST";
> >         |         ^~~~
> >     443 |         case 48: return "ELNRNG";
> > 
> > The generated file lacks the function start/end due to some strange
> > glitch:
> > 
> > http://vger.kernel.org/~acme/perf/generated-altlinux-sisyphus-arch_errno_name_array.c
> > 
> > So I'm adding this workaround, can you please check why this is
> > happening?
> 
> arch_errno_names.sh uses here-documents which are implemented in bash
> using temporary files.  Looks like it couldn't create a temporary file,
> e.g. because $TMPDIR points to a directory that doesn't exist or not
> writable.  If there was some "cannot create temp file for here-document"
> diagnostics in stderr, that's it.  If that's the case, it's not a problem
> in the script but in the environment.
> 
> I've Cc'ed more people, maybe they could have a look.

I cannot reproduce this, from Fedora 35 (Cloud Edition) virtual machine in QEMU[1],
then using:

  # podman run --security-opt label=disable -it -v $PWD/linux:/linux alt:sisyphus

Where linux is v5.19-rc3-48-gde5c208d533a, then apt-get update & install gcc, then:

  [root@3b364fe4fc22 linux]# tools/perf/trace/beauty/arch_errno_names.sh gcc tools/ | head
  /* SPDX-License-Identifier: GPL-2.0 */

  #include <string.h>

  static const char *errno_to_name__generic(int err)
  {
	  switch (err) {
	  case 1: return "EPERM";
	  case 2: return "ENOENT";
	  case 3: return "ESRCH";
	  case 4: return "EINTR";
	  case 5: return "EIO";

Thanks,

[1] https://github.com/Obirvalger/vml

> 
> 
> -- 
> ldv
