Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704CC4A4694
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350849AbiAaMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350321AbiAaMHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643630825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k+DYbhvcbUytWZeA8bcgfAsvYrRe7fudO+Mz41JEQpA=;
        b=JJNaroa3E7V/Wv8uABrbbVfoe6XxEebMu+7dsA+wCPSdAuK4Zz9t5qkX2AuT8AUtTY1Oip
        /XAv+N82YOw2okN8/41yY5MIdiTKl4babBQlIKxgfu+MLeHA2LmWVS5bvMzHaRKo1Z6exH
        1UEbELbFtqPs6pn+cfziAj1yjeNUc6s=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-LcGvfjzBOA-p_D3mM7ILkA-1; Mon, 31 Jan 2022 07:07:01 -0500
X-MC-Unique: LcGvfjzBOA-p_D3mM7ILkA-1
Received: by mail-yb1-f198.google.com with SMTP id a125-20020a25ca83000000b00619442ade1cso17293017ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 04:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+DYbhvcbUytWZeA8bcgfAsvYrRe7fudO+Mz41JEQpA=;
        b=JVvxAhNmTFYSCJM/Ng/3r+EG1SQ4cer+hBqPiLzsYOTPTXbMXRIpcQOmFwj20Jy1Io
         or5JAlqmbDBNrYTY1T29AAiKs0yjotNmk7iiD+ZPVSi6VzXiXCWceuwpM/dzvH2YziW6
         80KyW5HC2DHTAk0QgffXuihMgPo5Lj4vzPNzgAI6u9SpV7HhGfL0sdYEJYUgV++TFWRg
         fqvyXvn6LjTrnquwifjMiqinQXCj4dEIcJ1VPBraLULjuoCNBCWNs/xMDeXfDszs2Hpl
         9ZTON0pAmAg0gIySKVVutp2xSskbnU5ZnY++b5xfK/pHkRAwmDPtRsR0TZr9JYZUEdLT
         QHCQ==
X-Gm-Message-State: AOAM5320yNv1pjGkV1u0y6TsJXKi59XfnLVnkzLEz0V4IgEFhD3AVmNK
        f5F+vv4qG0i7tLP1XIE4gzme4htq8/Aog1WQ10qxBG57pZxgIPmTk71XtTqL8RlNPP5bpn05m1S
        Ux7dxvMXpdNc2e/8MZ/QMocvWQAehJ7FC56EaDnln
X-Received: by 2002:a25:d90a:: with SMTP id q10mr29679735ybg.253.1643630821345;
        Mon, 31 Jan 2022 04:07:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4XU5YfszLGQp4N9C+7Wcm6G7P3VJo0M1H3K29i4UnrahCCIj1CDSm3JxETTQm5Ow1SBCcgSEmb0cR2Dt3ZPQ=
X-Received: by 2002:a25:d90a:: with SMTP id q10mr29679717ybg.253.1643630821159;
 Mon, 31 Jan 2022 04:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20220128202858.96935-1-vbendel@redhat.com>
In-Reply-To: <20220128202858.96935-1-vbendel@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 31 Jan 2022 13:06:43 +0100
Message-ID: <CAFqZXNvG+-8FcEgcbKxmUeMznVp6NBAoPctN4EHCc3i-DZA8jQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] selinux: Fix and clean policydb->cond_list error paths
To:     vbendel@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 9:29 PM <vbendel@redhat.com> wrote:
> There are two users of policydb->cond_list: cond_read_list()
> and duplicate_policydb_cond_list(). If any of them gets an error,
> usually an -ENOMEM, the error-path-cleanup *_destroy() functions
> get called twice: firstly from these two and secondly from
> the caller functions' error paths.
>
> In case such -ENOMEM happens while assigning cond_node data, i.e.
> while ->cond_list_len is already non-zero, it leads to inappropriate
> dereferencing of policydb->cond_list[] data in the second called
> cond_list_destroy() from the caller functions' error paths, resulting
> with:
> - NULL pointer deref from cond_read_list();
> - use-after-free + double-free from duplicate_policydb_cond_list().
> (the cond_read_list() manages to set ->cond_list to NULL)
>
> Patch 1/3 simply makes the error behavior consistent by always setting
> ->cond_list to NULL.
>
> Patch 2/3 fixes the actual bug by resetting ->cond_list_len to 0,
> so any subsequent cond_list_destroy() calls would become noop.
>
> Patch 3/3 cleans up the duplicate *_destroy calls on these error paths,
> albeit it's a bit questionable and I'm looking for feedback on it:
> - on one hand the idea is that the caller functions call the *_destroy()
> bits anyway, hence removing duplicate efforts (which also fixes the bug,
> but I'd still prefer to apply patches 1 and 2 regardless);
> - on the other hand it's appropriate and more bug-proof for a function
> to clean everything it allocated on error.
> Hence I'm looking forward to seeing what approach the upstream would find
> more appropriate.
>
> Signed-off-by: Vratislav Bendel <vbendel@redhat.com>

For the series (with or without the last patch):
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

