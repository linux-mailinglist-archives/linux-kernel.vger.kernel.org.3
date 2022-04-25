Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D350EC13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiDYWaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbiDYWaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:30:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28991102AA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:23:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650925382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjtz8ftVjNFOHITcRfNKBH2pf+GAC31KHNdUbqit1QI=;
        b=miiV9ABqXFVR+Ml1AodoYDcEE6E0su38gBFtVh5cRAVM9Xl9Bl120QrEoVyj7qG4uScuvG
        tiHxQPNG0eVybeAEkgHKAQg3/9B9tldtTD6cIH5U46l/oMoyqsZH7T4iwYnayRtPQYkuDD
        MquPAMOgeRbdEK88Atgi2446dEcPsb/ZNZa9CCOtt8GBI3ZtbAtnSfiYNfy2PfkG+V568n
        UUUhAF7JvcvoACtiUqvtPxVZcCy4euXJ3P3yfTVGwsmhw13erIT9wtMkWILDFDO02pkq3w
        Td07oo/uwf/3n6tJtiqqoOUH9Lqsa9PyvhOUvRSKbvYREVsE0vDyQeSk5CTVlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650925382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjtz8ftVjNFOHITcRfNKBH2pf+GAC31KHNdUbqit1QI=;
        b=SwTBUM1xWz7dkqJQeV8urONh1/Y3DHjyvj5mh7aEA0jWilsahaZg+CEgRv6F/9mDBcutEc
        UMB/2jHVNQlFR8DA==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch v12 03/13] add basic task isolation prctl interface
In-Reply-To: <20220315153313.863413290@fedora.localdomain>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153313.863413290@fedora.localdomain>
Date:   Tue, 26 Apr 2022 00:23:02 +0200
Message-ID: <87zgk8zttl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
> +
> +/* Supported features */
> +# define ISOL_F_QUIESCE			(1UL << 0)
> +
> +# define ISOL_F_QUIESCE_MULTIPLE	(1UL << 0)

There is no user of this.

> +#  define ISOL_F_QUIESCE_VMSTATS	(1UL << 0)

TBH, I find this mightily confusing. Can we please make it clear that
the isolation features above, i.e. ISOL_F_QUIESCE (and whatever comes
next), and the feature specific defines are clearly seperated?

The attempt of seperating this by spaces between # and 'define' is more
than lame.

/* Supported isolation features */
#define ISOL_FEAT_QUIESCE		(1UL << 0)
#define ISOL_FEAT_SUPPORTED		(ISOL_FEAT_QUIESCE)

/* Subfeatures of ISOL_FEAT_QUIESCE */
#define ISOL_QUIESCE_VMSTAT		(1UL << 0)
#define ISOL_QUIESCE_SUPPORTED		(ISOL_QUIESCE_VMSTAT)

This is clearly visible seperated and the SUPPORTED variants are making
it trivial to add new features without rumaging through the code to fix
it up.

