Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98256D0E8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGJS4Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 10 Jul 2022 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJS4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 14:56:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0579140A6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 11:56:21 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M4JeB-1oAL7S3j9t-000IOH for <linux-kernel@vger.kernel.org>; Sun, 10 Jul
 2022 20:56:20 +0200
Received: by mail-yb1-f181.google.com with SMTP id n74so5626117yba.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 11:56:19 -0700 (PDT)
X-Gm-Message-State: AJIora9ON5xe2Xqk6IzTV5T2z5yB61XhPi8CmTRnxiHXtSp6TswtAmPu
        QJNfcaVLUx1OG6ME2PbT8T+N1hXVfFllV+HiDL4=
X-Google-Smtp-Source: AGRyM1vC8Psjq8TKqTYophNIDYGT63nbqvav729u+ibTi3lCuwuf8F4ff1EERlfLRC55htVqfUGVKk+aL3IGcrOWv8U=
X-Received: by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP id
 s15-20020a056902120f00b0066822289627mr15013108ybu.134.1657479378691; Sun, 10
 Jul 2022 11:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <e547df86b7195bb9cc5558afb4c74aeefe286849.1657474606.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e547df86b7195bb9cc5558afb4c74aeefe286849.1657474606.git.christophe.leroy@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 10 Jul 2022 20:56:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Wd_CR8EPqdPEp6kgjrymvw3cEuHCZZ8AvoT-sHVX2nQ@mail.gmail.com>
Message-ID: <CAK8P3a2Wd_CR8EPqdPEp6kgjrymvw3cEuHCZZ8AvoT-sHVX2nQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/32: Don't always pass -mcpu=powerpc to the compiler
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:/nOHuyOpTYhEByXNAmkHHQmhIzNRCKxiz0GI78R8e7xLrOVnP/w
 bKLbUQ2n0+RUEa3rko+7T1Gsjxo8zs9pqzBQiKLcGN281eEvAhnxYZ+BCiRdvA5nnf32ulj
 IjQWtukitI/0s6CoVPU/jydmqtG2ABlg83+DTdkFxZ+8yFdPFTbiVNVz8Rzy+G0qz93YtuB
 pL4fcVkiM1Dv9YQHk3cNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/+eUZtud8KM=:jhth1yumkIrYAgKp0zA+IM
 pvx2ahResbbo3dwvsVNnlLiRbdgXmn0b7HxukCMFcdjQvWZGSI+9pUMKWF7SjVMjBHd+tlQC/
 3XUQ2TgX32621yHxtMZE/YsbRupnX47pJ/Wb60lObuwanKgja43GtBzNILXW/WKHY6Ljhqisw
 S0bEYYpoJw0yax4zf1hEydldfvYM05zuqkWRP7al7rqtVp9XCTjdbgxTRSlf2Ox4nbWB2ioIo
 ZLsBMU5+s/0Ew2555ctYFqXvKW9sdXF3LrLg5STigtpSYF/zP61GodmVPtHe16xNVOJAKwjPY
 rOOeag1qZkoK1aZa2oh0eirBgs0ERGrLFz7uLpYjoADiXsypa+KG0O8ZxPYhEYnVFapym78DY
 7Jq1fzSRB8qDBgpM0cP0CRZOtgABRrDW9kyaCvA5Cdj7adCbr9qDorJVfA0lwnN8ZonspcH8B
 V7fqdPoxTOHihJoqQOA4j8Z7pnpRaHOU2v5pjr1tXWTF3sfgykSs1BwVqOrkGB6ZYhKCo/i4k
 Cy2+bBbBdFmob08hW6HQ/NShvqyJ/ok3BSTGi2u7g/mBlLzyUcp89KPB3K+JNZ2ylUUINa7uI
 6h78xXZ8IF3VrT1N35zl7J88vsMYwCO7NUOfJnJQsZyWOL3nwjiOBvzUaYH+SpTO8kAAf5U/W
 4GgjnCTetbc0oAm5s64ZTAnegzMuQVQhwuQDtsYdLRqPvK++3KGS05R6ULmwWmimWngbVp1lh
 gBWzMZlKftDwbvOzZnh+lVSWs39NRxPd0L6l6Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 7:36 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Since commit 4bf4f42a2feb ("powerpc/kbuild: Set default generic
> machine type for 32-bit compile"), when building a 32 bits kernel
> with a bi-arch version of GCC, or when building a book3s/32 kernel,
> the option -mcpu=powerpc is passed to GCC at all time, relying on it
> being eventually overriden by a subsequent -mcpu=xxxx.
>
> But when building the same kernel with a 32 bits only version of GCC,
> that is not done, relying on gcc being built with the expected default
> CPU.
>
> This logic has two problems. First, it is a bit fragile to rely on
> whether the GCC version is bi-arch or not, because today we can have
> bi-arch versions of GCC configured with a 32 bits default. Second,
> there are some versions of GCC which don't support -mcpu=powerpc,
> for instance for e500 SPE-only versions.
>
> So, stop relying on this approximative logic and allow the user to
> decide whether he/she wants to use the toolchain's default CPU or if
> he/she wants to set one, and allow only possible CPUs based on the
> selected target.
>
> Reported-by: Pali Rohár <pali@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Looks good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
