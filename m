Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4D155158D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbiFTKOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbiFTKOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F5B13F4E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6679060ECF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC15C3411B;
        Mon, 20 Jun 2022 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655720078;
        bh=I6kgVPatWmkFTkFsLkfZCwH1S6ZIvAAnyqWufNOOELs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WonSDKLS6fjnaE7SA26xo+fmAgClOR5BrXRj43F/GEq3rlvsCpt90LogHO6eP6qab
         4pgD2nT8TtZld6Ou59Rp9IVO/Tv7vFd5B1DlXKdL4L0ljH96A0pX8PtUZs50cZQ/6F
         2B8jOE+6msLRp+eBU7ggffzNR5V7zqeucjzfhhr0zF7xeJUzSavbg0Vxc1oen30Tbz
         8voGvPlCE2nGJ3+7Jbb6el4IHxfSjtDpaBxLGhzqBmEzyTFWKcRVa6sWM5DTgrpM1Q
         dv9Fr0TFX8Hxwdxgp2sKocXiYd3cBxgaF/gJ1ceFHwk7wuFfm/jK6nfntOAtsvD/2f
         Dv8N9Ik051dAw==
Message-ID: <07c07c2d0714b20bbfffe91b37e8ed810d017c35.camel@kernel.org>
Subject: Re: [PATCH 00/20] rcu/context-tracking: Merge RCU eqs-dynticks
 counter to context tracking v4
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
Date:   Mon, 20 Jun 2022 12:14:32 +0200
In-Reply-To: <20220608144037.1765000-1-frederic@kernel.org>
References: <20220608144037.1765000-1-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 16:40 +0200, Frederic Weisbecker wrote:
> Hi,
>=20
> No big issue reported or reviewed in the last take.
> Changes in this version:
>=20
> * Dropped noinstr related "fixes" as it's worth a whole patchset of its
>   own. Just comment on why some context tracking functions are not going
>   to be fixed (because they are obsolete).
>=20
> * Fixed several build splats reported by the kernel test robot
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/context-tracking-v4
>=20
> HEAD: 82e4a1998ec3a58b865249c6015d3ee9b94e3004
>=20
> Thanks,
> 	Frederic
> ---

For the whole series:

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Regards,
Nicolas
