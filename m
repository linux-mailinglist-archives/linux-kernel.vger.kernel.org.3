Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5682E52BEAF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiERPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbiERPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33D91DFD89
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5642A61958
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B80C385A9;
        Wed, 18 May 2022 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652886601;
        bh=SIvbxlSGGzkgi9tVz1CdkOJ99ZWAfRB8ApyV15kUEX4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u9aDk5HhIQ3k47ScSvMLrgb6tbQ8Hoqhs5CpqaQoAz0V4nc/sU//r1N0F8wF2Zna7
         FkURu8/kROwW5SGQ+y0WudFSMKiCMf3iQ5WjTKiZQjrFq40wHsaObsZ/XZg7wYFwRd
         8Sy39KgSwbBvZ9PHHox+qDtgfxROf3tFZdf4fBqG70mmMj2jbB0IIGiRgJLQnfcA0m
         r3RvGM/cKdAff0SESwBN2Lgs7BDq8pQhFlc4IsXFDcQHaXeQlQAttAJfnSe1+7qPjc
         UiKb6GmlQjNpH2AKiqNYNo1Uuqq82Vrq6dYpu/R5xbcCYreq6kh9hiPgxKwZDBp+Y2
         hczqQ/QYUGitA==
Message-ID: <372364b33b8d4b93908c3822e18f7d295de2ede9.camel@kernel.org>
Subject: Re: [PATCH 20/21] context_tracking: Convert state to atomic_t
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 18 May 2022 17:09:55 +0200
In-Reply-To: <20220503100051.2799723-21-frederic@kernel.org>
References: <20220503100051.2799723-1-frederic@kernel.org>
         <20220503100051.2799723-21-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 12:00 +0200, Frederic Weisbecker wrote:

[...]

> +/**
> + * ct_state() - return the current context tracking state if known
> + *
> + * Returns the current cpu's context tracking state if context tracking
> + * is enabled.  If context tracking is disabled, returns
> + * CONTEXT_DISABLED.  This should be used primarily for debugging.
> + */
> +static __always_inline int ct_state(void)
> +{
> +	int ret;
> +
> +	if (!context_tracking_enabled())
> +		return CONTEXT_DISABLED;
> +
> +	preempt_disable();
> +	ret =3D __ct_state();
> +	preempt_enable();
> +
> +	return ret;
> +}
> +

I can't see any use for this function with preemption enabled. You can't tr=
ust
the data due to CPU migration and it could be a source of bugs in the futur=
e.
Wouldn't it make more sense to move the burden into the callers? They all D=
TRT,
plus, this_cpu_ptr() will spew warnings if someone shows up and doesn't com=
ply.

Regards,

--=20
Nicol=C3=A1s S=C3=A1enz
