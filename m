Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CFE5331A7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiEXTQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbiEXTQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891321AF3A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24B5561689
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65363C34100;
        Tue, 24 May 2022 19:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653419773;
        bh=06nCL2c2PiPt0PsecxZ31pddqC8bXfmheV3FL2D5PZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwfihDtiDV3fR7kLlkAmf7p9cSuWJs6bQaulxfTe0csocglVq71KIqPMSbIkEOeU5
         uv+PPNPD4f4dOjDUlb8lPPGskjl6zLYZEMubyzZtiCs9xr/lzoXkT7QQkXwcFu/36W
         lR8ZIfsELXwakoqLHqKMulTjpZGDU/ZrTN+FuLT4MMy6CR1d+ZbPiDtkYl2trQxYbB
         oVO4Kh+bT+EUwc1pPjrhQhqwe5R1Ep3a/BnADZSDg1WjxAL0tYHBxOsfC8zVRmXaK1
         MIrkOO4UEG4gLTu8T+87ey7fZmErcaxoJkpfYwPzMiz38Y2So9fTHzYBJACftpnYBl
         APB5tj9C1fThw==
Received: by pali.im (Postfix)
        id 9498C9ED; Tue, 24 May 2022 21:16:10 +0200 (CEST)
Date:   Tue, 24 May 2022 21:16:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220524191610.hnodzz2j7mlgthey@pali>
References: <20220524093939.30927-1-pali@kernel.org>
 <20220524175955.GI25951@gate.crashing.org>
 <20220524181255.bmszzxmbwzv7zed7@pali>
 <20220524185247.GK25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524185247.GK25951@gate.crashing.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 May 2022 13:52:47 Segher Boessenkool wrote:
> On Tue, May 24, 2022 at 08:12:55PM +0200, Pali Rohár wrote:
> > On Tuesday 24 May 2022 12:59:55 Segher Boessenkool wrote:
> > > On Tue, May 24, 2022 at 11:39:39AM +0200, Pali Rohár wrote:
> > > > gcc e500 compiler does not support -mcpu=powerpc option. When it is
> > > > specified then gcc throws compile error:
> > > > 
> > > >   gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
> > > >   gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
> > > 
> > > What?  Are you using some modified version of GCC, perhaps?
> > 
> > Hello! I'm using official gcc version, no special modification.
> > 
> > > No version of GCC that isn't hamstrung can have this output.
> > 
> > gcc for e500 cores has really this output when you pass -mcpu=powerpc.
> > 
> > Upstream gcc dropped support for e500 cores during development of
> > version 9.
> 
> This isn't true.  The SPE instruction extension is no longer supported
> (because it wasn't maintained).  Everything else still works.
>
> > But you can still compile and install gcc 8.5.0 (last version
> > of gcc 8) which has this full e500 support.
> > 
> > Really, you can easily try it. Debian 10 (Buster) has gcc 8.3.0 in its
> > default installation and also provides packages with cross compilers.
> > Just run 'sudo apt install gcc-powerpc-linux-gnuspe' on desktop amd64
> > version of Debian 10, it will install e500 cross compiler.
> > 
> > -mcpu=8540 specify e500v1 and -mcpu=8548 specify e500v2
> 
> Aha.  Right, because this config forces -mspe it requires one of these
> CPUs.
> 
> You can use a powerpc-linux compiler instead, and everything will just
> work.  These CPUs are still supported, in all of GCC 9 .. GCC 12 :-)
> 
> 
> Segher

Ok. I can use different "generic" powerpc compiler (It should work fine
as you said, as it has also -mcpu=8540 option). But I think that
compilation of kernel should be supported also by that gcc 8.5.0 e500
compiler.

It is really annoying if for compiling kernel is needed different
compiler than for compiling rest of the system (userspace and
bootloader). And for user applications it should be really used e500
SPE-capable compiler due to performance reasons.
