Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2087F46C14C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbhLGRHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:07:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239784AbhLGRHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638896663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXSzrQOI/K5tZY+kjNzeUmFO3T6QyzyAUaamIjn3uk8=;
        b=idxzV9kQzsXkoybSf6uoXg5hjn0hT0lMfZuzD3VaHuEZhPL4aLG0Dc81Vxzx7tna+6iH2V
        DkanrNNylOgnhh4qV5orPcZR9Ety1soGhMJ03XHWecl1bzChMqsfQWYB1u2JAmHIQlL0QA
        4hknGj07YRFHOfJiiltLbYLBS634Zf4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-bWCt9y2KPC6IlDjqg2EroQ-1; Tue, 07 Dec 2021 12:04:22 -0500
X-MC-Unique: bWCt9y2KPC6IlDjqg2EroQ-1
Received: by mail-ed1-f71.google.com with SMTP id c1-20020aa7c741000000b003e7bf1da4bcso11910018eds.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IXSzrQOI/K5tZY+kjNzeUmFO3T6QyzyAUaamIjn3uk8=;
        b=vw+qZjdUNb6BvoleAoySPMIBwXLVSO1y9G3Cj56UHbFS71yPceqopt7UPPGl3O4ox6
         NJMw0Qx4Ov8HQkCSwQAtPVOnPBjJEq+DxCaf6wxYjfAFtOsEC19129FpW8omqiLQXzRJ
         a8hoh60au+sS1growqUja4bs1Xk1zkGofIpxDrcdUuMtMOwDzQkngATSru0f+rzibQ+K
         +Cu6axUP0Y8PXKVbwijVKuVUvBcl/Rh6IPVkbL/iwiu7e45HVEzyqBL7ynGhXOC5emjc
         xo39yUoN9T35yulwBWQlLUKqqbW2qZCtSMXvVVUbqMQlxP2+hjnZnhlcxA0UAPlZeevH
         llmw==
X-Gm-Message-State: AOAM530afijeqFd00FXmcHgifnrQQ/wPwnNPORfCKDTrZaAPGodfMI6T
        UONv2tgDRObAoUjr1/6SmWM29BAbsGSfwXNdCwVNIGx0IJ6Wqx4atEON9Nr3DzI7UhcmGKGTwQR
        bKLP5qkUVA2uJL5E88jFVGz2S
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr11175893edz.96.1638896661288;
        Tue, 07 Dec 2021 09:04:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwAgfWRJ0ycKbIJkQMQpvQquErHiSiNvlEGv/U09VDwMX7lCMbFfZBtuIWHyyCb05mtdvIrg==
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr11175865edz.96.1638896661130;
        Tue, 07 Dec 2021 09:04:21 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id y15sm202023edr.35.2021.12.07.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:04:20 -0800 (PST)
Date:   Tue, 7 Dec 2021 18:04:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: libperf: lack of interface
Message-ID: <Ya+UEn+qjUEzgKfq@krava>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YS+B6PVHtiTmqZS+@kernel.org>
 <YTCOVGyffe+VwL6G@krava>
 <OSBPR01MB4600E7C8C79D64125270D034F7A19@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB4600A616AD3341EAF6AA3DE8F7BC9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YXAJhTC9aqOS/GWy@krava>
 <OSBPR01MB460067F4CE80D8EF6B707D4CF7809@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB46002D1F64E2349CA9E742A4F76A9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB46003CB99B9AAC0A574D341DF76E9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB46003CB99B9AAC0A574D341DF76E9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:49:16AM +0000, nakamura.shun@fujitsu.com wrote:
> Hi jirka
> 
> > > > On Mon, Oct 18, 2021 at 08:57:20AM +0000, nakamura.shun@fujitsu.com wrote:
> > > > > Hi
> > > > > 
> > > > > > > On Wed, Sep 01, 2021 at 10:36:40AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > > > Em Wed, Sep 01, 2021 at 09:45:10AM +0000, nakamura.shun@fujitsu.com escreveu:
> > > > > > > > > Hello.
> > > > > > > > >
> > > > > > > > > I'm trying to change rdpmc test in perf_event_tests[1] to use libperf, but libperf doesn't have enough interfaces.
> > > > > > > > > Does anyone plan to implement any of these libperf features?
> > > > > > > > >
> > > > > > > > > - Interfaces that can run ioctl (PERF_EVENT_IOC_RESET) from userland
> > > > > > > > > - Interfaces that can run fcntl (SIGIO) from userland
> > > > > > >
> > > > > > > hi,
> > > > > > > we could add perf_evsel__fd like below, would it help your usecase?
> > > > > > >
> > > > > > > if you described your usecases in more details we could
> > > > > > > see if we could add/move something to libperf for that
> > > > > > >
> > > > > > > as Arnaldo said below it could be already in tools/perf/util/*.c
> > > > > > > somewhere ;-)
> > > > > > 
> > > > > > As Peter says, I understood that for rdpmc, no reset is needed.
> > > > > > 
> > > > > > However, PAPI resets it explicitly, for example, at PAPI_reset.
> > > > > > In other, PAPI also has the ability to call PERF_EVENT_IOC_REFLESH on overflow to call a user-registered handler, using SIGIO.
> > > > > > 
> > > > > > I think it is desirable to be able to achieve similar functionality.
> > > > > 
> > > > > Does anyone have any comments?
> > > > 
> > > > I'll try to add that functionality soon,
> > > > I'll cc you on patch
> > > 
> > > Thank you.
> > > I look forward to your patch.
> > 
> > Do you have a specific plan? 
> > I would like to know the rough period until your patch is made.
>  
> I will also try to implement these interfaces.

sorry for late reply, please do

thanks,
jirka

