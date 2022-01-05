Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F442484E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiAEG6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:58:17 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38690
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236419AbiAEG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:58:15 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CD65C3FFD5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 06:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641365893;
        bh=K7KhCCRGwBeqa84RMcXQSaKtKWeSUZPZtO3lWY1KoAw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UYg6xzOWq4Qg5RrxkGcLPDXVbcznh/B5w749878Aw6Rj5T+QOdYUgx5GLPRbmYhZO
         zEr3QGm5nUnLqy06wcPUdknYsSQ0OyW/zGc0148865HXoowDEZvfvepzJaBsnK0L2Q
         3K6LO93yEdx7XRwzHWLZO7K6wtjCRe5j1ddW0c+Bqk7SjvoPL3tIQ5GAIbYnM5TRpb
         JrfOFt5nDTP1zpZQNeD4RXWKXvPzuZmRkbbTSgMgrY4S/KxiXbjsM5MJgx7EWwr4NI
         YYufIfU7lOK+VeJ4vBEVaqsLQY+GhQi8zWandEdH8xdyAM1o4ft5j8WQel49P74sM7
         LxQhyg3mmYjaQ==
Received: by mail-oi1-f199.google.com with SMTP id bj40-20020a05680819a800b002bc9d122f13so25311053oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7KhCCRGwBeqa84RMcXQSaKtKWeSUZPZtO3lWY1KoAw=;
        b=z54ekyEsxpIknI+wixrsIEHbJOKY57vCW2VOXazsZFQFhKeA+lLnCP0ec/zzS//wHB
         9Vg+kSM0v6utlNw4QOK+MYZlfdyGENEfnCiciaGshL+4U3ycXu6aZMnIYlnUuXLpugoi
         fRKaaIOuMjFSxm5NNdYj51NgFsvRNkYuZ4ypmTyDwiWdarUnZo2zSwmTi1u8P/qwHA+w
         eBBxfnRd1f2+IxAMVSlmEH0GVNQe9/pqbI5ZYpYtLsXCPi3gneOrkdVxZpDV0gZX0lTo
         qlDpFzdaLTf9zbjZnOzO9yR7DXaiirVn+UE4ebreXsPUcc3lNxvmMPKgZhN2SFi47B3X
         TRdA==
X-Gm-Message-State: AOAM5335Hx3oH7AWnk0AlZWM25KbSOhH7yIYFxNelIjoruVP+wXUC0wI
        5pReKiCJsC7VeOFYjb7/kOXeaXsNFMgjVCfjGIK8qafbX+LBsG16rBLpCwwUYLBwt+HI/SFE9bm
        Q29Fj+2FILv/K7uLQD7fZ/sxLKUzL4kVBqsGH2lmiDU5x0a3WFyZnmLLBoA==
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr37862054oti.269.1641365891200;
        Tue, 04 Jan 2022 22:58:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNEUrV1/+wUr9dPal3uCYsIG1bY6qJIscVrBikSe+RUdub75zP+CxdWyhqtxOWGkSB4MQIVWIg4kS3Iyo32aI=
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr37862043oti.269.1641365890949;
 Tue, 04 Jan 2022 22:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-13-matthewgarrett@google.com> <CAAd53p6d2CsZcwaX0ZtjmOmQv1Dru4qmM-uRxtHJi0k5PnFMFQ@mail.gmail.com>
 <20220105064827.GA30988@srcf.ucam.org>
In-Reply-To: <20220105064827.GA30988@srcf.ucam.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 5 Jan 2022 14:57:57 +0800
Message-ID: <CAAd53p5A9ajyP=8edXW20MB1eLRAF3SsmXfdnkA2isBJD2Bd+w@mail.gmail.com>
Subject: Re: [PATCH V40 12/29] x86: Lock down IO port access when the kernel
 is locked down
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 2:48 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Wed, Jan 05, 2022 at 02:25:41PM +0800, Kai-Heng Feng wrote:
>
> > This patch breaks ioperm() usage from userspace programs with CAP_SYS_RAWIO cap.
> >
> > I wonder if it's possible to revert this commit?
>
> When lockdown is enabled, or under all circumstances? It's expected to
> be blocked when lockdown is enabled - allowing userland to use port IO
> would potentially allow reconfiguration of PCI devices in ways that
> could alter kernel behaviour in ways relevant to security, which is what
> lockdown aims to prevent. What's being broken by this?

Only when lockdown is enabled.

The affected system from the customer has SecureBoot enabled (and
hence lockdown), and the kernel upgrade surprisingly broke ioperm()
usage.
The userspace program is proprietary so I can't share it here.

Basically this patch makes ioperm() a noop on SecureBoot enabled x86 systems.
If reverting is not an option, what else can we do to circumvent the regression?

Kai-Heng
