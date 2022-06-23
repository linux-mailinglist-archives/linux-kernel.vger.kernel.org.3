Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2FA558AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFWV3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFWV3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A4775251F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656019758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6PfW9sxpQj/mvhni+b0KRiNmHNGj39/jQBs8n3G3n/E=;
        b=i2rZEXo49QwUmz7rTW1PNtwpd4ROnXA+jCSsz1p39sdzBjX/XxsNkdCcXUy0Y/FX65Qssh
        gAcDQMllb+ZUoZ+lc83TeQfuMn5G2+KZPvVbfOOHSuV9QRvM53VJk00Uk6XtNebUvj4exW
        YVuLVuY2r/rbvJOLeDK8qr+Tlf8+vS4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-vc2GWJ_YOGWIurpiz4FtMw-1; Thu, 23 Jun 2022 17:29:17 -0400
X-MC-Unique: vc2GWJ_YOGWIurpiz4FtMw-1
Received: by mail-il1-f198.google.com with SMTP id x5-20020a923005000000b002d1a91c4d13so185803ile.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6PfW9sxpQj/mvhni+b0KRiNmHNGj39/jQBs8n3G3n/E=;
        b=YHhMAQehGlX6EiX6BtZ0nRr95lmFAhGQozdm/kBrhy06yZyITcmvpoB4aL88Tjw/wN
         Y9O3vc1Wxo16tLCUC7W0qohn95FkAGEAcxStK65zrtVaL1E2DxzyHNyqamPBU3v4tSzA
         9yDuJ7MlCHe/WNAh15CU37zoK3QCV/kc4IWOgF1KU2mL5ap0yxe+0K7fUmM8PCnnKAhW
         Q4TokkKZEezUcDR94fchhYGbxzZ2RcSyHrPRJi8DtOxCfnwqD5XgEoZrRS1R06jY7E91
         JHBaUvEMlp3Uw7db44RKZ9u3w8VWdQRaYOjeh8plKkodWTALNJiAhEJssLMflhii8g3D
         e6rA==
X-Gm-Message-State: AJIora/jqnWrUUXnpdWB+f+HwAXsaZVbFrKPJXOmL73Vf07dLcfhOa5E
        aWe5xZXIOpeDndi0tMBhn0svanf2teJ7Bh7Yx1taA5y3p5wPH+Yba2hqNGVNeKtl+bGKTYup4qL
        DZxhdqNKbju48xqj8TqcTLl5W
X-Received: by 2002:a05:6602:13c3:b0:672:6e5b:f91d with SMTP id o3-20020a05660213c300b006726e5bf91dmr5280345iov.68.1656019755998;
        Thu, 23 Jun 2022 14:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtJvEhlzlRfOF8b92vaohNpblje8osM0+m8TcPa0obERTPPu0deqheKeigL7E2U8Aqg0jxfg==
X-Received: by 2002:a05:6602:13c3:b0:672:6e5b:f91d with SMTP id o3-20020a05660213c300b006726e5bf91dmr5280339iov.68.1656019755753;
        Thu, 23 Jun 2022 14:29:15 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id h7-20020a0566380f0700b00339cfcf4a49sm202645jas.141.2022.06.23.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:29:15 -0700 (PDT)
Date:   Thu, 23 Jun 2022 17:29:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] kvm: Merge "atomic" and "write" in
 __gfn_to_pfn_memslot()
Message-ID: <YrTbKaRe497n8M0o@xz-m1.local>
References: <20220622213656.81546-1-peterx@redhat.com>
 <20220622213656.81546-3-peterx@redhat.com>
 <YrR9i3yHzh5ftOxB@google.com>
 <YrTDBwoddwoY1uSV@xz-m1.local>
 <YrTNGVpT8Cw2yrnr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrTNGVpT8Cw2yrnr@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 08:29:13PM +0000, Sean Christopherson wrote:
> This is what I came up with for splitting @async into a pure input (no_wait) and
> a return value (KVM_PFN_ERR_NEEDS_IO).

The attached patch looks good to me.  It's just that..

[...]

>  kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
> -			       bool atomic, bool *async, bool write_fault,
> +			       bool atomic, bool no_wait, bool write_fault,
>  			       bool *writable, hva_t *hva)

.. with this patch on top we'll have 3 booleans already.  With the new one
to add separated as suggested then it'll hit 4.

Let's say one day we'll have that struct, but.. are you sure you think
keeping four booleans around is nicer than having a flag, no matter whether
we'd like to have a struct or not?

  kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
			       bool atomic, bool no_wait, bool write_fault,
                               bool interruptible, bool *writable, hva_t *hva);

What if the booleans goes to 5, 6, or more?

/me starts to wonder what'll be the magic number that we'll start to think
a bitmask flag will be more lovely here. :)

-- 
Peter Xu

