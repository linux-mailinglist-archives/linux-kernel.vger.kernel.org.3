Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408334E3DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiCVL7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiCVL7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:59:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2F323BE0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:57:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h16so10050102wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hLtfvRdZCZE7DrPVlS8YfsRhGZmzIPo7skcuEYSO4hw=;
        b=j+9e3zTSe7YMjvusq8VyhZY8Obm1Kcc84Veo/LfnBMvLWNPygsyrEsf+RY0OIJLaFq
         2qrQXWhRsxbJStpyY1JXXNOpzqUs4y9+tbRNniXopvJSP4ZIKD4g4f/mg/fQV7uzARsQ
         A6biV9wAj972M4YbMUVyHjZNliIG5QZI2oZNIGMV1waqfp2D5sNp1G5is4pS3hDHy0Wv
         Ch/lV6rhzQxdqpDjOdf9zM3vMdVZuN29JoaNmAnD9i8HYWK/gYQHuBM+xRk9M84sLOK+
         18oShMvbAI6J+YyNyMl4sFCFFVIzwl9a0MxmOjckbFGduxwz2vGqZuARwkxYRyZ1YqB9
         0u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hLtfvRdZCZE7DrPVlS8YfsRhGZmzIPo7skcuEYSO4hw=;
        b=a0iFpW4JuZpyA4smzgsHU+GE7sLLXFyBfHaeAxv+VFy+03ue4nob5b9LchwSKwPe+S
         fRTKzpW/NQogPTn5jQBuRHYNxB88pTrF7r1VFDnXdLRbNsCLC/NgVvM/ZrcGNJ6afE5p
         mG3/ZS+GRPga9a+k5IVsTaYiQlK658xpXpd43iG5kEArCoK62J7VwgXKnWrc6uD4LKsp
         xuI0gdpFMa4AdZdhmsFUP9ofeZcI2ZhuBxcl7YhcQ6D0b64yU+cPMHIbJndF7jxd179z
         UgM+vV1mgKyjPWHXwSqZwxqSi63CeS5gMf+YAR0+n4QBW7MGurnkkU/MPg3jluqKG0eH
         S/3A==
X-Gm-Message-State: AOAM530p7ep5/up1VtQPYL/u5UKVM157AOdUOrlWU3VftSPcJZcd4TNZ
        cQHdUrdJxl08ZdQCB30icDvmlg==
X-Google-Smtp-Source: ABdhPJyNqqUErWG52sDeu7pVzR3d0PgnXUIIgLZtllrYMoG+RJX1I7Iq+B2wvNyxlO0RIJXxVMt8TQ==
X-Received: by 2002:a05:600c:3b86:b0:38c:afdf:66cd with SMTP id n6-20020a05600c3b8600b0038cafdf66cdmr3361285wms.198.1647950262573;
        Tue, 22 Mar 2022 04:57:42 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b00203f8c96bcesm9981236wrv.49.2022.03.22.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 04:57:41 -0700 (PDT)
Date:   Tue, 22 Mar 2022 12:57:38 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Message-ID: <Yjm5stBpRC0g4G8s@google.com>
References: <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
 <YjDUO6bbyfGw/u0C@google.com>
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
 <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
 <YjHfGrZovk3N/H0f@google.com>
 <371faf0d-f794-4a2e-0a1c-9d454d7c8b12@intel.com>
 <YjhUjotmo+kYvoNP@google.com>
 <ffa56520-09b5-9c5d-7733-6767d2f8e350@intel.com>
 <YjiuoEUL6jH32cBi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YjiuoEUL6jH32cBi@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 05:58:08PM +0100, Steinar H. Gunderson wrote:
> but I'm seeing problems with “failing to process sample” when I go from
> 10us to 1us, so I'll have to look into that.

I took a debug log from perf report; the last few lines are (I abridged
some symbol names):

symbol__new: cppgc::internal::MemberBase::GetRaw() const 0x6078a90-0x60792d0
symbol__new: cppgc::internal::BasicMember<...>::Get() const 0x6078a90-0x60792d0
symbol__new: cppgc::internal::BasicMember<...>::operator->() const 0x6078a90-0x60792d0
__symbol__inc_addr_samples: addr=0x5561dc37cbf6
__symbol__inc_addr_samples(896): ERANGE! sym->name=void blink::ElementRuleCollector::CollectMatchingRulesForList<...>(...), start=0x6074310, addr=0x6078bf6, end=0x6078a90
problem adding hist entry, skipping event
Intel PT: failed to deliver event, error -34
0x5739a8 [0x8]: failed to process type: 68 [Numerical result out of range]

and this is evidently fatal. So for whatever reason, the sample address
is attributed to some symbol, and that symbol is assumed to have a
single range (is this even necessarily true?), we refuse the event,
and then we fail the entire report. (It doesn't happen with --stdio,
though!)

I'm a bit at a loss how to debug this. It doesn't happen without the
inlines being synthesized, but I don't know if there's something wrong
with it, or if it's just the symptom (I've certainly seen “failed to
process sample” without PT before).

/* Steinar */
