Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BC24C5E2F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiB0Sdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiB0Sdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:33:44 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7718A13EA8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:33:07 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id q10so7179794qtw.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=h1Xfq7VjVS4D6G/w68UJ7tfthN5JSqzqjvb/TggLI6Q=;
        b=XtAlzy9YfhFlRSoOQlJqI98K0svB/sCYK/B5W3SXc//1wU18MKiZzDCbUrUDWVVJaW
         GyE46nNV1WNE4hVaM0GxoFHTaK/24MTaVmtkTB9jZOIKlG5M/wnaDsm5CL9E2RhSKqJv
         /MgC+AmAPNxEDe7QwkNP3K5UopDa4IxD1wh/LxxbxnSGhjHzKyJxrkGU2jYsgxPWRxaR
         Y27kd39du6G6smZfQ+FU2O+2vc4XBu+V5o83kYcHA1dvHclSmvOQbIsQ8Yx+80H//8tq
         1Xe9qLsOxGskETNtwLqEf6QcUW0bmdprGKkjFVrDI0WXXO05j7/L8uM+cKVdBDo4bhOc
         Y8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=h1Xfq7VjVS4D6G/w68UJ7tfthN5JSqzqjvb/TggLI6Q=;
        b=IF7+6Ssnj6VXGyrvi3CLyxGvXjLrCpLNu+VBDEq/5dCEyPYx1IwjzSvWdmoIdAidhx
         0IuuTD6MVlGOzqURlVg6rsTwNEqrbnLChpfoBkMV5CIHYs1y/LuotsOJ3x1+uwm646vg
         d7vGZCGRDZqqnKuERU7jra6x4U9jFb2Y2c5eYUtRc11tW4p20uIzkQxmKpf+RP/Z3aSB
         zlBOFJ7F+U4DrjD/zHQFlxyK7BCpqH9EYwi3D9wFfdJHsingxtLrIRnRYwtUygB1/41R
         raSnMbKxAfdydCEyKevQ6GJRybhN9T7XSaSUMoc99s59fTVVBT7/rtkIkfC21T66Um9h
         RHLg==
X-Gm-Message-State: AOAM5300L1Vds/0N8gjiVZNARcgEjpJ2Hhxm+RBUcbXPVJ2NT4ojcm4E
        fQraBmiFq5L5vhzHtRlGOj3VMQ==
X-Google-Smtp-Source: ABdhPJwKt9CLApj2EJ+fEAlPDjbpT2Z3S44zkSppaVxM4pLoX0PuCsiZNn1+kYi2YpDQdK+tpl10Nw==
X-Received: by 2002:ac8:7e91:0:b0:2de:29d4:123d with SMTP id w17-20020ac87e91000000b002de29d4123dmr14051813qtj.322.1645986786439;
        Sun, 27 Feb 2022 10:33:06 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l7-20020a37f507000000b0047b528ef416sm4030551qkk.93.2022.02.27.10.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:33:06 -0800 (PST)
Date:   Sun, 27 Feb 2022 10:32:52 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     Nathan Chancellor <nathan@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
In-Reply-To: <5f8f4f-ad63-eb-fd73-d48748af8a76@google.com>
Message-ID: <546e7b7b-ab50-d1fa-6a67-2c9dd9e9688e@google.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com> <YhhRrBpXTFolUAKi@qian> <20220225190846.u4fwebimd5ejfdpd@revolver> <20220225202334.bsw5t3retcchpn2e@revolver> <YhlAPOquxUICyGsR@qian> <Yhlfkk/gTz6a/hOD@archlinux-ax161> <20220226015803.h4w6y3doe3om2sbc@revolver>
 <5f8f4f-ad63-eb-fd73-d48748af8a76@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Feb 2022, Hugh Dickins wrote:
> 
> I say "often": it's very erratic.  Once, a machine booted with mem=1G
> ran kernel builds successfully swapping for 4.5 hours before faulting
> in __nr_to_section in virt_to_folio ... while doing a __vma_adjust() -
> you'll ask me for a full stacktrace, and I'll answer sorry, too many,
> please try for yourself.  Another time, for 1.5 hours before hitting
> the BUG_ON(is_migration_entry(entry) && !PageLocked(p)) in
> pfn_swap_entry_to_page() - suggesting anon_vma locking had not been
> right while doing page migration (I was exercising THPs a lot).
> But now, can I even get it to complete the boot sequence?

Sorry, I never mentioned the architecture: x86_64 throughout for me.
