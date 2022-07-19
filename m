Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A2957A386
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiGSPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbiGSPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:48:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE7B599C7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:48:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e15so16979221wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JYB6QNZOPSX+BCoF/WDF8u48DHqjX/vkFUV+00Cp3lQ=;
        b=IquTmVAY/oKDJ0jAjzUbv7JwNe0SeR6hefUC/z4kFvqR6h+dN8AXUSwz6UOcpLt4NM
         Kbkaagejub8rjKCcgXG8XN9XZdtcDNeKLLL0JBPqeiSkah1n9jzXYPXtuRUFPE6x8hqC
         LtT5w6t1uVKEruQ2LMowPiS2OCpt+PIbwdD/CRAXTU7+p/UKFI2xlIeyjgNAGxY7Boc/
         S8ZRHmfPDGVKP8fI/aBLrvOi28sCgcW5k4WnH8a18hHPgwh4gYfoJqvIpOxQx7SfhtnC
         Bea+C++myHF6mxbBfeyP35rAwRducHGbDLibdEVowgoZt+TmjbZMV974ezZxYGzvVz+2
         oXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JYB6QNZOPSX+BCoF/WDF8u48DHqjX/vkFUV+00Cp3lQ=;
        b=2d0Cz0VOpDByN3A86nnwHcLHHCrOGFrH7D4NLbrc2MvYYHPW7+pZdmGv332LZV6RYX
         rpzML31yv3dRkoHJuu50IBt3Pn8sORfN8c/Lmd763BMbEMbcd7lTQVRdm6wUnURgN4qD
         j2fqoUQKWemJnJ+BQuQDKT7CBaanKcBzgVF5EtGWLZj5mlvsCM31r0p4I6GbSXA+10PF
         jrQtmywbkIab/AIkK3QQIFXeUkmijfyKXLL4I2bmk0A3x/7zerDitDfqv2df5bwiJuTl
         XJ47vv5Zc8t5sCDzSh5yP5dMn6lPNkawOFhl/7lhlMEyVy0EnT92sWPEfwyDOFe7iA9f
         BAaQ==
X-Gm-Message-State: AJIora/njlYJkp6Bhq3PCReTXaT+DXzu2PS7qlgg5ElAYPjcpvtoKE91
        7kA/nJVTiJnvMix+75sCzm60UUutaQOjug==
X-Google-Smtp-Source: AGRyM1u4SdLjWm6hUNRujxunjEdvlUs29vSp0aEPZ1nMaS2sctEJjWfnqPXwDBsOKFNNI/MzaD/WOQ==
X-Received: by 2002:a5d:5a9d:0:b0:21b:8247:7ec4 with SMTP id bp29-20020a5d5a9d000000b0021b82477ec4mr27067960wrb.561.1658245699622;
        Tue, 19 Jul 2022 08:48:19 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b003a31b79dc0esm5044883wmb.1.2022.07.19.08.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:48:19 -0700 (PDT)
Date:   Tue, 19 Jul 2022 16:48:15 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        kernel-team@android.com, Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v4] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Message-ID: <YtbSP21k1hTKGlqv@google.com>
References: <20220704131346.2650163-1-vdonnefort@google.com>
 <xhsmhfsix6ssc.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhfsix6ssc.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 04:12:03PM +0100, Valentin Schneider wrote:
> On 04/07/22 14:13, Vincent Donnefort wrote:
> > +static int _cpuhp_invoke_callback_range(bool bringup,
> > +					unsigned int cpu,
> > +					struct cpuhp_cpu_state *st,
> > +					enum cpuhp_state target,
> > +					bool nofail)
> [...]
> > +		if (nofail) {
> > +			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
> > +				cpu, bringup ? "UP" : "DOWN",
> > +				cpuhp_get_step(st->state)->name,
> > +				st->state, err);
> > +			ret = -1;
> 
> On a single failure we'll get two warns (WARN_ON_ONCE() + pr_warn(), and
> then subsequently just the pr_warn()), is that intended?

It does, this is to keep the backtrace that used to be here... but now, giving
a second thought, we can probably get rid of it and just keep the pr_warn()?

> 
> Also, why not have ret = err here?

If two states fail, the ret wouldn't mean much, hence a default "-1" just for
the WARN_ONCE. But if we drop the latter, that would simplify the problem of
knowing which error code to return.

> 
> > +		} else {
> > +			ret = err;
> >                       break;
> > +		}
> >       }
> >
> > -	return err;
> > +	return ret;
> 
> > +static inline void cpuhp_invoke_callback_range_nofail(bool bringup,
> > +						      unsigned int cpu,
> > +						      struct cpuhp_cpu_state *st,
> > +						      enum cpuhp_state target)
> > +{
> > +	WARN_ON_ONCE(_cpuhp_invoke_callback_range(bringup, cpu, st, target, true));
> >  }
> >
> 
