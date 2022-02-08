Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE34AD9BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349574AbiBHNZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347740AbiBHNXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:23:22 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEAAC02B5D2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:18:28 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y129so13413755ybe.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 05:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erPKAPZmnrdsnLNqF7MMgTZQ9+9nAxr8YWVYBs98IVM=;
        b=IrBJLyhuai9owyHLlJ6aGAaCIX/wkgUP0QYW9GlFQtal4Mx2m2L/c+vYnEWprv21cK
         HjmprtinTVsr+TN3ke08vEU7Z99dxDCShrUPmVb/JZBJ7RgwmCkhD4bszLJMhhUZDM/j
         pS+fjfCc9OZ5wmAweAn53IM4IUhDQFnZuKzP3u85pIaVD9J2LprLzZIbEye9XwCb4nRp
         Y5Wj5Gv0INYF+1bgC3uG+ynFyK84s3bZYZYwRP2IIxr4tQ9q8FEVdTCi3QoieKLLh3HX
         d2jx5dE4nbnfA8PAOGwlR59hDEcZWbljJLj4DIDfh3RLBGIV9eXrjSgtWAoEOkWPBWXo
         LD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erPKAPZmnrdsnLNqF7MMgTZQ9+9nAxr8YWVYBs98IVM=;
        b=pehj8XH0Ur4wYfN9k/vf2jB1/srP5rZVE3JoyBxAXZxLxJjqrgMXPt0GjJnpT1Bt0T
         DotKU+hL/vIBksoMbeOjr0g2Rw3DTLT5CxvUB3lWt0USaSC+UQbpewchHNFnSV/ukIux
         ygHcn8d35ahzV5G8iYddDXvVnrB+X4kYLrwkFmB9ThXRDTaXKmNm1U1tE7csrKnPRgoT
         9vyp4gFBj98VPGlGpLKI2uBxafn3hbCb9nD0vZqNL+LsKcuhBdyNCh+W2NwK6aKsKaWD
         5+J1NlC7rDwLd+6NqzkZ2hWmHqPQBJ88e3Q+JUhW+1a706TacW/OMOamb79EURV32hKI
         T9Vw==
X-Gm-Message-State: AOAM533npXtF7zyEe7xy02BMXiACWq3jrVx3DesRtSU1U+TtJkOrBo2D
        1DYWAslZZRPfPNKEMr13Iac1FeVeLkR/5ibUiUE=
X-Google-Smtp-Source: ABdhPJz8f29CkRmFUCDAaPM4riPPRwAhHipItCE4nYqlJ4Qx04mcjLqVsSab1zXdbDVBUhtAJ4VGPA/kU/5uTYyXI0g=
X-Received: by 2002:a81:dd09:: with SMTP id e9mr4733280ywn.202.1644326307082;
 Tue, 08 Feb 2022 05:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20220203131237.298090-1-pedrodemargomes@gmail.com>
 <c4128a09-1dc7-24b3-8ff2-eaf61f3de5e5@redhat.com> <CACpbsfapGSbno_n7ZJYJ2E4KkqWdWe_Wz8PuECBa3PZBp2Xnxw@mail.gmail.com>
 <dcb5d9c7-ae5c-e0c5-adee-37f5b92281e0@redhat.com>
In-Reply-To: <dcb5d9c7-ae5c-e0c5-adee-37f5b92281e0@redhat.com>
From:   Pedro Gomes <pedrodemargomes@gmail.com>
Date:   Tue, 8 Feb 2022 10:18:16 -0300
Message-ID: <CACpbsfbwXbvAgM3Hgc8Sk-evaPLk0Ui0WBz22=t-PWsKAM1bbw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: Add option to monitor only writes
To:     David Hildenbrand <david@redhat.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 6:01 AM David Hildenbrand <david@redhat.com> wrote:
>
> I'll put you on CC once I have something ready to at least handle pinned
> pages (FOLL_PIN) as expected, to not get them accidentally COWed.
>

OK, thanks!


-- 
Atenciosamente,
Pedro Demarchi Gomes.
