Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B23046A3E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245752AbhLFSYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:24:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244449AbhLFSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638814836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=euSBJV6H7AIayYsx/jymKT22o7jdD83Te73E5T3p9qg=;
        b=UDJfCI84cFsKO3daNj4Y0qBD6sU1s1+6OaUghMn7rzuiqQqxAFpx9xz3apDn4gkorAJHqs
        GMNOMWHWfYyx44OpmkhDUVYMe+9wEB+20oE/vaLhV1Unl121KokH86CN2eZkW63OxlKL5O
        qIkV7GtTupR0OTqYTMOYeWAfbbVCD4A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-WOnjW-EZOYeMrrL_Jn9S6w-1; Mon, 06 Dec 2021 13:20:34 -0500
X-MC-Unique: WOnjW-EZOYeMrrL_Jn9S6w-1
Received: by mail-wm1-f71.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso8257244wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=euSBJV6H7AIayYsx/jymKT22o7jdD83Te73E5T3p9qg=;
        b=5ZbHVAe4ZdRJvl4Of8L+dZsB//mpUHnGOmS9QyXqlfaokVFV9wS/8FmxAvqjGfWRRJ
         FxPWaWrDf6Kx4hFatizm+8y5OIVXtubkvZv6H6FNmGhEjCLGJcFtnr/owE/ygCGw1SZx
         czgYmrV9HI+i4awTZs4vjI3Z9vocCPQOafse3HSZUt5Vr/RofH8TrjOX8cbmuJVKYKBO
         mjh6W3mwPtFsA709+5i8tiuqgDAgIxgp+IH7vo4+XRMkqiAoTIKUVNY/KAEfgPDQPfXi
         wilr8oDr4wgdt+eIJ5ZScMTkMBN7hLRx5vCwcl3KrSc+a40pRumQv5iKx95XOqmfC/P2
         AjyQ==
X-Gm-Message-State: AOAM53388dpmdXqgdYWrvC4+0jJ7AK/JlWbMUMTSaQnR+ZCXZRFoF25A
        E5LoXued3h5CojMxlobriAQ0OwFmwOKJb/mV2GOE/KvbKA7yL7FgjapkBdZiLeqpPx7cMZZHuAE
        QWQa2diTMMxA2jJD2R3VXWNNk
X-Received: by 2002:a7b:c155:: with SMTP id z21mr186881wmi.107.1638814833557;
        Mon, 06 Dec 2021 10:20:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNGUuAeiZEBQ0uQXmueMFz5HGti1shlWq4mMAIfp1iMpGdogEvGrBWREXa04OkWVSqhplTxw==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr186854wmi.107.1638814833361;
        Mon, 06 Dec 2021 10:20:33 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id b13sm12459543wrh.32.2021.12.06.10.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:20:33 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCHv2 0/3] ftrace: Add ftrace-direct-multi-modify sample module
Date:   Mon,  6 Dec 2021 19:20:29 +0100
Message-Id: <20211206182032.87248-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset adds ftrace-direct-multi-modify.ko kernel module
that shows the usage of modify_ftrace_direct_multi API. Plus
two additional small fixes for ftrace direct code.

v2 changes:
  - rebased on top of v5.16-rc4
  - added s390x trampolines

thanks,
jirka


---
Jiri Olsa (3):
      ftrace: Use direct_ops hash in unregister_ftrace_direct
      ftrace: Add cleanup to unregister_ftrace_direct_multi
      ftrace/samples: Add module to test multi direct modify interface

 kernel/trace/ftrace.c                       |   8 +++++-
 samples/ftrace/Makefile                     |   1 +
 samples/ftrace/ftrace-direct-multi-modify.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 samples/ftrace/ftrace-direct-multi-modify.c

