Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013BA53303B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbiEXSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbiEXSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CBF9CF01
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5EA2614E0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D58FC34100;
        Tue, 24 May 2022 18:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653415978;
        bh=KKmMzhfMf2IUd80WmWmo3TqKi63TjvQ6ruuivE274NE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKhfeDp24SV7L2MG5nT3JiaoEWk7MC6y/f25RRCQNNA885YCRwhNSQOAK1HuTXtMW
         x0gruMGOJwK1JtKvfnjDrCJ/LP6hd6kgiXO5VJZFMdP6L6i/+oPA4Ng6Cs+IWDUvqJ
         CLVizSwmt5oIdFUAsr/HuShZ5fOeRIxjBqfneZLqcDuOFcRkK5COjRxxL7jBda/+1N
         /XCx46wQhIhZYtXatGNW4c7JWCgsBTRIxygEoM6vfYnbN68D2viVOqshKshd5o4Hjv
         5bBJcgS/QTh3RCLrQrR5Xtxafl3bR1M98AllZHWSE62zLXaBTGnKNf1cxd1BJDXcUL
         B5Mn4Vast99tA==
Received: by pali.im (Postfix)
        id 37C6F9ED; Tue, 24 May 2022 20:12:55 +0200 (CEST)
Date:   Tue, 24 May 2022 20:12:55 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220524181255.bmszzxmbwzv7zed7@pali>
References: <20220524093939.30927-1-pali@kernel.org>
 <20220524175955.GI25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524175955.GI25951@gate.crashing.org>
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

On Tuesday 24 May 2022 12:59:55 Segher Boessenkool wrote:
> Hi!
> 
> On Tue, May 24, 2022 at 11:39:39AM +0200, Pali Rohár wrote:
> > gcc e500 compiler does not support -mcpu=powerpc option. When it is
> > specified then gcc throws compile error:
> > 
> >   gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
> >   gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
> 
> What?  Are you using some modified version of GCC, perhaps?

Hello! I'm using official gcc version, no special modification.

> No version of GCC that isn't hamstrung can have this output.

gcc for e500 cores has really this output when you pass -mcpu=powerpc.

Upstream gcc dropped support for e500 cores during development of
version 9. But you can still compile and install gcc 8.5.0 (last version
of gcc 8) which has this full e500 support.

Really, you can easily try it. Debian 10 (Buster) has gcc 8.3.0 in its
default installation and also provides packages with cross compilers.
Just run 'sudo apt install gcc-powerpc-linux-gnuspe' on desktop amd64
version of Debian 10, it will install e500 cross compiler.

-mcpu=8540 specify e500v1 and -mcpu=8548 specify e500v2
