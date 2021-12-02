Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35C1465BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbhLBCHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhLBCHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:07:12 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A116C061574;
        Wed,  1 Dec 2021 18:03:51 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l8so26114889qtk.6;
        Wed, 01 Dec 2021 18:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o7Z9WafEYxT/72WTT9aIa0RjK6vq7gCdXsgRCMpQHj4=;
        b=mjccbCQ+Cp7Cl6vrMKshR7uny8yyNXGJT4B/MfPn8RTv07NO5wJDACeKrPS7ddSiPs
         7QmFEjxbAT9zlQAzsP3D3jt7CXXgUFx8aJ9INP9O08Rc6vH31v+c7TlqXNCBSaXm1fBT
         VbYpyMvCqWcjJ6ssnd1BmNinXyXiaDbXt6wkTLeBZHOP99bEPzt0vS7OvE8JWLQS66L7
         jOku9QUtn7ryHjcRuyblbDv9lovXid+IvHTTQQX5ZvdQgydvAEZcnl1eNsAYJwFgJ2aQ
         2GD1CzWosaORXSumsmoqRiv6vWC9buIUXkGYNomEWOY00RCPBNO9Rh4WxuL8d6VhhPCk
         YOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o7Z9WafEYxT/72WTT9aIa0RjK6vq7gCdXsgRCMpQHj4=;
        b=UCGcO1DDmPjqgxumpS1TNs3Tn51LQ7+xAuEyxXtKz78wQRp5TDXvhXo/QapMO2IkZL
         fXiFWanQqP01bTGv6zq1kb3+uMU3soiKvmcL9EvaNN8MnqGykCSw91+hmEq429udPMh0
         EUPJDpCYN4Pe+is9m5Xk0nE1KpkFKQtoBFW/UAmyPgkP3nqlCo1/LyPUD1E8jpE9JoDF
         N9jJecQB0iTCp2QYwdk+FxrzE44oq5+dFQoLiu13lORJTO48nXb7UrPQTk2Mly2p2sHb
         kaYM/3+vN+o2hle4bESlrQu3UnkQ8GqrgyIdY29PUuLqFVit7+6orubKHQqcAZX7OlmZ
         nZKA==
X-Gm-Message-State: AOAM533EcqwSemMEcp6RcZpLiyUzf/gT2dT84zFZN1xsSGPpZ0LaAuUZ
        EtqINY1Oi8OCi8cMWFiWvFE=
X-Google-Smtp-Source: ABdhPJxsvKS/0dqL3rzQaJ5EVLbYiMogssZPMNxBGhJTGML0Qtb+ae3G1LfooWvXDOeQ/EYV9e8tOg==
X-Received: by 2002:a05:622a:1a9b:: with SMTP id s27mr11123489qtc.417.1638410630248;
        Wed, 01 Dec 2021 18:03:50 -0800 (PST)
Received: from localhost ([66.216.211.25])
        by smtp.gmail.com with ESMTPSA id e7sm867726qtx.72.2021.12.01.18.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 18:03:49 -0800 (PST)
Date:   Wed, 1 Dec 2021 18:03:47 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH rcu 0/18] RCU no-CBs CPU updates for v5.17
Message-ID: <20211202020347.GB430494@lapt>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 04:28:48PM -0800, Paul E. McKenney wrote:
> Hello!

...

> 17.	Allow empty "rcu_nocbs" kernel parameter, courtesy of Frederic
> 	Weisbecker.

...

> Note that #17 might be updated given some ongoing work by Yury Norov
> to support "none" for bitmaps, including the cpumask taken by the
> rcu_nocbs kernel-boot parameter.

Hi Paul,

This is the only work that is needed to support 'none':

https://lkml.org/lkml/2021/11/24/2642

From the last discussion, it's not clear is this 'none' needed or not.
If needed, I'll submit the patch.

Thanks,
Yury
