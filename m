Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EF958715A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiHATYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHATYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:24:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13952AC70
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:24:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id rq15so16133063ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KH3trqee3TIV/ZSeY7BO2I7zkrH6kVi4kU5pJ2VZkpw=;
        b=Ti0gGF58wXXW/TRaxtl2Js1mWeGPbN9a9+WViVp2XfdjOfazhFqEqO2MjAXRfemOAK
         GW1pUdAe8RdSjf+rTJbO9BOGL13Is3xrWYKk0pz9W1F3Hse2pa6Q03vHH+42R1BBUHDa
         ApRwzEN8g/IyjwuPgYiY511zUt/W0iT36Kr1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KH3trqee3TIV/ZSeY7BO2I7zkrH6kVi4kU5pJ2VZkpw=;
        b=fxzTpogYJyaE5wJD6dl4C3Q5zg00d5/iAwuhBJGP7lIvbbytP7tu6+CDjXZG04yH8W
         5HTMsNkTbBDdtYdCdEZhE0fVPB68n+xtk8zv21uTsUC+xEDfqii7SEaKj/s+YE6w3W6W
         D9ED8/bytjjeoxLwqfsfWEiX8y1ApI7z9j9WYUDwKggtIoZ0a0puH5VDgp1IBMjcy0qp
         Fppl8jZYBrHtAaqWLS3I7C01IUHn+VylI3HVkrgxzrQM0zqvGGSXSMC7FgoWqCKQjGYu
         A6ji0Wr+9Ng6raGnPpehMyQcvcNOzIn9VH/ITcgyYYqSVXPtkg4h4TR//zYkPyfMtr4t
         1Nog==
X-Gm-Message-State: AJIora8UcNfNQ/H/FUeAz0pItZYYCbsxU6V+AHldMiWmCoXDJpjSOofS
        meXx7OIdfhGjS8yEmltXOPbML56zj5evZ1d73ZM=
X-Google-Smtp-Source: AGRyM1vd0mMf2TY9/VBjY6vndowGoyJhFt3c78tFuWIe2gprMscp4jgL+/PoD8QmKaa8npy46r7a9g==
X-Received: by 2002:a17:907:d22:b0:72b:9b4b:78a9 with SMTP id gn34-20020a1709070d2200b0072b9b4b78a9mr13834346ejc.626.1659381873064;
        Mon, 01 Aug 2022 12:24:33 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id h22-20020a50ed96000000b0043c0fbdcd8esm7163374edr.70.2022.08.01.12.24.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 12:24:32 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id j1so6951681wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 12:24:32 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr499947wru.193.1659381871867; Mon, 01
 Aug 2022 12:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220729102205.GA24050@willie-the-truck>
In-Reply-To: <20220729102205.GA24050@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 12:24:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=CQsmGPzDUZjey3DoMFsiCqn-O6kmCv6ZCW0AoO=kOg@mail.gmail.com>
Message-ID: <CAHk-=wj=CQsmGPzDUZjey3DoMFsiCqn-O6kmCv6ZCW0AoO=kOg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 5.20
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 3:22 AM Will Deacon <will@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

.. and I can happily report that this works fine on my M2 Air.

Which I'm sure is not any surprise, but it's still nice to be able to
actually test and run these things.

             Linus
