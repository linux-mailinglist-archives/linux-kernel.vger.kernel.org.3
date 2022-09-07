Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03CA5B0789
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiIGOw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIGOws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:52:48 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2318AA34C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:52:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f4so10632416qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fJo3B2xMqZ19itnKW4i6Qw4+xfulQDO8UT5EYIn/ENU=;
        b=ECGvOkiswcF70gUxltzOk31c9d9JG+Kf28aYQv4dMCfu2JRSu4f23yxHIj91wnxJzV
         SIgFjidzsT1IFPSiuhXSbP1I6jP669Vm2tj6t9abOsIdm3BQHBWP2m4T/QnsFyg7FPoS
         TamANYtiMBSNIpM5BDRg0ontXs6yaPaclJv6OtHswO2DImzpYwzSKVcjtf3ir2nGNN96
         7578R9fCuS9Z3e+5bsS7ACCsFNnQcRejm5D7YBajQilz6immEfPIRWamgTgdrTAf0yX+
         kQAlK35wl8ndn1bJ2VaW8u1Ub5C/p/hUdz2Ii4fiBo4L2J+yAwePHVdKtfcAK8wE4y59
         e2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fJo3B2xMqZ19itnKW4i6Qw4+xfulQDO8UT5EYIn/ENU=;
        b=OdghCjZ2AYz2r4BtfSd32gMe0Pc4yZeLH/QzgNGaeuE33w+BfHFz2j/a2Bsu7IegMz
         /42eAYXZAuBZ4K2dhFxel4W2bVOjtiYsOTqyDupK7JfprG1wY6urptUaa5zLAQgA5wIx
         +czIsIRyEJgFBXneqWorwLwyszKm/hMSkwZQYYkvnxhAjg9sdheOBJyYcuRvpg3yC2XX
         yiS8x2KUPHgml8PFmKzUDy2cGzxQeWe+PNwU5NjF6NDw4GSGRah29om5II7neoh9qDLm
         T8EpwAvI3+6dyE5gVkhPERc5H2DAcjADyKf+itOw9OFea3t9TO/YZHYzRRkL8Osk0z4H
         cn8A==
X-Gm-Message-State: ACgBeo3KZ5fbvnhMd4WHALP/0nufgnSHNrJP7gsuKgmrm3HTmWusjt5T
        JntzNht/TAqCzHdckO2O4ljlQNw8ZDazkFxDq5j3c6pR3BedMQ==
X-Google-Smtp-Source: AA6agR5Ew6RDlfvp5bEWcpFXxlI0QzrNr9squbwpxinK9hEJFdLC4HEbOK41+z5uSDtIsSHBUFG9OXHiDNL6i2jfv3w=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr3013495qkf.320.1662562366709; Wed, 07
 Sep 2022 07:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220907103041.0a88d5c4@endymion.delvare>
In-Reply-To: <20220907103041.0a88d5c4@endymion.delvare>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Sep 2022 17:52:10 +0300
Message-ID: <CAHp75VdzgWfQ=7nTvYmuxWMaPH0weF=Bzj+AEqsEhyQNeH1XHg@mail.gmail.com>
Subject: Re: [PATCH] firmware: dmi: Fortify entry point length checks
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 11:30 AM Jean Delvare <jdelvare@suse.de> wrote:
>
> Ensure that the SMBIOS entry point is long enough to include all the
> fields we need. Otherwise it is pointless to even attempt to verify
> its checksum.
>
> Also fix the maximum length check, which is technically 32, not 31.
> It does not matter in practice as the only valid values are 31 (for
> SMBIOS 2.x)

"NOTE: This value was incorrectly stated in version 2.1 of this specification as
1Eh. Because of this, there might be version 2.1 implementations that
use either the 1Eh or the 1Fh value, but version 2.2 or later
implementations must use the 1Fh value."

> and 24 (for SMBIOS 3.x), but let's still have the check
> right in case new fields are added to either structure in the future.

Thanks, makes sense to me. But probably needs more work :-)

--
With Best Regards,
Andy Shevchenko
