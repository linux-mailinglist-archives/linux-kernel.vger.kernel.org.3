Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7F2492F07
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348893AbiARULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348378AbiARULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:11:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FA6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:11:37 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so386395pja.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LKCUU04jhzRg3avCcdzhiNctDYJoROpzq94cvgLpl4Y=;
        b=pGpCN4E5n27lswRENLjJkUXRl5U6y0heJ9FaNyrklevgrorctLsBDEaf41sp98rDsX
         Q6oLSxjgAl4Nfc0XCuQ4meedx21JZ5QmF0ymMg0es72T0H55/e4tGFX5EjmwcqzL1tq2
         7yj+bKHUieRb7zkK6QQlLfNoYbNQcF/0NgAhyRKe+nacOVLIw/j7tVFfipwX9lH013za
         4YHqa8fzd+25lb1EsO4+0M5E7q5w6cP3XNRATjW06iQhvWydOMx7izyUClcvG/Wl5xAf
         ky7kQZWxI7v7UdD9ixTz3qaspG2qZcDZg04kkZQUypzEZ4yaJ2HVrgkUXVjgoZZB8jcj
         0s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LKCUU04jhzRg3avCcdzhiNctDYJoROpzq94cvgLpl4Y=;
        b=prw4sRkgupAZH0tFcWPWrYolAE//yEQTRol4vP2Ak0c/0As3TIlRTMbxgRR0I/Fivw
         grF1Ne+WDKbq8J/Z0UZDR+DmOO+WX02usZVEvLP0FR+hSmz/KQaNaNxTMvyBDajfk1f8
         YYh3fnHhCzHI5XstWvfHEwzxyCKAJec0Qe4JWTw0RzuSdzz0PXiutbqT9m96iDy6URy5
         ogS9fUjeL2eE0CTxWdXZhRm3/YNCmKU1JNmHTNjLESDbKVTxW2Yc8PD7y0a01YtnXxjk
         cBELAgbOfgzVCgguTJ6m9DlFpf6b2vws4EaMeJt45AKIWe4WmrdQ2FY5NEI3cMikA/DF
         pzuw==
X-Gm-Message-State: AOAM530pPzT8zWL1T4SAXvF3Xu9kpVqBE5H7rVfsJ5XF1vqdhRZOI+6l
        lHnvtUu1TAOGVWFKUdwftRs=
X-Google-Smtp-Source: ABdhPJyWrCpdsV62AjMddA9IrdfcyisSWk/Ym7sUkyvUUx99KrI2K1iYswLUL8mmbDobdkyyyQilxw==
X-Received: by 2002:a17:90b:1d0d:: with SMTP id on13mr234643pjb.200.1642536696717;
        Tue, 18 Jan 2022 12:11:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q19sm19803167pfk.131.2022.01.18.12.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 12:11:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 18 Jan 2022 10:11:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, jiangshanlai@gmail.com
Subject: Re: synchronize_rcu_expedited gets stuck in hotplug path
Message-ID: <Yece9mH3nzwGxar6@slm.duckdns.org>
References: <7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com>
 <20220118200646.GJ947480@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118200646.GJ947480@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 18, 2022 at 12:06:46PM -0800, Paul E. McKenney wrote:
> Interesting.  Adding Tejun and Lai on CC for their perspective.
> 
> As you say, the incoming CPU invoked synchronize_rcu_expedited() which
> in turn invoked queue_work().  By default, workqueues will of course
> queue that work on the current CPU.  But in this case, the CPU's bit
> is not yet set in the cpu_active_mask.  Thus, a workqueue scheduled on
> the incoming CPU won't be invoked until CPUHP_AP_ACTIVE, which won't
> be reached until after the grace period ends, which cannot happen until
> the workqueue handler is invoked.
> 
> I could imagine doing something as shown in the (untested) patch below,
> but first does this help?
> 
> If it does help, would this sort of check be appropriate here or
> should it instead go into workqueues?

Maybe it can be solved by rearranging the hotplug sequence but it's fragile
to schedule per-cpu work items from hotplug paths. Maybe the whole issue can
be side-stepped by making synchronize_rcu_expedited() use unbound workqueue
instead? Does it require to be per-cpu?

Thanks.

-- 
tejun
