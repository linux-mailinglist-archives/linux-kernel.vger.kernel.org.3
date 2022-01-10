Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD4489E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiAJRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238139AbiAJRVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641835290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VY56dbPaHLn3Z7C1nmGwXuOUHWMWAItdJjqmaXqDacs=;
        b=G5upLJkSdhuBu9vP1mnWf7PC1q8ZszCuNXvfWPAEVa1+TfOoWRtLhIAZZ+zNej5O34ID2F
        BhISM9ONZ6DudFKx7IGPXKs4c0CwEkZBkWhUZ81LeNCQSHVmVAHlcaGc9pA0BdWPmQzPP9
        LgCMd54gV8k8hSM862QNppCFQbgz+TU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-cGIKiCSUOky6q5bpEkbz0Q-1; Mon, 10 Jan 2022 12:21:29 -0500
X-MC-Unique: cGIKiCSUOky6q5bpEkbz0Q-1
Received: by mail-oi1-f200.google.com with SMTP id b82-20020acab255000000b002c7bc0c6349so10317527oif.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VY56dbPaHLn3Z7C1nmGwXuOUHWMWAItdJjqmaXqDacs=;
        b=hgLk7IyFPKBrjLPexLlqpEsNCooWn5WIbEnUC//4s7D5ektWFbz1gyrQoBHuJ19hRt
         KFkxSKSZ7USbE2Foy2JuXmbAXFkxa1c6ANXY9Y5Fjo+bdEYfiRtjJOEOj3rRaL43fIL8
         aMYgPtbdTNPd7Ww02Ju8SwN8IcejHAJs10kg5/HPraVZzWCWti+fhtjzwAUGmEkf0VXe
         eTEraUz9rp8aoNz9v8lY4Kr+C61oZ0jE9eXTF3FoPOVRbnfUhS2EY1tDmkhIqMQd6DPe
         FTFbH4MGTLqQd2Wi5BAU3U439RDbzHBJuaPGVwJcoIEVD1Upgk9ov5PZpnrksovLorQU
         pqoA==
X-Gm-Message-State: AOAM533BqPnj6e/iMH+FfrCdgypnHJ+b/2ujvN2rW+dM0/hkqWM4eWwg
        0i2BMA+fIJ4MASGcnOLUfJUUYyzLiRyCuG3YhSS1LJT6KRAK62a9Zmo8/swzbpSJUfk79J9lDYw
        ShJaztRGvLRbHStJHC/eHn/BF
X-Received: by 2002:a9d:be9:: with SMTP id 96mr562141oth.211.1641835287691;
        Mon, 10 Jan 2022 09:21:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy019bkdJ2xfFGTi9iDs1JrhWEMoVF7t0UebvqVLd/zmC9dnJ9ZxOEHSsDWfxamc2lxl3cjcA==
X-Received: by 2002:a9d:be9:: with SMTP id 96mr562123oth.211.1641835287545;
        Mon, 10 Jan 2022 09:21:27 -0800 (PST)
Received: from optiplex-fbsd (c-73-182-255-193.hsd1.nh.comcast.net. [73.182.255.193])
        by smtp.gmail.com with ESMTPSA id w13sm1253817oic.24.2022.01.10.09.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:21:27 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:21:24 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nico Pache <npache@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <YdxrFJyddTbAkXz9@optiplex-fbsd>
References: <20211207224013.880775-1-npache@redhat.com>
 <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
 <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com>
 <YdxoXhTqCmVrT0R5@optiplex-fbsd>
 <Ydxp5wMhnwM2vVX6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydxp5wMhnwM2vVX6@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 06:16:23PM +0100, Michal Hocko wrote:
> On Mon 10-01-22 12:09:50, Rafael Aquini wrote:
> [...]
> > > 3. From David, fix in node_zonelist().
> > > https://lore.kernel.org/all/51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com/T/#u
> > 
> > It seems to me that (3) is the simplest and effective way to cope with this case
> 
> Did you have chance to look at http://lkml.kernel.org/r/20211214100732.26335-1-mhocko@kernel.org

I'll take a closer look at it. 

Thanks Michal.

-- Rafael

