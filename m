Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D4B4D3CE3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbiCIW12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiCIW1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:27:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D8120F71
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:26:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m22so3618395pja.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DnX4yE0wKRLAa2OnqOmK7GeRT23OmcuMA/YZwxy1i9o=;
        b=Smajq1CdD1HPTSBKN3ajcNxuxHraSrmHZWGlTUKbIR7BFC8ecygKqsMt4vpoIkRd3q
         v0MiTh50GCZdBElwHeEJM1fvdzusGIkH8xwXUv1hNoRUSWwnqIm9f/QYxHNWaqGfCrFh
         6IrjUU2PowLSge+VWLOu9vhmFMMOK0ly1zpw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DnX4yE0wKRLAa2OnqOmK7GeRT23OmcuMA/YZwxy1i9o=;
        b=sVhIHPCdoFWM+WCJTKuv+vNt7hbb/xilgqVF1w4yJeAM76/PSm9ktcW4uy5BS3NRk7
         +22X7CVuOg58k+6cFVNF26oCYpLvVfGYbZK9lJd7+MAf/wfisvM3+inhruyxm791DeYt
         Ye6cfcm8i6zFscdGs6+Iod8Zfs4PWvfepuF+fvY5EKL6otB7fSXlFJaP2EVLIyBqaU+B
         mmeVXWgbGGxckmFHh53Vuu2jZyQuigpQTrlTJrk3e1ShS4JTrULJrVQnWvnwt/zlVNrR
         dSUwMZbF+fURHyPl0Ox+u0wd3nfY7Q3XTH8cCzg1HPOEUrGZHg4vt1vUaTwaUvKUJDi3
         HQ8Q==
X-Gm-Message-State: AOAM530c1Dcy+PiZEkq7UqsE8JgPA9AiplvuiuNhMI+lZ64tujadIwDY
        nuc9TzooQ2JuaoWrYIYs4yxDCA==
X-Google-Smtp-Source: ABdhPJzCcyacsQwJ64Jx4lBOECbPAiTDPJg1GvRkCsR6ZSF3r6rOSjrFo1b0pt2cBK/RzUWmSMRrEA==
X-Received: by 2002:a17:902:c14d:b0:151:dfb1:a1b4 with SMTP id 13-20020a170902c14d00b00151dfb1a1b4mr1875894plj.132.1646864783889;
        Wed, 09 Mar 2022 14:26:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o66-20020a17090a0a4800b001bf388fc96esm3601627pjo.21.2022.03.09.14.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:26:23 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:26:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 03/13] ptrace: Create ptrace_report_syscall_{entry,exit}
 in ptrace.h
Message-ID: <202203091426.04DF0C97@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-3-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-3-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:44AM -0600, Eric W. Biederman wrote:
> Rename tracehook_report_syscall_{entry,exit} to
> ptrace_report_syscall_{entry,exit} and place them in ptrace.h
> 
> There is no longer any generic tracehook infractructure so make
> these ptrace specific functions ptrace specific.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
