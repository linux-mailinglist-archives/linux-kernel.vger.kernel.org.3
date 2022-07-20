Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5CD57B8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbiGTO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiGTO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:57:35 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC574198D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:57:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m16so9570292qka.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ZdJHosg5SmguSr4QYtxRtnSRmNzmgYCrlbvAvjhF6/8=;
        b=hRSjO53dVDoKv6d15hfNA3BC5lcv7CxBEeYh9CIxq3gcNun87ZyiKkiWkEzUicgnUz
         Nvnp43sKvYQKW6IRLggs4vplH/qyuwBt5crtLtbdqcs/wFExjVn6+Y5XhTIBuJdpT+2D
         xwRlxQAp78i6v1YboKPRL3qm1bz3hn7MRYWIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ZdJHosg5SmguSr4QYtxRtnSRmNzmgYCrlbvAvjhF6/8=;
        b=Z7D3/xCbK0mx3s9ZXkKcjF3zK0YJuzY2otYu34Lxqxt69b19LFUTD+USpxzF6cf3s+
         BG4Sgo3rvQxVOJR6MwH5SF8lIjwTGVMWUsrD/oPD9e2JF79nGyRf3TfgZLJu/RD6eXeW
         SdDsBfb1BVPZZwc/kjy7JZW07g88rGDYXCeNbquYnrlEvoTWtTLK/9kc78S2BrAvsakt
         cZcsruXdn56jcOyS94Jug/phe8ZVhasRQxKbYzUk+AodZkicvcEuPAgutBjW83s7DbBw
         4BKvRT6dRQDfpFvexXt6yhIlqZcgokwunCJ7srwRGCIxevOJjmXbJPRXYmWNa3ySZN8P
         +0bQ==
X-Gm-Message-State: AJIora+4n/+zL4WEoGH4m7AUYpjmx0dHWHOeGyfMWv85pMITzvL/TYio
        C4eSBV0rdBmjzSrORH/1KtyKKA==
X-Google-Smtp-Source: AGRyM1vZMOndY5DuYvJ5pG59Q5tSNSJxmUr3eLkPLRc+k+VywfIspm8uleg4BanjD5/33wKSVjpSZQ==
X-Received: by 2002:a05:620a:942:b0:6b5:c733:eeb6 with SMTP id w2-20020a05620a094200b006b5c733eeb6mr19150846qkw.473.1658329053721;
        Wed, 20 Jul 2022 07:57:33 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a284700b0069fe1dfbeffsm17269404qkp.92.2022.07.20.07.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:57:33 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 20 Jul 2022 10:57:32 -0400 (EDT)
To:     Ian Rogers <irogers@google.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 3/3] perf test: Add user space counter reading tests
In-Reply-To: <20220719223946.176299-4-irogers@google.com>
Message-ID: <b17c9045-80be-f658-d362-f13040ac9484@maine.edu>
References: <20220719223946.176299-1-irogers@google.com> <20220719223946.176299-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022, Ian Rogers wrote:

> These tests are based on test_stat_user_read in
> tools/lib/perf/tests/test-evsel.c. The tests are modified to skip if
> perf_event_open fails or rdpmc isn't supported.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

> +		.type	= PERF_TYPE_HARDWARE,
> +		.config	= event,
> +#ifdef __aarch64__
> +		.config1 = 0x2,		/* Request user access */
> +#endif

should this value have a name rather than being a "magic constant"?

Vince
