Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D9A555256
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376923AbiFVR0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376536AbiFVR0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:26:14 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EE12A40D;
        Wed, 22 Jun 2022 10:26:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id i17so19482037qvo.13;
        Wed, 22 Jun 2022 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1FM/ZQ8a2ZHSH54UjftXe1OE1A5MBWIZme5bKp0p2VU=;
        b=ltYQlE+ufZavWCAouqv1TW9vS56tCbDMQa++jPKFWEYtLWl8ACUnL4k9uEPqHBwUGW
         prvthkK9L28PzIv7uXjkM8v9wnCRyuNu3ya1KX8RCk7AGR44NdOpW1iGvCqcrR9IE1Zc
         yKhRnFv0idELEytDZVBPvlL1N2TMZvfD+Opj4QFBqCoker1VfDii6c2MwaIyeN+Rdy5N
         MjC1ZlFmPSL2yJsOM7OBZn6+E4ZaTQW462yg/kfOblDH7yt2wX97oEx64jDPvyfZ25JI
         Y9sjBjql49LnSHTlysm8ZzP1V3fW/3A0nN4ykHiKviQ/uvr62VgPwy0EP/fSWok1K8gP
         ix4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1FM/ZQ8a2ZHSH54UjftXe1OE1A5MBWIZme5bKp0p2VU=;
        b=NNXrMMtiAAx1o/sIb9gfasGm0wlRUGVM5PJiKGmn5S7h2yH+V42pjHgi5JJsXir2Il
         Q5bQ9L2iFsgsFHcsk1jfvaDa/vmPLoNsBi8Erh6mmgrDFGWAYG6BK08oKF7l1/jQ1OLj
         Lyp3nJq1SD1e9XIVqUCHdtKgm3nMr+DjkGKLlFeo1QdzSmw66FwOy0cVeoSrH8zMeDSI
         H+uTMYrWVkz6+hrZGXB5VRe0cT9RGghhCvACvc37msbNp2t7iHaTYhpbIu2D/x0diNSS
         7GcEEvgGERJCxoLmnidcNVGw4sSW1QzJGXZMVZFvvmYT+jp4PHYWTLygtovsdaA7qbtP
         d/2Q==
X-Gm-Message-State: AJIora8jAVu2xsMZvijPTlQuZl00Kzlu3N2w6h4/lntLcUqIxrzMd4QZ
        mK2W7oqEQ9sVyQCiTjpd26Q=
X-Google-Smtp-Source: AGRyM1tJUeT6hrMp7b/MQ49U0FKbqJHVdoDBpKxJGSD7RszbsxLot3arstXwJB0ZRMZvUlnXsNC51w==
X-Received: by 2002:ac8:5ad1:0:b0:305:864:2eb0 with SMTP id d17-20020ac85ad1000000b0030508642eb0mr3941296qtd.168.1655918772862;
        Wed, 22 Jun 2022 10:26:12 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id bi20-20020a05620a319400b006a6dcd92eb3sm16277571qkb.121.2022.06.22.10.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:26:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id B91F027C0054;
        Wed, 22 Jun 2022 13:26:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 Jun 2022 13:26:11 -0400
X-ME-Sender: <xms:s1CzYg13AjATueSEa-v8fUULMHcVJCQKokKildKzPgQ0fH9FDkREtw>
    <xme:s1CzYrF69PXcVLeAxlQXqxpyr06HTWfMusxEWOUC0B0gnSJavBS6U7zzcoikTyiB1
    -7jxJtxIr0Ayzkprw>
X-ME-Received: <xmr:s1CzYo6b3--4ZLkLhuIK3nR7mpQRHFxtXvLIFhHJ6eqAsz-xr8gFT1QU-GoTFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefhedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtrodttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhg
    sehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeitdefvefhteeklefgtefhge
    elkeefffelvdevhfehueektdevhfettddvteevvdenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvg
    hrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhf
    vghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:s1CzYp07wtelxCjJCCBmcbQTOYiDr8RwtY6Wi0tOdylL8MDgxP0Rbw>
    <xmx:s1CzYjE0QrZCgn7kfnqnv-f_eB8YKLEAmOQL-LX5s0fnV4LRXqmtaA>
    <xmx:s1CzYi_bJjFCkGWp6z_vn8ODzx5BDPt3PkJkGbVx1aE3zKE7NDqAmg>
    <xmx:s1CzYniVQofPCFsPbvqm9DeIL-Nm61H966j99bX4Lj0938OSznW-XQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 13:26:11 -0400 (EDT)
Date:   Wed, 22 Jun 2022 10:25:59 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Message-ID: <YrNQpxjIiNpxwyQh@boqun-archlinux>
References: <20220622103549.2840087-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622103549.2840087-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 22, 2022 at 06:35:49PM +0800, Zqiang wrote:
> In CONFIG_PREEMPT=n and CONFIG_PREEMPT_COUNT=y kernel, after a exp
> grace period begins, if detected current CPU enters idle in
> rcu_exp_handler() IPI handler, will immediately report the exp QS of the
> current cpu, at this time, maybe not being in an RCU read-side critical
> section, but need wait until rcu-softirq or sched-clock irq or sched-switch
> occurs on current CPU to check and report exp QS.
> 

I think the idea is OK, however, this "optimization" is based on the
implementation detail that rcu_read_lock() counts preempt_count when
CONFIG_PREEMPT_COUNT=y, right? It's a little bit dangerous because the
preempt_count when CONFIG_PREEMPT_COUNT=y and CONFIG_PREEMPT=n is mostly
for debugging purposes IIUC, and in other words, _it could be gone_.

Also I'm not aware of any but there could be someone assuming that RCU
read-side critical sections can be formed without
rcu_read_{lock,unlock}() in CONFIG_PREEMPT=n kernel. For example, there
might be "creative" code like the following:

	void do_something_only_in_nonpreempt(void)
	{
		int *p;

		// This function only gets called in PREEMPT=n kernel,
		// which means everywhere is a RCU read-side critical
		// section, let's save some lines of code.

		p = rcu_dereference_check(gp, !IS_ENABLED(PREEMPT));
		... // of course no schedule() here.
		<access p>
	}

Again, I'm not aware of any existing code that does this but we need to
be sure.

Regards,
Boqun

> This commit add a exp QS check in rcu_exp_handler(), when not being
> in an RCU read-side critical section, report exp QS earlier.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_exp.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index be667583a554..34f08267410f 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -828,11 +828,14 @@ static void rcu_exp_handler(void *unused)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp = rdp->mynode;
> +	bool preempt_bh_disabled =
> +				!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
>  
>  	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
>  	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
>  		return;
> -	if (rcu_is_cpu_rrupt_from_idle()) {
> +	if (rcu_is_cpu_rrupt_from_idle() ||
> +			(IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preempt_bh_disabled)) {
>  		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
>  		return;
>  	}
> -- 
> 2.25.1
> 
