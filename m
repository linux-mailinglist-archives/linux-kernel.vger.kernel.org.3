Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEA6492D47
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348010AbiARS0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:26:19 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:43617 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbiARS0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:26:18 -0500
Received: by mail-yb1-f177.google.com with SMTP id g81so58653558ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nNs5o4VvLJblkKkIVcPmYPx10yy3hUKHbFmbQiq0e2c=;
        b=i5vAqzK4lB1qMbz7GnDBb+Wl7M2dwbIgChJ9tIXhUUqSTrTxfbv90echFlDcrbbPOh
         w8psv195l6I7O1xBObA8YPlMlCnL1wQIE+ZR94weqU2t+8pvBieupP7bjg6RpyIP/Fnc
         65LnDDpNUm0usWSoEsXF7E5FrY9fIHQIcBh6Adzn9UqUOjRm6o7bxnvd2eoJ4Q5gpVjf
         udr+2clp5l/2zbE5l/JquvZ+LDNhRfBhy70WTK519fOFp3ezZ9FtKs0nu1w5QBjTL8C+
         VBNKnk2d85XsOY35yeFtO1gUArWyhJdnMeTSrWF4zmj3bJlHKORyGR0M3AgRCIsB/u0g
         aVwA==
X-Gm-Message-State: AOAM532dtM7XLKtmLXcayuQF3m+GA0UE+r+Jghid2mqNMnbjK75sByiW
        ywqfQMvQs8KFYPOFS57L28UgOmL6Wj4CK9JGoHGopw==
X-Google-Smtp-Source: ABdhPJx5/up8OyqXZHlIHqf4NfI6Tfjq2cViE0P7N9WMB4LYAqgwwLReT8UFbDuDxxQ69bbIL88CvfRTEhI+2+iMALI=
X-Received: by 2002:a25:1388:: with SMTP id 130mr35201366ybt.321.1642530376588;
 Tue, 18 Jan 2022 10:26:16 -0800 (PST)
MIME-Version: 1.0
From:   Martin Ross <mross@pobox.com>
Date:   Tue, 18 Jan 2022 13:26:05 -0500
Message-ID: <CA++MVV3Jse4WZ-zr-SUWQz3Gk_dByU6JduVfUkvQNW+jgm9O4Q@mail.gmail.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
To:     jarkko@kernel.org
Cc:     corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com,
        jmorris@namei.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        Yael Tiomkin <yaelt@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

I have been working with Yael on this project so I thought I might add
a bit of background here around the use case that this series of
patches is trying to address.

At a high level we are trying to provide users of encryption that have
key management hierarchies a better tradeoff between security and
availability.  For available and performance reasons master keys often
need to be released (or derived/wrapped keys created) outside of a KMS
to clients (which may in turn further wrap those keys in a series of
levels).  What we are trying to do is provide a mechanism where the
wrapping/unwrapping of these keys is not dependent on a remote call at
runtime.  e.g.  To unwrap a key if you are using AWS KMS or Google
Service you need to make an RPC.  In practice to defend against
availability or performance issues, designers end up building their
own kms and effectively encrypting everything with a DEK.  The DEK
encrypts same set as the master key thereby eliminating the security
benefit of keeping the master key segregated in the first place.

We are building a mechanism to  create a security boundary in the
kernel that allows these master keys to be stored in the kernel and
used to wrap/unwrap keys via less trusted user processes.  The other
goal here is to eliminate the complexity and statefulness required to
do this today which would be to create a trusted daemon or process on
the machine.  Concretely this means that since the user process will
not have the master key the system designer has better options.  One
obvious advantage is that any core dumps or code injection attacks
won't be able to trivially grab the master key from the process or the
linux keyring.  Once in the kernel this functionality can be
transparently integrated into user space crypto libraries that have
existing key management functionality.

Hope this helps and happy to answer any further questions!

M
