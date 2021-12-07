Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A266446C751
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhLGWVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhLGWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:21:05 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538BCC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:17:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso2982890pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOpXkc9EXimdPGYt70xvcmH708qI3DPqksqt+BSsfRQ=;
        b=NX6n5x+djHsx9J6TTYMLLYcRFQhs5oC5zU0qPZucEN8U3/RjYWnOOH15rvRl4LMe/0
         fs4NSvh8WYBdT5RAnR2h9FMqV/s8G3prT3BcNYri+/7GmtlVNNJRBSbpDXmEbJ8ntmlr
         X9JIf87sScHB8MX1v9FaNAL9O7svaTx8SAlBFVA1WKENcbecGsz4yp1H4bsoF0tsN/J6
         8fnm/AzmKrp5/TvG300lAO3V6mjvvZJ+ljZZKrzmMp6au+hYW4JQW8GZI6NgY/Robf2+
         3834Rp78S+dQaeNWZfMrxjd2jYgeRzymZXYeYI5IQHSpCmJzVdCLF/TXr5KN0pfuq1vT
         R2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOpXkc9EXimdPGYt70xvcmH708qI3DPqksqt+BSsfRQ=;
        b=KIYbJtMw4UTX78DEcR6KAYkYqVidKYvudhlQaww77oXLHcEXsBf+o5WZxMeBT5bnOy
         Xb3IaCI/yMmUS1L/Zntsw3TIJWFkFPi8dFFcUaAF/dMML9prhJ32QZQrgUKZkl+pVTUg
         n/+pmeArjMPwf3Pck9xLdXytmDGHruIa5ZjzF893JzwWKihG7MmghMHvxoG/2UxKmhna
         dPFQzxFRMIHGAbzpWGpPdnpd1fC7r5icxmaGDFm6v6emHOhDoKdNLcdiQs5amUya/0/9
         zuwl/8Likm7ugkp55UBQARgc4Em6RRarQLR5v7Q0AaWB34lJrNC16nKFca6KIxOeR7MX
         uTNQ==
X-Gm-Message-State: AOAM533jiZ0NygzaoQ8bBnzriIdm5EtdRt4femx0bU62HVerWjtEOcIZ
        r8Xi/q27a7vehuKHO34yXIa9UP/2W7v4/MPsqiiPyA==
X-Google-Smtp-Source: ABdhPJxh2wyWO2gv41Gh3us0oW0BzBpeqCeN6WzQ8/yTrYDnmsCvUCo1XGee3pIcO2G48wGVL+kDbh8wXqNXlBB/Pa4=
X-Received: by 2002:a17:902:cb8a:b0:141:f601:d5f1 with SMTP id
 d10-20020a170902cb8a00b00141f601d5f1mr55260210ply.77.1638915453486; Tue, 07
 Dec 2021 14:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20211009015406.1311319-1-dlatypov@google.com>
In-Reply-To: <20211009015406.1311319-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 17:17:22 -0500
Message-ID: <CAFd5g44+jfgdP47sQwENBXpb0Tf6LdwTJB-H72dNB5HUNZoTZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: use dataclass instead of collections.namedtuple
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 9:54 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> namedtuple is a terse way of defining a collection of fields.
> However, it does not allow us to annotate the type of these fields.
> It also doesn't let us have any sort of inheritance between types.
>
> Since commit df4b0807ca1a ("kunit: tool: Assert the version
> requirement"), kunit.py has asserted that it's running on python >=3.7.
>
> So in that case use a 3.7 feature, dataclasses, to replace these.
>
> Changes in detail:
> * Make KunitExecRequest contain all the fields needed for exec_tests
> * Use inheritance to dedupe fields
>   * also allows us to e.g. pass a KUnitRequest in as a KUnitParseRequest
>   * this has changed around the order of some fields
> * Use named arguments when constructing all request objects in kunit.py
>   * This is to prevent accidentally mixing up fields, etc.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Sorry for taking so long to review this!
