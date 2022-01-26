Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B249CE58
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbiAZPbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbiAZPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:31:21 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73253C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:31:21 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id s12so28573774qkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=tuAwDuCZNYp0iGAO00ew96R+E+k/Li3kJqdbAoMlqDA=;
        b=XxiKAfF2rgXWe+VtsLPZa3DK5VCtxOwZz0P3m2tkGRvpJaozAGvhVyPYH3FqjY/KfD
         puonl2ptqCydJBcgXQ9om7ictAVEYT6OJy5wSDk1r4uGnSyvoV8sEurxQQD3AI1untmQ
         zgr/z0IbMslz7n48hWdWUaKExe6iNxZQevWSP2j0bxFWBkf5FoRuneeOiWWLEQc/qokr
         HRQd6wVFl2J1O5Dj6hWYav6KyE7SniLNMKIZAubuV38tnfLCQjdLFbx0f5zXpbhXpN0I
         3ZarIuzDY6MB/Fu709JZ0gcsXtj26kl5S9dEz9vvt4/mAbpnM65VQEFNqSKXOou/uTBn
         avvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=tuAwDuCZNYp0iGAO00ew96R+E+k/Li3kJqdbAoMlqDA=;
        b=73R2jboxraTg4mUxvPK8UtJAJCDZvWVv5NF3QJ7tAgi1wsJzilbpKT0fqMoMb8D+53
         xfDBs9bLRRgNoOVFe3pJvh6DQyjjLfZCp0IMNNvlNtmVyFMgtR3eoL9VMgAf8vfnhQym
         BCtlf0x+O2Gvh8rh3rKY6oDm2yjnYqL/pqKstsVBxkBTm7peLfIRywKTgV66l+lHfMq2
         Xk+1LZ6Cl19x+PFDpvYHgVV/+s4U6TsvMI/okUAP4tOwpipByP8J853Zl9+0cSELr7Rf
         Iw7SxqckCAXCRx0U/EFUR1rDYFWW1BmDT3yEUt9526P4QJOIQ1syP1lHmIuzYozRXqDk
         Scng==
X-Gm-Message-State: AOAM531/YY9WxbvU2zrjrwKMxNBV0aPK7EVJO3EK6SwbGz8pWP2tElmR
        FGtGHTFvV0T0PlIQX3V/RA==
X-Google-Smtp-Source: ABdhPJzQZYzEQZeKdD3J/ksROYUm394TENDPD0j1YNrEtW7UWPb2URik2SuytfQE2a+4Hk83jC4gbQ==
X-Received: by 2002:a37:9c8e:: with SMTP id f136mr13156652qke.575.1643211080472;
        Wed, 26 Jan 2022 07:31:20 -0800 (PST)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id e6sm10756255qte.6.2022.01.26.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:31:19 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:4de2:5f2e:d934:1026])
        by serve.minyard.net (Postfix) with ESMTPSA id C85C1180004;
        Wed, 26 Jan 2022 15:31:18 +0000 (UTC)
Date:   Wed, 26 Jan 2022 09:31:17 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Possible reproduction of CSD locking issue
Message-ID: <20220126153117.GU34919@minyard.net>
Reply-To: minyard@acm.org
References: <20220125182737.GO34919@minyard.net>
 <4609fe56-7d88-8176-a378-0f465670b37d@suse.com>
 <20220126135639.GS34919@minyard.net>
 <70245998-b99e-ebe7-e932-f8a1b46f6ac7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70245998-b99e-ebe7-e932-f8a1b46f6ac7@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:51:36PM +0100, Juergen Gross wrote:
> On 26.01.22 14:56, Corey Minyard wrote:
> > On Wed, Jan 26, 2022 at 07:08:22AM +0100, Juergen Gross wrote:

snip..

> > 
> >   csd: cnt(63d8e1f): 0003->0037 queue
> >   csd: cnt(63d8e20): 0003->0037 ipi
> >   csd: cnt(63d8e21): 0003->0037 ping
> > 
> > In __smp_call_single_queue_debug CPU 3 sends another message to
> > CPU 55 and sends an IPI.  But there should be a pinged entry
> > after this.
> > 
> >   csd: cnt(63d8e22): 0003->0037 queue
> >   csd: cnt(63d8e23): 0003->0037 noipi
> 
> This is interesting. Those are 5 consecutive entries without any
> missing in between (see the counter values). Could it be that after
> the ping there was an interrupt and the code was re-entered for
> sending another IPI? This would clearly result in a hang as seen.

Since preempt is enabled, wouldn't it eventually come back to the first
thread and send the IPI?  Unless CPU 3 is stuck in an interrupt or
interrupt storm.

-corey
