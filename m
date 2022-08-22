Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029ED59C99B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiHVUJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiHVUJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:09:12 -0400
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166F520A9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:09:10 -0700 (PDT)
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
        by mx0b-00364e01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MK9Ait015474
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pps01; bh=uDQzzrBltqrLuXdfqviqYjpWwOZaoadCcr/V3buMmzk=;
 b=eBKB6GXhNB9OH/RsklX8N3qsR3986OUWvuoVIoA9bqckXkqAVGa878qfYPOigeHdl8D9
 5mjdIVCFtOMF/BS7GrgyiBLt+z2KOo0pnhQU7xplOPfFQoTBrt71uGFNuqR0cE/s23nJ
 jGZg1ErKUDMpRsQCp8d2V6yBg3kk6Xcy+zYl4duavCWZLJ637XKCTmGQmHecx+P+QJB/
 U3IVwBdCJ1vXDln0zrtq0nF4NAsjeBX8B9JGVjlMiH5rYWui0sD2+AngOu1BJ5sEkzVF
 POm1xnTRkt78l4mlTT9mnEUnXAC9/eXi7qOWxV6KO7hGomYD497RIn3qA7GRc4klbVju LA== 
Received: from sendprdmail22.cc.columbia.edu (sendprdmail22.cc.columbia.edu [128.59.72.24])
        by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 3j2wj6d9qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:09:09 -0400
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
        by sendprdmail22.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 27MK99rM044822
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:09:09 -0400
Received: by mail-ua1-f71.google.com with SMTP id 66-20020a9f2048000000b0039dcf9c5852so1808401uam.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uDQzzrBltqrLuXdfqviqYjpWwOZaoadCcr/V3buMmzk=;
        b=wCtjyUlpmlKDpwuiAeyPfg7SAQbjsSXxF6jW3X0RD7dmBRTVcWPP+uccI3VozgxdjI
         NrtJti96c7+TozhfhI5QO3skW6sCO6Iex/ZUg81bXKfVxUn+Jm4c2v7kZmBIu3RPIjSl
         elUTcekeuTqmyMNzgO0DXc/e28jfSyqXXh2PP87lV0zUmJG575p6EtPiS6Y/BWdMftEl
         7rK+V4tqUjTQ0COSCczxx/10DJ3S/DoGzfZuAIxmYsY9/m5Lj/YkLUNT+D0qTIpZZNkF
         2NIRs+QGpZ2a9REEKG/MNhVyL9Ce/RRb0ciyJQng2qt0tQf68RbX2ES+HG/gXbix0n+P
         Pu4g==
X-Gm-Message-State: ACgBeo0RemwkCxew8E6Y/HCEXCQdStR2HU+1rKOLCpVoYM+hzik9HZ5e
        gSdKucEVjmlQq6RouhSKz83KHotS07Rqay2sZrDgDycYh3jGzqNmTcjLXV/x41AKFyXQ1Tq2/7A
        mYTwRfmlT1TqlL58b8C+hjdkIzNNL1bA/kPRfQDvM4z+fzEy9
X-Received: by 2002:a05:6122:685:b0:38c:8636:73f2 with SMTP id n5-20020a056122068500b0038c863673f2mr2146478vkq.41.1661198949011;
        Mon, 22 Aug 2022 13:09:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7s6hYT3c/XZ5suxdUpUz4pMjZRHKPbFYkuLyhQc2jVm12x3bUqHsUkeGlDgvvHzMhzfgY3eASLlxrA5cki6h0=
X-Received: by 2002:a05:6122:685:b0:38c:8636:73f2 with SMTP id
 n5-20020a056122068500b0038c863673f2mr2146469vkq.41.1661198948776; Mon, 22 Aug
 2022 13:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEHB248ft0LFUQDHNtB9NN_D3F=12Jndh13Ue=LokajXNhMk5Q@mail.gmail.com>
 <CAHC9VhTXNPWBDRoPcz-Jw=f+NNAEhxbh-ySc56CUd-ZbuboW5w@mail.gmail.com> <CAHC9VhQnYY_wdUjBbL3NpPYTQcr0M_Nf1g8ObbHiUoUbHPYdYA@mail.gmail.com>
