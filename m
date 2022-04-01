Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5454EEC1F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbiDALRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiDALRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:17:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9C917F3D8;
        Fri,  1 Apr 2022 04:15:50 -0700 (PDT)
Date:   Fri, 1 Apr 2022 13:15:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648811749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oKF9VqRTjJp3lTVoEsc7dqEf9uWuEicp/om5wBdNDCM=;
        b=pjOSccKOS6kaXHc1+sf/OM5FG1tzRaVuwec9T6AALXzmv5XrkKS2n5d6hgG3YZpvkn6IDw
        txBlOvu0IOY4tcHpXzRBqODjPNNqWWYExkxiU+q9Ng0N6OPWUv631TNuVKImt/Qv90QWqQ
        KmWhOOZ4h5V2jMfigvW+ZRlMZiXYWI5otwF+mjIAn6slQ4oWhyZh5cFIlplXHb60SFp2/T
        Ww7L797Bijz+eU/GsXmfpV1qbuH9a0X0Mn4F+nZXWB3CD31cfGea1k+hxyKFxQYxeR+b/t
        QJlSmyKha39l1byP5XZXZyIrq1eu7/SiFe4ExAJc8CyAGvmkYAVAPxm/BAhwSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648811749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oKF9VqRTjJp3lTVoEsc7dqEf9uWuEicp/om5wBdNDCM=;
        b=wtjk/bOGe7M9+i4Sq/yN6vbGu9gJHveTrV30EHMFShDrD1nIlS/E2XU9/xNdndadImVuGr
        Qfz6BM6FIIoc1LBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] kasan: Fix sleeping function called from invalid context
 in PREEMPT_RT
Message-ID: <Ykbe46hLAfJ8TsnW@linutronix.de>
References: <20220401091006.2100058-1-qiang1.zhang@intel.com>
 <YkbFhgN1jZPTMfnS@linutronix.de>
 <PH0PR11MB58800917A1BF8D1A76BEF84EDAE09@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58800917A1BF8D1A76BEF84EDAE09@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-01 10:10:38 [+0000], Zhang, Qiang1 wrote:
> >Could we fix in a way that we don't involve freeing memory from in-IRQ?
> >This could trigger a lockdep splat if the local-lock in SLUB is acquired from in-IRQ context on !PREEMPT_RT.
> 
> Hi, I  will move qlist_free_all() from IPI context to task context,
> This operation and the next release  members
> in the quarantine pool operate similarly
> 
> I don't know the phenomenon you described. Can you explain it in detail?

If you mean by phenomenon my second sentence then the kernel option
CONFIG_PROVE_RAW_LOCK_NESTING will trigger on !PREEMPT_RT in a code
sequence like
	raw_spin_lock()
	spin_lock();

which is wrong on PREEMPT_RT. So we have a warning on both
configurations.
The call chain in your case will probably not lead to a warning since
there is no raw_spinlock_t involved within the IPI call. We worked on
avoiding memory allocation and freeing from in-IRQ context therefore I
would prefer to have something that works for both and not just ifdef
around the RT-case.

> Thanks
> Zqiang

Sebastian
