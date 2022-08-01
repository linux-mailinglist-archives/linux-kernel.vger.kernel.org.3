Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E883587186
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiHATkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHATkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:40:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F1CC4;
        Mon,  1 Aug 2022 12:40:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k26so6520652ejx.5;
        Mon, 01 Aug 2022 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p68rKFvwaoybuf/oqm2qNNk2sii1+JQP9Px6zobKFXU=;
        b=eWKRDpCXwREP9gNrZUUpuYoI2NseiEJMV7z+O5wS5aZP+5RszSVdigMy66lzgT4TyW
         u+7YoPyap+qVCqqpVVlv3UXh6XKuds2HPgHyG7Nsvf2e1gLqjWcJgL3xH6qiMY8nyyH7
         sGv5KZgZ1B9i5nJP3GsihP9heks+5g10dCslOykAfMZ5Nmrelbspqjw1o5mxg/igilSC
         f+txWPe6IHpoJTyG9zFIbHbTvXppCSzre56J9YqYmzYd8LUL0T/XHcYtik9wr2Be0Aw5
         7JSEM0s817wjzfAkg3ahd8e8I80P7HLPknQLYlzrRcCS5GtgyZ61GwtTIMnIphBV1agQ
         pdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=p68rKFvwaoybuf/oqm2qNNk2sii1+JQP9Px6zobKFXU=;
        b=TvO8ihX9S3yRZqCpqMU7XqzjDcr2+OZ3UIUHkzHQSYey6dWpFJoUhN4c4FrSzKoF1n
         L2EaWQt6TkeG7xsrSV4ijwvkWy5FEEx9mPsW4YO0boUAGu4vYWMBo3DpwWE7WY0JGABC
         6WGmmLmbOO1pu/stiukA+o7Rii2dgjyUM9Y1Ht+k+4WelgxNmByHeYMY8bEpMUeyiNfp
         WFzVDD6fius8sN7tVfidnQyhk912DrpqmoYcGu+ynsQXR4LwoAMZDkkzxRJMlGJCOfEh
         /tFK3jfJ1SQJbuS3GWqSTqkU6TMZEQtOh20vfowCULFX/xlWYL23G2v/eieYfKeoMJTR
         aDFA==
X-Gm-Message-State: AJIora/yI1j+dJerQpENftm/xG8jSspXJ2Asz2eQIV/xoZ6KDZnw8FTl
        POx0JG3G6pRs4DYYjbAEk0Y=
X-Google-Smtp-Source: AGRyM1tBJwjV+fXm+aDN+d3gEZUMRFEUCwcQwIfN9wKTTiWb36ksdA3fKD5/PIMK5vVZhf+jwl5Rnw==
X-Received: by 2002:a17:907:7347:b0:72d:78bb:b0d7 with SMTP id dq7-20020a170907734700b0072d78bbb0d7mr13374107ejc.45.1659382851100;
        Mon, 01 Aug 2022 12:40:51 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id q8-20020a170906a08800b006fe0abb00f0sm5466009ejy.209.2022.08.01.12.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 12:40:50 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 1 Aug 2022 21:40:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@posk.io>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH 2/2] rseq: Kill process when unknown flags are
 encountered in ABI structures
Message-ID: <YugsQDLJJ/385wRP@gmail.com>
References: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com>
 <20220622194617.1155957-2-mathieu.desnoyers@efficios.com>
 <YufV3PmAOfo1Gt7g@gmail.com>
 <1686554751.93506.1659364793386.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686554751.93506.1659364793386.JavaMail.zimbra@efficios.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> The projects I know about that use rseq at the moment don't rely on the 
> old ABI ignoring unset flags:
> 
> - glibc initialize the rseq_abi()->flags to 0 and do not use rseq_abi()->rseq_cs->flags yet.
> - tcmalloc initialize rseq_abi()->flags and rseq_abi()->rseq_cs->flags to 0.
> - librseq (still only a master branch, no officially released public API yet) initialize
>   rseq_abi()->flags and rseq_abi()->rseq_cs->cs_flags to 0.
> - the Linux kernel selftests initialize rseq_abi()->flags and rseq_abi()->rseq_cs->cs_flags
>   to 0.
> - AFAIK DynamoRIO does not rely on the kernel ignoring unset flags bits.
> - AFAIK CRIU does not rely on the kernel ignoring unset flags bits.

Thanks - that's exhaustive enough.

> If anyone else rely on rseq ignoring those unset flags, please yell now.

Well, people are unlikely to see random lkml mails - but if gets reported 
as a regression then we need to revert. But I don't expect it to happen.

Thanks,

	Ingo
