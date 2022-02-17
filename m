Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025524BA5B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbiBQQ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:27:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiBQQ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FA149AD9B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645115208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hCGdZ67U7n7QTxmEpkXTMre/CxFj1dLb8EpsB9Wt9NU=;
        b=GezvIP/FDCuCmOONL2/N+znUrvSlf3Dn1YzdVsR8UGtqHkUlHeHjrzXvZ4uMgpgTxfZdQB
        5Fdi+oNp1g9Pot3OTRH3VRqxQNJxihltcVv0Bw7qEyr0U+qAbCIbXMp9h+usElW1+8fgAH
        yT1qx1qbo0kM/mYTRrQVGvDci7EE68E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-PiK3aXcyMfyvswnMJNt5rQ-1; Thu, 17 Feb 2022 11:26:47 -0500
X-MC-Unique: PiK3aXcyMfyvswnMJNt5rQ-1
Received: by mail-lj1-f200.google.com with SMTP id q17-20020a2e7511000000b0023c95987502so47451ljc.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hCGdZ67U7n7QTxmEpkXTMre/CxFj1dLb8EpsB9Wt9NU=;
        b=AcDu8M/Jjb0i9MYtWGjDEsNJNek/i+Hx3kJbRDuD1R/Cqr+octT90ntrQDWHr5lxIz
         k5KxZ1Mf5a7v1YgRnTy6saqdiHOi3QnSyqqH9VFL93bTnMlG8Ge2D8Cv5XoWUPo0VijB
         7FxQYJzCjf35pFEq/ki98F0r3q8/XlFqhKTDvNpEs0L3Da+BXnyRJ9VGdF2N+sPmYiwb
         L5W9jHLd7MoG27g/PcnSEEKyoDjxrNMC/YfmxEkPq54gjZ544/bpPQlr69m7dqp0bF2I
         cbrrtT0USwfunjOu6UUel94rnMNMhI+MZyd+kb4VnA/nhdkC2y8mHHHulF1gmqA76Thz
         n/lg==
X-Gm-Message-State: AOAM533AiUi+hMPZrM0tFSClzVa1aIIpoiG7dm4P8azIXrsJP3WaoskG
        83F5Ej/I/2ejeMIbaVaImXVmtMMVz/dI80cPBvGnIQTZnBfXuZDUmA+E1uxb6HC2Z95TnjGr+Lv
        lL6OhsVuYn+mNtJa2vJQnbWQtdVyWwjKdRUFxrMw=
X-Received: by 2002:a05:6512:150d:b0:442:aad5:2550 with SMTP id bq13-20020a056512150d00b00442aad52550mr2567895lfb.678.1645115205790;
        Thu, 17 Feb 2022 08:26:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLZ9H9RgrFT61tMlkFrlaF/ED3Z9gDTXl+XfGnohcx4TPIGO+mRgxBZFxuaJb0yee8DvwIgmsS16CP6ZukixU=
X-Received: by 2002:a05:6512:150d:b0:442:aad5:2550 with SMTP id
 bq13-20020a056512150d00b00442aad52550mr2567879lfb.678.1645115205613; Thu, 17
 Feb 2022 08:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20220209171118.3269581-1-atomlin@redhat.com> <20220209171118.3269581-3-atomlin@redhat.com>
 <14a1678f-0c56-1237-c5c7-4ca1bac4b42a@csgroup.eu> <CANfR36gVY+1k7YJy0fn1z+mGv-LqEmZJSvSHXn_BFR4WC+oJrQ@mail.gmail.com>
 <alpine.LSU.2.21.2202171648590.29121@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2202171648590.29121@pobox.suse.cz>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Thu, 17 Feb 2022 16:26:33 +0000
Message-ID: <CANfR36hExnjBM1=529Ae6EvETx7XiPFDSmZCTOV2MLS_YEfoCQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] module: Move version support into a separate file
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-17 16:51 +0100, Miroslav Benes wrote:
> It is not, but "struct find_symbol_arg", which you moved, uses "enum
> mod_license" defined above, so you can either leave it as it is, or carve
> "enum mod_license" definition out.

Hi Miroslav,

I've done this already for v6. I hope to share the latest version for
review shortly.


Kind regards,

-- 
Aaron Tomlin

