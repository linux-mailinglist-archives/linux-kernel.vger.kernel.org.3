Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD77052C1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiERSEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiERSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:04:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F6617B845
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DC38617AD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 18:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E90C385A9;
        Wed, 18 May 2022 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652897070;
        bh=WgouBQbqLvRYIiDEBmX7GonuTuvke3EKEAJwjoD1z7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRY8v8BQgQ+fFlpAlT6dhPVrxS3tazMgc3P2Fp+AAgph5Seun637xPoHQ+QRzYHMN
         /vsbi29VNxroevsGxuAsGAAHMqvwaWn5TbkJp/q4DQUsEgGkfC80fRcEmVUH0xDuzv
         L+EpVqMmuDZHx/ETDm0bnmnkCB4Nb5aI7oWRBjx1/rV5iH9IDNHrxESl0joId5Ku0g
         scWjKsFMnl/7HXKz3SFZY5nf5KOssClhlZoRuASqkjskkwH+yvfQYHcL90NDt7k1EI
         qLhm/is0IPL7mbI5OPLygxN81Co2w+10a/rd7lHeOOrugixcRZHeDgj2/GElPyDyXW
         /QNygaJxfI3Fw==
Date:   Wed, 18 May 2022 11:04:28 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: objtool "no non-local symbols" error with tip of tree LLVM
Message-ID: <20220518180428.6yxf6tcqvzdvtfxb@treble>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
 <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
 <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
 <20220518012429.4zqzarvwsraxivux@treble>
 <YoSEXii2v0ob/8db@hirez.programming.kicks-ass.net>
 <20220518161725.2bkzavre2bg4xu72@treble>
 <20220518172513.GH10117@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220518172513.GH10117@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 07:25:13PM +0200, Peter Zijlstra wrote:
> So while writing the global symbol can always use the new data section,
> writing the new symbol can need arbitrary iteration of the data blocks.
> 
> Something somewhat similar is when there's no global symbols, then the
> new symbol needs to go in the new data block instead of the old.
> 
> So it all became a tangled mess and I ended up with the one generic
> function that could do it all (which is both simpler and less code than
> trying to deal with all the weird cases).

Makes sense, and matches my post-bike-ride insights.  Thanks :-)

-- 
Josh
