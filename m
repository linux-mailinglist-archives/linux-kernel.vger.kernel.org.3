Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F448CA67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbiALRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344144AbiALRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:52:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FD6C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:52:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id pj2so6523752pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4lOr0cO3MtfPjxOReqWS5LWG9cMBTSgs7rdN+koXOwM=;
        b=X74Qu9X/Fwr3SmVCD7qP2n9dWtLD6j7cD+7ia6lCkMQfgGTrzwjvG68ZxyCsEcD+Pd
         effSJTMx8/h8k/XLP00W0L12Uy/6Bp8YD0WvJBQwrzw1Qdh03hLZLMYASGNCAV6QSN6W
         Z+Yi00tEq+iraj0PX2/AH8XZ7TQk00ZGnoG2MUmE/UctqFp22VIpQNFP1hfroTD0EmWo
         Rk5frZk/ckQljI/6XBCljvo97zfYX6J70/muKiYVfG0XGHxxzGnmmIOxKEiUwDaki+Te
         6D6ja7NEWxoxjg3VwoaVNafs8B20Bfq+RrG0s+THZAL+aIM9RS82Gfz6Br/mzdkVRKJ5
         TDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lOr0cO3MtfPjxOReqWS5LWG9cMBTSgs7rdN+koXOwM=;
        b=a4UVmWQ1I5twDZUMZmsnNSgXe8fNUn/06ImgNLkvSoNe1uC6F/cRrrbx6TnL43n8H/
         BiJio32MoX1BKVR8JFo4mgaMNleePVrp3gDMPqAq2Eppz65Lfgqn4PE0xqUia9qmRzjv
         1YrL3QghP4ejkUcSWzOHp292nordYEp/MEYVCZraH10PyN1s68ir0JGomlqhWfSH8K+s
         08igbk1tqK3EsvNFfYgLAI5tE/4DcTnWp7zUiBjv/sZ8TZOJvNrst/cY1UEylxVutlW0
         tI+1MTEtP7RryKs2uidTtuQuEdbnv5tM+EOEfCouMyX9GSKZ7lL0Cy0+oySW8iaDBee/
         jmZQ==
X-Gm-Message-State: AOAM532cZCnzdrGbgycTmhejsv52r8ooALFqDrxvzz35HJMH1/3dCRml
        byOiIhy+uqP8xBZDlW2BoFLD8g==
X-Google-Smtp-Source: ABdhPJzmVHtXXCExxXrlD6q6+Z8uAPfHE4FtJOgWfW1egZvlp1s9OzJP8s/SDJqyHmwU/foKpjTpGg==
X-Received: by 2002:a63:350c:: with SMTP id c12mr681310pga.568.1642009932842;
        Wed, 12 Jan 2022 09:52:12 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s7sm253374pfu.133.2022.01.12.09.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 09:52:12 -0800 (PST)
Date:   Wed, 12 Jan 2022 17:52:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, kevin.tian@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] KVM: Do compatibility checks on hotplugged CPUs
Message-ID: <Yd8VSCghD3OvuGJ7@google.com>
References: <20211227081515.2088920-1-chao.gao@intel.com>
 <20211227081515.2088920-7-chao.gao@intel.com>
 <YdzTfIEZ727L4g2R@google.com>
 <20220111053205.GD2175@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111053205.GD2175@gao-cwp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022, Chao Gao wrote:
> On Tue, Jan 11, 2022 at 12:46:52AM +0000, Sean Christopherson wrote:
> >This has a fairly big flaw in that it prevents KVM from creating VMs even if the
> >offending CPU is offlined.  That seems like a very reasonable thing to do, e.g.
> >admin sees that hotplugging a CPU broke KVM and removes the CPU to remedy the
> >problem.  And if KVM is built-in, reloading KVM to wipe hardware_incompatible
> >after offlining the CPU isn't an option.

...

> >That said, I'm not convinced that continuing with the hotplug in this scenario
> >is ever the right thing to do.  Either the CPU being hotplugged really is a different
> >CPU, or it's literally broken.  In both cases, odds are very, very good that running
> >on the dodgy CPU will hose the kernel sooner or later, i.e. KVM's compatibility checks
> >are just the canary in the coal mine.
> 
> Ok. Then here are two options:
> 1. KVM always prevents incompatible CPUs from being brought up regardless of running VMs
> 2. make "disabling KVM on incompatible CPUs" an opt-in feature.
> 
> Which one do you think is better?

IMO, #1.  It's simpler to implement and document, and is less likely to surprise
the user.  We can always pivot to #2 _if_ anyone requests the ability to dynamically
disable KVM in order to bring up heterogenous CPUs and has a reasonable, sane use
case for doing so.  But that's a big "if" as I would be very surprised if it's even
possible to encounter such a setup without a hardware bug, firmware bug, and/or user
error.
