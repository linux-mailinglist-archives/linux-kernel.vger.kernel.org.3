Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3656C47DDD4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 03:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbhLWCsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 21:48:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:33983 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238419AbhLWCsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 21:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640227697; x=1671763697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xoQPorTJWOJVOewl9ed9N6FZy1Jk553UBe2EFgd+xbU=;
  b=BPgJaFY69r1ZTngqzIyxiGSnMvK6kHQgmuimVfQMeGFKXOEjQ7STx9N2
   +icdjkyPU7x4NYEYL4rnrr+yRjLwpDCkMOpQwhj4JAum8NT544dmvox3Z
   hnGNs4VOKIohq6Z2jsEScsp5rmZ8JrqxOJ8ZBzeQ6iyIA7GmM8UUKcnCM
   GOZheOPNfSwxd5ORih4MCD3LEjoYWRt280jZ15qt2HkIz8aKryfXm1BuK
   iKKKNevFWZ88T7lZxRCyJjFpNWlI8Ig3derzDudXTV4E0yVu2+0qqBiPv
   BNwfBu5RGPmLzMEa8FWEKtZGnzt8YfSnWvMwg3uxx3W4YAI2NgOk89lxF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227589288"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="227589288"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 18:48:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="521918227"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 18:48:15 -0800
Date:   Thu, 23 Dec 2021 10:48:00 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [kthread]  40966e316f: WARNING:at_kernel/sched/core.c:#sched_init
Message-ID: <20211223024800.GA33629@xsang-OptiPlex-9020>
References: <20211216102956.GC10708@xsang-OptiPlex-9020>
 <878rwjf9my.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rwjf9my.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Eric,

On Fri, Dec 17, 2021 at 11:01:41AM -0600, Eric W. Biederman wrote:
> kernel test robot <oliver.sang@intel.com> writes:
> 
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 40966e316f86b8cfd83abd31ccb4df729309d3e7 ("kthread: Ensure struct kthread is present for all kthreads")
> > https://git.kernel.org/cgit/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
> >
> > in testcase: trinity
> > version: trinity-x86_64-608712d8-1_20211207
> > with following parameters:
> >
> > 	runtime: 300s
> >
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> >
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire
> > log/backtrace):
> 
> 
> Ok. That is very weird.  I will dig into it.
> 
> Silly question is there anything in this testing to cause memory
> allocations to fail early in boot?

we didn't observe it. actually test could finish for both this
commit (though with reported warning) and parent. the only diff seems
the reported warning.

cead18552660702a 40966e316f86b8cfd83abd31ccb
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :8          100%           8:8     dmesg.RIP:sched_init
           :8          100%           8:8     dmesg.WARNING:at_kernel/sched/core.c:#sched_init

but could you check in dmesg we attached in original report for any suspicous
memory issue?

or could you help check the config we used (also attached in original report)
to see if we can make some changes then to expose the possible memory issue,
in case our current config cannot capture? Thanks



> 
> Eric
