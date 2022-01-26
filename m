Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B17B49CFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbiAZQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:48:04 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:43697 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiAZQsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:48:03 -0500
Received: by mail-oi1-f173.google.com with SMTP id p203so641643oih.10;
        Wed, 26 Jan 2022 08:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6gFP0lcd6ItARzuIKDJccK9kwYCNQdLqC4kjVDvDJS0=;
        b=sVNtAZg9zlFSA5nMgRtq2l/9B4bIGaXrz48yrHRlO42dNpQHyRzxGGyeVcru7hcl73
         u9ik48jmW2CCqRnlqfaaDNV+uRxXg5kXL/LbmlwCAPBp30vtdHJWA9wmee5KFPgZn5iy
         Eetk0+eIyrXgNKzkgQ2eaxxjZeVh0jxZVjSOsTYtAjEsxXBrIfLWSbEQ7iXQqb93v1r5
         j6MDRsVkjf6YTArB8rDeYsCmoOq885hxJpdmZlelHHSyYCHicEvcYbZXxTZH5AIsGgiL
         uZ3SNS7ve1em/PuCHCNwO9ZTC+JzkX6vBr4u5nD+VAcv7OFX47YD4v+1nKsRACwouPxi
         6l3A==
X-Gm-Message-State: AOAM533ZMZxTCGoZL2VvP9U4jVsSiF8MMZ4dnfukRK/rRxmbvBtDDDCJ
        ncWVOC0h6UCcFseNQxFyfw==
X-Google-Smtp-Source: ABdhPJwFhyVnuVxL5/czwcl+I12DBt+i8ghW7V5R5zYYXI2C1rc9EfwwMLM20QqzVavhwvZz03q/Ng==
X-Received: by 2002:a05:6808:f88:: with SMTP id o8mr4510928oiw.29.1643215682768;
        Wed, 26 Jan 2022 08:48:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z17sm5037867otk.62.2022.01.26.08.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:48:00 -0800 (PST)
Received: (nullmailer pid 952293 invoked by uid 1000);
        Wed, 26 Jan 2022 16:47:59 -0000
Date:   Wed, 26 Jan 2022 10:47:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC V1 10/11] perf: Expand perf_branch_entry.type
Message-ID: <YfF7P9flt8D2+Kfr@robh.at.kernel.org>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-11-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642998653-21377-11-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:00:52AM +0530, Anshuman Khandual wrote:
> Current perf_branch_entry.type is a 4 bits field just enough to accommodate
> 16 generic branch types. This is insufficient to accommodate platforms like
> arm64 which has much more branch types. Lets just expands this field into a
> 6 bits one, which can now hold 64 generic branch types. This also adds more
> generic branch types and updates the BRBE driver as required.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_pmu_brbe.c           |  7 ++++++-

This patch should come before the BRBE support so that it can be applied
sooner rather than later. If another field is added to the end before 
expanding this field, then you will be stuck with assembling bits from 2 
fields.

>  include/uapi/linux/perf_event.h       | 10 ++++++++--
>  tools/include/uapi/linux/perf_event.h | 10 ++++++++--
>  tools/perf/util/branch.c              |  8 +++++++-
>  4 files changed, 29 insertions(+), 6 deletions(-)
