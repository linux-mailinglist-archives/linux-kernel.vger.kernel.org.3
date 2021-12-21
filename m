Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D976247BECA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhLULVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhLULVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:21:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DFDC061574;
        Tue, 21 Dec 2021 03:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B907B81598;
        Tue, 21 Dec 2021 11:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC0CC36AE8;
        Tue, 21 Dec 2021 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640085667;
        bh=2Js6OTOXgFjZQ1/Lt3+P5V8TaO+a3gMLZqFbquMp14Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iVdODdQ68+cl2SvyTjTWHZWCgF5P1beevj8zl109X5gvxDsANovGoelcL63S64yv2
         zyrkTdulnS+oTBWNTeSdDvqME4uWwpmeyQZxIrdJ3AUU+P5WMW9o5uoL5FzNnYWCT5
         Xs/kTWQQpPsAYofyg6+ObLSXdVcoMYD3S8cGRUMQ9UGppNBHZ6/ryaZAjfL+Qd3scb
         S73nLoOHD73xnwetr+SUzeqDjcJtxXkH4mWBED7DAkPPYHseFFIi9Cthpx8kMybiV3
         jYLvghlFKdSIKuyOyzq/LKMLSaLsBcH16FRapKshUQM8x3Ng7uqszufG1kpnmea7Y3
         BZUbNrWayQu6g==
Received: by mail-ed1-f42.google.com with SMTP id bm14so37777607edb.5;
        Tue, 21 Dec 2021 03:21:06 -0800 (PST)
X-Gm-Message-State: AOAM530iB/KjXr2VlHz/kPSvbq2+l9Y9LRCoRmMFTC9S7yPj26L8M5J1
        lcYH0YnBEX7pntSy4ksOJcRjSU3pYHggjgCvXA==
X-Google-Smtp-Source: ABdhPJxtSfpFlcxoNW0PrKICsU544S4NNvZ9OMkYeWI1nGxS3sU0RB46zKSlkFovH0Ucw4Yb3SuI8F4kwZj8Wct39UU=
X-Received: by 2002:aa7:d6d5:: with SMTP id x21mr2698366edr.201.1640085665181;
 Tue, 21 Dec 2021 03:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20211221092830.680839-1-yinxiujiang@kylinos.cn>
In-Reply-To: <20211221092830.680839-1-yinxiujiang@kylinos.cn>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Dec 2021 07:20:53 -0400
X-Gmail-Original-Message-ID: <CAL_JsqLtQanbiC4egB8d5quQRZNq0V6q2s+=qhBeypBqLH-pgA@mail.gmail.com>
Message-ID: <CAL_JsqLtQanbiC4egB8d5quQRZNq0V6q2s+=qhBeypBqLH-pgA@mail.gmail.com>
Subject: Re: [PATCH] of: unittest: Fix out of bounds array access when id < 0
To:     Yin Xiujiang <yinxiujiang@kylinos.cn>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 5:34 AM Yin Xiujiang <yinxiujiang@kylinos.cn> wrote:
>
> In of_unittest_untrack_overlay if id is less than 0 then
> overlay_id_bits will be out of bounds. And it is also mentioned
> in bugzilla as a bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=214867
>
> Fix this bug by tiggering WARN_ON()

If id shouldn't be less than 0, can we make it unsigned instead as
discussed here[1].

Rob

[1] https://lore.kernel.org/all/c474a371-b524-1da8-4a67-e72cf8f2b0f7@gmail.com/
