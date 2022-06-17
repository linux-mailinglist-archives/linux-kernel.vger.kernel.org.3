Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8D454FE27
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344081AbiFQUNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiFQUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:13:26 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552295C35E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:13:25 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id q104so7966474qvq.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:mime-version;
        bh=c6HUnYkSdwKF6VwZqapAdI/2A9eVLq9BatAO2vrrJnw=;
        b=dH4hwY+JUwHqWAOnAMYh+qe4C+Zef5b8t/2v0ZWIpDQgfFra8a1MhYCcJimdS4//xt
         NrDPCFSEbNQwuuksbTvqwPZg5hVEasYajGDsYCNSDtGEt4irD7DmKtmemXhMKCZ30Ulm
         u8EpbvZhHMmUQlD6ngiG4FiwhmzGXOlFK6tLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version;
        bh=c6HUnYkSdwKF6VwZqapAdI/2A9eVLq9BatAO2vrrJnw=;
        b=tbkAHn/bh2gM1Z5fdpzrtkarkxNx7ivBXKy0CtriXv01kFgByh7i4hLzZCASnJ0N0j
         3K7wNtM5AgfvnGi91jc1jtLAoEU1nv6E+kpqlQRHsMhsM3I3o7nxoNsnI0W+BNSMJCrq
         Gytx4kqW7DmsHv7P8XMb8cvzxU/b+fb616qO4bKJlZf9+Dy3mdWvnpboyyMVL6dibPdm
         nYB6pVluiwidj4gT0ed+kmrMYSpLkbWoHo2YFYJmtMYvSUkhmiHjYGzu9BHoVQM0HI7m
         UozPWZT6mz3jr2nMsLpTNlYFedIWsgQwHm1W/yVUurTFYegxAY4Z6rJ0k1vtlmGUg0Cf
         Aipg==
X-Gm-Message-State: AJIora/PKJAgZJQzc7E2w0vSqvP+XVyh1hJEL/8UKNOMeDAX0LWKlQkQ
        qC9MbOrW+9rcSBNgl4h78QoOEbYJ/u40fA==
X-Google-Smtp-Source: AGRyM1tdf19qGWMpde/NBHQopZashJ9qk17WLUuCuLkBlXiGaKUuDFYm2QcKkO7kpZg8vxf89UK7pA==
X-Received: by 2002:ad4:5bc1:0:b0:42c:531c:ef12 with SMTP id t1-20020ad45bc1000000b0042c531cef12mr9984516qvt.15.1655496804161;
        Fri, 17 Jun 2022 13:13:24 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id z13-20020a05622a060d00b00304eb8e880dsm5689926qta.23.2022.06.17.13.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:13:23 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 17 Jun 2022 16:13:22 -0400 (EDT)
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: READ_ONCE() usage in perf_mmap_read_self()
Message-ID: <f26be5e-af31-a996-9c7-86d9d1ed4b2@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
 
Is the perf_mmap__read_self() interface as found in tools/lib/perf/mmap.c
the "official" interface for accessing the perf mmap info from
userspace?
 
Are the READ_ONCE() calls required?  If they are left out, will accessing 
the mmap interface potentially fail?  Has this ever been seen in practice?
 
Part of why I am asking is both
 	tools/lib/perf/mmap.c
and
 	tools/linux/compiler.h (which defines READ_ONCE)
have SPDX headers indicating they are GPL-2.0 licensed, which means it 
seems like it would not be possible to easily use the perf mmap interface 
from BSD-licensed code.  Would it be possible to get those two files 
re-licensed?
 
The (BSD-licensed) PAPI is currently using a mmap reading interface 
based on early documentation for the feature, but it isn't 100% the same 
as the version from libperf (and isn't using READ_ONCE).  Life would be 
easier if we could use the perf version of the code because then we would 
have one less variable to deal with when trying to track down issues.
 
Vince Weaver
vincent.weaver@maine.edu
