Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB864DA50F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbiCOWLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbiCOWLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04E055C370
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647382234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sQtSBHNQH4OCn0hjFNRX0y7NCWzjkpGXawmrdrNsMPU=;
        b=Q678Y8avw30TUZxUrgvKiqRyOZByAS8j/bh8bCaGdqWJ85t4rLyVoFPRpuIyJvEufyiNPe
        3B/n57toJeqWuUziLHcMx3nQ94ET42BdO8DO8ywl8KwAB61UpptZUwGZHt1GdS7pO44bI+
        biKtLIhEO17qafJU5Js/DdyKzbkP6RA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-7daHrlAmOSu5qc3hC6Laew-1; Tue, 15 Mar 2022 18:10:32 -0400
X-MC-Unique: 7daHrlAmOSu5qc3hC6Laew-1
Received: by mail-oo1-f70.google.com with SMTP id t31-20020a4a96e2000000b00320f7e020c3so295702ooi.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sQtSBHNQH4OCn0hjFNRX0y7NCWzjkpGXawmrdrNsMPU=;
        b=mmkte8aY88wOdfrxzyiORRQIiFDfRbHZ1vDHGcFc4Hz0n73zOrXEnxIOufIMn70ig/
         CDEQBjmKX4s3MLObADk1YiGnLIRyvVswAMPeShtR6+2UmSCiX1t5abidwthyR7vNFEbZ
         lEZyw45tIMrRBwPv9x60NkJH5NNvyQUuzFNjEWueqo/mUoJmxEdjhsdoJ6yv1ekuZ9fX
         AX8w3ePQkzC2T5GeHqbqwcst3jwW+oHtXd9+xSwOhzgGoUBOxepBH1ETBHt/zINVt5UX
         T4RI9EslSycI7JvdEn0lU/CRjBY8ka4YuLNThJjA4dDUphMBENV2Tsiu4v2ExD6ekb4y
         ci1g==
X-Gm-Message-State: AOAM532CLaUi/1vVpbBw/aHbZq/qdOPmJLIYDjMTXnTZV2Bc8kIVRQyW
        mVlfxmoqtkKZPOzSIL9iz1fpFv8GuS7Q+d8hVsjiXSUStTTxZUp0Wa/bG/XYVKyeSh8JtTRb9Xx
        WGwsd3Mpk55BK8F+cwojyWgYb
X-Received: by 2002:a05:6808:28f:b0:2ec:c78d:cc7d with SMTP id z15-20020a056808028f00b002ecc78dcc7dmr2610629oic.208.1647382232246;
        Tue, 15 Mar 2022 15:10:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPTq+4slSzvGFi+Pc0Q+T45lfMAx1zAPc2CPr2l3CS2WVg98Wkf4Z/j/hCEL4qs/m9QAQ5Lg==
X-Received: by 2002:a05:6808:28f:b0:2ec:c78d:cc7d with SMTP id z15-20020a056808028f00b002ecc78dcc7dmr2610618oic.208.1647382232020;
        Tue, 15 Mar 2022 15:10:32 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id e5-20020acab505000000b002ecfd33334bsm181844oif.53.2022.03.15.15.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:10:31 -0700 (PDT)
Date:   Tue, 15 Mar 2022 15:10:27 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v1 2/2] static_call: Remove __DEFINE_STATIC_CALL macro
Message-ID: <20220315221027.adisw5th4t6aibrb@treble>
References: <1e0a61a88f52a460f62a58ffc2a5f847d1f7d9d8.1647253456.git.christophe.leroy@csgroup.eu>
 <329074f92d96e3220ebe15da7bbe2779beee31eb.1647253456.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <329074f92d96e3220ebe15da7bbe2779beee31eb.1647253456.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:27:36AM +0100, Christophe Leroy wrote:
> Only DEFINE_STATIC_CALL use __DEFINE_STATIC_CALL macro now when
> CONFIG_HAVE_STATIC_CALL is selected.
> 
> Only keep __DEFINE_STATIC_CALL() for the generic fallback, and
> also use it to implement DEFINE_STATIC_CALL_NULL() in that case.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

