Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795DD523CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346440AbiEKSld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345942AbiEKSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:41:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8139253A63
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:41:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 137so2540893pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S/W5ahkGN17aKq0Mty9sz97Udgy5Xn2TAfN6MZt7waU=;
        b=XveS5Ud+z1fchdpPGSkARSVyucG8ugxr4jxbMORfnB1YYXhlGJAcMCrc5wrAwoZRON
         DtHicPaUaCKDpQt2oOtd8+2P97VQRrf1CUbpKJv3O/6HoZeIUi7iMrF3S8/Rkj422WoM
         2Oyh1G9wsHU15WrRW5ebSebBXeU6QC7Lvx1mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S/W5ahkGN17aKq0Mty9sz97Udgy5Xn2TAfN6MZt7waU=;
        b=8L9kryijL6YscYKiZctmYaUyYh2aXqc92tb6X9SxPRmolKmC4jU1mT46TmFcZD+Juz
         E8mu5YIJdjlRCfL7jARlg1roVbguI4EKJG0D5f6SvDubnfuKxoVu9CoAPBqWKVRXQnCL
         Hi4DWiFZ7pQ5eKYoNni58fOslJspffK0a929WSz/UOId1KOqhZMFXA1LhfLxY4aDkWDT
         vGpC7ZGbuUQrNsBc5dpTY+PWLphDl+YVZJIho2bu9teFzirJ5BBdfIdyFSIDEulwhrUJ
         nush63RR324xF0tIP835ekJ0VZZ1az620fScDmG3SRuFNSBYYv7+Fhudj4LhLmYi+5EN
         R11w==
X-Gm-Message-State: AOAM531XpBkTW+uj6hi6vsVcQ4Zd4NYmVZ33pKmHzZuA2dZIee2LF2/t
        /qIr3KK//oN5Ifd8CId0yep/pg==
X-Google-Smtp-Source: ABdhPJwoR3i4ge1oBu9XbRbVuEIompRPsDhy0HZWjmNG50ANEwhAp9q+pVd3jlSw24yDqJk17Y1SQA==
X-Received: by 2002:a05:6a00:23c6:b0:50f:f570:7ea7 with SMTP id g6-20020a056a0023c600b0050ff5707ea7mr26253004pfc.76.1652294487025;
        Wed, 11 May 2022 11:41:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902bb8300b0015e8d4eb241sm2228516pls.139.2022.05.11.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 11:41:26 -0700 (PDT)
Date:   Wed, 11 May 2022 11:41:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] x86/mm/pgtable: Fix -Wstringop-overflow warnings
Message-ID: <202205111140.21530A125@keescook>
References: <20220509194541.GA91598@embeddedor>
 <202205091251.5703DE2@keescook>
 <20220509205056.GA109715@embeddedor>
 <202205091351.6E0BA523@keescook>
 <20220510141202.GA6878@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510141202.GA6878@embeddedor>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 09:12:02AM -0500, Gustavo A. R. Silva wrote:
> It doesn't seem to work... however, the following piece of code implies
> that pmds and u_pmds should be first preallocated through preallocate_pmds(),
> which cannot happen if (MAX_PREALLOCATED_PMDS != 0 && MAX_PREALLOCATED_USER_PMDS != 0)

This works, weirdly:

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..937a87b404c3 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -424,8 +424,8 @@ static inline void _pgd_free(pgd_t *pgd)
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
-	pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
-	pmd_t *pmds[MAX_PREALLOCATED_PMDS];
+	pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS + 1];
+	pmd_t *pmds[MAX_PREALLOCATED_PMDS + 1];
 
 	pgd = _pgd_alloc();
 

-- 
Kees Cook
