Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B3452BF66
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiERPbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiERPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:31:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1D43DA66
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EC9760EB4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC19C385A9;
        Wed, 18 May 2022 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652887899;
        bh=OuxNgGxuC8k9qTUF84n1SDE8XsbTIsF7YoOsLOokWpo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C+jbe9kq/ZfdNiNJB7MDYELx2RFMn5Cv0J4SWq6IDFGYwN/d8S0ZkczRFlBglIAfJ
         8Ht1omNUyWTsuEUXZG+skRcS6RCMLRoe6EtwhG92bEDn/HUlhh9hFAer3NRPh24bdy
         tiOWneEL5x88lhgTVobIIqMm14IFXyJ+SnCNok3ENiHK7JcyO4+OfVaozOucSTxKFC
         A2H5mSD9na8lX0ielBqm4dJ9gBhgMECCxsS3nBCcJYTrtG0CHSbhh0ky0ar1A+B8/2
         54eHtPEc4/N4A0YtF3dDRXrP/p7rgwrGM6fAxGIP1n4Jo13+a/ZNXlHIYmDLIxPNNH
         1i5i4/VU206eQ==
Message-ID: <adf7fca9aab320abc7a0c364b3e99709e0d99548.camel@kernel.org>
Subject: Re: [PATCH 21/21] rcu/context_tracking: Merge dynticks counter and
 context tracking states
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
Date:   Wed, 18 May 2022 17:31:32 +0200
In-Reply-To: <20220503100051.2799723-22-frederic@kernel.org>
References: <20220503100051.2799723-1-frederic@kernel.org>
         <20220503100051.2799723-22-frederic@kernel.org>
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

> diff --git a/include/linux/context_tracking_state.h b/include/linux/conte=
xt_tracking_state.h
> index edd9f8f5b753..0841435620cf 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -10,12 +10,20 @@
>  #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
> =20
>  enum ctx_state {
> -	CONTEXT_DISABLED =3D -1,	/* returned by ct_state() if unknown */
> -	CONTEXT_KERNEL =3D 0,
> -	CONTEXT_USER,
> -	CONTEXT_GUEST,
> +	CONTEXT_DISABLED	=3D -1,	/* returned by ct_state() if unknown */
> +	CONTEXT_KERNEL		=3D 0,
> +	CONTEXT_IDLE		=3D 1,
> +	CONTEXT_USER		=3D 2,
> +	CONTEXT_GUEST		=3D 3,
> +	CONTEXT_MAX		=3D 4,
>  };
> =20
> +/* Even value for idle, else odd. */
> +#define RCU_DYNTICKS_IDX CONTEXT_MAX
> +
> +#define CT_STATE_MASK (CONTEXT_MAX - 1)
> +#define CT_DYNTICKS_MASK (~CT_STATE_MASK)

Nit: These macros only work as long as we don't introduce new contexts. It'=
s
maybe worth a comment.

Regards,

--=20
Nicol=C3=A1s S=C3=A1enz
