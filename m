Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BBA498719
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbiAXRjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbiAXRjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:39:35 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058CBC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:39:35 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v186so53771564ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41aTXdV4RG6O01NXUYoariT3ZoaysCZ/qlDc5spT4HA=;
        b=KtMyrRvJWIl6g8aDJ61tlp8htAjY4Z83rHHQ37w5E4AYOV95sTCTO3FBn7EBhflmbJ
         CxWCXrBckFGPQfca5aep0e7UzLEXMD3ETaTClllL8KjOFuwaNx0fD7wHsaadw+5J3wC3
         r1TXzS45h+raBDvMZKiw8DbRJ90dXATrxp3b+SqgcWH2NvW4lSxRXeIxf7yslsW4VR5q
         e7qz73Et4MV6Buk+jQNlwpzFBpHTHcDl97z4Am5fDJQgk+plZfap5ZpWKxp8wvp/qPcg
         X2vn5qfhrAnouI9M3KkyH7Y5xdIXJ0gDHZGSMQUHCbTtD1tzFJL8zb8fiVAul/A2HoFV
         7+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41aTXdV4RG6O01NXUYoariT3ZoaysCZ/qlDc5spT4HA=;
        b=CLrI6d2Ok2/OuPLihQoADMjdLt+FZ4Aenn9rJPI4vvOkEXF6+Ckj1minvyAFDef7Ee
         NPEPhqz+5FRdUQPEqNRSwP90pUmb4AEw7MZHxhecCzRF21lKTm4OKocA14xSHlnkdgFQ
         +QKkHEg35mjPEgWrNEzn2u6RqpK7Hoh5Bb5I3M6rp7Ihf7bTUmLQGDbU99K53NuukO5G
         diW3FLgzHJxqf9B5tz/w2u+qJXlhlVF41VUB+kOptqpg4E+/YvkMc/f7pBKA/Z8IpqQs
         mdDQplAqDLtgRcrkMtOARHwWggEUDqhLajGTMhuP5j/19+pMkUB9vbaDIZ8izmVl5wWS
         UalA==
X-Gm-Message-State: AOAM531GMKhf03Il/FIOUltdSGupZyGuIyN6v6eJasOaUVX+GCxtjD+S
        0f57buQBUHeUH5uyYFjF1B9ymKfecKZf7cc0WQcaDtJ6MbyxNg==
X-Google-Smtp-Source: ABdhPJzijEBEsszZji35c2/oqwgGLWjHqxbyQXeb+yO/np9p1/WZOLk+N2o1x5C4wXMRIs7+CkyMUPv+rSy5Z5jM20o=
X-Received: by 2002:a25:b683:: with SMTP id s3mr24190315ybj.293.1643045973784;
 Mon, 24 Jan 2022 09:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20220122000301.1872828-1-jeffreyji@google.com>
 <20220121194057.17079951@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <CAMzD94QW5uK2wAZfYWu5J=2HqCcLrT=y7u6+0PgJvHBb0YTz_Q@mail.gmail.com> <20220124092924.0eb17027@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20220124092924.0eb17027@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 24 Jan 2022 09:39:22 -0800
Message-ID: <CANn89iKGOw3LZ_2agxewuNLMLRX7TSnGYnf0T6NwC+1s4OB2bg@mail.gmail.com>
Subject: Re: [PATCH net-next] net-core: add InMacErrors counter
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Brian Vazquez <brianvv@google.com>,
        Jeffrey Ji <jeffreyjilinux@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, jeffreyji <jeffreyji@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 9:29 AM Jakub Kicinski <kuba@kernel.org> wrote:

> That much it's understood, but it's a trade off. This drop point
> existed for 20 years, why do we need to consume extra memory now?

Being able to tell after the facts, that such a drop reason had
occured can help investigations.

nstat -a | grep InMac

Jeffrey, what about _also_ adding the kfree_skb_reason(), since this
seems to also help ?
