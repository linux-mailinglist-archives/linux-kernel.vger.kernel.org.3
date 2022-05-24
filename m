Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52105330C7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiEXS6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiEXS6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:58:13 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 514075B3C6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:58:12 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 24OIqnf7028066;
        Tue, 24 May 2022 13:52:49 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 24OIqmBx028065;
        Tue, 24 May 2022 13:52:48 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 24 May 2022 13:52:47 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220524185247.GK25951@gate.crashing.org>
References: <20220524093939.30927-1-pali@kernel.org> <20220524175955.GI25951@gate.crashing.org> <20220524181255.bmszzxmbwzv7zed7@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524181255.bmszzxmbwzv7zed7@pali>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 08:12:55PM +0200, Pali Rohár wrote:
> On Tuesday 24 May 2022 12:59:55 Segher Boessenkool wrote:
> > On Tue, May 24, 2022 at 11:39:39AM +0200, Pali Rohár wrote:
> > > gcc e500 compiler does not support -mcpu=powerpc option. When it is
> > > specified then gcc throws compile error:
> > > 
> > >   gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
> > >   gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
> > 
> > What?  Are you using some modified version of GCC, perhaps?
> 
> Hello! I'm using official gcc version, no special modification.
> 
> > No version of GCC that isn't hamstrung can have this output.
> 
> gcc for e500 cores has really this output when you pass -mcpu=powerpc.
> 
> Upstream gcc dropped support for e500 cores during development of
> version 9.

This isn't true.  The SPE instruction extension is no longer supported
(because it wasn't maintained).  Everything else still works.

> But you can still compile and install gcc 8.5.0 (last version
> of gcc 8) which has this full e500 support.
> 
> Really, you can easily try it. Debian 10 (Buster) has gcc 8.3.0 in its
> default installation and also provides packages with cross compilers.
> Just run 'sudo apt install gcc-powerpc-linux-gnuspe' on desktop amd64
> version of Debian 10, it will install e500 cross compiler.
> 
> -mcpu=8540 specify e500v1 and -mcpu=8548 specify e500v2

Aha.  Right, because this config forces -mspe it requires one of these
CPUs.

You can use a powerpc-linux compiler instead, and everything will just
work.  These CPUs are still supported, in all of GCC 9 .. GCC 12 :-)


Segher
