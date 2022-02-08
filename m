Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C354ADFD0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352866AbiBHRkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiBHRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:40:30 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD70C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:40:29 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u12so7327628plq.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/n1iBZYN6aHIiLtOtn1wQ4O2zv6mMxdTx7XSbC0LcaI=;
        b=HJCRSyKMcnxeOscdWUgdASIJppRNO8mryKlh6ZnR92wjTmgwvY0FCEaRhBmvzV962c
         QdUMfwxgiba1SFdf9cfVB4kJ31kAA96EnfzxE4yIHduE4+xgkqI+2XvPawSMxMsvCxVX
         H+/+DG9jlOJzNT61ivP+cIuq1EEV6K5aKXZfyxQrr0S9919TMECKe5gMfkRwWUosXnIg
         knMgR2kMmqwBQRCom0lWdSj1niaw1GS5izTBRJi2ISSwkDNjPsPRvaPPb091gOfqV6YN
         +VjCVjGjqbX0KnNHLqs2KW0rMtVADduFWCH84kQiqP8qob/ilyT0ENSVHdQ84nI3uHFl
         5Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/n1iBZYN6aHIiLtOtn1wQ4O2zv6mMxdTx7XSbC0LcaI=;
        b=dCmQh/SGcWMD7Gt5ULDJPKB8l6nunNJfTaO+9lq4QAoQEcqvEZRrhO8h7UkKM9gT+W
         PWGQ1qJhIwUFApIPMjeoa34GEGc7ToOvOTDZrWgxevaS0hT+Gv9lGXdpuiNjQxOj+5Fl
         twyZXQTKXKSg/FVgsJduUziagsQi0Pl0T5i7BRZCkC2rV+XagJ4SI7S8G9tusWxo71cz
         snfmQJ3jsztrrd2x4bo+FnihB4xfe0DPx5dxCPhMha33KPQTGU/syxfQoecNnB7oU1/i
         vHOrukWE/7WALw3cOCNTkF4wyxkJyBkDk/llphrm0H84JMuM1zJtQRgvxVG46AvodQxp
         IZfA==
X-Gm-Message-State: AOAM532BsfjmhKvwtdq9LJqn4xYyTw+YAY7tzRIqwFJCWDUehHpzWJcs
        Eyp5e1pJn2kyhJm7K2gZEpEagPa+Gdr1gA==
X-Google-Smtp-Source: ABdhPJwR/x0TYGG1SBd756+XzEqNV4rg/D+sMksphjg6guk0AuOrLNZLRo+6UJK75/mniRmmUzvZIw==
X-Received: by 2002:a17:90b:a06:: with SMTP id gg6mr2559556pjb.153.1644342029263;
        Tue, 08 Feb 2022 09:40:29 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id oc17sm3921322pjb.10.2022.02.08.09.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:40:28 -0800 (PST)
Date:   Tue, 8 Feb 2022 17:40:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 5/6] x86/cpu: Remove "noexec"
Message-ID: <YgKrCZkiU3X2OV6b@google.com>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-6-bp@alien8.de>
 <202202071419.E21C67553@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202071419.E21C67553@keescook>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022, Kees Cook wrote:
> On Thu, Jan 27, 2022 at 12:56:25PM +0100, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > It doesn't make any sense to disable non-executable mappings -
> > security-wise or else.

Heh, I've actually used noexec relatively recently to triage KVM goofs.  That
said, the same net result can still be achieved via clearcpuid=52, so I've no
objection to removing the dedicated parameter.
