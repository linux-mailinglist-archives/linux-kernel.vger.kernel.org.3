Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9805B0533
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiIGNek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIGNeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:34:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC7E14D3C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A447B81CBA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE82C433B5;
        Wed,  7 Sep 2022 13:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662557672;
        bh=I4sl+EP6EIr8KxXfMp4uQHC2C2OBmBWs+1rAMJRX4M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6Ng9SiTXBsmpoMT1p29Q9PdH7X2rGPAsj8DaZdXub8ywy3lDyJ1zVck3fTvlDq+s
         OYZj3eU1YHKGHSC+tG0k77AuIX5Oakm5S+7qFInW0ojwsmJuEYzQONYKZ0TpGM3XQ1
         vs+2faJTof39ncVPaDz61SXslO4/Wls3PNLN+MvUb5j8Z/05sOSXxduQymE7pSiRkW
         V40tWlfCxLOHqhUG1Qj6Hku3h2X0JtYbzNPKV+xcCu9zdXQLcQNzMKingSgMfloPIX
         JVkSW+nAovCasfmXUFfaNqZXA6YUB2UBS0H3We6imCrgvrEO/mar5Zp6gf8DHvcwhy
         6yIQCzvL5fRkQ==
Date:   Wed, 7 Sep 2022 14:34:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] arm64: run softirqs on the per-CPU IRQ stack
Message-ID: <20220907133426.GA30248@willie-the-truck>
References: <20220815124739.15948-1-zhengqi.arch@bytedance.com>
 <595c912a-1503-d420-f32f-297b824decae@bytedance.com>
 <430e3e5f-d446-6307-cba0-6f859bce560f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <430e3e5f-d446-6307-cba0-6f859bce560f@bytedance.com>
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

On Wed, Sep 07, 2022 at 03:04:48PM +0800, Qi Zheng wrote:
> 
> 
> On 2022/8/26 12:16, Qi Zheng wrote:
> > 
> > 
> > On 2022/8/15 20:47, Qi Zheng wrote:
> > > Currently arm64 supports per-CPU IRQ stack, but softirqs
> > > are still handled in the task context.
> > > 
> > > Since any call to local_bh_enable() at any level in the task's
> > > call stack may trigger a softirq processing run, which could
> > > potentially cause a task stack overflow if the combined stack
> > > footprints exceed the stack's size, let's run these softirqs
> > > on the IRQ stack as well.
> > > 
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Will Deacon <will@kernel.org>
> > > ---
> > > v2: https://lore.kernel.org/lkml/20220802065325.39740-1-zhengqi.arch@bytedance.com/
> > > v1: https://lore.kernel.org/lkml/20220708094950.41944-1-zhengqi.arch@bytedance.com/
> > > RFC: https://lore.kernel.org/lkml/20220707110511.52129-1-zhengqi.arch@bytedance.com/
> > > 
> > > Changelog in v2 -> v3:
> > >   - rebase onto the v6.0-rc1
> 
> Hi Will,
> 
> Are we good to merge this patch? Or if there is anything else I need to
> do, please let me know. :)

I'm expecting Catalin to pick this one up for 6.1.

Will
