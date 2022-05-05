Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6542751CADF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385452AbiEEVHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiEEVHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1138D5DE5C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 14:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A064461EFA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 21:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C756DC385A4;
        Thu,  5 May 2022 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651784613;
        bh=JaZNcdOZ4SMQrsVEg6zw8opQg7AkFGaMyN5Aqvk60qI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KThFvShSluYM2Zk52rOfGeTBoJz7wnHjVoqDlXbPDUPPPOmYb5fe38ZYCtcvcjNxg
         IMZB+cwa673BX7CZc9BTkoFAw9kzODQbJrixNRh+KFDE/BygjmqQFUDHM9lm3yQuui
         bzADBuALnPDDQPhapDqljQmrOiht7yU6n96FAMNxy9W6G5CljogOz4h0CzJoGm4h/C
         gy63l8LDx0q7yk6HnDrWRp7Tof93A1EvN2W5cVMpQTkugNH7FeeqCZ+WbNA5PvQflY
         8dNud1qruX7drF9znw8ffffRLoOXB3hnWtBABA6i7g9Nm4JENtT3ROHlynm3lWNykj
         onvlVDz6/dtGw==
Date:   Thu, 5 May 2022 14:03:30 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix SLS checks
Message-ID: <20220505210330.flb36r4emty2js3y@treble>
References: <Ym0UWja2L40QbgEc@hirez.programming.kicks-ass.net>
 <20220502181547.fzz2yre2p4akph4s@treble>
 <YnA8Yw19AQV28w54@hirez.programming.kicks-ass.net>
 <20220503211510.ytdv5l4l2zwjdwg7@treble>
 <YnIqt4aOooAvlja4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnIqt4aOooAvlja4@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 09:26:47AM +0200, Peter Zijlstra wrote:
> > I don't quite follow this 2nd sentence and how it's related here, since
> > this function doesn't actually deal with direct jumps.
> 
> Ah, my bad. Also, this wrong.
> 
> I suppose this wants to be something like:
> 
> 	if (i < insn->length && op == JMP32_INSN_OPCODE)
> 		bytes[i++] = INT3_INSN_OPCODE;
> 
> So this *can* be a jump, but typically won't be I suppose.

Yep.

> > Speaking of, I guess we'll eventually need to hack this SLS mess into
> > jump labels :-/
> 
> Urgh... can't we reason that the straight line case is actually expected
> to run with the given register state anyway and ignore this?

Yeah, that makes sense.

So for jump labels the SLS path would probably not be worse than a
typical v1-style conditional branch misspeculation into the 'else' path,
and we've already given up on worrying about those anyway.

-- 
Josh
