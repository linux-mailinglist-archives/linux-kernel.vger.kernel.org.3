Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5585B0A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIGQme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiIGQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:42:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8D5754A0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D748B81E0A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D931AC433C1;
        Wed,  7 Sep 2022 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662568906;
        bh=EZUj/XJnYo6nJbBgT4QYvk1/OrMCmJbS3YvtDagavKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jaUndbgDpgNBkROv0iMSNm5SZ/u9/UI+Cf7W5SthTUka5rvz5c5ySj1q+8mZHhDk0
         FuVZLEf/tGN6TJNFoSIeXez0QsKwWs23l6o5a41SQhCibN2BaS2cpDtoiYZjoSy8+F
         q3Wo47JBC5khwRD7SJKle4pQvn33bJAlH4LcruhE9cGiHiI2T8Ef84nVguz9dPlyRz
         MvDKGMog1LvnodyNpBU+q24aFOQ5NeW5ncr9+hm717VX8iC+caMcsaw9nHJsF/zhg0
         mELMI4WlHpE16unwj8+Blpn0m1G8HuBvtX1baLo3//mbjps8MNQ/PyBDvIr5F/C3JU
         yBkHjGXuCNeZg==
Date:   Wed, 7 Sep 2022 17:41:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     sudeep.holla@arm.com, palmer@dabbelt.com, catalin.marinas@arm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, atishp@atishpatra.org,
        Brice.Goglin@inria.fr, gregkh@linuxfoundation.org
Subject: Re: [GIT PULL] Fix RISC-V's arch-topology reporting
Message-ID: <20220907164140.GA30683@willie-the-truck>
References: <4849490e-b362-c13a-c2e4-82acc3268a3f@microchip.com>
 <afa3b7a8-3615-36bb-4850-b7966028f74c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa3b7a8-3615-36bb-4850-b7966028f74c@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 04:39:31PM +0000, Conor.Dooley@microchip.com wrote:
> On 15/08/2022 23:14, Conor Dooley wrote:
> > Hey Will/Palmer/Sudeep,
> > 
> > Catalin suggested [0] dropping the CC: stable for the arm64 patch and
> > instead making it a specific prereq of the RISC-V patch & making a PR,
> > so here we are.. I was still up when -rc1 came out so pushed it last
> > night to get the test coverage, but LKP seems to not have reported a
> > build success since early on the 13th so not holding my horses! I built
> > it again for both ARMs and RISC-V myself.
> > 
> > I tagged it tonight, so it's on conor/linux.git as riscv-topo-on-6.0-rc1
> > with the prereq specified.
> > 
> > Not sure if you want to merge this too Sudeep or if that's up to Greg?
> 
> What's the story with this from an arm64 & topology PoV?
> Palmer merged this into riscv/for-next a couple weeks ago, so just
> wondering what the craic is on the other fronts.

If it's merged in the riscv tree, then I guess we don't need to do anything
on the arm64 side. It would be handy if it's on its own branch, however,
just in case we run into a conflict later on during the cycle.

Catalin -- this is the series we spoke about the other day touching the
topology code.

Cheers,

Will
