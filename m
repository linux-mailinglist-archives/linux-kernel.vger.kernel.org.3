Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A7531E22
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiEWVox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiEWVop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:44:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEFBD5E;
        Mon, 23 May 2022 14:44:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653342283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nxgVXilPvGv5Ur4KZ/tA/GNYYCdYt1Yn3s1uc6YEbqk=;
        b=nbcRQ3tNutokS0GPtDC5vVXNWdbB0DViz4NQZETExW9xKhmYEK4VVN4dqwY544jEgVly3q
        LMolciIGiGhpeP/Wc1nVc/i84lSUPnNWcZY/ypc1bqrO7XO28xjtY6UWunIu4EkTpQhrtJ
        NnPtXeG9q+TEDBbL02I2RLQE6kDuzLdZMbjV2yt7w2yPjKNcp6e9cuvN8fuFj2DwSMtz+p
        bNXtxu3+qEq7MnmXv4o35nf1Epgy+swt2oA0s/rieEaJq4iT9WWgfAIhhkZ0/u5BpZ9AJB
        YvcLLlMe+OcWpCh8aNMzL0Xsxyp03cwIyRUCwjpGvQb1XopRnmiC2zSfhOM/Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653342283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nxgVXilPvGv5Ur4KZ/tA/GNYYCdYt1Yn3s1uc6YEbqk=;
        b=7R4pFFYXUqq4lTX80SwjoCLmA6Llcc8UbK8uV+WywIygHUKWyGx/PcDpSGbfutH23DT1oF
        /prpR3J/iiGbJtBQ==
To:     J Lovejoy <opensource@jilayne.com>, Max Mehl <max.mehl@fsfe.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-spdx@vger.kernel.org
Subject: Re: [patch 0/9] scripts/spdxcheck: Better statistics and exclude
 handling
In-Reply-To: <97d8beb2-db33-1e50-eadb-6ac8d650f044@jilayne.com>
References: <20220516101901.475557433@linutronix.de>
 <1652706350.kh41opdwg4.2220@fsfe.org> <87zgjhpawr.ffs@tglx>
 <87wnelpam3.ffs@tglx> <1652775347.3cr9dmk5qv.2220@fsfe.org>
 <8735h7ltre.ffs@tglx> <97d8beb2-db33-1e50-eadb-6ac8d650f044@jilayne.com>
Date:   Mon, 23 May 2022 23:44:42 +0200
Message-ID: <878rqr2ab9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23 2022 at 10:11, J. Lovejoy wrote:
> On 5/17/22 3:43 PM, Thomas Gleixner wrote:
> I think the discussion here is hitting upon the "inconvenience" of the 
> lack of black/white rules in the law (as to what is copyrightable) 
> versus the convenience of downstream recipients of code who want to be 
> sure they have proper rights (which mixes in the guidance/rules of 
> Reuse, tooling, etc.).

Correct.

> I think some rules in terms of files that are clearly not copyrightable 
> can be implemented in various tooling (hopefully, with the guidance of a 
> lawyer steeped in copyright law), and I agree that putting a license (by 
> way of an SPDX identifier or any other way for that matter) on such 
> files is neither a good use of time nor a good idea (from the 
> perspective of being inaccurate as to the need for a license and thus 
> sending the wrong impression). That being said, there will not be a way 
> to make clear cut rules for everything, without involving a judge. 
> Sorry! That's just how the law works (and we actually often don't want 
> black/white lines in the law, actually).
>
> I can see a policy of, "when it's not clear (as to copyrightability), 
> then add a license", though.

No argument here, but trivial things like an include which file includes
another include file are pretty clear IMO and we really should make our
mind up on those. Even a header file which contains a single function
declaration is questionable at best, but yes it's hard to put a hard
line on those.

Thanks,

        tglx
