Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C4B5825EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiG0LyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiG0LyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 062784A82C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658922844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SP1w57fp+hsZfYQJGgHW7plV6UUJj5FwbpNViuY4GCs=;
        b=Qt6J40cxjcqf1Yk0hgPSJWZ1okLgsJfDtV1fkpdcnfJUmCEYzkVht+1UDzKkTROF8oIloJ
        JxawZUqGa6HkGWHUuYcv+1D0jrAm/zPtbjT+ktEwvzoQUGNQVbbBi/3fPpJ0BnmN7BjcXu
        zda9MRlHvyBIz5frEUtjRSg5QuTS7Oo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-fX3ZYiNKPRqnjjdIF_Dv0w-1; Wed, 27 Jul 2022 07:54:03 -0400
X-MC-Unique: fX3ZYiNKPRqnjjdIF_Dv0w-1
Received: by mail-wm1-f72.google.com with SMTP id k27-20020a05600c1c9b00b003a2fee19a80so1069703wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SP1w57fp+hsZfYQJGgHW7plV6UUJj5FwbpNViuY4GCs=;
        b=H1unvAxcRB1W6KxioLOrj78pNj3yBYXnRPxxCoZ4pfuI2kR/OVysU52FLQjShRHzyd
         hsc0zEqiOuyIeV4qOZvuAFdiZQ7m/xTOgp4NpxkUHIfO9/UhnlEiEYJXtYx0syPeuwYk
         Rz4ltxic2NMp/o7zPqylh8zIPDtwwkiSRE0y+f9J5O5m3HFW9wT+T0Fq0k3sNeiBYiHE
         F0tWgdR2U+QuMT8RWWJ93KuRi0e8CqLQqsiEDVuRAAu5HNjWuqOTkWQ30x+pRDe9fR6N
         Y5PU33v9cvSJGIyqnzMt3gORy499RCeJx7ztO4SjhiYVM2sbv+ldVccdikxe/ts6Bdhn
         V0/w==
X-Gm-Message-State: AJIora8fChadQ7TD5VT5XKoaMcyM7Tsoz/GzW9DEgXP/QLIJrGWS9uEE
        rrewIyebnMh1sdwWhJAayk2YnmNkT1/AOBUwDWXxb2sRTNW03fnx/ra2uU5orgNkfXX1dv6k0ht
        Njl7g0o+xXtXfSc7Mji/YAjkQzigsoiV52CAAYnYt8JAoYp3TttxDVzbS+7a1Am6kl+S293NeZD
        IT
X-Received: by 2002:a05:600c:1da2:b0:3a3:10ed:43ce with SMTP id p34-20020a05600c1da200b003a310ed43cemr2786055wms.136.1658922841629;
        Wed, 27 Jul 2022 04:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s7ybqxZF480cQSyfocffyoNNa/Jrqy7+HmyFGSQO9KzmBF4+VCLUdr+Fldxd1xuHDVW6Ip2Q==
X-Received: by 2002:a05:600c:1da2:b0:3a3:10ed:43ce with SMTP id p34-20020a05600c1da200b003a310ed43cemr2786033wms.136.1658922841294;
        Wed, 27 Jul 2022 04:54:01 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m64-20020a1c2643000000b003a30af0ec83sm2046838wmm.25.2022.07.27.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 04:54:00 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH v2 0/2] workqueue: destroy_worker() vs isolated CPUs
Date:   Wed, 27 Jul 2022 12:53:25 +0100
Message-Id: <20220727115327.2273547-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Using a work struct from within the workqueue code itself is a bit scary, but
I've done more rigorous testing than for v1 and it's looking OK (at the very
least locking-wise).

Note that this affects all kworkers (not just percpu ones) for the sake of
consistency and to prevent adding extra corner cases. kthread_set_per_cpu(p, -1)
is a no-op for unbound kworkers, and IIUC the affinity change is not required
since unbound workers have to be affined to a subset of wq_unbound_cpumask, but
it shouldn't be harmful either.

2/2 is a simple and stupid stresser that forces extra pcpu kworkers to be
spawned on a specific CPU - I can then quickly test this on QEMU by making sure
said CPU is isolated on the cmdline.

Thanks to Tejun & Lai for the discussion thus far.

Revisions
=========

RFCv1 -> RFCv2
++++++++++++++

o Change the pool->timer into a delayed_work to have a sleepable context for
  unbinding kworkers

Cheers,
Valentin

Valentin Schneider (2):
  workqueue: Unbind workers before sending them to exit()
  DEBUG: workqueue: kworker spawner

 kernel/Makefile    |   2 +-
 kernel/workqueue.c | 118 ++++++++++++++++++++++++++++++++++-----------
 kernel/wqstress.c  |  69 ++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 30 deletions(-)
 create mode 100644 kernel/wqstress.c

--
2.31.1

