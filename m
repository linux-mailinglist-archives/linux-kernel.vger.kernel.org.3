Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA78F4B1AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346640AbiBKBA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:00:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346596AbiBKBAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:00:25 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6645115D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:00:25 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id j2so20663914ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WIDkP+UZjRsiSQWkVvyjS0bhDfj4yHGdnjb56uFKkqc=;
        b=oPc/VtDbvJ5xdR+F5EjLqss73GzSSMZ83MK/qQ94DQ2ewUdsC9GJj7idJxQJAMQEP1
         Y9ehthayIHFX8IgQGbsxrOvnf6vfWaXBkCE7InAxIy1Y5bUDLe6WKkGjevb0/aj5joLI
         tQOr5giDHTQOEyl4sOrAWWCrPGBPktgX6/65bEUUtn80HJiXktW3MeDGv4rNvQaa2953
         c4FZdoUj+IaQOUq+ET3LUjpJgQ1u8qRN2K/knfW/W2MSEUPhfqWTYSd9xFrNdD3GMRRm
         5Da5tCcCvTxirpusRKEjN6utN50DbddWPWVYtHHgLEicSloM67vZtlqIZM24l2zGRtvV
         vMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WIDkP+UZjRsiSQWkVvyjS0bhDfj4yHGdnjb56uFKkqc=;
        b=NWaXuSk5CNMTkcGDRNANe07IGl2JCdL1MA6eYuJQHtN7z1lQ+B1cDIpJbu/hjN3Djh
         UjRyOviIqJT8gFdLVbjNvf+pDMm+ylH8tYHneo1Q+thyDDSPV6VPh2vHexVYcofI/qpi
         ecXuNV60HzJxxskl7ECrQgtMwz7xZ35LGRV4HJO0lUExhsaGy4IMw06UYcmRRvmwSon9
         X6jCnMkYjGjyWfBPnoytNORIKova5qg+WL0PbFX3bEK5AGTTYseSvT0BoV47KFZorU4j
         5SNcu/BlmoMs6F4B0+JJ7lCoJe86yQg8qAa4RXWJiDgdTIjdz/MnAEZy5Ev4M5Eli8KH
         uDvg==
X-Gm-Message-State: AOAM5337HIhrcCQxJRQ0kAZBRFUmHOcyqxUs/rj5aHO+MWZ3KxR7cMGW
        d7BM5p5K5Qfbc4gZw8+YvixjqhaP7vwbuJkuTV1Vhg==
X-Google-Smtp-Source: ABdhPJygE7mUe4mxNoMa5wIo3MDF9IoyoY8qTZnJ3OJ5MpKCksp/AMCTD9rcOVERCgZDpgx0maGUdtrhblBp5EdMEQg=
X-Received: by 2002:a05:6902:247:: with SMTP id k7mr9466845ybs.322.1644541225166;
 Thu, 10 Feb 2022 17:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20220202125438.19345-1-j.neuschaefer@gmx.net> <20220202125438.19345-2-j.neuschaefer@gmx.net>
In-Reply-To: <20220202125438.19345-2-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 02:00:14 +0100
Message-ID: <CACRpkdYZBF2Gy-7cUBDv11WomjZFXLoUmcUcWKtUq8Dz58i9jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: nuvoton: npcm7xx: Use %zd printk format for ARRAY_SIZE()
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 1:54 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> When compile-testing on 64-bit architectures, GCC complains about the
> mismatch of types between the %d format specifier and value returned by
> ARRAY_LENGTH(). Use %zd, which is correct everywhere.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

These two patches applied!

Yours,
Linus Walleij
