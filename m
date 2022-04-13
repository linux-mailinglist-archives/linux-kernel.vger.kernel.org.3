Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78664FF324
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiDMJR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiDMJRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:17:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D93245B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:15:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k22so1687528wrd.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnj/mfXyw3X9KuyzrqC4TpOmshoDLe2fxPgBUJq8rEw=;
        b=OLiTP5KTzX2EMQRMyuZQT6agCOB3/2yrnTe+Ik9ZxL7u/LI4YqoTK9b+9w/hoTCHtW
         BAPtK2aVG4wxs4Uos7Q+IdMKHnf+gBRXR7sn4HgBcLEoqme+PPD4qIUFCRI2ln0Yo26L
         hEnBUOoqJesrXatPPw06xQdIliL1PCuQwZlt0N4dUDVIV7X1nPNnDMoxEt2gVPylMh9Q
         /73M9Clg+zrCQi45/Hxb2ttjKQmnockYXBgF41WzV3WtkJ7aTw7TNtNVndCc51+2ZWhA
         Gx6Nq/BAqvZes2RzBJJf75nM6G5itbbYDlUZ7M4nscat2VciVx3lok8ACDCjkeZM4I4Q
         oGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnj/mfXyw3X9KuyzrqC4TpOmshoDLe2fxPgBUJq8rEw=;
        b=f7rKevtYnSa7axPswiFjWhtfai1ocmWlOJHg7NFWgfUN0D0/m+IgqU/tEBzn+CqmyG
         7gMujCtcxxNWqC9Hxfqj/SvPpFqMX/mypY3pAq3xTLSPwNBXF5BKIXNgpWt5XfB7/96e
         fpPy1wnUwVMHRkhyt/01k1UFv4vcAw07IXG1nQFVvcoA8BZniDlBn8byVc6c+EXxPp41
         kUhdcNUqxZ+xxWGcFBSzvYTGg1Tnls6+dICrBzj3GiAzwFHf5nONh+zMDTXL5GpsvtTI
         e3Nu4jVRn9ypLE0YahGPy9yIF1cpVJ2JLDsRIkzAmO5BBGvjGQcFMzsTqNn4wSJrSryL
         RmPA==
X-Gm-Message-State: AOAM531hR7+SJMKyPWo+7nSNRggN7RVsyZWdr2fUYRaGgFuwJY2zq7pM
        duhX7MUjQ3Jn50gbxaPX0vQdYD8EMysbHRT925TDSw==
X-Google-Smtp-Source: ABdhPJx8DruPa2vSEAy/3SFqU1sX90/qigxx5j4L1ib/z1Wj8i0Vy+rDVHfazCrISW9FG0MytXPj0Ml4Q7klFXyK9gU=
X-Received: by 2002:adf:de81:0:b0:207:a65c:d895 with SMTP id
 w1-20020adfde81000000b00207a65cd895mr11371461wrl.647.1649841314677; Wed, 13
 Apr 2022 02:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-8-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-8-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:15:03 +0200
Message-ID: <CAAeLtUA2icAJSUD-cc8+xnx7Vmmd3ehn2ieB4_DuzOu2_dFvrA@mail.gmail.com>
Subject: Re: [PATCH v9 07/12] riscv: move boot alternatives to after fill_hwcap
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 at 05:03, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Move the application of boot alternatives to after the hw-capabilities
> are populated. This allows to check for available extensions when
> determining which alternatives to apply and also makes it actually
> work if CONFIG_SMP is disabled for whatever reason.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
