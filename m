Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5BA495872
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 03:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiAUC4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 21:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiAUC4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:56:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19860C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 18:56:37 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso12455116pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 18:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8EP/XZZ7Adn8RrGBv8m4FZeB3iBzLGLU9rPwYoh5yw=;
        b=Jx0PtvGyAcCNi+Gk6w9sFCqPBN9EXeSFnV2eHAckQsddN3rd6m/i8MAeiAfnTaWRHD
         7MwopjlDrvqrlkbsGNtOaWeZr8vw12Oi5AUsgVREu0EQ+zWmmaiMDU2PbXfDLAlQ9/T8
         uD80nzTgu71SJkXDlE9DjLbr8Hqv2wyJ9X3XyUMGtGe18FHc3UIw/H5JxqZk++tlsfB9
         W/j+12yicImVTjUd5EUHmUVEWtDCofM3gI49gA8541iTX6YswWxnbXqjW21N6VkDmoim
         M9gDoCysk9QpNoI6LQyis/9hucoJ7tM6rNDO+DJUdrQNCbtm8sAojZx/8zzL3pb25Pwp
         apmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8EP/XZZ7Adn8RrGBv8m4FZeB3iBzLGLU9rPwYoh5yw=;
        b=JtJj9jUsZfajVOeOPiFLWqESwiHNELRqBRdnfvTSWqCDd4B1fFud3mYuroDNZiDX1x
         DPK8K/HOx/SewqBxB54T4sHOASTkl3RgFUUHyHhykR31Zy8deVcSAd26GAeqhN1LlIvw
         CXOgbXz1xijl3+NHX9QJIkzef9d85qWUfZcE0wqDXsEe3mEyoVJHvDSk+4eDKxyp97TM
         dp0xMqRMOruxd6MPG3DZ0qZAusCC67TOHYk2yTP/7uWPVrO1Gefa7gnyhPp1K6dAT0dc
         KJiivjFVVqFn/t9Q1uYY0euPXDqI8gzedTnkfV8hH2WSyUwiR5vHV2RYdunuXYF0JZ+K
         PM7w==
X-Gm-Message-State: AOAM532F/x4g/NaEziomd4QTcZtPMPkZZ+bwPnxn2PbezssygiAA3Mwu
        dQCVrzTS4O5OZQjgQblJJhNioQJfu3pW/7HWMSE=
X-Google-Smtp-Source: ABdhPJwgyXeKcusyG2pttm3gH14j8e1vfIMereXIXyoaOsOmzmeK+cPJg6UDQr9Fvqa+2OfU0xsdini5MnmyOKI9e8o=
X-Received: by 2002:a17:90a:9104:: with SMTP id k4mr14427919pjo.87.1642733796533;
 Thu, 20 Jan 2022 18:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20220118235244.540103-1-yury.norov@gmail.com> <Yedgj+Lo2eru8197@casper.infradead.org>
 <cfe4c63e-57c0-2a9d-c3e9-959bc77b87c6@arm.com> <CAAH8bW_=KtrwLpg4tx+1tdMjN2mUiuLOoZH6nvbn8qNjU6aB3A@mail.gmail.com>
 <5b62ed03-8da8-a94d-cc48-a8cac1eae1c9@arm.com>
In-Reply-To: <5b62ed03-8da8-a94d-cc48-a8cac1eae1c9@arm.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 20 Jan 2022 18:56:16 -0800
Message-ID: <CAAH8bW_wL7=7+Jj6vXmQSe_az0BvS_otxhBe4LOKU5fcJV9aXQ@mail.gmail.com>
Subject: Re: [PATCH] vmap(): don't allow invalid pages
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 7:37 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 1/19/22 10:52 PM, Yury Norov wrote:
> >> Why should not this just scan over the entire user provided struct page
> >> array and make sure that all pages there in are valid via above method,
> >> but in vmap() itself before calling vmap_pages_range(). Because seems
> >> like a single invalid page detected in vmap_pages_pte_range() will
> >> anyways abort the entire vmap(). This will also enable us to drop the
> >> existing NULL check above.
> >
> > I can do this, but why is it any better than the current approach?
>
> Because it will just return on the first instance where the valid page
> check fails, saving us some CPU cycles and an incomplete mapping ?

This should normally never happen, that's why warn_on() is there. If it
happens, there is a serious problem, and the code must be fixed. So,
no CPU cycles saving in real life.
