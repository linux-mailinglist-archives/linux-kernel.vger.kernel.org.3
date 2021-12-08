Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5946D1B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhLHLPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLHLPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:15:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ACBC061746;
        Wed,  8 Dec 2021 03:12:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so3942418wme.0;
        Wed, 08 Dec 2021 03:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=378xPFp5hnCamLfI3QIia2J4E80vAdBkgnbCBVjGhgM=;
        b=mkkuaKIXZahpy5kT86GjsXK/OKt+cTz2CN7v/s8LIhXZr5TO+HUJCaC/hWOxTmjX+s
         Jae5uLCMv8m9TpKvfogCntnR8GlQnplfhT5lAJm0XJ+zXJyvffTTBgBoAFROkpv/flnL
         vdBzp//v3YuwkJWJ3YYOIhcaplDJTEwsnuJAAp9fuw1qMlR9k9ySeutSeDPgil5/tD6M
         xSEMdiWXLPmw1tRjQIb0SnQC8QMKD+pa2NXnsokb/WD0YW7YHykoL2sHfxt38n2QjvGz
         R0CXJAUQrKnfuAe0s3Gg1h1IcIpXXVhPV6I1rN8FRcbiuhUiwHgqQHpoRxmgN88bVAHo
         JjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=378xPFp5hnCamLfI3QIia2J4E80vAdBkgnbCBVjGhgM=;
        b=n46dPt0hYpfnvHCYTJ+Ca0BHyGzC0uDqbPoaxThvQaKj9QitUjddyfsjqNf6YdO7YM
         BQuKxdRxafzveSMmPeH1EDIZgG7I3qCNVSCQIcSyjTfWBPrpqZkJzvDYKDAObsilYqea
         B4vKWsj/MEXAfmJCQApSUS2lbt35+dQZfKxL/Ab28alaXWfFWpiyucwwx1n/CmMl4U2M
         UTMIT8TOH4xw38dS2Pqwodxr+nsbkD7KS+t8+8HITFOZbZH95RfXT6k1p8GwXvhQJVFB
         XGkOagI5SQyscF9bRQ1O0kbXYI5HaeFMM9/wvgCHIgPm3J5FUK5K05XODNX/p5cWJ1Ys
         QgHg==
X-Gm-Message-State: AOAM530db9Tk+czHulxCcrphqEkZznebfjNZKXV2u4rdxiU0kUTvhyk/
        GjWUx22PiztUFYBwl1P3E16gAdGM9FA8Dg==
X-Google-Smtp-Source: ABdhPJxqKtlzI1MNYNzXPJaKaSyzT4pPm8tYDAZCBZmhub+p0NpJ2nxG1wCV+6NoqQsfqncP3fb2Cw==
X-Received: by 2002:a05:600c:3ba5:: with SMTP id n37mr15144038wms.168.1638961921009;
        Wed, 08 Dec 2021 03:12:01 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id w17sm2399874wmc.14.2021.12.08.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:12:00 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Wed, 8 Dec 2021 12:11:59 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf dlfilter: Drop unused variable
Message-ID: <YbCS/xEis4QKbH6D@eldamar.lan>
References: <20211123211821.132924-1-carnil@debian.org>
 <5603b487-3e42-cfbd-200b-250c46dc0bc6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5603b487-3e42-cfbd-200b-250c46dc0bc6@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Wed, Dec 08, 2021 at 10:44:01AM +0000, German Gomez wrote:
> 
> On 23/11/2021 21:18, Salvatore Bonaccorso wrote:
> > Compiling tools/perf/dlfilters/dlfilter-test-api-v0.c result in:
> >
> > 	checking for stdlib.h... dlfilters/dlfilter-test-api-v0.c: In function ‘filter_event’:
> > 	dlfilters/dlfilter-test-api-v0.c:311:29: warning: unused variable ‘d’ [-Wunused-variable]
> > 	  311 |         struct filter_data *d = data;
> > 	      |
> 
> Did you get this warning when issuing "make"? From my side, it generated
> this gcc command so I didn't get it (make DEBUG=1):
> 
>   gcc -c -Iinclude  -o dlfilters/dlfilter-test-api-v0.o -fpic dlfilters/dlfilter-test-api-v0.c
> 
> Reviewed-by: German Gomez <german.gomez@arm.com>

Only when passing -Wall (this is the case when building the kernel packages in
Debian with additional flags, so this is why this was spotted):

gcc -Wall -c -Iinclude  -o dlfilters/dlfilter-test-api-v0.o -fpic dlfilters/dlfilter-test-api-v0.c
dlfilters/dlfilter-test-api-v0.c: In function ‘filter_event’:
dlfilters/dlfilter-test-api-v0.c:311:29: warning: unused variable ‘d’ [-Wunused-variable]
  311 |         struct filter_data *d = data;
      |

Regards,
Salvatore
