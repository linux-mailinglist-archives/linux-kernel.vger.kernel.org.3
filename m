Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E205050E5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbiDYQcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbiDYQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1E1DB1A9C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650904165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K7g3AatLSzn8/HLimbJLWaWvwBPHnQqNizbHt7sJOJ8=;
        b=CythLHqhzFkZvdocx29D+dh4T3KhFkeRuP8jbIzwS9JCVZVjc4leqaLUn+QUi36Y6PDAoL
        ybNC0rkMxt7zXWCbK2sPwFlLbuzJn5+itfh31zggwfEhhV8dcKm6xQh/33IgvsUIP9lolA
        7X9m7dLR7xYMttUldVh0IILtwVSH21s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-AVsaUf9RP2yJGQNI6O5rkw-1; Mon, 25 Apr 2022 12:29:24 -0400
X-MC-Unique: AVsaUf9RP2yJGQNI6O5rkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 099CD1C0513A;
        Mon, 25 Apr 2022 16:29:24 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 293C640CF91E;
        Mon, 25 Apr 2022 16:29:22 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 592EF416F574; Mon, 25 Apr 2022 13:29:04 -0300 (-03)
Date:   Mon, 25 Apr 2022 13:29:04 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 00/13] extensible prctl task isolation interface and
 vmstat sync
Message-ID: <YmbMUAkOxsStAP36@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <20220317150804.GB459366@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317150804.GB459366@lothringen>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:08:04PM +0100, Frederic Weisbecker wrote:
> On Tue, Mar 15, 2022 at 12:31:32PM -0300, Marcelo Tosatti wrote:
> > The logic to disable vmstat worker thread, when entering
> > nohz full, does not cover all scenarios. For example, it is possible
> > for the following to happen:
> > 
> > 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> > 2) app runs mlock, which increases counters for mlock'ed pages.
> > 3) start -RT loop
> > 
> > Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> > the mlock, vmstat shepherd can restart vmstat worker thread on
> > the CPU in question.
> > 
> > To fix this, add task isolation prctl interface to quiesce
> > deferred actions when returning to userspace.
> > 
> > The patchset is based on ideas and code from the
> > task isolation patchset from Alex Belits:
> > https://lwn.net/Articles/816298/
> > 
> > Please refer to Documentation/userspace-api/task_isolation.rst
> > (patch 1) for details. Its attached at the end of this message
> > in .txt format as well.
> > 
> > Note: the prctl interface is independent of nohz_full=.
> > 
> > The userspace patches can be found at https://people.redhat.com/~mtosatti/task-isol-v6-userspace-patches/
> > 
> > - qemu-task-isolation.patch: activate task isolation from CPU execution loop
> > - rt-tests-task-isolation.patch: add task isolation activation to cyclictest/oslat
> > - util-linux-chisol.patch: add chisol tool to util-linux.
> 
> I still see a few details to sort out but overall the whole thing looks good:
> 
>   Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
> 
> Perhaps it's time to apply this patchset on some branch and iterate from there.
> 
> Thomas, Peter, what do you think?
> 
> Thanks!

Ping ?

