Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FC854A0CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351708AbiFMVGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352217AbiFMVEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64B5C36306
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655152726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=miyd1T3+stkgi1mrJ4phi+uWQilLr1GqB1Dxvn0GUOs=;
        b=W1kdgea77zNwKf+TaNoVHt3TgM1XSPAi+0pwxot1AO07XaSMeB2bER4K/PHEu4dWPKIwVS
        R01sYEZXq3bPSlx/QHYFANqE4MJUvzhmz01MR8iqn1l1ay41VDIo3xtnTpD4VH8GBV95j1
        jMssrUcxrwOiVCvel05ho6K1qktC2OI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-Zfq_V0t7P1S-F7yxESNwyQ-1; Mon, 13 Jun 2022 16:38:45 -0400
X-MC-Unique: Zfq_V0t7P1S-F7yxESNwyQ-1
Received: by mail-pg1-f197.google.com with SMTP id a15-20020a65604f000000b00401a9baf7d5so3907422pgp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=miyd1T3+stkgi1mrJ4phi+uWQilLr1GqB1Dxvn0GUOs=;
        b=dSUqI+NJQQtYswzKEcqVPfHeIVT+pUBPNPsAaEu4H2AGMyXV7oFsm7s1SC3j59xBnJ
         /QyG3CKN/I15XSPw786b6ESr1xS/tGjcWHhyKyLtnwlVZeI8Y4VVGMwvE8wm7Ra4M1h/
         6qUwQmB3P/AQAeKht4oDkSKc5oleUPmHR8uEXCL1+HuzACXnkly2WXvayIIYfmhdc7ZM
         QzxfCx7xujZSX1ZWPJWF4fwMn7fpANaVN02Wm08brDnlLCv1YDLd7wxxmNPEXolM/w2Z
         kaLpatkWMt3TZVG7UJj5uZH20l4gjgn1MYpO3i/iQekUxY5XalEOrNrvYBkcwquLxcK5
         WxLA==
X-Gm-Message-State: AJIora/lLpYEzbqYLu6BLOz2HRy7b9DWX2NSZ63p2Cm/azqJaF+WQiRE
        0fiirsBMyTfuPSz5kmPoUS2ocXVlZhL7T8eLwlpHnvFudFwq/cYdBgdUx514lVaNN3krEg+BVke
        IRg1uSnPpqwio+3zmspwsD6jX
X-Received: by 2002:a17:902:7604:b0:168:cca6:1b38 with SMTP id k4-20020a170902760400b00168cca61b38mr1113743pll.174.1655152724278;
        Mon, 13 Jun 2022 13:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sXs1WFaIXkc6CwFKtbKlij7wvfOFwhTNHBGbcdQcBmY3+wFKnIyMn1hhRSLuPxBKdX7sAxag==
X-Received: by 2002:a17:902:7604:b0:168:cca6:1b38 with SMTP id k4-20020a170902760400b00168cca61b38mr1113720pll.174.1655152723983;
        Mon, 13 Jun 2022 13:38:43 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ja2-20020a170902efc200b0015e8d4eb2c0sm5526354plb.266.2022.06.13.13.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:38:43 -0700 (PDT)
Date:   Mon, 13 Jun 2022 13:38:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <20220613203842.zyncvndwfauef2yh@cantor>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512151309.330068-1-steve.wahl@hpe.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> To support up to 64 sockets with 10 DMAR units each (640), make the
> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> set.
> 
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot properly.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
> 
> Note that we could not find a reason for connecting
> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> it seemed like the two would continue to match on earlier processors.
> There doesn't appear to be kernel code that assumes that the value of
> one is related to the other.
> 
> v2: Make this value a config option, rather than a fixed constant.  The default
> values should match previous configuration except in the MAXSMP case.  Keeping the
> value at a power of two was requested by Kevin Tian.
> 
>  drivers/iommu/intel/Kconfig | 6 ++++++
>  include/linux/dmar.h        | 6 +-----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 

Baolu do you have this queued up for v5.20? Also do you have a public repo where
you keep the vt-d changes before sending Joerg the patches for a release?

Regards,
Jerry

