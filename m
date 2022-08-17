Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC43259738A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiHQQCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbiHQQCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:02:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0E49E2C7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52622B81C83
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB506C433D6;
        Wed, 17 Aug 2022 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660752168;
        bh=3UdwnNUZwdXFDg8LnAxqtXZ5ba2/AOzmihq8V8tBfmk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fB13grRcIyPXjYpP17x07Wyec960L6xilhbIxcL2F3z8CG1Ppq2OinKV/8NhE4F3a
         304UcPEJY+2qu953d6eL60r/rn4TWOkoAP+zqVq/qZgHLx/bxBsIekM4P3HJBymtPt
         PI4jyNojFovzUad+TkmeBD/tr1dORzphJYGjtfuA=
Date:   Wed, 17 Aug 2022 09:02:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pratyush Brahma <pbrahma@qti.qualcomm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        quic_charante@quicinc.com,
        Pratyush Brahma <quic_pbrahma@quicinc.com>
Subject: Re: [PATCH v2] mm: oom_kill: add trace logs in process_mrelease()
 system call
Message-Id: <20220817090247.ef99115ca7a6c847f90dc4c6@linux-foundation.org>
In-Reply-To: <20220816060017.17996-1-pbrahma@qti.qualcomm.com>
References: <20220816060017.17996-1-pbrahma@qti.qualcomm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 11:30:17 +0530 Pratyush Brahma <pbrahma@qti.qualcomm.com> wrote:

> From: Charan Teja Kalla <quic_charante@quicinc.com>
> 
> The process_mrelease() system call[1] is used to release the memory of
> a dying process from the context of the caller, which is similar to and
> uses the functions of the oom reaper logic. There exists trace logs for
> a process when reaped by the oom reaper. Just extend the same to when
> done by the process_mrelease() system call.
> 
> ...
>
> +	pr_debug("process_mrelease: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
> +						task_pid_nr(task), task->comm,
> +						K(get_mm_counter(mm, MM_ANONPAGES)),
> +						K(get_mm_counter(mm, MM_FILEPAGES)),
> +						K(get_mm_counter(mm, MM_SHMEMPAGES)));

This addition wasn't changelogged.  It's the only pr_debug in
oom_kill.c.  Please explain?

