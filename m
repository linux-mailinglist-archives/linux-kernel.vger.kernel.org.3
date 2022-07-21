Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC39257D3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiGUTJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiGUTJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF21B8C146
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658430564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ewgLO5BLUTwFzlaPTOrZbCbEaC1XqhfSuyvQTiqA3w8=;
        b=GIDRQZeEt9ZnMLZ0wXpstJ8sIHN6AE3klnLobKsMK0k0MvVzu2jDUwA7UvqB5P5VtDIsZX
        r5Pd3dEzuppOteqzV7LS+JhH4Xq3NgsqyKRPpdDgtZnFAQ5MAYrEAzDOgtADqcVCCs6GDl
        X8LQNud3ENbVvYMiNoSF01b1Nn5YBTM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-g8oLJ8_YPO6zj798DAWaVg-1; Thu, 21 Jul 2022 15:09:22 -0400
X-MC-Unique: g8oLJ8_YPO6zj798DAWaVg-1
Received: by mail-qv1-f71.google.com with SMTP id ld29-20020a056214419d00b004740c1dda13so1608093qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ewgLO5BLUTwFzlaPTOrZbCbEaC1XqhfSuyvQTiqA3w8=;
        b=xlRtqe3Ve2yN15Bc+XLKBukdzBr3oIt9yq6UUHKN+oxMqnZavKXw360MzGUIb/QCNI
         1i0NIMzPC7YSG6Gp6gYWGEVGEvrkRs4zRoMA5bgONvkEdaE4AH1mKmCC6AwkavcNCAqY
         1NWn4HCGGQwJCqK7cOzb3TJm8WWopsMsHnU4flJaENsl0GJJet6dej09gIdx9n/7otev
         rOtRr+GNs/PRPIeAChkW8LVkDp7AeH0CzcKRGjakHMQ08vhXcw0KDFKuM1PXsG2ezxIh
         n6DElNABdD9Y4Wm/nHcETsPJDYcI//Rg6U/U2uUL8W447ai2pmuErFRViAW7xDduSW2c
         PZQA==
X-Gm-Message-State: AJIora+cL5dYCfGJnadDIT+M7oQR/4oSIusQ72HVfe4uS1k9Kg+460OF
        pG72AINt/GSxvmtdCIBiAHyRxNGhk+0uX3hibU++xm5+QDoeN74i7UPew3z+pXv5QbQJPwKSBsx
        XoV+DoygnIWu+1P+XzCoWiBgK
X-Received: by 2002:ad4:5cca:0:b0:473:ffee:5025 with SMTP id iu10-20020ad45cca000000b00473ffee5025mr10968256qvb.109.1658430562027;
        Thu, 21 Jul 2022 12:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssC0zkU+AxnBoLQGT4WR/iZrLQwrRslzdmya+Z0mlVUu2iFBNLakGbhaHUZlNNYgTEA+A64w==
X-Received: by 2002:ad4:5cca:0:b0:473:ffee:5025 with SMTP id iu10-20020ad45cca000000b00473ffee5025mr10968215qvb.109.1658430561546;
        Thu, 21 Jul 2022 12:09:21 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id z11-20020ae9c10b000000b006a3325fd985sm1787584qki.13.2022.07.21.12.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:09:20 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:09:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 20/26] hugetlb: add support for high-granularity
 UFFDIO_CONTINUE
Message-ID: <YtmkX73/wzptkZbu@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-21-jthoughton@google.com>
 <YtGUARcBHxLU0axU@xz-m1.local>
 <CADrL8HXYab_VJS=Y0h2OSiCrj2pYbDJME2P=Tsn9jcDRbcqR1g@mail.gmail.com>
 <YtGh46Jr0EGpqW7s@xz-m1.local>
 <CADrL8HX1YbDArmPsGUH+7b6dNxDa3Xo+fd5npGgz=RFehSw6iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HX1YbDArmPsGUH+7b6dNxDa3Xo+fd5npGgz=RFehSw6iA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 01:58:06PM -0700, James Houghton wrote:
> > > > > @@ -335,12 +337,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> > > > >       copied = 0;
> > > > >       page = NULL;
> > > > >       vma_hpagesize = vma_kernel_pagesize(dst_vma);
> > > > > +     if (use_hgm)
> > > > > +             vma_altpagesize = PAGE_SIZE;
> > > >
> > > > Do we need to check the "len" to know whether we should use sub-page
> > > > mapping or original hpage size?  E.g. any old UFFDIO_CONTINUE code will
> > > > still want the old behavior I think.
> > >
> > > I think that's a fair point; however, if we enable HGM and the address
> > > and len happen to be hstate-aligned
> >
> > The address can, but len (note! not "end" here) cannot?
> 
> They both (dst_start and len) need to be hpage-aligned, otherwise we
> won't be able to install hstate-sized PTEs. Like if we're installing
> 4K at the beginning of a 1G hpage, we can't install a PUD, because we
> only want to install that 4K.

I'm still confused...

Shouldn't one of the major goals of sub-page mapping is to grant user the
capability to do UFFDIO_CONTINUE with len<hpagesize (so we install pages in
sub-page level)?  If so, why len needs to be always hpagesize aligned?

-- 
Peter Xu