> +struct task_isol_info {
> +	/* Which features have been configured */
> +	u64 conf_mask;
> +	/* Which features are active */
> +	u64 active_mask;
> +	/* Quiesce mask */
> +	u64 quiesce_mask;
> +
> +	/* Oneshot mask */
> +	u64 oneshot_mask;

Repeating the member names in the comments is useful because?

> +	u8 inherit_mask;

inherit_mask is really a misnomer. It's a convoluted boolean, but not a
mask, especially not in the context of the other masks in that
structure. But sure, slapping mask on everything is conveniant and
spares to think about proper naming conventions.

> +int prctl_task_isol_feat_get(unsigned long arg2, unsigned long arg3,
> +				  unsigned long arg4, unsigned long arg5)
> +{
> +	int ret;
> +	void __user *addr = (void __user *) arg3;
> +
> +	switch (arg2) {
> +	case 0: {

Can we please have a proper constant for that case? 

> +		u64 supported_fmask = ISOL_F_QUIESCE;

According to the above this becomes

		u64 supported_fmask = ISOL_FEAT_SUPPORTED;

which makes the code future proof and self explaining.

> +		ret = 0;
> +		if (copy_to_user(addr, &supported_fmask, sizeof(u64)))
> +			ret = -EFAULT;
> +
> +		return ret;
> +	}
> +	case ISOL_F_QUIESCE: {

This is a bitmask.

Q: How is that supposed to work on 32bit kernels when the number of used
   feature bits reaches 32?

A: Not at all

Q: Why is this mask muck 64bit?

A: Just because it looks good and is so future proof because 64bit...

You are designing a user space interface which has to be supported
forever.

> +		struct task_isol_quiesce_extensions *q_ext;
> +
> +		q_ext = kzalloc(sizeof(struct task_isol_quiesce_extensions),
> +			 GFP_KERNEL);
> +		if (!q_ext)
> +			return -ENOMEM;
> +
> +		q_ext->supported_quiesce_bits = ISOL_F_QUIESCE_VMSTATS;

Same as above, just with ISOL_QUIESCE_SUPPORTED.

> +		ret = 0;
> +		if (copy_to_user(addr, q_ext, sizeof(*q_ext)))
> +			ret = -EFAULT;
> +		kfree(q_ext);
> +		return ret;
> +	}
> +	default:
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int cfg_inherit_get(unsigned long arg3, unsigned long arg4,
> +			   unsigned long arg5)
> +{
> +	struct task_isol_inherit_control *i_ctrl;
> +	int ret;
> +	void __user *addr = (void __user *) arg3;
> +
> +	if (!current->task_isol_info)
> +		return -EINVAL;
> +
> +	i_ctrl = kzalloc(sizeof(struct task_isol_inherit_control),
> +			 GFP_KERNEL);

        kzalloc(sizeof(*i_ctrl), GFP_KERNEL);

> +static int cfg_feat_get(unsigned long arg3, unsigned long arg4,
> +			unsigned long arg5)
> +{
> +	int ret = 0;
> +
> +	switch (arg3) {
> +	case 0: {

Proper constant define please.

> +		void __user *addr = (void __user *)arg4;
> +		u64 cfg_mask = 0;
> +
> +		if (current->task_isol_info)
> +			cfg_mask = current->task_isol_info->conf_mask;
> +
> +		if (copy_to_user(addr, &cfg_mask, sizeof(u64)))
> +			ret = -EFAULT;
> +
> +		return ret;
> +	}
> +	case ISOL_F_QUIESCE: {
> +		struct task_isol_quiesce_control *i_qctrl;
> +		void __user *addr = (void __user *)arg5;
> +
> +		if (arg4 != QUIESCE_CONTROL)
> +			return -EINVAL;

The point of arg4 here is?

> +		i_qctrl = kzalloc(sizeof(struct task_isol_quiesce_control),
> +				  GFP_KERNEL);
> +		if (!i_qctrl)
> +			return -ENOMEM;
> +
> +		if (current->task_isol_info)
> +			i_qctrl->quiesce_mask = current->task_isol_info->quiesce_mask;
> +
> +		if (copy_to_user(addr, i_qctrl, sizeof(*i_qctrl)))
> +			ret = -EFAULT;
> +
> +		kfree(i_qctrl);
> +		return ret;
> +	}
> +	default:
> +		break;
> +	}
> +	return -EINVAL;

You can spare all the

        default:
                break;
        }
        return -EINVAL;

instances by returning -EINVAL in the default case directly.

> +static int cfg_inherit_set(unsigned long arg3, unsigned long arg4,
> +			   unsigned long arg5)
> +{
> +	int ret = 0;
> +	struct task_isol_inherit_control *i_ctrl;
> +	const void __user *addr = (const void __user *)arg3;
> +
> +	i_ctrl = kzalloc(sizeof(struct task_isol_inherit_control),
> +			 GFP_KERNEL);

See above.

> +	if (!i_ctrl)
> +		return -ENOMEM;
> +
> +	ret = -EFAULT;
> +	if (copy_from_user(i_ctrl, addr, sizeof(*i_ctrl)))
> +		goto out_free;
> +
> +	ret = -EINVAL;
> +	if (i_ctrl->inherit_mask & ~(ISOL_INHERIT_CONF|ISOL_INHERIT_ACTIVE))
> +		goto out_free;
> +
> +	if (i_ctrl->inherit_mask & ISOL_INHERIT_ACTIVE)
> +		if (!(i_ctrl->inherit_mask & ISOL_INHERIT_CONF))
> +			goto out_free;

This lacks curly braces on the first condition because it's not followed
by a single line statement.

Aside of that, why is this a wholesale inherit decision and not feature
granular? A big void of information in changelog and comments....

> +	if (!current->task_isol_info) {
> +		struct task_isol_info *task_isol_info;
> +
> +		task_isol_info = task_isol_alloc_context();
> +		if (IS_ERR(task_isol_info)) {
> +			ret = PTR_ERR(task_isol_info);
> +			goto out_free;
> +		}
> +		current->task_isol_info = task_isol_info;
> +	}
> +
> +	ret = 0;
> +	current->task_isol_info->inherit_mask = i_ctrl->inherit_mask;
> +
> +out_free:
> +	kfree(i_ctrl);
> +
> +	return ret;
> +}
> +
> +static int cfg_feat_quiesce_set(unsigned long arg4, unsigned long arg5)
> +{
> +	struct task_isol_info *info;
> +	struct task_isol_quiesce_control *i_qctrl;
> +	int ret = 0;
> +	const void __user *addr = (const void __user *)arg5;

Can you please use a consistent coding style for variable declarations
all over the place? These visually randomly ordered declarations are
annoying as hell.

	const void __user *addr = (const void __user *)arg5;
	struct task_isol_quiesce_control *i_qctrl;
	struct task_isol_info *info;
	int ret = 0;

is visually consistent and the fastest to parse.

> +	if (arg4 != QUIESCE_CONTROL)
> +		return -EINVAL;

Again. What's the purpose of this argument? This is:

       prctl(PR_ISOL_CFG_SET, I_CFG_FEAT, ISOL_F_QUIESCE,....);

So why does this need yet another different instance of (1UL << 0) as
4th argument?

This is confusing at best and smells badly of overengineering. But I
might be missing something due to the void of information provided.

> +	i_qctrl = kzalloc(sizeof(struct task_isol_quiesce_control),
> +			 GFP_KERNEL);

See above.

> +	if (!i_qctrl)
> +		return -ENOMEM;
> +
> +	ret = -EFAULT;
> +	if (copy_from_user(i_qctrl, addr, sizeof(*i_qctrl)))
> +		goto out_free;
> +
> +	ret = -EINVAL;
> +	if (i_qctrl->flags != 0)
> +		goto out_free;
> +
> +	if (i_qctrl->quiesce_mask != ISOL_F_QUIESCE_VMSTATS &&
> +	    i_qctrl->quiesce_mask != 0)
> +		goto out_free;

Yet another place, where extending the QUIESCE subfeatures requires code
changes.

	if (i_qctrl->quiesce_mask & ~ISOL_QUIESCE_SUPPORTED)
        	goto out_free;

would be too simple, self explaining and extensible, right?

> +
> +	if ((~i_qctrl->quiesce_mask & i_qctrl->quiesce_oneshot_mask) != 0)
> +		goto out_free;

	if (i_qctrl->quiesce_oneshot_mask & ~i_qctrl_quiesce_mask)
        	goto out_free;

Yes, it's the same. But now put both conditions in context:
         
	if (i_qctrl->quiesce_mask & ~ISOL_QUIESCE_SUPPORTED)
        	goto out_free;

        if (i_qctrl->quiesce_oneshot_mask & ~i_qctrl_quiesce_mask)
        	goto out_free;

Can you see the pattern? Readable code matters.

> +
> +	/* current->task_isol_info is only allocated/freed from task
> +	 * context.
> +	 */
> +	if (!current->task_isol_info) {
> +		info = task_isol_alloc_context();
> +		if (IS_ERR(info)) {
> +			ret = PTR_ERR(info);
> +			goto out_free;
> +		}
> +		current->task_isol_info = info;
> +	}

This is copied verbatim from cfg_feat_inherit_set() with the add on of a
malformatted useless comment. The concept of helper functions exists for
a reason.

> +	info = current->task_isol_info;
> +
> +	info->quiesce_mask = i_qctrl->quiesce_mask;
> +	info->oneshot_mask = i_qctrl->quiesce_oneshot_mask;
> +	info->conf_mask |= ISOL_F_QUIESCE;

So this marks the QUIESCE feature configured whether there is a bit set
in info->quiesce_mask or not. What's the point when quiesce_mask is 0?

I kinda understand what you are trying to achieve, but the outcome is
inconsistent garbage. Why?

   1) What's the point of activating a feature which has no subfeature
      configured?

   2) What's the point of inheriting a feature which has no subfeature
      configured?

   3) Once you activated a feature, then clearing all subfeatures keeps
      the feature itself activated.

   4) Once you activated a feature, then setting an additional
      subfeature, activates it immediately.

Aside of being inconsistent, how is that useful and explainable to mere
mortals, aka. application programmers? And no, your attempt of
documentation does not address that either.

The point is that due to your design choice of feature/subfeatures,
which is again not explained at all (that's what changelogs and comments
are for), this inconsistency is part of the design, unless you refuse to
configure a feature after it has been activated.

I really have to ask the question, whether this envisioned granularity
makes sense at all. How many unique feature/subfeature pairs are going
to be there? I'm all for extensible and future proof interfaces, but
there has to be at least some useful argument why this needs to be a
64x64 bitmap array...

And no, I'm not going to read back on a gazillion of mail threads to
find that information. This information has to be in the changelog and
comments. Not a fundamentaly new requirement, right?

> +int prctl_task_isol_activate_set(unsigned long arg2, unsigned long arg3,
> +				      unsigned long arg4, unsigned long arg5)
> +{
> +	int ret;
> +	struct task_isol_info *info;
> +	u64 active_mask;
> +	const void __user *addr_mask = (const void __user *)arg2;
> +
> +	ret = -EFAULT;
> +	if (copy_from_user(&active_mask, addr_mask, sizeof(u64)))
> +		goto out;
> +
> +	ret = -EINVAL;
> +	if (active_mask != ISOL_F_QUIESCE && active_mask != 0)

Yet another place which needs to be changed when the isolation feature
set is expanded and yet another unparseable condition.

	if (active_mask & ~ ISOL_FEAT_SUPPORTED)
        	return -EINVAL;

Of course, it does not matter whether a feature has been configured or
not. So what's the point of this conf_mask aside of having it available
for the more than questionable inheritance control.

> +		return ret;

Sigh. What's the purpose of ret here? First you do:

	ret = -EFAULT;
	if (copy_from_user(&active_mask, addr_mask, sizeof(u64)))
		goto out;

where @out you just return ret.

Then you preset ret with -EINVAL for the mask check to return that in
the error case. And so forth... ret is not required at all in this
function.

Consistent and comprehensible code is too much to ask for, right?

Thanks,

        tglx
