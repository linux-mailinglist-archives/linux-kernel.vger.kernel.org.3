Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6A55D2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiF0IVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiF0IVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:21:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA506279
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:21:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l6so7486152plg.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QEdYkhc/vgHXgRfRmjc0nzpx3LEjhX5ml1rzqRnP/4s=;
        b=FBGP8QbnA/Q993e72LgTAcq4R2SHAg39ll9+8sV4mS/OaV53vVEBH3G9PmoL/WU5Ng
         EgGKJAzBw78GDCL2he0DRiOLKUjOFhu9QGvBP+wDybeVNL1aH0Uu3m8RA979bs8c6/JB
         GT19bNcR6pZDiEPk5dGI9EBAeVL2okq1qn6xzP5hsN8ZwKcWUvmi6zS2ytXG6s2QDXlu
         bUZ7692vrOpbQAIextdiUprzZ0S7YfY4JeIydOon1xbf6qnfWgOEBvkWi+z7rej7Qv3t
         4CaUDdfON8gcc+Z0Pl+nCFP16aNZeaJbm+km/qFaJoNR/kYnDgKmrPMb2UKPxa1HxUID
         yn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QEdYkhc/vgHXgRfRmjc0nzpx3LEjhX5ml1rzqRnP/4s=;
        b=HSq9ypvf89V96RjXb/6kyXXh01VbnTdeC1LKqcvYjGjtY8sw9Xf+wUvwK4KtO17r04
         Eb0g/Ec9J+C3CD+/Xn48vmQENCnOo0tC/exo45wfn06omuJICqeQ/7xWXqJ63/QM3aCh
         8/qJTAFKKS43jOQXfz/qJeGtpRyOirgx0rIMdDYX93aRkV/L+7vPHs/AHHCiaV8Bmlji
         jcKvSkRAAemwWrRiPWYufzPOXKes+SPEPxYEgBMRH/AGVwL/1gF5tPtVBnpAuyVTnqxv
         inJqJswJ0aRxxCekBeypvtOnMmQTJIsR61RtBa/DKJRHSOGjcpeq6CMAfqlLOuQb522/
         RLlQ==
X-Gm-Message-State: AJIora/npTr3T+HMDY0/rTWrfIkd1+4eNB98frXaxZ9M/QP0qLV4mNfR
        8IzXw2mNr9S/pIsMHcAcsmU=
X-Google-Smtp-Source: AGRyM1s4u5NPA/YOTVo+6n8fYNjPSjmjD7+mf9utAl655FKO6jiPaFvR5fTcoPhraldp8VpBWPz9EQ==
X-Received: by 2002:a17:90a:ba04:b0:1ee:e6b0:edff with SMTP id s4-20020a17090aba0400b001eee6b0edffmr2201137pjr.153.1656318074516;
        Mon, 27 Jun 2022 01:21:14 -0700 (PDT)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b0016a6cd546d6sm6150889ple.251.2022.06.27.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:21:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Jun 2022 17:21:12 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <YrloeE/LEnfYvqp3@mtj.duckdns.org>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <YrllOoGRqp+Cdc9/@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrllOoGRqp+Cdc9/@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Mon, Jun 27, 2022 at 10:07:22AM +0200, Michal Hocko wrote:
> So if somebody has woken up our thread from inside kthread() then it
> doesn't have that pointer on the stack and I couldn't it find elsewhere
> either. Maybe somebody has an idea where to look at.

One way could be bpftrace'ing or printking __wake_up_common() and
friends to dump backtrace if it's trying to wake a kthread whose comm
starts with kworker/ and doesn't have (struct worker
*)kthread_data(task)->pool set.

Thanks.

-- 
tejun
