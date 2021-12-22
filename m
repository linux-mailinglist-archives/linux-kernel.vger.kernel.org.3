Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01347D1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbhLVM1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244833AbhLVM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:27:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C49C061574;
        Wed, 22 Dec 2021 04:27:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o20so7906683eds.10;
        Wed, 22 Dec 2021 04:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAWKXJ03Mjonmea/50HYvG6YASoC2U6OY7b/+8v5Llc=;
        b=DrrSho4cwCA7Wh/aYnoEyI7aFQf1h3SoF3yI2IYZNrUG9EzEWCMWtkQPgqVwPW5URx
         vTNna5RbMN/1N+DhEHit42YwyGl/Hr1o0hE1QtTk5FCcO9dUOWe1VV4zuISo4YjO3qpa
         jEVNpRlgR9K5VfDKJ2BkbT0XywZuM2KbslJ3JyP+n+yYV7ydNSuHt6keY6HctEwzW7h3
         Q76GZt3ZvcGR5h835vuhIWWYX1CPDWMK3gH6xml7S7LYKUQf8ZTRjn/TAxRXUEKy5dQZ
         WLcil3svEx1K1cOaLXn75609pJYjBmfTenQ8TheF54MxSPZl2LeMNx/Sdy+ZXGsGyW+o
         ldlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAWKXJ03Mjonmea/50HYvG6YASoC2U6OY7b/+8v5Llc=;
        b=Z3shStAy0UFH9M6O+dZfk7tRLnx85cMMm5LEFZo97kFC9cd0hgQcHjcWkbG6b9y4nI
         SWqWIjmiN2BofTnN6kHXQecjbtltxJe6pW/h1iTuGrr9j7n/YBoPHm2ENVjHD+P3Q5CF
         NSMzQA4HJ1jIih5Cj0+x53Ymk8imk5aC0nshEbMbV0KzbT4r1pY89OBaYYtfWjfyB2Kr
         irSKn8X6njHQon2CZFL3oCBm8340xI7XZliHrLiLX2t8VKn6yRqOLD1RDFYHuDuf8Hlu
         T1lVqiWouSTLhVKNw8XVV4SoBCKCpAZPSXWVf3Zd0SezWaDDg5QoQskPMrRqLfNECG7o
         oLig==
X-Gm-Message-State: AOAM533hpx3ji1SSMkuyLzPm9EFWn/JSORrTgEoxiZnGuRps6D/eeBHs
        TO7yuZfCDgF2VPunpEscEK9ZzOEtHJqesa5xwGw=
X-Google-Smtp-Source: ABdhPJwVgZ8zNhk0qAMMUZ3tp8wUGdltwnAClEChY8v0gwQdT7A0rrnRm5fqDJ8efZ/80CxSwD/lUPgo1DZ/2ktoV80=
X-Received: by 2002:a17:906:a3c6:: with SMTP id ca6mr2232477ejb.639.1640176049966;
 Wed, 22 Dec 2021 04:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-8-liambeguin@gmail.com>
In-Reply-To: <20211222034646.222189-8-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 14:25:31 +0200
Message-ID: <CAHp75VciEd55KfQQ6VdK84-uufO-N5k0TLrvv9tn7-wj3n=Bug@mail.gmail.com>
Subject: Re: [PATCH v11 07/15] iio: afe: rescale: use s64 for temporary scale calculations
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> From: Liam Beguin <lvb@xiphos.com>
>
> All four scaling coefficients can take signed values.
> Make tmp a signed 64-bit integer and switch to div_s64() to preserve
> signs during 64-bit divisions.

Sounds to me like a fix with all necessary stuff needed about it:
- Fixes tag
- moving to the beginning of the series, where other fixes are

-- 
With Best Regards,
Andy Shevchenko