In-Reply-To: <CAHC9VhQnYY_wdUjBbL3NpPYTQcr0M_Nf1g8ObbHiUoUbHPYdYA@mail.gmail.com>
From:   Gabriel Ryan <gabe@cs.columbia.edu>
Date:   Mon, 22 Aug 2022 16:09:02 -0400
Message-ID: <CALbthtfcfSKfn4JWSKxo0t0Y+_c5ZjoGPWW2e=z3doKcB3XvxA@mail.gmail.com>
Subject: Re: data-race in audit_log_start / audit_receive
To:     Paul Moore <paul@paul-moore.com>
Cc:     abhishek.shah@columbia.edu, eparis@redhat.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: DMqXm0socehuRicxRPdMHScbW-3qx-Jx
X-Proofpoint-ORIG-GUID: DMqXm0socehuRicxRPdMHScbW-3qx-Jx
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_12,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=10 mlxscore=0 clxscore=1015 impostorscore=10 bulkscore=10
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220080
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for taking the time to review our report! It sounds like there
aren't severe negative impacts and patching to eliminate the race
would impose unnecessary performance penalties so we'll mark this as
benign for future reference.

Thanks,

Gabe

On Fri, Aug 19, 2022 at 8:06 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Aug 18, 2022 at 9:59 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Aug 18, 2022 at 6:23 PM Abhishek Shah
> > <abhishek.shah@columbia.edu> wrote:
> > > Hi all,
> > >
> > > We found a data race involving the audit_cmd_mutex.owner variable. We think this bug is concerning because audit_ctl_owner_current is used at a location that controls the scheduling of tasks shown here. Please let us know what you think.
> > >
> > > Thanks!
> > >
> > > -----------------Report----------------------
> > >
> > > write to 0xffffffff881d0710 of 8 bytes by task 6541 on cpu 0:
> > >  audit_ctl_lock kernel/audit.c:237 [inline]
> >
> > ...
> >
> > > read to 0xffffffff881d0710 of 8 bytes by task 6542 on cpu 1:
> > >  audit_ctl_owner_current kernel/audit.c:258 [inline]
> >
> > Yes, technically there is a race condition if/when an auditd instance
> > is registering itself the exact same time as another task is
> > attempting to log an audit record via audit_log_start().
>
> I realized after I sent this and turned off my computer last night
> that I typed the wrong thing - the race isn't between auditd and
> audit_log_start(), it's between the code which changes the audit
> subsystem state (see audit_receive() and the audit watch/tree code)
> and audit_log_start().
>
> > The risk
> > being that a *very* limited number of audit records could be
> > mis-handled with respect to their queue priority and that is it; no
> > records would be lost or misplaced.  Correcting this would likely
> > involve a more complex locking scheme[1] or a rather severe
> > performance penalty due to an additional lock in the audit_log_start()
> > code path.  There may be some value in modifying
> > audit_ctl_owner_current() to use READ_ONCE(), but it isn't clear to me
> > that this would significantly improve things or have no impact on
> > performance.
>
> Another thing I thought of last night - I don't believe READ_ONCE()
> adds a memory barrier, which would probably be needed; although my
> original statement still stands, I'm not sure the performance hit
> would justify the marginal impact on the audit queue.
>
> > Have you noticed any serious problems on your system due to this?  If
> > you have a reproducer which shows actual harm on the system could you
> > please share that?
> >
> > [1] The obvious choice would be to move to a RCU based scheme, but
> > even that doesn't totally solve the problem as there would still be a
> > window where some tasks would have an "old" value.  It might actually
> > end up extending the race window on large multi-core systems due to
> > the time needed for all of the critical sections to complete.
>
> --
> paul-moore.com

-- 
Gabriel Ryan
PhD Candidate at Columbia University
