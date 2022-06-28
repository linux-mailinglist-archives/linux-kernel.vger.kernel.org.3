Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B2F55F1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiF1XCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiF1XCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F34703AA58
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656457357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BILLrOx0KBGDparaBoWGr82nDo23bdigh/cJQEB6on8=;
        b=Qz37mzWj40qCqjlnQ0yjevPZNubWrZEZc+U0xKZW3dGMLCB1mwKk2CcH2ytof2+UNsVyCM
        4d1XbnlIjWCzKqlTF1HUHQL7Cw5Y3+bl1aHGN2OJzdmBkiRoIIUi9opVR2Y6D/P5lyZIqM
        G4MCIFuBBxVtTFXDOIfsfwun6JPIVE0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-ExNF0mozPKy0vSHc60BX7A-1; Tue, 28 Jun 2022 19:02:35 -0400
X-MC-Unique: ExNF0mozPKy0vSHc60BX7A-1
Received: by mail-il1-f199.google.com with SMTP id n14-20020a056e021bae00b002d92c91da8aso8137004ili.15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BILLrOx0KBGDparaBoWGr82nDo23bdigh/cJQEB6on8=;
        b=FdhAJ1GVYgCnocxMOhJxoMjJ5Sa4s7DjCR76AYdVnPv4sUr32q9I6cMI/Ef6k61dqy
         tzkNgBDHY1tQchgDEytdlUEXR7hrxZ1VVv0WqcT/sBLhHF8sWgJr+E5hWlsIyfATgfLD
         tE2mHtCLxOTyvwlhgeVhzPZvd8bNQtNhcVRA5KQaHegA8KIz+k6sEtNG2oE5/E+PXrtF
         K++nMIGMZpMOFpNXa/EtKudsCPX29OWcAHqpyJGhWdCn6ypLDp/tA4t4htPiXFKbUWrN
         EObQgNT4ifZipmcE++Ddhv6JEg9/V5jBEo/VEwvcHiL9UhwAObOub29tVpjED6e7XIIB
         LKJw==
X-Gm-Message-State: AJIora8d304b3XNElv+itGeu6XhiC9Ui+7+Tsq5NGdvGtn8PYrczV45O
        1xdG8Fgz2O9Wr2lbbFqyH1vQtu3OSoWo09L85NJ6u0YxQFkR5WtYTfAa9ocvCh0pd6j5NVKOocW
        X3qF2TWro/V/lkdfTFcfRcwiO
X-Received: by 2002:a05:6638:1446:b0:331:e0cc:bd15 with SMTP id l6-20020a056638144600b00331e0ccbd15mr289904jad.89.1656457354974;
        Tue, 28 Jun 2022 16:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sktsRJzoU53vy6uKrBPRFlirO/gd0xp0mF0YJcR9N5sGdjb8aEiG+AA9O8limDyR6fBWNUhA==
X-Received: by 2002:a05:6638:1446:b0:331:e0cc:bd15 with SMTP id l6-20020a056638144600b00331e0ccbd15mr289894jad.89.1656457354776;
        Tue, 28 Jun 2022 16:02:34 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id x8-20020a6bd008000000b006755ae0679bsm1816220ioa.50.2022.06.28.16.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 16:02:34 -0700 (PDT)
Date:   Tue, 28 Jun 2022 19:02:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 2/4] kvm: Merge "atomic" and "write" in
 __gfn_to_pfn_memslot()
Message-ID: <YruIiNIII0pXcrYY@xz-m1.local>
References: <20220622213656.81546-1-peterx@redhat.com>
 <20220622213656.81546-3-peterx@redhat.com>
 <c047c213-252b-4a0b-9720-070307962d23@nvidia.com>
 <Yrtar+i2X0YjmD/F@xz-m1.local>
 <02831f10-3077-8836-34d0-bb853516099f@nvidia.com>
 <YruFm8vJMPxVUJTO@xz-m1.local>
 <c4f7d5cb-5b23-3384-722f-cc8c517cb123@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4f7d5cb-5b23-3384-722f-cc8c517cb123@nvidia.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 03:55:22PM -0700, John Hubbard wrote:
> On 6/28/22 15:50, Peter Xu wrote:
> > And if you see the patch I actually did something similar (in kvm_host.h):
> > 
> >   /* gfn_to_pfn (gtp) flags */
> >   ...
> > 
> > I'd still go for GTP, but let me know if you think any of the above is
> > better, I can switch.
> > 
> 
> Yeah, I'll leave that call up to you. I don't have anything better. :)

Thanks. I'll also give it a shot with Sean's suggestion on struct when
repost (I doubt whether I can bare with 4 bools after all..).  If that goes
well we don't worry this too since there'll be no flag introduced.

-- 
Peter Xu

