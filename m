Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CDD54FE28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbiFQULj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244439AbiFQULi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:11:38 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C631ADA2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:11:37 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 43so7986986qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:message-id:mime-version;
        bh=c6HUnYkSdwKF6VwZqapAdI/2A9eVLq9BatAO2vrrJnw=;
        b=IX2PByp4AaPYCaHsl6YaKxCQDBLcbzVfewb/i5gDZJp4jC5hZnUusDaeihpND2VR3b
         2sZT0iz0pv92t3hD0zp1TvJBu9l8dLLbEi7+msWg7AfZOIXgxBr5+apxMEFg4MuWs2ty
         lLkNS/F1s2iGiJZURZjQDd3QjCpnH5JBlqEoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:message-id:mime-version;
        bh=c6HUnYkSdwKF6VwZqapAdI/2A9eVLq9BatAO2vrrJnw=;
        b=C/E5++CxqZEvBUKaIdF85dW5Wth7SdvmmatKkUNlXZ9MT0Hw21+TzveMnawTrwGRN5
         tjgJVGcE+wRbn6kNCsbn0U555NKAVAdo7T4tByTu+unNz7z78nY02MaOXU5ysy7J1C5v
         SfOeWmnD3K8mK419oHHrJZf8bNQGWEc2SIwtgQ9+vLqHUTHMJBE2XRyY8bZdUDXcp97S
         P+L3Cp/cru2o1o/+JD7psFlDoUpOlJBxNUVvbu8LNNEgUop1ZGqd8O2KWg9afT1ZzjIm
         L6YK16M20OwTxfs70gmH295VCZlKed7hsKgih98rxru4Ktau4yzmLoGC55YZKaTBoQIM
         W4dg==
X-Gm-Message-State: AJIora+439SUOCzIBOm2P2w1hXmTQ+pFQZC/UxjVGvHdISr/99rNlhk9
        YZNn9E/Xz4od1ZJEg+HnS+aU9AtOuvZKsQ==
X-Google-Smtp-Source: AGRyM1uH6N33lIH+urBS+pxdMchukdpm2KfvwVdoRWcIoCCFoYOXcO7VRs/OEyCpGYrMfI3DsYiOlg==
X-Received: by 2002:ac8:5e4f:0:b0:305:1e3d:b829 with SMTP id i15-20020ac85e4f000000b003051e3db829mr10040332qtx.471.1655496695881;
        Fri, 17 Jun 2022 13:11:35 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id y29-20020a37f61d000000b006a3325fd985sm5011152qkj.13.2022.06.17.13.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:11:35 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 17 Jun 2022 16:11:34 -0400 (EDT)
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>
Message-ID: <db2031ec-cf4-4323-9d3-8262849add3d@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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


