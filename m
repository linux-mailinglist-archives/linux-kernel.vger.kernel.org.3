Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0015002D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiDMX74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiDMX7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:59:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14AF655497
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:57:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD9971424;
        Wed, 13 Apr 2022 16:57:31 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ECF93F73B;
        Wed, 13 Apr 2022 16:57:29 -0700 (PDT)
Date:   Thu, 14 Apr 2022 00:57:19 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "Valentin.Schneider@arm.com" <Valentin.Schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Wei Wang <wvw@google.com>
Subject: Re: Scheduling tasks on idle cpu
Message-ID: <20220413235719.xs72pm2kgihia46g@airbuntu>
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411233447.rcencjivkhyltyxm@airbuntu>
 <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
 <CAKfTPtBWUvvFMsSnfcKsOpHFdvxvSWpjfuLpjwwQrwhQc7+xuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBWUvvFMsSnfcKsOpHFdvxvSWpjfuLpjwwQrwhQc7+xuw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/22 11:07, Vincent Guittot wrote:
> On Tue, 12 Apr 2022 at 10:39, David Laight <David.Laight@aculab.com> wrote:
> > Yes I want the CFS scheduler to pick an idle cpu in preference
> > to an active RT one.
> 
> When task 34512 wakes up, scheduler checks if prev or this cpu are
> idle which is not the case for you. Then, it compares the load of prev
> and this_cpu and seems to select this_cpu (cpu17).
> 
> Once cpu17 selected, it will try to find an idle cpu which shares LLC
> but it seems that the scheduler didn't find one and finally keeps task
> 34512 on this_cpu.
> 
> Note that during the next tick, a load balance will be trigger if
> this_cpu still have both RT and task 34512,

David said there are idle cpus

	"  There are two physical cpu with 20 cores each (with hyperthreading).
	16, 18, 34, 36 and 38 were idle. So both 16 and 18 should be on the
	same NUMA node. All the others are running the same RT thread code.  "

Except for the possibility of them becoming idle just after the task has woken
up, shouldn't one of them have been picked?

Thanks

--
Qais Yousef
