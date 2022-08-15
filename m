Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF055594B73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 02:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344722AbiHPASM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 20:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346084AbiHPAKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 20:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CB521741BD
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660595364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yF2p92c7UW45kbBlW38nCYzaIJh2lntG/FxhvA8qLXQ=;
        b=gcIJuVRHhy3Z2I7GZw8Hg0B2LuC1ycK7lNWusdZ4/GX+AIp6KTq41j9bTXUWcJmFEvbBH8
        zRgATha6SzWjdLf5CLGTF+C4JoIMYFHGdeBXh3ZPyoORGjL56x4WZoRgE6KYnWAItrCxDC
        qxaPm5IGP4cIUjIVGg+vVjr5h06L5M4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-127-nTXxZU6OOLSq_fbKk5Oosw-1; Mon, 15 Aug 2022 16:29:22 -0400
X-MC-Unique: nTXxZU6OOLSq_fbKk5Oosw-1
Received: by mail-qv1-f71.google.com with SMTP id dn2-20020a056214094200b0047491ead6a2so3126650qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yF2p92c7UW45kbBlW38nCYzaIJh2lntG/FxhvA8qLXQ=;
        b=lYgO2lrmhEmqNyAb5P4HBa8x/wD0HRLESXlC1ecSYfwmycou8+o8JrZUZ3z7kCzuPW
         cep8/ziaJjA/TONIj/qDvpRPLob7arZjBJdIEFK2E5G56e+HEpcRNzKT864eFt4lUJcq
         FDE7p3l1sSqb+mN73hLyukwgqEKPLSjrMc4Vt+YhiiK6uUnzQtKYhr8Y8Jzt2K8bOOwn
         1XYiZe8HY46MRHzKhFcd29h1jyDyjZ2KkHpbID6P6anDEnKNyqVd/Wf9VguKLyEzrslE
         tiMVOYQfYYTm5p/UPUgqPjanzbj6NE1CZjXFspE5ymzW36iCfQNw8VVANojcjzhisxxX
         /YEA==
X-Gm-Message-State: ACgBeo1XBa7Ip9D6qxCBBmm9xWPNVVJt4Kp3Kiw2TJE1pRA/rPqWRjDO
        NMXmrNkESfsjJWhMdtpSRhEzM1iYuodBRzQKTh0M3+aHBdS0kSSlRst1L7lueZTutRjGVZQC8XX
        3cGQ29LljTpScMk29CT4vn5+D
X-Received: by 2002:a05:6214:4012:b0:476:f313:7fb with SMTP id kd18-20020a056214401200b00476f31307fbmr15152143qvb.130.1660595362282;
        Mon, 15 Aug 2022 13:29:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7M2YNoyb3WxJwIyqbQOJCTtBR3o9E5qdm+nbEnRX6MOjsfXhK1hCLQcLdCsYq6SkZJarEQSQ==
X-Received: by 2002:a05:6214:4012:b0:476:f313:7fb with SMTP id kd18-20020a056214401200b00476f31307fbmr15152125qvb.130.1660595362089;
        Mon, 15 Aug 2022 13:29:22 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id o8-20020ac87c48000000b00343028a9425sm9464004qtv.16.2022.08.15.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 13:29:21 -0700 (PDT)
Date:   Mon, 15 Aug 2022 16:29:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linuxram@us.ibm.com,
        paulus@ozlabs.org
Subject: Re: [PATCH 1/2] mm/migrate_device.c: Copy pte dirty bit to page
Message-ID: <YvqsoL7fKJzEqTA3@xz-m1.local>
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alistair,

On Fri, Aug 12, 2022 at 03:22:30PM +1000, Alistair Popple wrote:
> migrate_vma_setup() has a fast path in migrate_vma_collect_pmd() that
> installs migration entries directly if it can lock the migrating page.
> When removing a dirty pte the dirty bit is supposed to be carried over
> to the underlying page to prevent it being lost.
> 
> Currently migrate_vma_*() can only be used for private anonymous
> mappings. That means loss of the dirty bit usually doesn't result in
> data loss because these pages are typically not file-backed. However
> pages may be backed by swap storage which can result in data loss if an
> attempt is made to migrate a dirty page that doesn't yet have the
> PageDirty flag set.
> 
> In this case migration will fail due to unexpected references but the
> dirty pte bit will be lost. If the page is subsequently reclaimed data
> won't be written back to swap storage as it is considered uptodate,
> resulting in data loss if the page is subsequently accessed.
> 
> Prevent this by copying the dirty bit to the page when removing the pte
> to match what try_to_migrate_one() does.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reported-by: Peter Xu <peterx@redhat.com>

This line should be:

Reported-by: Huang Ying <ying.huang@intel.com>

Please also feel free to add:

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

