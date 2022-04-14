Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50863501E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344390AbiDNWKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344220AbiDNWKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 981EAAD13A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649974087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFT4RHdEEKxbL6Pp86FmfbXwXPcHJ7kLGQ3GnlsoNWY=;
        b=IvhtRu7l3ScwYyP+X91vOo+HHAGHab/C79cYWdvYbKQnrnXPI1+cLvWdahodcm0CU0Z+sw
        gBQSOd03Rx8TEdczXM1k+igs3hJS6Dib2K06DtGyTQmFrOpwnddC+BN8yN3vRLJ4XSg9b3
        gs4TrVrCefvofSyuVbqQjBCcnmKalVs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-b6fDHk0_NP-8-Lbcttw8mQ-1; Thu, 14 Apr 2022 18:08:06 -0400
X-MC-Unique: b6fDHk0_NP-8-Lbcttw8mQ-1
Received: by mail-qv1-f72.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso5514111qva.18
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YFT4RHdEEKxbL6Pp86FmfbXwXPcHJ7kLGQ3GnlsoNWY=;
        b=FQVONNzw2eVxOROTxdK6wqxjK9olvMjGteVqLnpbnZoeDSrHaLkeqVC6zkR23Az4+H
         TzUorjdiC9MmbZBToTJO2Mx00/91FmajVTGd+1K2VDLfAmEqfgWJJ9fBufg0LRjIjxUl
         K5Q1ppT+HHdwWA3X79cG5Wl+XtuP9ltKn7y/uVs23jg6Du52vcTDlKxdFRvqC0Y2tH2u
         9DPOcgya5uj6/rEDp9V27AWb4UNhpAiYh4evKFCBJE9xdr+fFfqcNkbfc/oq0qSi6roR
         gwSk5SH+ij4kTlO3Cn9HQIGzf3Mu6B/0XqhHKigl6a1mrplpq95yPnPq+rcgrXhLUV3o
         gaeg==
X-Gm-Message-State: AOAM5302KOcRJARakfqZM8IkwJVVoK3p9fuqH7PKdjh46+l8fJOxXUmK
        JoluxRZ/7zA4yYqxbnw+rIq2yaKMjUlQb1BaWwPlrpyV/WyO53qMh1tZWjqZ82o2i9VFsJ929hZ
        6jsD/9NI/PSRmrROMQChBY72o
X-Received: by 2002:ac8:3d49:0:b0:2eb:cbf8:4140 with SMTP id u9-20020ac83d49000000b002ebcbf84140mr3396293qtf.279.1649974085424;
        Thu, 14 Apr 2022 15:08:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNjD/LTcMvPIJiuDOC/j2dXELRBVtiEyiCbNKO8ii6DGHRCdlZjGYbBcoVixvERtyk40LsDQ==
X-Received: by 2002:ac8:3d49:0:b0:2eb:cbf8:4140 with SMTP id u9-20020ac83d49000000b002ebcbf84140mr3396276qtf.279.1649974085199;
        Thu, 14 Apr 2022 15:08:05 -0700 (PDT)
Received: from t14s.localdomain (c-73-69-212-193.hsd1.nh.comcast.net. [73.69.212.193])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b0067afe7dd3ffsm1606450qki.49.2022.04.14.15.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:08:04 -0700 (PDT)
Message-ID: <8c5012c88989a8f05a3b67540b9172336c57ddf7.camel@redhat.com>
Subject: Re: Plumbers conf presentation on -fanalyze?
From:   David Malcolm <dmalcolm@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Apr 2022 18:08:03 -0400
In-Reply-To: <CAKwvOdnb-DiAnq4bT7XiJpFtqyJYpWNw1shEp8gWYpVmUpRBaA@mail.gmail.com>
References: <CAKwvOdnb-DiAnq4bT7XiJpFtqyJYpWNw1shEp8gWYpVmUpRBaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-14 at 14:42 -0700, Nick Desaulniers wrote:
> Hi David,
> Jose and I are currently in the planning process to put together a
> Kernel+Toolchain microconference track at Linux Plumbers Conference
> this year (Sept 12-14) in Dublin, Ireland.
> 
> We had seen
> https://developers.redhat.com/articles/2022/04/12/state-static-analysis-gcc-12-compiler#scaling_up_the_analyzer
> particularly the section on The Linux kernel and were wondering if
> you'd be interested in presenting more information about -fanalyze to
> kernel and toolchain developers there?

Thanks!  I'm very much interested, but am not yet sure about travel
(both in terms of (a) budget and (b) possible new virus strains).  Is
this conference going to be purely in-person, or hybrid virtual/in-
person?

Dave

