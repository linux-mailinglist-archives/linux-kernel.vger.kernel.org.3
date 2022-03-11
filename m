Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392D34D5E79
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347529AbiCKJeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347477AbiCKJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:34:12 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F711BE0DE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:33:09 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id e22so6556297qvf.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=vpPcHMluYAXV8Paw7JGI4S73DN1T1jhxT9j/EEXlW3Q=;
        b=mp3Eia2dyVOCG0jbYGZw65g85ozfSFa31ZZnBTRpOm+QoI1uYrxH7NMKYYBAZ2OZBy
         xIzHAKF98navsEfg8UdZd3RyGPRiL0EDWgCatPtRH19MJXQ/8R/nuigafMDRjL1wBmGe
         Y7AldwHbOXRuAjwnbpFrLmvU1uSZNiWR0J+C3UgZm3zakPqlRLp8/4UupqdWDG5ZNAAS
         2qE/5gL+ttv6Rcl6iITcIe2xEGKDFtcX/3GCutQnN8xcYqDvNIHOXqPKoGFcEEokRKkY
         Q1G1/QwmgSi1JA99opOxjStXLjHYe6KZ3dpi5ofoh37oHmYh4CFpTeyyCal5+YuYx9ex
         1fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=vpPcHMluYAXV8Paw7JGI4S73DN1T1jhxT9j/EEXlW3Q=;
        b=oeR/5n95ANWXlEQsTawDl/2MHYWoqb2WFtotL4SaxpjEJiSKB2l8qx+ouBV1agFg3r
         2KTYTfcEtLqyzsg/DRq5azg+bf+9Y72CNTikljWG+buLKCUIqDqfckNsL7Jr81kqnI69
         c2MhAqRpsszbqmEB4tGa6+yH4JMUqdMeezl7cOjfpiupte/ylM29cRVRuj3ERjOfg8WN
         FlejFXODL9XPKdaH4ecg10bwEPVVKq2NQ6BnQqDaBdTRxpafVjqz1jdCoDqweS2gakqC
         HvLy8Oqz5rYmi6sRJGgZbarB/+Z93R95P/9ZrOlP16hPm/6xl07kTnm0r+bRcUPMP7Of
         r1kA==
X-Gm-Message-State: AOAM530Dw5B0Wg7ZQTWWuh8KlRUfZcoffme1WDn4g86wbc1/B7LbPmGL
        mufpiOisZoTc7Cfnm0TCWlAN3g==
X-Google-Smtp-Source: ABdhPJztjI+5fmqkcecCbEwAfuR6OVRvwXzRVXtMyeIKy8MrkXPdGDcy5hhoOnlr178M2Z/mxeqCCg==
X-Received: by 2002:ad4:5dca:0:b0:43c:5758:480a with SMTP id m10-20020ad45dca000000b0043c5758480amr493049qvh.77.1646991187966;
        Fri, 11 Mar 2022 01:33:07 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y196-20020a3764cd000000b0067d51bbacdfsm2184830qkb.107.2022.03.11.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:33:07 -0800 (PST)
Date:   Fri, 11 Mar 2022 01:33:05 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
In-Reply-To: <20220309191023.34fmzibc2u5tcinw@revolver>
Message-ID: <d8bbd273-5d64-c826-fae2-3e399eefcf@google.com>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com> <20220304184927.vkq6ewn6uqtcesma@revolver> <20220304190531.6giqbnnaka4xhovx@revolver> <6038ebc2-bc88-497d-a3f3-5936726fb023@google.com> <20220305020021.qmwg5dkham4lyz6v@revolver>
 <29eac73-4f94-1688-3834-8bd6687a18@google.com> <20220308160552.d3dlcaclkqnlkzzj@revolver> <6036627b-6110-cc58-ca1-a6f736553dd@google.com> <105e1620-5cf2-fecd-27e7-21a6045cc3ac@suse.cz> <20220309191023.34fmzibc2u5tcinw@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 9 Mar 2022, Liam Howlett wrote:
> * Vlastimil Babka <vbabka@suse.cz> [220309 07:41]:
> > On 3/8/22 22:32, Hugh Dickins wrote:
> > 
> > > Does that help?
> 
> I think so.  You want to set the mpol the same across the vma because we
> are specifically calling mbind, but it isn't necessary because the mpol
> is equivalent but not the same mpol?

I did not understand that logic, so cannot confirm it.

The crucial point, as I see it, is that a call to shmem_set_policy() was
needed in many cases, but had been "optimized away" by the mpol_equal test.

> I guess I have the same question
> as Vlastimil brought up - why does tmpfs need this?

One way of answering would be: because tmpfs is used to back SysV SHM,
and "man 2 mbind" has a paragraph on the subject of mbind on a shared
memory region created using the shmget(2) system call.

Or you could look in Documentation/admin-guide/mm/numa_memory_policy.rst,
section on "Shared Policy".  (But it's a surprise to me to see how that
makes no mention of tmpfs itself: it's as if it's just an accident that
this is how NUMA mempolicy is applied to mappings of tmpfs files.)

An important comment from ChangeLog-2.6.7 when mm/mempolicy.c came in:
For shmfs/tmpfs/hugetlbfs shared memory the policy is shared between
all users and remembered even when nobody has memory mapped.

(But although hugetlbfs support was intended in the original RFC to lkml,
it was never implemented in the tree, despite appearances: a patch I did
not send this time, but eventually will, removes the appearance of shared
mempolicy on hugetlbfs.)

Hugh
