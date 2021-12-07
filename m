Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB88846C787
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbhLGWiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:38:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232434AbhLGWh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638916468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXV5aKDpOk1UCVYHUPyHCeEEX1ZRip9IPqxSBkIP9Vw=;
        b=fyOIGe/fdZUR7aNK2RZbWtYXl1Y48Cnf551WpZjCScH5pkwtZboPP3gCx1EgncbEyOzLcq
        +ruRltqN2I9WBVjtVdBO7g+H/kH26LYJslp3VnmrKpAReSDC4ar/B0nNx9JbeQV4lsz3jS
        27lBglfLdv6iE3Kdnerz4byRecSuOqc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-WUUmRtOOOjeIVypQ5p3rKg-1; Tue, 07 Dec 2021 17:34:27 -0500
X-MC-Unique: WUUmRtOOOjeIVypQ5p3rKg-1
Received: by mail-yb1-f199.google.com with SMTP id l145-20020a25cc97000000b005c5d04a1d52so930173ybf.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXV5aKDpOk1UCVYHUPyHCeEEX1ZRip9IPqxSBkIP9Vw=;
        b=SNoNaXUUwK1OHay/NDtTCQfzbA1hCJRYjvhnq+/Hd3HZKJqy+WEFEl/n99Vhg5ULpY
         yPpe3h2889dsk3+y7QZ6OrWmUDI/pt1ksbvnioeLvmv6jQ5VcWaYi/DOQoJH/JXL0zof
         bzLrrvHrQ0vlKhbZrahOs60MK7r5+ds8jtPQsGv5xYpTt/wiujzgpdaF7yc8EYxr1y23
         F8pyByTxoGZHQLP3xLM+lt4aX4NCOsiAziPOM/4+J5fj4znJTguVfkEkKtGiUhDUvgnA
         hLUN06lB2iQz3+V3k4KwJqSJ8kMjWLle0Vqhsn1lZZwdRW/ZXo5yW4t8g3tvzywOEUw6
         54eQ==
X-Gm-Message-State: AOAM532TR8P0CPkDOCDP+ouQpmLGdCRZPcOYAyK3Gc+PjxzUVo1X8X9+
        KNakRSN3f6vQZJPmPBvJbY0GD6YKcObnnd+yI5y/67I1W9nOGLhgE15ABkRS7vFWA612oK+dWKU
        SeW9V2JQh6A2o4yNW1OEQ9XhyS+ttjs7GwgyfQu7B
X-Received: by 2002:a25:3489:: with SMTP id b131mr52484734yba.76.1638916466792;
        Tue, 07 Dec 2021 14:34:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwv1Ok19vrmvvNUoxVNCUs234zgV17Ov8mxAzDjk116VsbdGnjAw6jOamayBlBiEoKv4dNNtO9SuGcjSHkA0P8=
X-Received: by 2002:a25:3489:: with SMTP id b131mr52484696yba.76.1638916466292;
 Tue, 07 Dec 2021 14:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20211207214902.772614-1-jsavitz@redhat.com>
In-Reply-To: <20211207214902.772614-1-jsavitz@redhat.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Tue, 7 Dec 2021 17:34:10 -0500
Message-ID: <CAL1p7m7tHxo4am8W6ycO=ZjgxCWMwYUo4mCQseaer-EX+8qZuw@mail.gmail.com>
Subject: Re: [PATCH] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer

