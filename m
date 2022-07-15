Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37CD57591F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiGOBd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiGOBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 576753ED46
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657848803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u/U2xaa/vsw5f/HwUYz7caI2/KRVjJ8EhiCQx4+NJbM=;
        b=XG9vhSFdsxoQf+Z+Uxdh9jneRbCyLeOp4+stj3BHgkS5iWlKadzpcHpAcrPDJH8r+VHx51
        5xuxdFmrY2WhhsHKkuY1HRRNIdFNDIq6zTz8DxLmDatEnuqH1FPr1uzQy697D3nKyQJQ5W
        iEec4XyaxQ/Y+hP4A8vlBCFrmjIs3bI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-RiRW-v7BNY69kwk-8B8ToA-1; Thu, 14 Jul 2022 21:33:20 -0400
X-MC-Unique: RiRW-v7BNY69kwk-8B8ToA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FF26800124;
        Fri, 15 Jul 2022 01:33:19 +0000 (UTC)
Received: from localhost (ovpn-13-91.pek2.redhat.com [10.72.13.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B1C2166B26;
        Fri, 15 Jul 2022 01:33:16 +0000 (UTC)
Date:   Fri, 15 Jul 2022 09:33:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org
Subject: Re: Unstable tsc caused soft lockup in kdump kernel
Message-ID: <YtDD2WHLiFbceXuE@MiWiFi-R3L-srv>
References: <YrwokiIVX9E9kQIh@MiWiFi-R3L-srv>
 <bf57256f-127d-6f26-404a-b9cff6df70b3@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf57256f-127d-6f26-404a-b9cff6df70b3@igalia.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/14/22 at 04:34pm, Guilherme G. Piccoli wrote:
> On 29/06/2022 07:25, Baoquan He wrote:
> > Hi,
> > 
> > On a HP machine, after crash triggered via sysrq-c, kdump kernel will
> > boot and get soft lockup as below. And this can be always reproduced.
> > 
> > From log, it seems that unreliable tsc was marked as unstable in
> > clocksource_watchdog, then worker sched_clock_work was scheduled. And
> > this tsc unstable marking always happened after sysrq-c is triggered.
> > And the cpu where worker smp_call_function_many_cond is running won't
> > be stopped and hang there and keep locks, even though the cpu should be
> > stopped. While kdump kernel is running in a different cpu and boot, then
> > soft lockup happened because other workers or the relevant threads are
> > waiting for locks taken by the hang sched_clock_work worker.
> > 
> > Any idea or suggestion?
> > 
> > The normal kernel boot log and kdump kernel log, kernel config, are all
> > attached, please check.
> > 
> 
> Hi Baoquan, interesting issue! Do you happen to have a full kdump boot
> log with the issue? Maybe collected through serial console, etc.
> It seems the one attached is from a succeeding kdump by passing
> "tsc=unstable" to the kdump kernel right?

The attached kdump boot log is the one in which kdump kernel is hang.
The 'tsc=unstable' need be added to 1st kernel to work around it. Only
adding 'tsc=unstable' into kdump kernel doesn't change anything since
the clocksouce_watchdog work has been in a loop because of the unstable
tsc in 1st kernel.

> 
> Also, did you try to "forbid" tsc to get marked as unstable in the first
> kernel, before kdump? I mean like a hack code change, just prevent
> kernel doing that and seeing if it works. If that still fails, then it
> seems the cause of the issue is the same as the cause of TSC getting
> unstable - in other words, something would be causing both the kdump
> kernel lockup AND the TSC unstable marking in the first kernel...

As I added later that adding 'tsc=unstable' into 1st kernel's cmdline can work
around the issue. kdump works well with that.

