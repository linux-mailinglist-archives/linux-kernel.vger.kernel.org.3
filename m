Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14A598A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345424AbiHRRYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345353AbiHRRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:23:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8A2BB31
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:23:20 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y187so1613149iof.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=X1PRfiTW0ZbzrjEzYLkrMF9zmX77XAZwlizZppwE8xo=;
        b=HFpZqiw6dLHvq5WZeg7bibs3hsyLVsFFUbuqCGHj3ldaaTjWem7qmiSBSRW+4hYkCH
         ujoMpndvofRjFOGnHx+r7Q63iZcIM4J1gLBFkrl7tp3m5PQi4yT9ZAPqHpW3H/sYwF9w
         9Ffz8E72GXntPMRDj7Ca9IbL5MgWSCSZzqHOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=X1PRfiTW0ZbzrjEzYLkrMF9zmX77XAZwlizZppwE8xo=;
        b=v3q5JXrjVo6z/4g5zip8GUTdrTq6NLQwCEFjNqdKReaMJJltntbZSKElQI/QmThiIm
         L6KoaLsqCkjjyIpNAVuOR4B4aa+ovS6NjjvIG2C6jrK/2/SPaj3ATSIdP+gtb/0tFOWB
         S3DWE+C4I5O7odSxAPqfmlN2QivjMZeDMtXD4h7MNHdIqAH0Z4kGYGszP9l/NIEmCy4G
         ogT112uCG4223TyY2hDzlJez5BPQGOHjdnf5LkNGTl++6331Id6S3aZwPTbec6PnDgap
         keMuBhvvdojMRPkpH8mqJtFKrmiVJXLSoz4TeAQDs8rgBADaCPUo/AvXCIRmivVr59/3
         G3tQ==
X-Gm-Message-State: ACgBeo3psqYQxWvUxhZ1XSBcx2KutwLhcCxmZ1qQxMtiO0HM3SQfJHGV
        z3B1gcw2cY/qp2DqjIEycpmYUTUitSZw7mgwcRSdpN68jLwpOg==
X-Google-Smtp-Source: AA6agR4l8raOuQK2CppY5jN2dwbZhcb6zQJgquto+Y2BrwuVdXQKVlLlCTe0Zu6/A4D6iwx/cU4OH+XIOypB5uHgvyY=
X-Received: by 2002:a05:6602:26c7:b0:67b:72ef:b87b with SMTP id
 g7-20020a05660226c700b0067b72efb87bmr1867182ioo.175.1660843399015; Thu, 18
 Aug 2022 10:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220809034517.3867176-1-joel@joelfernandes.org> <20220809034517.3867176-5-joel@joelfernandes.org>
In-Reply-To: <20220809034517.3867176-5-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Aug 2022 13:23:07 -0400
Message-ID: <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry, adding back the CC list]

On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> This is required to prevent callbacks triggering RCU machinery too
> quickly and too often, which adds more power to the system.
>
> When testing, we found that these paths were invoked often when the
> system is not doing anything (screen is ON but otherwise idle).

Unfortunately, I am seeing a slow down in ChromeOS boot performance
after applying this particular patch. It is the first time I could
test ChromeOS boot times with the series since it was hard to find a
ChromeOS device that runs the upstream kernel.

Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
patch? I wonder if the issue is with wake up interaction with the nocb
GP threads.

We ought to disable lazy RCU during boot since it would have little
benefit anyway. But I am also concerned about some deeper problem I
did not catch before.

I'll look into tracing the fs paths to see if I can narrow down what's
causing it. Will also try a newer kernel, I am currently testing on
5.19-rc4.

Thanks,

 - Joel
