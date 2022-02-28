Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D454C7AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiB1UsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiB1UsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:48:09 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FA81116;
        Mon, 28 Feb 2022 12:47:29 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hw13so27261320ejc.9;
        Mon, 28 Feb 2022 12:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rTBdLbtdo7wtX+D2nVhSJkaUuM1Am/L9EZKGTeeVo9I=;
        b=EdX3M1Wb5rhefWc8K0jvVH4ktTsytUuplBulD6AvV4YlGbesLVovA8DKtCyFBjLV2i
         5xQfr2SJ6uavJCtam+2P3XvFAnsn+rloFywLlrP6JZU4cbyrmMT9AKVpo8kcDfmDpSxb
         X7t+S/YMhxDuZhT9DZXb8Wou2U11EuUvs55tlTDFvKtCA1v/O4dhhg3/xapH/7kNwQBK
         cGrWAB6diprnGhDQ7wCUk74LGJ3A3jPwGsKEpnhsm3pmeajiPnrfmWMcQ6jFI+y4T2CT
         eIyx5YoCIBomAPSENH0imGifbm0k/iViT0sk8CWjPZ4zBjXTTyx+DgUsRxSm0NEzcij8
         Mrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTBdLbtdo7wtX+D2nVhSJkaUuM1Am/L9EZKGTeeVo9I=;
        b=nJ39U8Y0O2x+na19okkIzi5SHyl32fLCJlp07dxaimO5DikzmhX9VC5QkutyBLTAne
         meeorw9v20+jaEeUSQbZB8sH9DP+Of/ky+XFbNAZtlYv5Brco8QxKpCoTCwzvjhx+DSA
         LscKScUsw0geWCzmXsxstjjkl/SD/e0x1+ofNJfNslpM0z+7fK2GG7FgkUsQTkiFrLdp
         Knx68iFTfen3TvePlP1857H/pdKotS+6YzDZ3Zkmz2G9cNqEikXICiL5urZOsnmUUy1m
         FWITvCHi6QPny4+M1K4YMoyUigplO0lBtx5UWNOihsZAY++q/pUXwBkS7hK81O2buFjm
         AM8w==
X-Gm-Message-State: AOAM533PxDo1++YcdRjHlvvUaRWPfOmKr8KtuQ8Vd8ab4b6bzP1fElZ2
        uD59VlGa8Np2WKZDiGOWtTRaTDZF8KSKxnNWGHY=
X-Google-Smtp-Source: ABdhPJylsibBvQ6z/vOH/YFXrTotB2PCU3JVHE0AC4wKOaqAFS2AaG7WZKiRzSLKtgw4fkbTTV4DksHCcRYLOTXgBxI=
X-Received: by 2002:a17:906:b5b:b0:6b9:70ac:231b with SMTP id
 v27-20020a1709060b5b00b006b970ac231bmr17049638ejg.132.1646081248316; Mon, 28
 Feb 2022 12:47:28 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
In-Reply-To: <20220228183355.9090-1-Jason@zx2c4.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Feb 2022 22:46:07 +0200
Message-ID: <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
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

On Mon, Feb 28, 2022 at 9:28 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> From: Alexander Graf <graf@amazon.com>
>
> We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CLS
> entries of the respective devices. However, when making structs for
> matching, we squeeze those IDs into acpi_device_id, which only has 9
> bytes space to store the identifier. The subsystem actually captures the
> full length of the IDs, and the modalias has the full length, but this
> struct we use for matching is limited. It originally had 16 bytes, but
> was changed to only have 9 in 6543becf26ff ("mod/file2alias: make
> modalias generation safe for cross compiling"), presumably on the theory
> that it would match the ACPI spec so it didn't matter.

> Unfortunately, while most people adhere to the ACPI specs, Microsoft
> decided that its VM Generation Counter device [1] should only be
> identifiable by _CID with a value of "VM_Gen_Counter", which is longer
> than 9 characters.

Then why do we not see the ECR from somebody to update the spec or to
fix MS' abuse of it?
I believe _this_ should be the prerequisite to the proposed change.

> To allow device drivers to match identifiers that exceed the 9 byte
> limit, this simply ups the length to 16, just like it was before the
> aforementioned commit. Empirical testing indicates that this
> doesn't actually increase vmlinux size on 64-bit, because the ulong in
> the same struct caused there to be 7 bytes of padding anyway, and when
> doing a s/M/Y/g i386_defconfig build, the bzImage only increased by
> 0.0055%, so negligible.
>
> This patch is a prerequisite to add support for VMGenID in Linux, the
> subsequent patch in this series. It has been confirmed to also work on
> the udev/modalias side in userspace.


-- 
With Best Regards,
Andy Shevchenko
