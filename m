Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC2591137
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbiHLNLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiHLNLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:11:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6606C75F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:11:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j1so1184112wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc;
        bh=oBbits87Sh54Pv6OEfDdfWZYrwVvKln+o+HoHPpBNT0=;
        b=s4ddTScLTJaDLUFkiZ3TBa3nJtFTnumXRrFoezKDY9/HeFWIew4zitQN4HCRxdSuMN
         AI1TlchQml2Nbne0zQcQvvVkELdYXXjY9CRNmdUMpNH1ZIQCr0iTGvM4zW7BH74GccBr
         LZM0Stq/nIwqOeEWQuxBUSxqFsxd4FqhzRhZapA9vGlCIj466gdc66fFKTY57C01wlVx
         YawjSwDBzBtyktrL9O/Colyw1wBIFwJiYCVVJ6bhrWLll9yerrK+kByLaITALFhvlzSk
         IH1Zxzo+3qkM1G8YTG1HfSGfNNUK5T41HOVE1g+P8JThNJeigd5Ka01AzXV0G+hcDFD9
         jO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oBbits87Sh54Pv6OEfDdfWZYrwVvKln+o+HoHPpBNT0=;
        b=aVZWN6PEpCoiVDEKmsB57PEdVDdvun0/ZpZk2PKSYO74lbepZLk9vv6vgISY+4eIpg
         DMMbBxoQaWo30nDtq4Q4EyxrnaQoq1y754N9LfK5ZEaMzxiw1mk0M/mcWPwPIy99Y2nI
         nu20jdHBHTA8QkvcC+LGXZl4HCX+s175mAlncSsq2Xe4r03eDaQTN15eU/76BAzCfscX
         c769cvDEJy5k+CO6p4bJ4+dfvFgAVsj3e+Y37R6XTujCAxv1c3B4n1VuWgihUygwaV6V
         AlGPnBtcC76SC/ldOw5lncDTkhAk1FIB3mONnpjxiujsiEk48ZcMLnqmCQWhI4Mz8hfS
         E+RA==
X-Gm-Message-State: ACgBeo0+P6CuKMyn7kw7ICZFU7FMUIjOkJ5/hz57jksLPYX6CZYZc7gN
        oQz/pAqJgaIeJHhYhhddRC4qL8mFiqM6iw==
X-Google-Smtp-Source: AA6agR6AuxoJ9bwmQi0vU/ySTcZsqisySBUe5l5ptauxg9gq8coDfUkOE+L1t6nDa3qVGWnjHUlVsA==
X-Received: by 2002:adf:f346:0:b0:21f:13ec:cacf with SMTP id e6-20020adff346000000b0021f13eccacfmr2080589wrp.525.1660309892485;
        Fri, 12 Aug 2022 06:11:32 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id e17-20020adfa451000000b0021e30e9e44asm2000849wra.53.2022.08.12.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 06:11:31 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] ACPI: Device enumeration rearrangements and
 parent field elimination
In-Reply-To: <12036348.O9o76ZdvQC@kreacher> (Rafael J. Wysocki's message of
        "Wed, 10 Aug 2022 18:11:58 +0200")
References: <12036348.O9o76ZdvQC@kreacher>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 12 Aug 2022 14:11:31 +0100
Message-ID: <875yixk3ng.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> Hi All,
>
> There are still opportunities to clean up the ACPI support code and
> this series is part of the effort in that direction.
>
> It makes changes without functional impact (AFAICS) to the core ACPI
> code related to devices and to some of its users.
>
> Please refer to the patch changelogs for details.

Other than the single typo I noticed in Patch 2, the changes look good!

If it helps,

Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>

Thanks,
Punit

[...]

