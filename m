Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96B501FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348023AbiDOAc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348042AbiDOAch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACAC1AC925
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649982608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VSz+7o9rzVeLYCMoLF6o14+CdRpAu25XhazHWiW1Ekw=;
        b=GsB1M3BDkZl3pbS0mw1L8//GkKIhs3LPGRuWETRNcmNjcJnaXrnuD9os25Olkqu71+kK2b
        5hiRDFuBFsyo+4M/RVb5AA/WM0P0RcOJVhTpUK0kESugsOZosBlaMiTG+3UDkdG5/xJK/G
        egu1tIt73IjNr8bI9JVfIzGvt+fe5TI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-M0xSELKrP7GMio9oyoBL7w-1; Thu, 14 Apr 2022 20:30:07 -0400
X-MC-Unique: M0xSELKrP7GMio9oyoBL7w-1
Received: by mail-io1-f72.google.com with SMTP id g11-20020a056602072b00b00645cc0735d7so3982103iox.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSz+7o9rzVeLYCMoLF6o14+CdRpAu25XhazHWiW1Ekw=;
        b=m+CUEEqNvFY5GHtyKlHRCKORpMr0Z15g9BYm8oD/RVrsM63FGHNRnY+/UnjwhD6cwt
         Aih6xaISTwyDv4HwFLtUxps0mPApWx8Lk+piNCUEK/mrsFkPj7/h6vbp9nDeSBgvBMHa
         xEO4Ef4pq5sTg2sb28iOXXkDU/e9Dfq35CQ7t10H3o+pFGAqTSYLIshar2wYMwJzH3h6
         CRtPeoArlb5O8JrPcwWtpbK7i915LM62PRqGjuoAfga6pr5/lAoSIbF9+7zmsR0MsHaC
         gWLPLFtPnEiketPDcBzwP+hN2vbQD7fPbYPEidJEVP8mWm6wnSdH414z/Sgsaq4UJ8y/
         k87A==
X-Gm-Message-State: AOAM532qvgpja542LeXZ/hF5qx11NVbEsnJocekkkhDPTZIhkBXfkcaA
        /+/VWMMMzc7qGJg6h/Np75jMzdhE8UiRNFEt4oUt8i/AsaqGRFmLD6QAQzPp8RhddG8kmgF/CeJ
        w1f+LG8CZ/SxlIktOrGenHr6Q
X-Received: by 2002:a05:6638:1356:b0:323:aa22:8cc9 with SMTP id u22-20020a056638135600b00323aa228cc9mr2421523jad.72.1649982606831;
        Thu, 14 Apr 2022 17:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNmZUtU6A/iPiMIQDhMr2fY/CjMD+funMZD15Mw8RhUBPYn1edOjFRd96NsCdDm7QzuLA0Rg==
X-Received: by 2002:a05:6638:1356:b0:323:aa22:8cc9 with SMTP id u22-20020a056638135600b00323aa228cc9mr2421510jad.72.1649982606634;
        Thu, 14 Apr 2022 17:30:06 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id c22-20020a5ea816000000b00649d360663asm1994437ioa.40.2022.04.14.17.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 17:30:06 -0700 (PDT)
Date:   Thu, 14 Apr 2022 20:30:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH] kvm: selftests: Fix cut-off of addr_gva2gpa lookup
Message-ID: <Yli8jJWmOt9Qqjbi@xz-m1.local>
References: <20220414010703.72683-1-peterx@redhat.com>
 <Ylgn/Jw+FMIFqqc0@google.com>
 <bf15209d-2c50-9957-af24-c4f428f213b1@redhat.com>
 <YliTdb1LjfJoIcFc@xz-m1.local>
 <CALMp9eRjNd5_VFOsAoANkoaCTkKSHp3awrABZ5LR20+VoXZuAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALMp9eRjNd5_VFOsAoANkoaCTkKSHp3awrABZ5LR20+VoXZuAA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:01:04PM -0700, Jim Mattson wrote:
> On Thu, Apr 14, 2022 at 2:36 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Apr 14, 2022 at 04:14:22PM +0200, Paolo Bonzini wrote:
> > > On 4/14/22 15:56, Sean Christopherson wrote:
> > > > > - return (pte[index[0]].pfn * vm->page_size) + (gva & 0xfffu);
> > > > > + return ((vm_paddr_t)pte[index[0]].pfn * vm->page_size) + (gva & 0xfffu);
> > > > This is but one of many paths that can get burned by pfn being 40 bits.  The
> > > > most backport friendly fix is probably to add a pfn=>gpa helper and use that to
> > > > place the myriad "pfn * vm->page_size" instances.
> > > >
> > > > For a true long term solution, my vote is to do away with the bit field struct
> > > > and use #define'd masks and whatnot.
> > >
> > > Yes, bitfields larger than 32 bits are a mess.
> >
> > It's very interesting to know this..
> 
> I don't think the undefined behavior is restricted to extended
> bit-fields. Even for regular bit-fields, the C99 spec says, "A
> bit-field shall have a type that is a qualified or unqualified version
> of _Bool, signed
> int, unsigned int, or some other implementation-defined type." One
> might assume that even the permissive final clause refers to
> fundamental language types, but I suppose "n-bit integer" meets the
> strict definition of a "type,"
> for arbitrary values of n.

Fair enough.

I just noticed it actually make sense to have such a behavior, because in
the case of A*B where A is the bitfield (<32 bits) and when B is an int
(=32bits, page_size in the test case or a default constant value which will
also be treated as int/uint).

Then it's simply extending the smaller field into the same size as the
bigger one, as 40bits*32bits goes into a 40bits output which needs some
proper masking if calculated with RAX, while a e.g. 20bits*32bits goes into
32bits, in which case no further masking needed.

Thanks,

-- 
Peter Xu

