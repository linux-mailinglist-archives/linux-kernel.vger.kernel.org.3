Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA18F4D7DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiCNI5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiCNI5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:57:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7AA403C0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:56:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so10266321plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xJkiDlz3HjpJV2R+3JbmTlL+SAG14PZ3xVrckfn5kNk=;
        b=dkYXGOyJzkjCjEaUYwMBBwUQ2lQfJ7mDnqUx083FGEQ+pkorSa1ttsyS+AdZFuEmPS
         kmCCSIVnfSNZKhFXBYZFR8ki+O6JHuUUhqbIfosIdBU3GqZIkHYj2alLZ3FUXUf6ZNBc
         LP5A8bNHQJLkfjqrUBCLHBdaNkQsWMWyNIV1kTkhFbq6SRGP/sBtTvdQNe6HkrKrkv2k
         Lf82xZ7m2xkbDg7xl1inT8y5ZZOtijYg6ORnC/8uJxIKZAtHsfHEYsFcdk4gaOPpSmeT
         eiZgL6CUY/s+cesA1eNYmHMI5CFnN3eTyglBgFafMFY6hw77sJlG7SZ4F3sDb6hpKr/D
         d4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=xJkiDlz3HjpJV2R+3JbmTlL+SAG14PZ3xVrckfn5kNk=;
        b=12i3BhuiQQYBu2Cvl4YH+tgV/reDw8yqldqglratpwdZxHI+cY0ua2Rfive3UcHTAk
         TzGQua9eI8H4aT8hUdFNvn6QIPlMADuadr1AJR1yDicrLk6ViOdu5Dlb73gjfJW6T3vt
         zYL7aE1LigO49tOZJKQdJ4RSIaJwu/LyfKnAyJtr1izE7j4qOdsC9AkIKWooXgbY9wYn
         jy18UENyo7UlwWpboT5r35wIMMZCv+86qe6H2VOiNm+5surpL2pRPEuc/ddVxr0hIlN9
         GPHExzRsZojVZ8/soHsfN+gEaMps2IBm3QteZNPVgVUHmZ33mE4AwmiCmalhtFAjOG7p
         XzKg==
X-Gm-Message-State: AOAM533yWQE4FJzDDRyyf7QJSr1TiwFATCUAbwfyS2ntoQZtjcOMkFn+
        A1+zIs1NQ+yr9+G7vfYlN7HLnxIsDh8yIjvFxgUBEt0U5oP9tA==
X-Google-Smtp-Source: ABdhPJxfESJhZgMSB07Ud5xszy38lMUWBSmH5NVzvowlZrXZkoq+MgH4i4vNjgmR0ELx688xrYGljHac7kXGrIgNgSo=
X-Received: by 2002:a17:902:a585:b0:14d:58ef:65 with SMTP id
 az5-20020a170902a58500b0014d58ef0065mr22469940plb.139.1647248187124; Mon, 14
 Mar 2022 01:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220310220932.140973-1-jsd@semihalf.com> <Yiu2NIvEOow87s+r@ninjato>
In-Reply-To: <Yiu2NIvEOow87s+r@ninjato>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 14 Mar 2022 09:56:16 +0100
Message-ID: <CAOtMz3OM9c7NpGiYVHxs+KOVBVNykbQkj+KarBbNtUt6iiiQCw@mail.gmail.com>
Subject: Re: [PATCH v2 -next] i2c: designware: Remove code duplication
To:     Wolfram Sang <wsa@kernel.org>, Jan Dabros <jsd@semihalf.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

pt., 11 mar 2022 o 21:51 Wolfram Sang <wsa@kernel.org> napisa=C5=82(a):
>
> On Thu, Mar 10, 2022 at 11:09:32PM +0100, Jan Dabros wrote:
> > Simplify code by moving common part to one function.
> >
> > Signed-off-by: Jan Dabros <jsd@semihalf.com>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Is it really based on for-next? I can't apply the patch. Am I missing
> something?

I checked this once again and I mistakenly used the old linux-next
baseline. Actually the cherry-pick of the above patch was successful,
but I confirmed "git am" is not happy because of the missing semicolon
in one of the lines from context. Baseline for v2 doesn't include
1e4fe5430b: "i2c: designware: remove unneeded semicolon" thus the
problem.

Sorry for the confusion, I will send v3 rebased on top of fresh -next.

Best Regards,
Jan
