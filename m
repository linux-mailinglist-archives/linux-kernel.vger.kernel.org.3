Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE0D46C497
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhLGUaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhLGUaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:30:04 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A917C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:26:33 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y7so73739plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQpK64bn98594YeNAogic3YHGdCcFqkqDbQ4M9QznsM=;
        b=mkOHqqj1M+Rj54ng6bYWnsAnf5EJ47fY3pEggwZ2KlmcEWI+BiH5TaqNOtjVcmiVOT
         mdx7nTE8AVBMAQAhnQZP/XbLugAM1s/D6E4AE35tqGh5mM7bc9RZ7N2Kf3/FRgoZywM5
         ikBikOD8FeIuJ0i3q9fEcAKRkNS0dR+xfThaWypE4peWOjXNqotuFAgKkL2nMkFhI9Qy
         oRcnw2oo2SANffVkCz1+wtZghh9dZHfMHRxAHFWkkg0mE8ArbZv/KUx5m+AgJ/v/z0vW
         1sZngZgxFvDHQenaWnn1YfjkVw8xF7TUekIGQvmLZN3iyoW8mmbEL2LLlCLaIboUPuoI
         HM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQpK64bn98594YeNAogic3YHGdCcFqkqDbQ4M9QznsM=;
        b=nN0EjYkGMj14XvgW9skJROkLLYhl5X2hWnTzDEPWu2tbAPu/cnWXpCxbzCVqYrMf7p
         Gvy/AA3DSt2LvUME8k1i4r1x1yxsDOYZgcYyTb+JCHQLpAUqb0qWylAZSr+RCz4WDQ4a
         6xnVbDV+7yWpb62/EJlUoYn8eG0CMvKFV2EiANGm2Mm+TZGIaKz4kSOUY+GmJaZlU/CP
         VF/6qTV47mkXxBoriRJQ6ofgHI+NE7S9d8hQnIQao1c8WfqFXyYb3INPHwJ0OBUpwTbw
         RACMiit/BOuY+ifRHQkarFvdPsHnOEMtGa7CMNFP66aRgCxDRjI1obQwF4dkC57LfqEf
         Q8eQ==
X-Gm-Message-State: AOAM533OcQ7phQeQ5/fBmLP23FO8Em+JM38opA1IywuTgL3NMjkExHZb
        NDBf1h9xtg64dCmJmfsjnXlApm3/wdSkCVmRmPkr9A==
X-Google-Smtp-Source: ABdhPJw683y5aqkLT66MwASREjBlo4XJZ/HgFIcv78uJAF8kOE6LwpBeKAkbwl2ansBG6PgONV6StZ3wkhBQ8jiADJ8=
X-Received: by 2002:a17:90b:230c:: with SMTP id mt12mr1742521pjb.63.1638908792867;
 Tue, 07 Dec 2021 12:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20211102073014.2901870-1-davidgow@google.com> <20211102073014.2901870-3-davidgow@google.com>
In-Reply-To: <20211102073014.2901870-3-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:26:21 -0500
Message-ID: <CAFd5g46jjo-2DUSNRi5=VHhdpq0e1tz=PqyvL_p1cxB0TQr3sA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] kunit: Don't crash if no parameters are generated
To:     David Gow <davidgow@google.com>
Cc:     Rae Moar <rmr167@gmail.com>, Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 3:30 AM David Gow <davidgow@google.com> wrote:
>
> It's possible that a parameterised test could end up with zero
> parameters. At the moment, the test function will nevertheless be called
> with NULL as the parameter. Instead, don't try to run the test code, and
> just mark the test as SKIPped.
>
> Reported-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
