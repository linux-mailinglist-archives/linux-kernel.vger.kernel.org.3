Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB5054D07C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347069AbiFOR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243685AbiFOR5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:57:12 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2FD544CC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:57:11 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d23so9357023qke.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:mime-version;
        bh=lUE1wMAUhn3kDY9KTIDAYl8As1JumgEjfydHKTXBoMA=;
        b=UWiV+IKLfovZ0BMALPQiVyjiWYDSwQjf/lH3EyiJcqf1sGrFa9gWqv1UgYKIEotxDK
         9pfzIcBtAQoovKOvqxNUaBKSI1Fg5CEL0GGtA8Tpq3gqQt4haQyD0qeeDfzPxSlzcX9Q
         rv6g+VqLqiM0sbc03LRWTiXOe5rhouubMjflU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version;
        bh=lUE1wMAUhn3kDY9KTIDAYl8As1JumgEjfydHKTXBoMA=;
        b=392jmihUFiJWrOcmJmgpLnDQkmuCkR7y+l2LLKU3OJSvtOz46sdB0gNv6vqTJGLH39
         TI2SqVDlyRpYDk5CDib1G2THwV9959NkHXxXqdJQ763QhDsZqEOxA7mhbSYWmsxQtsY3
         0SSunC63LkEa+np+iK45prI4t5a/uEeIEZh3Kje5PxEafL60qKXEwROTsp9vd+UsOH4l
         fq9hmsuDZcPl5Dd2eD9bnQ+zQJKgqzspYg/ubAjQhTRn0olFMxkAN6j+rmIa9NMS/gFz
         b7k8Geyj0SZFXeEEu3pnACiObIj/sxc705ZoZdiG9EdbcpYHYayIlxpJly7chc8ZD1F+
         Itlg==
X-Gm-Message-State: AJIora+nw56z2/Kk3dNtam/L1V/7GnrsRx66lkrlj5KzhYL1wjRbcnAt
        X1DZOY42A2jgYpyKgK3vUzRMAkoIH28hsg==
X-Google-Smtp-Source: AGRyM1vMLNv5LCOOU21DkgjrnWPbkBrClGJuiXoZyFYP/yNZz3BJ/0L0FVWKnHb/Puwp1Jk0RvbucQ==
X-Received: by 2002:a37:6b47:0:b0:6a7:48d:e64a with SMTP id g68-20020a376b47000000b006a7048de64amr729185qkc.112.1655315830505;
        Wed, 15 Jun 2022 10:57:10 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id cc23-20020a05622a411700b00304f98ad3c1sm9327430qtb.29.2022.06.15.10.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:57:09 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 15 Jun 2022 13:57:03 -0400 (EDT)
To:     linux-kernel@vger.kernel.org
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [perf] why is /proc/sys/kernel/perf_user_access ARM64 only?
Message-ID: <30d95df2-c3b-b3e3-d65e-c6be0355fb1@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just wasted a lot of time tracking down why rdpmc() event reading wasn't 
working on an ARM64 machine.

It turns out ARM64 has added a custom
	"/proc/sys/kernel/perf_user_access"
to control rdpmc access, but only on ARM64.
	e2012600810c9ded81f6f63a8d04781be3c300ad

Why is this ARM64-only?  Why isn't this generic perf infrastructure?
How is this different from the existing
	/sys/bus/event_source/devices/cpu/rdpmc
tooling?

Also, when user events are disabled, why is the ARMv8 PMU not disabling
the cap_user_rdpmc bit in the perf mmap() page?

rdpmc was trouble before, but now it's an even bigger 
architecture-dependent mess just trying to figure out if the feature is 
enabled or not.

Vince
