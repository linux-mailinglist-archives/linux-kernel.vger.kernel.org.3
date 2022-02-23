Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD84C0D16
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiBWHNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbiBWHNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:13:09 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3157B0F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:12:39 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q11so8024835pln.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uuzVN1UJ0wlPIBvc5RuIVNuH89a9Tcx9jYvk/QnraQ=;
        b=UqcYI26jPzt/A9W+XVxcNMYGU4H6L8u+7eyPS2QINEXDuB96ft/dKBVQG4O70cqeZa
         yhZUAqRDIRqT9UKPAtyrP+euVjV32odYSAEn21NK2goWj6cuuNkMbECCMKw9R1/xGVjB
         rfouz12S64OtWfovNfGWyH0OCbInN77kWZSkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uuzVN1UJ0wlPIBvc5RuIVNuH89a9Tcx9jYvk/QnraQ=;
        b=Fgxl5xqG6KYhq5UYvXvW14ZA5LBUEulh1QsPBhdX5sghJRQ0rji6+PhzvDjUjEQ7BH
         Gq/wdRwJ5B23eC3feH0oc4hK7laY3V2Q2iVr1zgwRrGEFNKAaM9pCD7Y0JyPm4QBjj5d
         +fQbimK+7C7QIkutOYeNoNpgJQz7XtJrcwOakx9hLj/RDqs6h8RSSQu9x+cXj4cNS4e2
         tyXlDgjfFocSHV+X7CA9AqZJa7OF/QATnJS2rewhyYgizht98UaKiMl9yTcMzgsFJW5e
         SAxpdhbUPQH5Z+sdtUExpW6AXTLUxH9higfyjGTYnwuUd0bRczjWONGO1GErJ7+Ysn+4
         sujw==
X-Gm-Message-State: AOAM532ESVrVfsF91m55EyumiiTLLt0s5tjmg9q0juE0dD202WGDnu10
        e2Q+4vRshbnY+d2awvcbHEqcSA==
X-Google-Smtp-Source: ABdhPJzghEaT60ySPQIKC2OuUaWnP3XDsnfAPCp2Ui70QAAvJUKtBFDZ+cklkNBA18kDIcbu6Wsn3w==
X-Received: by 2002:a17:90a:67c3:b0:1bc:9cdf:1ee9 with SMTP id g3-20020a17090a67c300b001bc9cdf1ee9mr1010955pjm.203.1645600359035;
        Tue, 22 Feb 2022 23:12:39 -0800 (PST)
Received: from swarm08 ([210.107.197.32])
        by smtp.gmail.com with ESMTPSA id u21sm1732193pjr.46.2022.02.22.23.12.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Feb 2022 23:12:38 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:12:32 +0900
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonghyeon Kim <tome01@ajou.ac.kr>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/3] Rebase DAMON_RECALIM for NUMA system
Message-ID: <20220223071232.GD6270@swarm08>
References: <20220218102611.31895-1-tome01@ajou.ac.kr>
 <20220222095302.7859-1-sj@kernel.org>
 <20220223051146.GA4530@swarm08>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223051146.GA4530@swarm08>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 02:11:46PM +0900, Jonghyeon Kim wrote:
> On Tue, Feb 22, 2022 at 09:53:02AM +0000, SeongJae Park wrote:
> > Hello Jonghyeon,
> > 
> > On Fri, 18 Feb 2022 19:26:08 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:
> > 
> > > 
> > > Current DAMON_RECALIM is not compatible with the NUMA memory system. To
> > > proactively reclaim memory, DAMON_RECLAIM kernel thread(kdamond) has to wake up
> > > before kswapd does reclaim memory. However, the current watermark for proactive
> > > reclamation is based on entire system free memory. So, though the one memory
> > > node is fully used, kdamond is not waked up.
> > > 
> > > These patches clarify watermarks of DAMOS and enable monitoring per NUMA node
> > > proactive reclamation on DAMON_RECLAIM.
> > 
> > The high level concept of this patchset looks good to me.  Nevertheless, maybe
> > there is some rooms for improvement.  I left some comments on patches.
> > 
> > 
> > Thanks,
> > SJ
> > 
> 
> Hello SeongJae,
> 
> Thanks for your patient comments about these patches. I will clean up and
> develop these patches including your suggestion and correction in next version.
> 
> 
> Jonghyeon
