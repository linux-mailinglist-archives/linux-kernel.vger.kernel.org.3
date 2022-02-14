Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E344B5AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiBNTvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:51:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiBNTvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:51:20 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F381275FC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:51:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m22so11824246pfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xfLlstyLrwocScqIOv+14Ypez3TInqIWV7B8q26ohT4=;
        b=PWrWd5BhgiJFgXs3u+v2SLDwgqgvXNE6iuwpaJubHXLScyqY7eJ2F/xsbEUCo2RejS
         kLWQXfTg5BPh68bdMlmp5e4O4LZSjtZEAb8ZxjV3ZXbBfDWqJJEyLzai6/kXIjQnfy7I
         fI2vrpuoJu0Z7URJNXtL+UpNGPyl6yIYIxmVycsGQOzqcvwuTIfR5wzzYmH6NrLPH1eg
         aqvNORdlYlyTIo09FT0bXwpkLEPLRPpMzgJZbCxSPDWGOgA3KwPBc4Relao+NPKrIn0u
         sbVch78jwJZm7m/3kY8Ylj4zBA+VDk1PxkZC0fhy9o+PhG8x52FOKtnt3Y7cbvVqKwPb
         sFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xfLlstyLrwocScqIOv+14Ypez3TInqIWV7B8q26ohT4=;
        b=ETCu0KB1okwSMpX5/DHUVTcjaIQy61M+zI29EyC6RDMZkT0cAGVQzqvAvrubxuq+to
         ZHb61H3Lyxb43sQu/jI8O6welWQoCzhpe3nnEcqrU4fez1qxCMzq6JsU64IPmDcHnEoM
         LPfmV4f3KSYxF62bDqfd/FS8VMAHWh3GKA3VUbCEzs9EVNn9vAZx7CNxraRU7OTZCI6/
         nvw4S77POZikAtoM8I14e9hh6bZC+xONyybNmlFDNjJIYWNIAGHCaFIaszyt/jZosS/i
         Kce5QReEMVCAa14YVUWtLXeCgNb5WlhALalRPn/aeERfnTTS3jI4njNSnsxKL76w1bKA
         bd+g==
X-Gm-Message-State: AOAM531aVfD5Ohzq9HozmwZwhA+fUHaou1aTEdWhelmCQHa4YvTE4zXo
        rGZC14u450eh8gkwgXzskxM=
X-Google-Smtp-Source: ABdhPJzWYLn7LUF0I4vIIdv406pNxtyWp4SRIXGlYTIZYXAXlFhiK83IpHrz8Q2PLVHkvreB3rYOMw==
X-Received: by 2002:a63:cc43:: with SMTP id q3mr491233pgi.243.1644867977018;
        Mon, 14 Feb 2022 11:46:17 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id i4sm2935509pfq.105.2022.02.14.11.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:46:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 09:46:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        zhangqiao22@huawei.com, dietmar.eggemann@arm.com
Subject: Re: [GIT PULL] sched/urgent for 5.17-rc4
Message-ID: <Ygqxh09H4QbtRpuE@slm.duckdns.org>
References: <Ygj7feK+vdtPw6zj@zn.tnic>
 <CAHk-=wiHUWHHcPLCvyXQKf2wbL3L1SOQSGVuCdf-py6QZGnuqQ@mail.gmail.com>
 <YgoWoh6pIzlsQx6d@hirez.programming.kicks-ass.net>
 <YgoeCbwj5mbCR0qA@hirez.programming.kicks-ass.net>
 <YgqquDnQe3SihgJU@slm.duckdns.org>
 <YgqvGuQUF1BdpAl0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgqvGuQUF1BdpAl0@hirez.programming.kicks-ass.net>
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

On Mon, Feb 14, 2022 at 08:35:54PM +0100, Peter Zijlstra wrote:
> So there's two things that need doing; the re-cloning of the task_group
> thing, but also calling of __set_task_cpu() which sets up the proper
> runqueue links.
> 
> The first is CGroup only, and *could* in theory be done in ->can_fork(),
> but the second needs to be done unconditionally, and it doesn't make
> much sense to split this up.
> 
> I actually tried, but it made the patch bigger/uglier -- but maybe I
> didn't try hard enough.

If there needs to be a separate call anyway, it prolly is better to keep
them together. It'd just be nice to mention why cpu is different in this
regard in a comment.

Thanks.

-- 
tejun
