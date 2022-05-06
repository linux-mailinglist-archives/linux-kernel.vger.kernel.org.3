Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A7F51DBE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442824AbiEFP3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiEFP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:29:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DC68984
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F31B5621D0
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 15:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3053DC385A9;
        Fri,  6 May 2022 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651850763;
        bh=yPObXMYAtH1m+T5Wk5sN2N5msoIrkMz64KtalD501rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqcwhHHAz8MPjKWeZuQeAdE9Mf7AjfOyaf2nUOJ7tendma/QzhFAri56SFXKTjfxH
         QSZwsXtoh+Sh2WjQ2l32BUTxDnImPKqcPcyLzWFtFU1g0qjvoTrpsJn1xg2lh7V7Xk
         nuO4oIIq9nJyWzm190rCxHorVfamK0dAIinQ3u1VZ4MxE74uh272/l5jRql6qaX255
         mUnMdRL7RZ5luETXkbOJdiR2SESA5sZ0EZQ5MwraR//GFRfHgIN890o93jUhXujfOe
         qnYj4Qne6uI/MjGOzo8/O740URvoQtSNsZ29Xn1HNOJR6DdYAi/8PRmiXvorb3OBGm
         XJSXInuFRsV1g==
Date:   Fri, 6 May 2022 08:26:01 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/faddr2line: Only use text symbols to calculate
 function size
Message-ID: <20220506152601.z4f3bachnyfeqgzf@treble>
References: <2fb2bc4e857848c83cfa96483e4b25b23d46be49.1651516951.git.jpoimboe@redhat.com>
 <CAPDLWs_aOi-f801SAhA1X2YH4XE_r5P3AfPV1uhQWA10bKKffg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDLWs_aOi-f801SAhA1X2YH4XE_r5P3AfPV1uhQWA10bKKffg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 11:34:00AM +0530, Kaiwan N Billimoria wrote:
> Hi Josh,
> 
> Unfortunately, it didn't work with my test case (as before):
> $ <...>/linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x124
> bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> $
> 
> What _did_ work was the earlier (much longer) patch you'd sent (your
> email dt 20 Jan 2022),
> Could you pl recheck...
> (As before, i have the test case module here:
> https://github.com/PacktPublishing/Linux-Kernel-Debugging/tree/main/ch7/oops_tryv2

Sorry, I totally managed to forget that I rewrote the whole script:

  https://lkml.kernel.org/lkml/20220120171751.gibauc4zovoskjns@treble

IIRC, that was the one that fixed your issue.  Let me go clean that one
up...

-- 
Josh
