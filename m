Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B53F463D68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245288AbhK3SMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:12:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244480AbhK3SMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638295767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dCW7AjvcsfnQ6JeVlt/Lp1KjBKaBEwl0X0gDNVXxzs=;
        b=cYDfDa/kRqJRn50vNwhY3UMSRS1hZTGB+Xii6xncv+QyqNLbGDgOdpt2iwY45/NsR+8YNz
        FnYrX6yWqDWrcIvwXXlQswBxE6rrbF+Jq/6cLPyvTY3m/TEFMaj7V1WW41RPuEaYqVP0BO
        911DZizjNkPpHGAXtz3u3F33lhzLp2g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-69-PG9-8fBbOaO_DnMTXxcoGA-1; Tue, 30 Nov 2021 13:09:25 -0500
X-MC-Unique: PG9-8fBbOaO_DnMTXxcoGA-1
Received: by mail-wm1-f72.google.com with SMTP id i131-20020a1c3b89000000b00337f92384e0so14200931wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/dCW7AjvcsfnQ6JeVlt/Lp1KjBKaBEwl0X0gDNVXxzs=;
        b=TXGzJbmI7a8yRvb9oCwXBXYU5nzsahEkZbonOZOUazg7hCyjmE5OgieoHl/T0yGoiq
         smmvNZto54fXS3PXAbndP4KQd/aqtExNm+apLcxoCuNmKFckkuPyWeY4EtqRYRgaScrd
         GJQtG9/iy2T1Vckbb/PKy0MDsFASD5juyxEP1qR7zqoFNwQHiqlybRMIIVXyf7eKmq2k
         7Q9a7lZ3VAYQku1DxLFfSwD71UJ1NUmWz5lzzc7SByRHLtonpPkRjI6DedwpK+f+tSSx
         dh4C0qLndy83Wt4/ChQqY/KQfY8Vz7IQohjqRA7R4Hh/sP4k1DO8REPC8WH0DEB0kKWp
         gl2Q==
X-Gm-Message-State: AOAM530wqWivcuRzU7eWQSyL0R+hm3aNmoYtnocQOsJaX4CT26xBIx5d
        UVPRaEg0eOAYWHVf+Kkf05nCf6Vz6YK5s6wKsPUf6eqxkCwZIJu+3ClYwIfHSiv6SRTcbO8lblZ
        +DLodHCkMIshcnwfGTLHdNsY3
X-Received: by 2002:adf:a190:: with SMTP id u16mr541677wru.483.1638295764495;
        Tue, 30 Nov 2021 10:09:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyk/oWb3w92b8sLB1B0V/nf4I6+6tqcRtn+THDoTOs5Hd0j+FZWS7V/drDTU5g4AY19i8KuWg==
X-Received: by 2002:adf:a190:: with SMTP id u16mr541639wru.483.1638295764253;
        Tue, 30 Nov 2021 10:09:24 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id h7sm16358802wrt.64.2021.11.30.10.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:09:24 -0800 (PST)
Message-ID: <43462fe11258395f4e885c3d594a3ed1b604b858.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] mm/page_alloc: Remote per-cpu page list drain
 support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, cl@linux.com, ppandit@redhat.com
Date:   Tue, 30 Nov 2021 19:09:23 +0100
In-Reply-To: <7549db15-5149-160f-86e3-55136fe482ce@suse.cz>
References: <20211103170512.2745765-1-nsaenzju@redhat.com>
         <7549db15-5149-160f-86e3-55136fe482ce@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil, sorry for the late reply and thanks for your feedback. :)

On Tue, 2021-11-23 at 15:58 +0100, Vlastimil Babka wrote:
> > [1] Other approaches can be found here:
> > 
> >   - Static branch conditional on nohz_full, no performance loss, the extra
> >     config option makes is painful to maintain (v1):
> >     https://lore.kernel.org/linux-mm/20210921161323.607817-5-nsaenzju@redhat.com/
> > 
> >   - RCU based approach, complex, yet a bit less taxing performance wise
> >     (RFC):
> >     https://lore.kernel.org/linux-mm/20211008161922.942459-4-nsaenzju@redhat.com/
> 
> Hm I wonder if there might still be another alternative possible. IIRC I did
> propose at some point a local drain on the NOHZ cpu before returning to
> userspace, and then avoiding that cpu in remote drains, but tglx didn't like
> the idea of making entering the NOHZ full mode more expensive [1].
> 
> But what if we instead set pcp->high = 0 for these cpus so they would avoid
> populating the pcplists in the first place? Then there wouldn't have to be a
> drain at all. On the other hand page allocator operations would not benefit
> from zone lock batching on those cpus. But perhaps that would be acceptable
> tradeoff, as a nohz cpu is expected to run in userspace most of the time,
> and page allocator operations are rare except maybe some initial page
> faults? (I assume those kind of workloads pre-populate and/or mlock their
> address space anyway).

I've looked a bit into this and it seems straightforward. Our workloads
pre-populate everything, and a slight statup performance hit is not that tragic
(I'll measure it nonetheless). The per-cpu nohz_full state at some point will
be dynamic, but the feature seems simple to disable/enable. I'll have to teach
__drain_all_pages(zone, force_all_cpus=true) to bypass this special case
but that's all. I might have a go at this.

Thanks!

-- 
Nicolás Sáenz

