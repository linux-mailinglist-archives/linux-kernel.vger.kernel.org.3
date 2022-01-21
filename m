Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530B24967CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiAUWZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiAUWZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:25:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62451C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:25:40 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so9796009pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNBwc+5YqBlwJAB9/ODxmCPz0rJm+XA1ilU6R9x1PgM=;
        b=rQiGZUqDkxyJ69HOcPLmXuswV62OiXkPDNj0gwExWUUpX9iT3CRxo7FtrfgQU35N+r
         2/pgTs5xQRZ7rZ8G9LQELkE+V+zcVsZLCH/Iaj8hU4nzhDuXAh2WXctCJHGHqWkRGr61
         oITivmeqQuDfbK5Aerojo5ulqWWYB+EynNHfEgbw/jFWZcoMSzjb+j4TSG89O5KL/5hA
         MPYhOIwB15hmcxs+4vyiTouSNteVj6B4S16171+9hEAiWNr45z45dgOCfHHFe9NPOc9z
         uY4ckShcAuLdMMF8pGD8mq4AXkYnm9KGPQHV5BUYeBwreyGbNoOkZckvqIfypAOKjQal
         Gzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNBwc+5YqBlwJAB9/ODxmCPz0rJm+XA1ilU6R9x1PgM=;
        b=YVZzLSvnbMcgDruJG/9TVNulpNaaBCrkBj3ViN54LjhaXgemzUBvRiEdB9wGiq6uC5
         PL33ojFGgU9Q9zk3ROZXePfHhaBsuQeg+0d/PXfah/DjEmF1agnjS8bYXsCjggL6U3nE
         NO/DVFEYzTg2DfBPkwrYu3eyCr7aTLJtwVmUAysqk7M2YrYsEnTCzuRWhZHCWHvbqbAY
         8PdgKJfmebixqcfcKUm6SggrODvJfeV+Ra6AXbRxBq+IGDyBKQ1L2GctdeMXropb6csN
         PhhFnXLAg+sVRB6Razvk9dff93eIEigvz78Ts1pY2xgFrJTBfvAr9tM2lnUA0ytclcP/
         OYVQ==
X-Gm-Message-State: AOAM5328xrZPOIhmNajcplQDFbUnzaIIxgly+Cue5CL+/cs3qYbjHVx2
        fpFSZNcAEAUf/dGZA1mWLV/wRwRMv5uw4OcKeYhzJw==
X-Google-Smtp-Source: ABdhPJzHA3d1pY1kgrKMo6XyeWNOcvUiJqPlsPA7Ahz+QHXJnk6CcIg2J3OkyLCZFU2LRMs/nbruSYgeBepvLTPBF4c=
X-Received: by 2002:a17:90b:4f4d:: with SMTP id pj13mr2681752pjb.63.1642803939628;
 Fri, 21 Jan 2022 14:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-6-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-6-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 17:25:28 -0500
Message-ID: <CAFd5g44ngF4Sr6AjQRUsF6BgGUtnHJTZUCGs8VmHjMraoAg1AQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] kunit: decrease macro layering for EQ/NE asserts
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 5:35 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Introduce KUNIT_BINARY_PTR_ASSERTION to match KUNIT_BINARY_INT_ASSERTION
> and make KUNIT_EXPECT_EQ and KUNIT_EXPECT_PTREQ use these instead of
> shared intermediate macros that only remove the need to type "==" or
> "!=".
>
> The current macro chain looks like:
> KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION => KUNIT_BASE_EQ_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> KUNIT_EXPECT_PTR_EQ_MSG => KUNIT_BINARY_PTR_EQ_MSG_ASSERTION => KUNIT_BASE_EQ_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> <ditto for NE and ASSERT>
>
> After this change:
> KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> KUNIT_EXPECT_PTR_EQ_MSG => KUNIT_BINARY_PTR_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
