Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF0A4FA181
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbiDICCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiDICCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E922ABB90B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649469635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRNiaLDF+bOnRenMKJ7VX/3O5X3d7lP4lE5YBDirAV0=;
        b=I81Mt3T6PCKHkP7bfhNsqUEnsW4PkQho74F8qfh8XiuXheEjGx3MbxrsxDf4cyr8jXtlWi
        vO1R1/y1Nd1MkUtkFvYJ9kFaW/KOTSnsZZM5xQ6Fe+KKx+zqL52zW2hC2aP6C6G1tW4mwI
        5vvCykQKcX3qSA5SKZs2rraBzxWcgCI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-5IU1e4QQPYiNjNnwwgkGUw-1; Fri, 08 Apr 2022 22:00:32 -0400
X-MC-Unique: 5IU1e4QQPYiNjNnwwgkGUw-1
Received: by mail-qv1-f70.google.com with SMTP id kc2-20020a056214410200b00443e6240ba1so10787864qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 19:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oRNiaLDF+bOnRenMKJ7VX/3O5X3d7lP4lE5YBDirAV0=;
        b=1iMQ6TcNsMSnGHVJvReocAdtM7F3hl9GyvZqJLN51u96WG4+YT50VNvnWw4sEk91KE
         +B13aOqyxnKkjoEdhimK1cjucv/vA8YCmpAMAWOkSvNyfJNSDs00EFjWSdnyCNj/dOPH
         bSQRHuyGtb8uOfrCMUYLIsMiRXiW+3MQflhzk8hwpDg18A8x7XKyIJJLrFMa5jgCWM7P
         3iSdz7wS8dqhcY+sziZocZPVp8Vw/vEJVUKtUz007ZkCtwcdl+7RY+YY/rTwJNVv3Iq1
         yukre3gWXXlccsYEZgaScSvNXVGfH7cSp6u/CjJW7AyioRyOqJCcbFqbcfPD8LRQeQ//
         zdsA==
X-Gm-Message-State: AOAM531Y12QN8UAUnjP3oLsry74hc+f7UOSZpOVQ1fr7WULJaQWvxtEY
        E0uW99/vosZNmkZgWsOL0fG0H6zAT2jGja4UpQ6v0I+0lXpQa7hBN6qFrYG5/NvV6ET1wqs+TlF
        6zywZzkbDwyGwCwCQR4r7DbiP
X-Received: by 2002:a37:9582:0:b0:69a:5ca1:63b7 with SMTP id x124-20020a379582000000b0069a5ca163b7mr5374299qkd.584.1649469632285;
        Fri, 08 Apr 2022 19:00:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcUdxuZy5paPESZ3IWvo0i0+OHKsMbCzG44lHWPXEfTfRUgHzSs/0YnN+QIalgik4MImVTFA==
X-Received: by 2002:a37:9582:0:b0:69a:5ca1:63b7 with SMTP id x124-20020a379582000000b0069a5ca163b7mr5374289qkd.584.1649469632091;
        Fri, 08 Apr 2022 19:00:32 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id u22-20020a05622a199600b002eb841fcb6dsm19499115qtc.73.2022.04.08.19.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 19:00:31 -0700 (PDT)
Date:   Fri, 8 Apr 2022 19:00:28 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86: PUSH_AND_CLEAR_REGS_COMPAT
Message-ID: <20220409020028.wfcwidlvg5rgwpki@treble>
References: <20220408223827.GR2731@worktop.programming.kicks-ass.net>
 <20220408231447.GS2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220408231447.GS2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 01:14:47AM +0200, Peter Zijlstra wrote:
> On Sat, Apr 09, 2022 at 12:38:27AM +0200, Peter Zijlstra wrote:
> > 
> > How insane?
> 
> Anyway, the questino is; since int80 doesn't wipe the high regs, can we
> get away with the SYS*_compat things not doing that either and then all
> using the normal PUSH_AND_CLEAR_REGS without having to invent _COMPAT
> for that?

I'd rather not, clearing the register values on the stack is a good
thing as it gives attackers less control.  In fact I wish we could do
that for the 64-bit syscalls, but alas, callee-saved registers and all.

-- 
Josh

