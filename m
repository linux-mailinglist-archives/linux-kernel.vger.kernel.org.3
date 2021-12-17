Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F14792F7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhLQRkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbhLQRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:40:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43982C061574;
        Fri, 17 Dec 2021 09:40:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639762825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m5F123U0colHSmCqnwjZ4Dods3aSHz4qLqVBNFM6i9o=;
        b=M97PsoR4BRUQhroZzpUh4+XBNNJnywoRxRxr/ok/TBeMJCY4ypdunZjJmvjRgr7CiA4Kl8
        /A+W9VzU6ilQsKbMPWly2k4CoIEjHRgYUJTPn/VJ2bHibz6W0C2KwOOEMSg/5LKERXhdkc
        6UJRHy7cDgMBjuQw3iayUS+9Zk5JMTVGIqPr+ftNoAm2+FMT3s94ht0G1xNgMlDdX85REm
        85CyTdtqc/UYJu0uqFprzssjiY93CZMZPQdFvEvdfWHz6jLtFgC/gsBNCwFw0p1gFnXWJA
        b5c+v7x/zH3SNeuu5fWJZlkXxH96820Y2m1J/Qh8H6OVDXOuXNeSvl3iI4nbbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639762825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m5F123U0colHSmCqnwjZ4Dods3aSHz4qLqVBNFM6i9o=;
        b=YsHqhAgCpxaEn4cn8Hd06FNdbE4AGuRS+n5cp9pTKZR1X670LiOuiGNuLeruZlOwdwaClv
        DdOnfTIC/6sUK8Cg==
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, mark.rutland@arm.com,
        paulmck@kernel.org
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        peterz@infradead.org, mtosatti@redhat.com, frederic@kernel.org,
        corbet@lwn.net, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: Re: [PATCH v3 1/2] Documentation: Fill the gaps about entry/noinstr
 constraints
In-Reply-To: <20211217105753.892855-1-nsaenzju@redhat.com>
References: <20211217105753.892855-1-nsaenzju@redhat.com>
Date:   Fri, 17 Dec 2021 18:40:25 +0100
Message-ID: <87a6gzcepi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas,

On Fri, Dec 17 2021 at 11:57, Nicolas Saenz Julienne wrote:
> +Non-instrumentable code - noinstr
> +---------------------------------
> +
> +Most instrumentation facilities depend on RCU, so intrumentation is prohibited
> +for entry code before RCU starts watching and exit code after RCU stops
> +watching. In addition, many architectures must save and restore register state,
> +which means that (for example) a breakpoint in the breakpoint entry code would
> +overwrite the debug registers of the initial breakpoint.
> +
> +Such code must be marked with the 'noinstr' attribute, placing that code into a
> +special section inaccessible to instrumentation and debug facilities. Some
> +functions are partially instrumentable, which is handled by marking them nointr

s/nointr/noinstr/

Thanks for polishing this!

       tglx
