Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED51B553D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356050AbiFUVOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355931AbiFUVN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:13:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4B433353
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:00:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 128so7185985pfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hFqBmB+kt0rtaIPaQ9KZ5LuoFwIj2x82PzqkrWEtyKU=;
        b=TNa3pSTndKVSyB2tGrJa9c+jY2RecssGJr47JZaCbPMcVuC5JrbHKKt4/sTBfy52GX
         ZoLBBfUJo0HpLu6z4QDbh3mMi+ILoX65eJSlThihVfGNx2lz7CcWiy6CJwW5sKxAk5V0
         kHbpvT1+WcXU6+Jgx5jvCPwMXIALyfuHX8Nc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hFqBmB+kt0rtaIPaQ9KZ5LuoFwIj2x82PzqkrWEtyKU=;
        b=akphiS87hLLFS9FAPjC6OzAAcDI51hhU6tZdymUEZDqMk96xXwqhtN4dNhEol7I8R1
         KDM9j+07uF4eUdsScylNHoZIVAHHR/msdmUW/HCrFxJh+EP2hMQOdTBVouv3rRdh1+rc
         AtBbdN1p03+3HqivfbyXnJBzTNSEhq8eitcKP+mUH77oxa5B18f0jI7f+7bfcOfmynn9
         XEMpyfYNVPLZkJZzTlHMPRICPUUaZT43pVJzbyoPcJGi3upxHgzgYcE2mcSboOdD/YmQ
         K3TMPI6IJi4ePnvpS2WhILeXodg6N9ysPoyvh9Pz+x0CCspbPrks6Qy0xl7hD+pBCc4h
         ZN0g==
X-Gm-Message-State: AJIora8bt1pganPeyk+yf4EtPR9iwyZM7CwFDNBaCDEW7eRWhNBd55J1
        2HAqZmlN2KWK7faOjzFpb+j9KQ==
X-Google-Smtp-Source: AGRyM1vS1WHRdTIT9IYRs+xx+wXkAMDh2br3ATVm9QvwiP+IUHXwkOKN9l90zBOq2MpUpC4k5ZJgrQ==
X-Received: by 2002:a63:1e0e:0:b0:3f6:4dce:918b with SMTP id e14-20020a631e0e000000b003f64dce918bmr28558117pge.53.1655845214448;
        Tue, 21 Jun 2022 14:00:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x139-20020a627c91000000b0050dc7628196sm6251408pfc.112.2022.06.21.14.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 14:00:14 -0700 (PDT)
Date:   Tue, 21 Jun 2022 14:00:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 4/9] efi: pstore: Omit efivars caching EFI varstore
 access layer
Message-ID: <202206211357.C66CD742E5@keescook>
References: <20220621153623.3786960-1-ardb@kernel.org>
 <20220621153623.3786960-5-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621153623.3786960-5-ardb@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 05:36:18PM +0200, Ard Biesheuvel wrote:
> Avoid the efivars layer and simply call the newly introduced EFI
> varstore helpers instead. This simplifies the code substantially, and
> also allows us to remove some hacks in the shared efivars layer that
> were added for efi-pstore specifically.
> 
> Since we don't store the name of the associated EFI variable into each
> pstore record when enumerating them, we have to guess the variable name
> it was constructed from at deletion time, since we no longer keep a
> shadow copy of the variable store. To make this a bit more exact, store
> the CRC-32 of the ASCII name into the pstore record's ECC region so we
> can use it later to make an educated guess regarding the name of the EFI
> variable.

I wonder if pstore_record should have a "private" field for backends to
use? That seems like it solve the need for overloading the ecc field,
and allow for arbitrarily more information to be stored (i.e. store full
efi var name instead of an easily-colliding crc32?)

-- 
Kees Cook
