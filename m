Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76E7533D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbiEYNJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbiEYNJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:09:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208BEA502C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:08:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a13so7991808plh.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nDxqtsfr0dKVwqZEkCAARcK1ckdc1oO5HqeANGAWehk=;
        b=BTlOkkjr47cZ9JCfyJeGWXO9DhAslHTm3aWUPVMOoy0syMYRM3O1lIx7Fhj5JhFIj/
         BCHNH5vbygawBpqwccbSGiDpUJqjmRoKB1f5k7E7jP9h4DiDDpwbHCX0vxZOHZXfp01i
         VOqg35B+4koUNfXOlszBZYSIVdJuZZoj3XLhVuJ2i3P1M2jcd1ZVN7/FFPfwNvTo8S9q
         nCs0ReL68nU+qNvBM43jdG9B9j0xcDGvFqrmDz591lh///Kfsy8i0r5xQbvoBl5bdO75
         PXdDioYydc8Vss2c+0TnSd7ygr0IlGGQYKHhONkJQhQVKH4Z5q/O2tSAzQaSp/xKXsZV
         Th5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nDxqtsfr0dKVwqZEkCAARcK1ckdc1oO5HqeANGAWehk=;
        b=Q1DT9RweLqxympynHebzSdvO21wp4YR8P3Q3uoKPMDgnWYjZwvLPcXtN/dIBi6UZ1e
         YWusIMrIKFVhmnzoQ1l/9zD2eyE2nR442xD+P44DVaU0SmMoonBXV4EIsFnu12nend77
         6r2L+PD1eEB3JRx6nqarGODAFWy8JhIV5Vnn/u7Ea7UKDR3XCkNAWSJmL24lkOAchODT
         ewr7HKQipGL5UEozMdkWSRsAHPk/sNvIBjSkpPIVehDj/rOrStVLfSz2oRhBUzmU6Qw1
         zBKaVntn1sAk1ktmZAfC9kN34e6cd+ire21KJ7eoIC/aqMwAC2nVJdgRfga53vszh3Xy
         Dx0g==
X-Gm-Message-State: AOAM5303QR4X9/j9qPcp2OCVaKR5N3RIlIYPdffUeDybGhRrRVmimExC
        zOJqTHMPg3JhzW480+rQTagnPg==
X-Google-Smtp-Source: ABdhPJyKX69CFBYY2SjvPUiWXbHBo3yvXochacWqrHstxGIYhAq7e5BhB89u6flk/MG+oOa3+o+Xiw==
X-Received: by 2002:a17:903:2cf:b0:151:a932:f1f0 with SMTP id s15-20020a17090302cf00b00151a932f1f0mr32523630plk.130.1653484136125;
        Wed, 25 May 2022 06:08:56 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090aa50b00b001df4e851aecsm1762072pjq.3.2022.05.25.06.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:08:55 -0700 (PDT)
Date:   Wed, 25 May 2022 21:08:51 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, mhocko@kernel.org,
        shakeelb@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 01/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <Yo4qYx6TZFr+jkZg@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-2-songmuchun@bytedance.com>
 <Yo2WKADtPy2rekRh@carbon>
 <Yo3hXe8bF3boWx5C@FVFYT0MHHV2J.usts.net>
 <Yo4jJjBksFVeJHxA@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo4jJjBksFVeJHxA@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 08:37:58AM -0400, Johannes Weiner wrote:
> On Wed, May 25, 2022 at 03:57:17PM +0800, Muchun Song wrote:
> > On Tue, May 24, 2022 at 07:36:24PM -0700, Roman Gushchin wrote:
> > > On Tue, May 24, 2022 at 02:05:41PM +0800, Muchun Song wrote:
> > > > -	memcg_reparent_list_lrus(memcg, parent);
> > > > +	memcg_reparent_list_lrus(memcg, parent_mem_cgroup(memcg));
> > > We effectively dropped this:
> > > 	if (!parent)
> > > 		parent = root_mem_cgroup;
> > > Is it safe? (assuming v1 non-hierarchical mode, it's usually when all
> > > is getting complicated)
> 
> Yes, it's correct. But it's a quiet, incidental cleanup, so I can see
> why it's confusing. It might be better to split the dead code removal
> into a separate patch - with the following in the changelog ;):
>

Well, I can split the dead code removal into a separate patch. :-)

Thanks.
 
> > Since no-hierarchy mode is deprecated after commit bef8620cd8e0
> > ("mm: memcg: deprecate the non-hierarchical mode"), so
> > parent_mem_cgroup() cannot return a NULL except root memcg,
> > however, root memcg will not be offline, so it is safe. Right?
> 
