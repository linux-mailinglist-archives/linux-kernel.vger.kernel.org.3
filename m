Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D354F4C896D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiCAKjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiCAKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:38:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B412AF7;
        Tue,  1 Mar 2022 02:38:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4A26CE1A9A;
        Tue,  1 Mar 2022 10:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6356FC340EF;
        Tue,  1 Mar 2022 10:38:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eKJ0M/+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646131092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lksrJfo9QkvpO/yFJGeun7qghTYIG+QeJ6lsYZiAhy0=;
        b=eKJ0M/+xC1bRrQz3h+YIJ2wdMiBjedO72FmZQKocPapn+M9O/6qjJR5BT4baBoKPyyFFSE
        pCmBhHw4FUNX5W9X5kqkmSx3F7riSymxuyVxTmf9vAr0I9aQ3udtUjYk1ieAz7Mcj0TT76
        xO9H3uf55vicDmPrCVeSiFMxNixU5cc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f3e2f53c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 1 Mar 2022 10:38:12 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id u61so910835ybi.11;
        Tue, 01 Mar 2022 02:38:11 -0800 (PST)
X-Gm-Message-State: AOAM531Mtfpzm2akQNyk3HBmw1JGjKP5nAlgW070TnzizuKB0nuG2CND
        3FrQyBRHRemBVlc5jbRcpUvrGhtec3fysloZsOg=
X-Google-Smtp-Source: ABdhPJxVMHyS5UlHFoFaBLlDJE2oG/H3jmfuH9grQGZNxbXbUeDPCBWh9I7qEntrlnAwcmKZJ5loGUgJFAEPK74ptkY=
X-Received: by 2002:a25:e204:0:b0:610:cb53:b753 with SMTP id
 h4-20020a25e204000000b00610cb53b753mr22080336ybe.267.1646131091156; Tue, 01
 Mar 2022 02:38:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <e9bfc654-5504-29ff-5a5a-b73f24691600@redhat.com>
In-Reply-To: <e9bfc654-5504-29ff-5a5a-b73f24691600@redhat.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 1 Mar 2022 11:38:00 +0100
X-Gmail-Original-Message-ID: <CAHmME9oa4VQm7M0xsqCcy_0zaruhZarwodTyJEw0rtJnBskM=Q@mail.gmail.com>
Message-ID: <CAHmME9oa4VQm7M0xsqCcy_0zaruhZarwodTyJEw0rtJnBskM=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
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

Hi Hans,

On Tue, Mar 1, 2022 at 11:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Thanks for the Ack. I still need Rafael's Ack to take this through my
random.git tree, right? Or are you two one in the same when it comes
to that? Trying not to step on toes if possible.

Jason
