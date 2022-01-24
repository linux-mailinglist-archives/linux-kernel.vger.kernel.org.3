Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD33F497BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiAXJNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:13:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbiAXJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643015614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q/cJ3iWSzk/L9pl1h0bSd2z9dkOZnVgBJiwkxutziMY=;
        b=Cxb/oXBhlURefpfXJwh1xVY3J7t0QghjHgPGKqwtMbwSTqHDjMdqRDTgF3Xh0Dsr2kaDyw
        aks8YMYlzq0ITUuSypsCb5lONBUKmWe/YJ5xPia+rdWqAr9605GgiI9DOZL+xkjvLjZ/JT
        W3ubR3ZqKdD20P5RnsX+O1MeCYLOdC0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-QzfWNIUWMb-nqbsFMj47nA-1; Mon, 24 Jan 2022 04:13:32 -0500
X-MC-Unique: QzfWNIUWMb-nqbsFMj47nA-1
Received: by mail-pf1-f200.google.com with SMTP id u80-20020a627953000000b004c82105f20dso2002666pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/cJ3iWSzk/L9pl1h0bSd2z9dkOZnVgBJiwkxutziMY=;
        b=wR0rEConOI+q81mtQm4lzCSfsgusvQfSNyIaj/KiJXAKn307EJdxYHxqnVVFtbnf/w
         WgRY0U3L1PwbA8fQIQYokhHQ7SxaPIoY8HquReOgAoeW8zX0q5/thxNKVIPnOuRqEl4Z
         IgNiG7JqgmKVpFnB7xzGUdW61eFaKVLfbQoYv5lpzPBmhGGDMhgSirDoQYVQv4ndhbdJ
         GeOp4ZT2nsmtWMfOc05kPszlhvOAIwJm9jlyjHK4oOQgQNEp69d5jMBKiYhPiPegeFzu
         o8DCwdYIhcFVpZLs3u/2cPMBem72eRR6YUf9hy4H8AktamdVCBtktebQWM5qPBoLrOGi
         53zw==
X-Gm-Message-State: AOAM532zO25Vv6Hq1k07lJ7v/wfVRm5/9HixINTJtoKTgRjrc6LAXt+1
        ySgAx/kU324KLOli2C6jrqILAhV8Hvqj5APDZOVSFdHUXuWfRgIlQREPcy+FiToS0bhH+FxdoFM
        OnjnnLgoeMO1hLnRY0DU7egrY
X-Received: by 2002:a17:90b:2406:: with SMTP id nr6mr966725pjb.99.1643015611587;
        Mon, 24 Jan 2022 01:13:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWqTwByq4KaLiWEW35f6vhZ1leVAu4fEBkDJOyuZh7qPP+hPn4AmTAz6+a6+60W4DPgrTBcA==
X-Received: by 2002:a17:90b:2406:: with SMTP id nr6mr966711pjb.99.1643015611367;
        Mon, 24 Jan 2022 01:13:31 -0800 (PST)
Received: from xz-m1.local ([94.177.118.73])
        by smtp.gmail.com with ESMTPSA id s13sm4719075pfk.174.2022.01.24.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 01:13:30 -0800 (PST)
Date:   Mon, 24 Jan 2022 17:13:23 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <Ye5ts7VtDnja2VUZ@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
 <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com>
 <Yd7VEXI+/Lu8MVOo@xz-m1.local>
 <Yd7W6ndSPkXQjurY@xz-m1.local>
 <391aa58d-ce84-9d4-d68d-d98a9c533255@google.com>
 <Yek6PaW8fAXY4Bft@xz-m1.local>
 <YeokbrpCdAGAYHEl@xz-m1.local>
 <YepAgBz4EUXc/jrM@xz-m1.local>
 <56e33192-965d-691a-afc-f77f5856afd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56e33192-965d-691a-afc-f77f5856afd@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:51:57PM -0800, Hugh Dickins wrote:
> I don't know of any problem that needs fixing with the zero page:
> how do you suppose the zero page gets into a truncatable or hole-punchable
> mapping?  We use it for read faults in anonymous mappings.  And I told the
> story of how once-upon-a-time it could get inserted into any mapping by
> reading from /dev/zero, but that odd case was dropped years ago.  And I
> am open to (even encouraging) a change to make use of zero page for read
> faults of holes in shmem: but that's potential future work, which would
> require some changes elsewhere (though perhaps none here: the zero page
> could never be used for the result of a COW).
> 
> Please explain the zero page problem you hope to fix here.

After I tried to learn the old/new worlds of zero page somehow I thought there
can be zero pfns installed, but it seems not at all..

Please ignore above, sorry for the noise.

-- 
Peter Xu

