Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A340549D01C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbiAZQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243356AbiAZQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:56:16 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF101C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:56:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso240708pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uN7NEj5/raErdh8LaUTfPYj1Ec1u+VdFcqJ9xn+nQIU=;
        b=mhYqHQZZB39aySo2/+3XRE7jLNheFRdkwkBL/R3OcdOWaRRMYqG2KQGz+wopMjOhu4
         3CnokKklrApleKwXbbKjtdViOJBpAx/oV1RFjD7ONv02Uc7zDL1ide5RumzgKWLAJoHP
         Zqiin07JHO2vhkKfWB6JDaqYBsI7X1AtCqIm7xJY+2nifZ50IIVj3dQDNaKqSOjopNop
         3wtK3OuNutK6LrIq7e8BMZT9gXbU5Kv5TX77KC6mPanqNZCvm9oxe+0lQ1arUH2HGvvh
         Jf6ayoObu1t6TE54wxY1cN/NGrvacrIU091Bz0waxrg9Dc81grFV0e0bhSo2ZOwP9sBe
         I1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uN7NEj5/raErdh8LaUTfPYj1Ec1u+VdFcqJ9xn+nQIU=;
        b=ZKP+BNlhU59ERLzldJb46D8RC0n5cnnIvzklqJpFcoBqMimttxj7OPKxqPB19NYR+N
         6PE4oYGOcT5xcnVZrtAJSygNnBau6iJ1b7MA2yii6VYspWDTlG5bHyllrln7uD+y/kLE
         RB+kE+5QVQtGDalkwimvzCNpTEUvBUJCo3X/6ti7qeBBKU+1kxsNpzQ+714IDF096XPl
         /jGlvuYrLwCYaqVRLSEeeksLI07TilU2nQ2rBL/H+iJMlgdp6+ILdLIS4MV0T4yEhSHg
         Y1U5EZ7cF48N+sAJTuoswM3ogOjbv1NeshDer1U8i9cKuCn1MqJv0EA//x83hztuiAgh
         VUpQ==
X-Gm-Message-State: AOAM530306euZhcc7p4CZmSz/kX/CaJK90d6KEQr1ZKotJfiBTnEFBaa
        5ps9QXPnp5gZa+wnkoeA8oI=
X-Google-Smtp-Source: ABdhPJyntRcmrfpDezmn9Tc1wWkgZxfdXhHUdtfQm1k6VfUxTsnl2ByqHNq4Lu1KvtZxUcNQz2B24Q==
X-Received: by 2002:a17:902:aa49:b0:14a:c390:a44b with SMTP id c9-20020a170902aa4900b0014ac390a44bmr24727719plr.11.1643216175325;
        Wed, 26 Jan 2022 08:56:15 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id nu7sm3834358pjb.30.2022.01.26.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:56:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Jan 2022 06:56:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Peter Collingbourne <pcc@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [resend RFC 1/3] pid: introduce task_by_pid()
Message-ID: <YfF9LdvBsC/lkdWL@slm.duckdns.org>
References: <20220124105247.2118990-1-brauner@kernel.org>
 <20220124105247.2118990-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124105247.2118990-2-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:52:45AM +0100, Christian Brauner wrote:
> We have a lot of places that open code
> 
> if (who)
>         p = find_task_by_vpid(who);
> else
>         p = current;
> 
> Introduce a simpler helper which can be used instead.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>

For cgroup part:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
