Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127AF4C77EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiB1SgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbiB1Sfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:35:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D205AEDB;
        Mon, 28 Feb 2022 10:21:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2351B81627;
        Mon, 28 Feb 2022 18:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E838C340F1;
        Mon, 28 Feb 2022 18:21:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XYXgcGvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646072474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0iIkz5uHWJtsoXeAkWT2e1MnU1M3yDSoa1B9WDhNOA=;
        b=XYXgcGvoVCXgQUAB7Vz9CsdApL3I2knmdXAMh8LuZ+7pJyuLFk5G4oSKbOMtyCqqEEPETY
        24DzY4e3f4DEvkiOLqe3X8YKM0UlY6ll5ijBcius1BlP/ADCRf3Yxg6GsxK7gMIRGW1NEW
        pSwPt4Lylt6hdFPd21WqhUbv3q9d5MM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f8da637a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Feb 2022 18:21:13 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id b35so22239895ybi.13;
        Mon, 28 Feb 2022 10:21:12 -0800 (PST)
X-Gm-Message-State: AOAM5307QW332jo5sc29OuNwiuFIPHw6RoUVxAa3djMFQN7NXk+fmaxq
        2ZuCWNsYDUctA1tnFiDrCi8U1oe6ffpjVR4VMfs=
X-Google-Smtp-Source: ABdhPJwlOr5HJkXmhp0mYINN9ApBCTxUkGi+q4lnl0CZTJ86zUWbK9eJ0VzSl/XHmScThD3AURRzQiHnSPOu9R2Jd2Y=
X-Received: by 2002:a25:e204:0:b0:610:cb53:b753 with SMTP id
 h4-20020a25e204000000b00610cb53b753mr19163518ybe.267.1646072472285; Mon, 28
 Feb 2022 10:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20220226220639.1173594-1-Jason@zx2c4.com> <20220226220639.1173594-3-Jason@zx2c4.com>
 <0c73d29e-e558-efb9-d0d7-c612b2bb7e90@amazon.com> <YhtyBHUyFysmZ9bC@zx2c4.com>
 <CAHmME9pocD1CoZbnF7p4k0ws7-R0Vc9H4i5TRJ_MCX-d3AZhFw@mail.gmail.com> <CAJZ5v0h_Z9XS9ZgSF4CWrZ4RU7=Oa02MY3_g0Y_rcgRNzsizfQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h_Z9XS9ZgSF4CWrZ4RU7=Oa02MY3_g0Y_rcgRNzsizfQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Feb 2022 19:21:00 +0100
X-Gmail-Original-Message-ID: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
Message-ID: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alexander Graf <graf@amazon.com>, Len Brown <lenb@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Mon, Feb 28, 2022 at 7:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> Increasing the ACPI_ID_LEN value is fine with me, but the patch
> changelog is not entirely accurate.
>
> The ACPI subsystem uses struct acpi_device_id mostly (if not only) for
> device ID matching and it is generally used for creating lists of ACPI
> device IDs in drivers (and allow/deny lists etc).  The device IDs
> extracted from the ACPI tables can be longer than ACPI_ID_LEN.
>
> This means that drivers cannot match device IDs longer than 8
> characters (excluding the terminating 0), because the IDs in the lists
> used by them for ID matching cannot be longer than this and not
> because the ACPI subsystem is limited by that value.

Thanks for your notes there. I think Ard more or less pointed out
something similar too. I'll amend the commit message, send a v2, and
hopefully this change is okay with Mika/Andy/Hans.

Regards,
Jason
