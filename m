Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9F58CF0A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244227AbiHHUVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbiHHUVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48978DFAB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659990104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2SyjU4nlrlicLQvmsmQrDI50xPp70ZBk8GnqHoj+j0=;
        b=f+aGXjZ40riLXjGISla6J4l7khNu/0/zOG75f7xbrxb8gS3QjZHotah9opK91vEXrPyYbE
        8t+0pGOopL2WGCrRxw/T5u++pxP2n6EQDA87PAhpGTiBL7EtHUTrtmoK3m35o3IRJDsJTP
        h7u29bY+N8fz2pFFfORKWUEBYqnXuME=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-5a5NE4dlOxmQrTvax__Q7A-1; Mon, 08 Aug 2022 16:21:43 -0400
X-MC-Unique: 5a5NE4dlOxmQrTvax__Q7A-1
Received: by mail-il1-f200.google.com with SMTP id h25-20020a056e021d9900b002e069b96119so4833106ila.14
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=W2SyjU4nlrlicLQvmsmQrDI50xPp70ZBk8GnqHoj+j0=;
        b=UF8utFIYT6UoBVx0rrC+1G52/klDzOcuy3ZCQyNPgI1ohSMOPdxW803f3pHXCrIVPl
         sarKHZdybXWPhA9Qnvu9z2XPN9nQf4igHonooBh0eixj44tm9nv26aBuBsd8hpXJGwy4
         T8s+ZALtVskkMuKqMug4cGhG+fsrp1+nCM+kCmA4g74Ouq5xa4daEgdf6iaZHLr8u1EM
         w29W9LMGnXcTKyovHsTYtrBAI0WNc3jBfrrQGS+ln5SoiSId8uzHRoSlt4pgoD71q78D
         HGAT7qmzzoWjUgTnBiG9ClDE56DHN8EuZt1knx7uow0/JT/dDFV145o5UFxc/vDpMVuk
         S3jw==
X-Gm-Message-State: ACgBeo26eTBfFSe2WvakcFRpYhcvgeJMXLPhlZ4f/FvkbTTVkIN+oGZN
        I5D1JHI6HRpMxEakc64iepfCQnqYS0UudeJUanN0jEDsN5hERFep3uCDFx3X+w20oafW1AAEaC9
        zDSTUfVJItywjrrobSq3TmWuE
X-Received: by 2002:a92:6a12:0:b0:2e0:e25c:e0ea with SMTP id f18-20020a926a12000000b002e0e25ce0eamr3995267ilc.116.1659990102669;
        Mon, 08 Aug 2022 13:21:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5gj5a06A0E3N4wf7ujPUZGjSh7N4Ok4Scx3ueVjFKxPQHpyF6e8zLpFWLnL9ZHZTOdnnUbGQ==
X-Received: by 2002:a92:6a12:0:b0:2e0:e25c:e0ea with SMTP id f18-20020a926a12000000b002e0e25ce0eamr3995262ilc.116.1659990102486;
        Mon, 08 Aug 2022 13:21:42 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id m9-20020a02a149000000b003427967df49sm5583702jah.19.2022.08.08.13.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 13:21:41 -0700 (PDT)
Date:   Mon, 8 Aug 2022 16:21:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
Message-ID: <YvFwU4e3WOSRseh6@xz-m1.local>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-3-david@redhat.com>
 <Yu1dkZeBwv0SUQMq@xz-m1.local>
 <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
 <YvE0OwsyQEL3K5Hm@xz-m1.local>
 <8b317ac7-f80e-4aab-4ad1-4e19a1a0740f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b317ac7-f80e-4aab-4ad1-4e19a1a0740f@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 06:25:21PM +0200, David Hildenbrand wrote:
> >> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
> >> unfortunately wrong.
> >>
> >> If you're curious, take a look at f83a275dbc5c ("mm: account for
> >> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
> >> and mmap() code.
> >>
> >> Long story short: if the file is read-only, we only have VM_MAYSHARE but
> >> not VM_SHARED (and consequently also not VM_MAYWRITE).
> > 
> > To ask in another way: if file is RO but mapped RW (mmap() will have
> > VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
> > won't we grant write bit errornously while we shouldn't? As the user
> > doesn't really have write permission to the file.
> 
> Thus the VM_WRITE check. :)
> 
> I wonder if we should just do it cleanly and introduce the maybe_mkwrite
> semantics here as well. Then there is no need for additional VM_WRITE
> checks and hugetlb will work just like !hugetlb.

Hmm yeah I think the VM_MAYSHARE check is correct, since we'll need to fail
the cases where MAYSHARE && !SHARE - we used to silently let it pass.

But then OTOH using WARN_ON_ONCE on the VM_WRITE check is probably not
right, because iiuc it can be triggered easily by the userspace. E.g. as
simple as mapping hugetlb as RO+shared then write to it?

So maybe_mkwrite() seems not an option now - IIUC we really need that
!VM_WRITE check to fail properly, but just without the warning to pollute
dmesg?

Thanks,

-- 
Peter Xu

