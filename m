Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02F8477247
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhLPMzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbhLPMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:55:04 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAEBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:55:03 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z9so25265697qtj.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUxka4JklTkkHlOcWoZDOb37rmiSUPCIVM2O4zND04I=;
        b=F0qVsIO485bGLYv/b0H+BHfow1NEFXYFa4xznk+NJ9vnBFzB3VqwTeqW4Tl4FX1+Wy
         /jyXLeSrra6mZbWo9VzAHNcGmAVSIrMOaIXlM4WLvpG/tqE7jsbiDofcJzkFVCV5urjC
         aWKZ14D/SOnl1cnjW1EqRl1Rq9u0ESEygvc6+9pZ3qnwBFZEAHkx8U31pxhuxjy8oi2H
         B3yfMm2fLGiZuzpMs/Tk0Rue4230bTfsmiXBUK6gyb5tobZoZwWSClUbsfF7djSTT1gv
         QD1h5ple1ME10se7n/7PzGdr8We/16leHdr3w52flS1DgAvkFBLUoBLIZhemlrlpfXTJ
         Ocsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUxka4JklTkkHlOcWoZDOb37rmiSUPCIVM2O4zND04I=;
        b=1KJmvSnFiL0WHwouK6mUnYN1mz8rD8sMsyCk96lszzDimQWh52DqpcLp9TgI08LH3p
         DIrQeVhJAi5qeW8x2f/LiIKdyF4xOsJZuTAV4mlioz8PWBYVC5OnkV1pAkf0J5nUAq7l
         bhCWk3jrKdgTcHPryF8bzVSWKF00VrXWeFwZa6jMGHrmm2Rboo52Bb+uzMpxWtHGEL6I
         1EHskf5sqvnc3V1k08v04DC9g0qcd5BxuHBEv7oIjTpKU2YOoIJgRoV4Ll/H1jzoON9i
         1al6/y1TDQOBhku2DtZOUIUuolM1ZbCraI8Hd5AkYJAW9xORu7PRJVqbHFnyMB1nsZAV
         zVbA==
X-Gm-Message-State: AOAM5310YY+RurvyqE51Z/yonv7g58aFM1HXGJf48+lh//qkasDREWdb
        m60djbef5Ev/yhyD/jKNWMMCMzpea+0gJVi2e3ebfQ==
X-Google-Smtp-Source: ABdhPJyCxq7QwcfJ3icCH/lpOTeUERcb0ysKCPTY5axpJVOqxNOTOTI7BrI9JGYTsDADA/pLk5Y0IrO2eLQ80uHg2jE=
X-Received: by 2002:ac8:7fc5:: with SMTP id b5mr16915979qtk.492.1639659302910;
 Thu, 16 Dec 2021 04:55:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <4b39d778ac71937325641c3d7a36889b37fb3242.1639432170.git.andreyknvl@google.com>
In-Reply-To: <4b39d778ac71937325641c3d7a36889b37fb3242.1639432170.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 13:54:26 +0100
Message-ID: <CAG_fn=VfGP7JT6ZJshsh_+rA4MR3gSM67CXCF7uhEQ6WGia6Dg@mail.gmail.com>
Subject: Re: [PATCH mm v3 04/38] kasan, page_alloc: simplify
 kasan_poison_pages call site
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:52 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Simplify the code around calling kasan_poison_pages() in
> free_pages_prepare().
>
> This patch does no functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
