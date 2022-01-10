Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB548A1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbiAJVQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240441AbiAJVQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641849371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgPggEUxpH9cg9HZbODYoC6wOKH8t1DwAM46PU3G64c=;
        b=dcOMpZndiLDXIbUUhdmi6vMi3F831HO7isr5g3HFjWuujwRjUtOPcoLopn3vFAor7SRw+1
        hUePxY3Kwa6XG8uIfjFm08J4zFAsISzlppZhOsWuDNzxWDE0zvNL3pNLlFkvLzHIdkRNak
        wfaNGUlgQQSOuIDL87V45PfXOmD3WvI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-Rsb0shE1OlaUKHpDv_VTHQ-1; Mon, 10 Jan 2022 16:16:10 -0500
X-MC-Unique: Rsb0shE1OlaUKHpDv_VTHQ-1
Received: by mail-qt1-f200.google.com with SMTP id b7-20020ac85bc7000000b002b65aee118bso11797578qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BgPggEUxpH9cg9HZbODYoC6wOKH8t1DwAM46PU3G64c=;
        b=wZlZCOI7B0WtFizQK4XdDlfDcz1C5cLwnCoDiS5qo9Jo/HTJgJ32lQ449HPtyrUTl0
         mJ7XUzrXpE6Hznp9n4PlndPb5Sdgdn3zgeIwRzo8cz/PGiCb+O+Y61Gyn0Sl0IjbasEu
         K23TlsjjdYYZG9FPN2JA2YU4PkL8ckOoFf5+nZDIwq4PUOwYQPD8zu1aW4qQ7m7D7gie
         3QIaYwAVWuDYbH13uIPVkH7rTGSfjkMLZdofT2Y8ThvIx28DqzKSa8YT7kEr4qpLbqTq
         SuUM+v50uGzuE7+Tdmk2khnHFG2oL896LESQiNki9rZ2JUOn5ZdoBxGLNPo7b21J7Ckk
         G5SA==
X-Gm-Message-State: AOAM5326p2iAtiaJ+v6+ppy2wfTbXlXtcerkDU6GJ2sbwrUcZ/H6RBRT
        LWcClNtxEVXhy8JvCCGi+9o53MSiU72PTpy2RAjmld1jFHx/+rCFtCmwhG0q79D9SN3zQl8ZubO
        jqnpXxZHl+leJv3O1jO9FOwrV
X-Received: by 2002:a05:622a:1487:: with SMTP id t7mr1366531qtx.667.1641849370036;
        Mon, 10 Jan 2022 13:16:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFKk6kHX2QKZrJ8F+/zI+EDY+BYAjE/EL6wb5h/KgYqM5ja2uyTjcBT+7vfPQ0gRkLNd7c+g==
X-Received: by 2002:a05:622a:1487:: with SMTP id t7mr1366494qtx.667.1641849369379;
        Mon, 10 Jan 2022 13:16:09 -0800 (PST)
Received: from optiplex-lnx (c-73-182-255-193.hsd1.nh.comcast.net. [73.182.255.193])
        by smtp.gmail.com with ESMTPSA id r13sm5920370qtw.41.2022.01.10.13.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 13:16:08 -0800 (PST)
From:   Rafael Aquini <raquini@redhat.com>
X-Google-Original-From: Rafael Aquini <raquini@optiplex-lnx>
Date:   Mon, 10 Jan 2022 16:16:06 -0500
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v2 0/4] mm, memory_hotplug: handle unitialized numa node
 gracefully
Message-ID: <YdyiFq+A25Mg0odE@optiplex-lnx>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
 <20211214100732.26335-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214100732.26335-1-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 11:07:28AM +0100, Michal Hocko wrote:
> Hi,
> this should be the full bundle for now. I have ended up with 4 patches.
> The primary fix is patch 2 (should be reasonably easy to backport to
> older kernels if there is any need for that). Patches 3 and 4 are mere
> clean ups.
>
> I will repost once this can get some testing from Alexey. Shouldn't be
> too much different from http://lkml.kernel.org/r/YbHfBgPQMkjtuHYF@dhcp22.suse.cz
> with the follow up fix squashed in.
> 
> I would really appreciate to hear more about http://lkml.kernel.org/r/YbMZsczMGpChaWz0@dhcp22.suse.cz
> because I would like to add that information to the changelog as well.
> 
> Thanks for the review and testing.
> 

FWIW, you can add my Acked-by on your repost Michal.

I reviewed your patches and tested them against that PPC crash on boot 
described at https://lore.kernel.org/all/YdxoXhTqCmVrT0R5@optiplex-fbsd/

Everything has worked like a charm, AFAICT.

Thank you for letting me know about these patches, and thanks for
working on them as a follow-up to that problem reported by Nico.

-- Rafael

