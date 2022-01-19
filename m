Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443E9493244
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350638AbiASBW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:22:58 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48252
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343527AbiASBW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:22:57 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 48D9340027
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642555376;
        bh=xUJSqu8n1W3DwSb7KYDr8YeMmcT2ABKA6gJJDqW1UEM=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=ht4rX9iC6du6XKlpljEps7xCmGScXDQJeKKV8lIInh7vFMuDIwYipEKatVDNF3L8w
         JAspk7YDa6YUCRjG00Wdu2G596STsNLKEHKYFFGnlYz5SOzFcez1WUPD1Vae9epL9F
         h1+p38r2pQ5w7bYHjPOke5xkVbSOf5zEZaDg/I6tgfh5hLZFOh7OaH749R3Tl1vkeD
         A8biYLnfjIG1mWCT9/MvVRi5YRclMHulqi7udXUcRHPUvdMOs+vV0VWrUCo4Vpxi4C
         U9xleaO1odJ3v2y95FOSQY2qOBkBJBV6MaAYjILZGxazi5gU8PTltIhYiSkI5lJs0w
         ubmCdh7ssLy7g==
Received: by mail-ot1-f70.google.com with SMTP id q12-20020a9d654c000000b0059103bdc5ecso410163otl.14
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xUJSqu8n1W3DwSb7KYDr8YeMmcT2ABKA6gJJDqW1UEM=;
        b=wNrEmLMukoohcJIcKm8mFmyHIVu9WtcZIbgKlWcIszfWb+BSPJZBWJLPXpKISjaPR0
         AFSCb/X6ZfU+o6jtYmsA3ArQ9+6pJrCjJuiNuGJEvU54DBq6I4lAJ3NeIsFbyeE4okqR
         DAwD57v5AKgxq1aWCmd76hk2MTubgjIWRNr9egPcM3Uvyy8bGax/Tpl1HnJTi4CVLedK
         IKq8ghthHZoEwbx4dDq6UuOlPIMIVdEo6q2jZUcYI5fqB9imA5alft32e02T2l0nIqH4
         w3Rc7uCQS130UnEyhomXaZgYPPSUgiLznO31etJrSgqL5Jr3vkEK4ZQLgTKBZ9X6wKf6
         vfug==
X-Gm-Message-State: AOAM530HSOh54nOtR+8NKZ1fDF395heMznOSOUeo7+3ypFZJMxlv1Iic
        mLacDKhxsxNVgOtNyPi9IWAEpr9OkR5cPmWK2CnmMSXSTK3nD5DnvFVGDwW+/3UBxIglQ/aUVhX
        sVM+vPJL/IEQhj3QzxzuvgUZIdtuRDPAJgYm9DSIdA331kz3gDMhpxVXywA==
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr8241661otq.269.1642555375089;
        Tue, 18 Jan 2022 17:22:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyD9dH8jrVforfEi9y/GHyKd2pIoqDn192FDYsbvJeO9yTnyo/YEb/NrHtuEsitIgx7DECZ860NegD11YB3hEg=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr8241640otq.269.1642555374835;
 Tue, 18 Jan 2022 17:22:54 -0800 (PST)
MIME-Version: 1.0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 19 Jan 2022 09:22:43 +0800
Message-ID: <CAAd53p5EiTXfAhCFPDaicksQOa5usOkS5v7moPgM2A7QZ6QCqg@mail.gmail.com>
Subject: Convert type of 'struct dmi_system_id -> driver_data' from 'void *'
 to kernel_ulong_t?
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     jkosina@suse.cz, Hans de Goede <hdegoede@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, mgurtovoy@nvidia.com,
        linux@weissschuh.net, Arnd Bergmann <arnd@arndb.de>,
        stephan@gerhold.net, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wonder if there's any reason to use 'void *' instead of
kernel_ulong_t for 'driver_data' in 'struct dmi_system_id'?

I'd like to use the driver_data for applying quirk flags, and I found
out unlike most other struct *_id, the dmi variant is using 'void *'
for driver_data. Is there any technical reason for this?

Kai-Heng
