Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB247BCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhLUJgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:36:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233216AbhLUJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640079361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2FSzsZgNLWGLz0XhMjKaJvgHqsF7frzjYDf7l6DD9o=;
        b=g9QtzznVJpHglbobaAtj2IIqmDTDSjyjq+id+Kx11qYPb3A4pwkLSMe3Aix1UQcwOP5b9B
        96kRDZNo5rWGcDvuoimH0Bk8sKS/aoQqG7vSFDY/5Qw1GpRSAyn0yEhg6F/PyglKZZxBE2
        xMyGOBSfWaZMwdJIN1aWYZh5e5Y5VO4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-hpSxNQDwPBS5VVoS0c0Xaw-1; Tue, 21 Dec 2021 04:36:00 -0500
X-MC-Unique: hpSxNQDwPBS5VVoS0c0Xaw-1
Received: by mail-wm1-f72.google.com with SMTP id p22-20020a05600c1d9600b00345a25ea8cfso882669wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+2FSzsZgNLWGLz0XhMjKaJvgHqsF7frzjYDf7l6DD9o=;
        b=2Y/xSJnNWTOhGObkrBmMlhSqssKPuy84qI1bR38IHEvduXn+lg0c4O5nTkLVkt/VYw
         nXyx7yFVhcMhG/3crUouteYMPRfT9WDDD/5lKIw3v2iaX8CUkxKyO9bqzw4Qehm6vCAd
         HQuI/pnjLLLFAnUvyqZCs/qRQTLCVl+2n7OTREf+xJyCTDbDdfUmTxGEdcle6EsEtgT7
         rTQ3W6qThrmzIa/bqkc2WwUQbSspfjsapi9/Nto9z0nvmlYhwGOpwk//B/0pbZ/0jrsG
         lDJfWSYOFvhSNTpG4nMqv+bVWS5CJgPj0bwsbERtr+dAdaPrupkeEtNimJ58nS4+P/+j
         7+wQ==
X-Gm-Message-State: AOAM5312C1WSev0/t60ggZyBd34dWyGTWGdK9DHQDJD+ysbNW2qe6WEX
        uycC5kKYQ/vuoXixYFUIILiLw+3DBFOzbNWPhsvcBm+elq2VDbUo1SsG9Dd6J6KvkQZrrakEVjT
        Q/QgYX/NBvafUeZiwLTmPi9VB
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr1833666wri.197.1640079359334;
        Tue, 21 Dec 2021 01:35:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/1aAdXtJSPl2esQ9FVWb9gI7srtciCVYmg1Xivyel9J/heXzg+Wlcav85MQtWHeLh0gkclg==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr1833656wri.197.1640079359208;
        Tue, 21 Dec 2021 01:35:59 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id r11sm17559494wrw.5.2021.12.21.01.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:35:58 -0800 (PST)
Date:   Tue, 21 Dec 2021 10:35:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf pmu: Fix event list for uncore PMUs
Message-ID: <YcGf/d5PPqqyXxUW@krava>
References: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
 <YcGJJ2g+i5qWea7d@krava>
 <bbf9c0b4-c048-3adf-5282-2355aa648acf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf9c0b4-c048-3adf-5282-2355aa648acf@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:10:37AM +0000, John Garry wrote:
> On 21/12/2021 07:58, Jiri Olsa wrote:
> > > +	/* Different names -> never duplicates */
> > > +	if (strcmp(alias_a->name, alias_b->name))
> > > +		return false;
> > > +	if (!alias_a->pmu)
> > > +		return true;
> > > +	if (!alias_b->pmu)
> > > +		return true;
> > nit could be:
> > 
> > 	if (!alias_a->pmu || !alias_b->pmu)
> > 		return true;
> > 
> > would be great to have more comments explaining the check
> > 
> 
> This is just a sanity check that both strings are non-NULL as we do a
> strcmp() next. So would this be better:
> 
> if (!alias_a->pmu || !alias_b->pmu || !strcmp(alias_a->pmu, alias_b->pmu))
> 	return true
> 
> ?
> 
> It will spill a line.

sure, it cought my eye because the is_cpu check later is done on
the same line, so I started wondering what's the difference ;-)

jirka

> 
> Thanks,
> John
> 
> > thanks,
> > jirka
> > 
> > > +	if (!strcmp(alias_a->pmu, alias_b->pmu))
> > > +		return true;
> > > +	/* uncore PMUs */
> 
> 

