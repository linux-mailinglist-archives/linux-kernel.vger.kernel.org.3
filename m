Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9145B2742
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIHT5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIHT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3945FDBB9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662667043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=zYQznb7UCgAsj1nSAP7Hka8AefENrite35msFZDyBWs=;
        b=eW7UBO/voCe5SvN2hS/ANPTgCZtZ7qA7hgbQulmLRoWPVKIIfNh6T8c5JKllY6ClSzvtJS
        A/sthbrHd/Lb/4sumooexL9tR+ztguGfAhXos4aAEK0L/67gekDUqHxo9IPSDQ4Td4mT3O
        F2vPdaNvSz08V+l2w/HNzvssC9aZ9sg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-8fX44FGMPyu1Ii8SboH5_w-1; Thu, 08 Sep 2022 15:57:19 -0400
X-MC-Unique: 8fX44FGMPyu1Ii8SboH5_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A64B803520;
        Thu,  8 Sep 2022 19:57:18 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E4E32166B26;
        Thu,  8 Sep 2022 19:57:18 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 1FECC415CD52; Thu,  8 Sep 2022 16:54:07 -0300 (-03)
Message-ID: <20220908192859.546633738@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 08 Sep 2022 16:28:59 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Prasad Pandit <ppandit@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 0/7] cpu isolation: infra to block interference to select CPUs
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of codepaths in the kernel that interrupt
code execution in remote CPUs. A subset of such codepaths are
triggered from userspace and can therefore return errors.

Introduce a cpumask named "block interference", writable from userspace.

This cpumask (and associated helpers) can be used by code that executes
code on remote CPUs to optionally return an error.

Note: the word "interference" has been chosen since "interruption" is
often confused with "device interrupt".

To protect readers VS writers of this cpumask, a per-CPU read-write
semaphore is used. This is acceptable since the codepaths which 
trigger such interferences are not (or should not be) hot.

What is proposed is to incrementally modify code that can return errors
in two ways:

1) Introduction of fail variants of the functions that generate 
code execution on remote CPUs. This way the modified code should
look like:

        block_interf_read_lock();

        ret = smp_call_func_single_fail() / stop_machine_fail() / ...

        block_interf_read_unlock();

This is grep friendly (so one can search for smp_call_function_* variants)
and re-uses code.

2) Usage of block interference CPU mask helpers. For certain 
users of smp_call_func_*, stop_machine_* functions it 
is natural to check for block interference CPUs before
calling the functions for remote code execution.

For example if its not desirable to perform error handling at
smp_call_func_* time, or if performing the error handling requires
unjustified complexity. Then:


        block_interf_read_lock();

	if target cpumask intersects with block interference cpumask {
		block_interf_read_unlock();
		return error
	}

	...
        ret = smp_call_function_single / stop_machine() / ...
	...

        block_interf_read_unlock();

Regarding housekeeping flags, it is usually the case that initialization might
require code execution on interference blocked CPUs (for example MTRR 
initialization, resctrlfs initialization, MSR writes, ...). Therefore 
tagging the CPUs after system initialization is necessary, which
is not possible with current housekeeping flags infrastructure.

This patchset converts clockevent and clocksource unbind, perf_event_open
system call, and /proc/mtrr writes, but there are several more users
to convert (eg: MSR reads/writes, resctrlfs, etc).

Sending this as an RFC to know whether folks think this is the
right direction.


