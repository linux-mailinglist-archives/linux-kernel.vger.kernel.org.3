Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B924687FE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbhLDWEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhLDWEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:04:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF8EC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 14:01:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r11so26323534edd.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 14:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrArc/ifsgPokgBSC+Ea7AYzh1AFMkX0pvs51A3I4u4=;
        b=RbFJlew0CJwUua0mcM+UwWlLfDB+SvHq+bCujY26qJe03tLD8T4/o4D3aQzet0lIxM
         H3P8ImGLhgxwRq6PMV/CnAHDQrV+LCLwuv5vpralfCkN3myC7aKDAR4fCTef9EthYPV4
         Xb49U5ntDeqmLcYHi3cs9bqWUa1oiHprIOu0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrArc/ifsgPokgBSC+Ea7AYzh1AFMkX0pvs51A3I4u4=;
        b=rwyAC/FAni/OrAvNy9rsj47lHQaD3tvS7ISIRQqMFh9RPH+IbhKQsPTDW53xphZSPf
         4Twdihdc8UFQoRAA+hdCIdNZYm1YBYwWbo+hz2qLlGMReX1nt6jR29hi74o3lMPnhSw1
         bC95zkZDEMb16e9aQhpLoizKP2KS15PLkYKagA2LU6f/034viONkafIQYQXJ0Z/2XQcc
         xO0UFGzZSuQzOyTbSDEKlbrjNHQkARIf10g4y0UauO4XPBKmcUvkinTdLpT3ZPAWs/Cj
         xTDv6eDGkZa6bKA/QrDOOzkXAMktid1/J+JQTj3UNDqAdfLqwPCs0sAdSyJ0LnNCGCZL
         YweA==
X-Gm-Message-State: AOAM531inReB0+xHJKPskZi7kkFdbjRz1NoIxdtnXTkmooO/RLKLPajd
        SJe7ykvTEkjyvyMCBofxA1qP9RPfdZ4sbDNB
X-Google-Smtp-Source: ABdhPJxhGOGLr5Luhuaeid91coKpeLJQnpXp8e+q59ySOpS3yPPPtC5jFX2ZUUwsFOGC1FTw3FzWHg==
X-Received: by 2002:a17:907:2ce1:: with SMTP id hz1mr33428736ejc.96.1638655275982;
        Sat, 04 Dec 2021 14:01:15 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id f17sm4679295edq.39.2021.12.04.14.01.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 14:01:14 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id j3so13755686wrp.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 14:01:14 -0800 (PST)
X-Received: by 2002:adf:f8c3:: with SMTP id f3mr31503846wrq.495.1638655273990;
 Sat, 04 Dec 2021 14:01:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
 <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com> <CAJZ5v0janj--CTeVndJAwiaset5tP8XYdXmeW1hHREcO4BefZw@mail.gmail.com>
In-Reply-To: <CAJZ5v0janj--CTeVndJAwiaset5tP8XYdXmeW1hHREcO4BefZw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Dec 2021 14:00:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjeN0FO7s+o=ZhxjCwTU6N17oT1h1WHRXtiysRRx5A1Uw@mail.gmail.com>
Message-ID: <CAHk-=wjeN0FO7s+o=ZhxjCwTU6N17oT1h1WHRXtiysRRx5A1Uw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.16-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 12:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> but it is interesting that you can reproduce it.  I thought it would
> be rather theoretical.

Well, "reproduce it" may be putting it a bit strong...

It happened this morning, and after that suspend/resume was broken
until a reboot. But I've only ever seen it that one time.

              Linus
