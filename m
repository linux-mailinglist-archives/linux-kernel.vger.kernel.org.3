Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E982155E9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbiF1QaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348445AbiF1Q3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4E183AA7C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1k3CBwOlDNKLLgVJWLqKeFaKpZTZnO4zAu76Qx9GG0o=;
        b=T6SUE3v/UmAusFMCs/XvzNt4AwfIQypqqoPAeajwWcziDRZIp5QnB4wnUIRexk7BNFsWGy
        HxC0IeJtn0UeVDLsZbrfeRqWIYHKz0asRIbEtoP0TCkCjkQa/J4sFufTA4Zuv6jMtjtMqZ
        Hup7rQqwDP85jBAzoI7gVaZuZYifl0U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-xiprpjSmOpiT3HmDPXSdTg-1; Tue, 28 Jun 2022 12:21:25 -0400
X-MC-Unique: xiprpjSmOpiT3HmDPXSdTg-1
Received: by mail-wm1-f71.google.com with SMTP id m17-20020a05600c3b1100b003a04a2f4936so3283929wms.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1k3CBwOlDNKLLgVJWLqKeFaKpZTZnO4zAu76Qx9GG0o=;
        b=mOYuJGe/uRFj7jswHEnEq8Zcg+3Zyu8ymZZD5omfu8gocN+06I60Eld6Ixuxk7dvzA
         LSQV7E7bPq0fB/tzLt8Fntu5FHr0/bVfYcgtL40iPOiqataQqQ4OP+PzZkCUZ2r+6vg2
         FRpzDDQLe1CwbO5kO+lgX2vgz7g6kNLSESgDrgzSnuxeE2j3mXL8nyz8TElCno519jam
         y0G12YjEorNxxZhPeGZwkaIFbOOVEeePDhridhT3EHNqQh3o6WkutcsoeeTrFebybgcB
         1+r9URqVzhGrWWgXG0Gza/u0dyVQcMzgzNCcnGdyKrfiX8gkHnjrSVsjoY/R8BTEM4U0
         r9FQ==
X-Gm-Message-State: AJIora/n79xXuYjcKPD3gZ1p5MTnulsMM+1sHCfYULMqGI4hoE0T1Mw7
        VPMObLzgXBHAoah63KIAQvcP9tBfXa5VGI7loWbfNUmZVN6pdqaT/olOl7phnSp8HDQnDQePrzv
        U7rNibTam7LqFb9rLfU8zRBw=
X-Received: by 2002:a05:6000:168b:b0:21b:a2c1:c93d with SMTP id y11-20020a056000168b00b0021ba2c1c93dmr19798232wrd.358.1656433283820;
        Tue, 28 Jun 2022 09:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uu+nFvJHR79Zm6a20l826vX97rS7XFvJDCMz5epAWBPHZ04E38/KxhS9TcdigmR+mZjbPDqg==
X-Received: by 2002:a05:6000:168b:b0:21b:a2c1:c93d with SMTP id y11-20020a056000168b00b0021ba2c1c93dmr19798215wrd.358.1656433283636;
        Tue, 28 Jun 2022 09:21:23 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id a17-20020adffb91000000b0020c5253d907sm14249763wrr.83.2022.06.28.09.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:21:22 -0700 (PDT)
Date:   Tue, 28 Jun 2022 17:21:22 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com, neelx@redhat.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v11 10/14] module: kallsyms: Fix suspicious rcu usage
Message-ID: <20220628162122.v7s3z24icwavur6y@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-11-atomlin@redhat.com>
 <20220627235612.4796c837@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627235612.4796c837@gandalf.local.home>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-06-27 23:56 -0400, Steven Rostedt wrote:
> > +	preempt_enable();
> 
>         ^^^^^^^^^^^^^^^^^
> 
> This just introduced an unbounded latency and will fail PREEMPT_RT.
> 

Hi Steve,

Sorry about that!

If I understand correctly, there is absolutely no need to explicitly
disable preemption in this context. I will use: rcu_read_lock() and
rcu_read_unlock(), respectively, which will then be suitable for the
preemptible RCU implementation.


Kind regards,

-- 
Aaron Tomlin

