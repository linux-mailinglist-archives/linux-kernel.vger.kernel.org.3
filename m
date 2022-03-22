Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEAC4E4261
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiCVO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiCVO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:57:07 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E488E7DE0C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:55:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h11so24301238ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJMl3AIFcF87cQUleBkFKkVPaWByiHGJeoFWYQMNgik=;
        b=qQzswXDGavCN5WhW0OAeoyM1wW4joFwli817+w9plNxiP6IoZOoX/hwRBJiB0RQmMH
         tR9W/SQrbExbQpDHwBcmpl1unrt75UOIyHR84fv8gbfQdqm27+J0NucWkl2xN2B7hlC+
         oGftNNnsbYI1+q//ii/3a48fMjhnrXcWD/xW5fHxFqB2/n7MuKZD2/+Oe8GgmnMMJ1/L
         dfXM2IBqFzmXPS+EnFN7ADzWNxxRDDUBxCqT4ub5z0N0TF0AC6Pcvmtd3NpqqxY4yNwp
         mZXMRPcUrZxMU9V6DhuWB1C3uJKQufC/j+L2rUN3GB4vK/55zJw1+ZUiAsXk7IViVW4+
         DnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJMl3AIFcF87cQUleBkFKkVPaWByiHGJeoFWYQMNgik=;
        b=HWYcCTTRrxlFKMKRvXZLJ+VISZT+/fNmdkmxhguVNFqSuY2H8WFZJoFKaZ/UTO7IwI
         1/p4u6Zz/0+GvT2ROoYs25/2QJNcQug50Ix05Sn3iGDc6SzFqf58VZcGG7MBEoBTccOU
         enMJK6iedKL04/421dHt+gbEqbQ2iizPyDHKFodI7If58cvjCavebEueoo+oBSF0JWLz
         jhzajkBUH+b6GLwZYxSeflJjKzF7Rwa1BMHSksnDVha2UN9ocPun2oWfj9BXSZTrfyiG
         P0iDaHQLitXxkJZq5ycyOuahGJU0CqBmh2Pw9OmK6B5GjJASI6F3NdY48gt/GDpY0zV7
         FQkw==
X-Gm-Message-State: AOAM53116GV2QtPVLYVI0gl23q2uwjEBF2yjgPEde1CTn/TaAo8yQwN1
        doJgIlKrIVBxQvxNStB88ri/JqoA2BYLeQMtw0vmpA==
X-Google-Smtp-Source: ABdhPJzGriogLRwr+wF10ufkYmppvz/YdygqFcMmJ6u9D3Sw03wXF0SzNpYedVxVFmbAWbCE7Q2p4pFNSPlRNPd04Fo=
X-Received: by 2002:a2e:6e0b:0:b0:247:f07d:ed69 with SMTP id
 j11-20020a2e6e0b000000b00247f07ded69mr19330642ljc.381.1647960934836; Tue, 22
 Mar 2022 07:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-4-vincent.guittot@linaro.org> <2d401a6c591e7fd1711c0db5b28517f7bf1f5adc.camel@linux.intel.com>
In-Reply-To: <2d401a6c591e7fd1711c0db5b28517f7bf1f5adc.camel@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 22 Mar 2022 15:55:23 +0100
Message-ID: <CAKfTPtBwnLLFmbubqhp_Dn-vDJx-Ue3TQ9Q=tNb=m=yHqG+_Hg@mail.gmail.com>
Subject: Re: [PATCH 3/6] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, Valentin.Schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 at 01:22, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Fri, 2022-03-11 at 17:14 +0100, Vincent Guittot wrote:
> >
> > +static void __setscheduler_latency(struct task_struct *p,
> > +             const struct sched_attr *attr)
> > +{
> > +     if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
> > +             p->latency_prio = NICE_TO_LATENCY(attr->sched_latency_nice);
>
> NICE_TO_LATENCY used here but has defined later in patch 5.  This will break
> bisect.

yes, I have done a mistake when reorganizing the patchset.
latency_prio replaces latency_nice in patch 5 so it should still be
latency_nice field here instead of latency_prio.
Will fix it.

>
> > +             set_latency_weight(p);
> > +     }
> >  }
> >
> >
>
> Tim
>
