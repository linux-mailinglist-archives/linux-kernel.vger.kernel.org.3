Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BD6489640
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbiAJKXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbiAJKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:23:01 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84DFC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:23:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so6444007edd.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0nrXkjvT8Y2JTsBxE15ySAcNK2QPiRrQi7yxt+5z/k=;
        b=bZfdedTaBlISxsnA+HjOnZ2STTnliWILpWqzvyQ6qQWMHBDbqJEEzOrRd7Z209N+wV
         Pt7u7gf1aCvV8qAsRsq66SlB7ZDSM81mOI0eXQscqDfQv76/Retg+8ieV2cdXTVCUNjb
         g4vH1O+eIUoj+skY/jI67sxujc+a9xhj6NpSqTtbfLNAVq+qdFEeEDKW3F6/f4alCMU8
         8L29OhGE3C74CBXs0JFnCg3y8HxUbE/DzEziHguagP7ZjFEC8l2IaEP/MmuLunKjutas
         4ep7CN06F9nNM9u7F+wgRgi2rt+tZT+31rYGvYIdT1lKg5Mp1aohyE5cQW58dtnP3Qos
         qAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0nrXkjvT8Y2JTsBxE15ySAcNK2QPiRrQi7yxt+5z/k=;
        b=6W1eZ0lIl/jkTrwGywYTzzYhwviU5fBt0zhFFdrPPt91ZuGhgCK2nsfHw4TRGTLu53
         bebK/7Do5umTrhzbnDRhb6lp8s9OxaP4umhcOpLjL+TtjkXbyQoPrQ1x1qE8YFMHniCS
         KgybA5k/VELcCDpQzDNHtaUajbQrQhRnyM/pdfkFOmcjTYRv0ZqTemu2QDatbYAYlFiu
         W4NbZVbOucCArPJhuOSc4y22mEc798rPmFmadsjnLsWgHZ4fCWHLYHqrfxwK5tT+I2Yh
         9eVkwwsakeLJcy1YAxUgznXmjfVIN1H4MXDqdTzqYb/gYS8/UNUYBls7xOV1qq4dM2CR
         I6qg==
X-Gm-Message-State: AOAM530MRuaXLw89FDMd+gMinP7yw3zP5BMKsfRoBB2PqQUurI1Ou3YZ
        x7UV7SHwog9TocFspQPMr4kynidmSWqXl6e74OA=
X-Google-Smtp-Source: ABdhPJwECqRHbXYE3+1gJLeWik7SnLbktBiu0AZzxvMVObvaegtHQCjFwf0DmV1UNgLl9J6yU9U5sFqr0U6pNjyMLGM=
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr57649438ejc.497.1641810179272;
 Mon, 10 Jan 2022 02:22:59 -0800 (PST)
MIME-Version: 1.0
References: <20220108140756.3985487-1-trix@redhat.com> <CAHp75VfbSmgeyi=8q1_he7mpGrNxYAOewKYWD=h8BSuxz2XWOw@mail.gmail.com>
 <0c0926d9-9b72-1519-7e22-e90ffc229940@redhat.com>
In-Reply-To: <0c0926d9-9b72-1519-7e22-e90ffc229940@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jan 2022 12:21:11 +0200
Message-ID: <CAHp75VdJOzYR0HsZ2LWn-iAMwcM3s0NNDKQdXZZudcEB9RwE9A@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: cs35l41: fix double free in cs35l41_hda_probe()
To:     Tom Rix <trix@redhat.com>
Cc:     "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
        "tanureal@opensource.cirrus.com" <tanureal@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 2:37 AM Tom Rix <trix@redhat.com> wrote:
> On 1/9/22 2:33 PM, Andy Shevchenko wrote:
> On Saturday, January 8, 2022, <trix@redhat.com> wrote:

...

>> +       if (unlikely(ret)) {
>
> This is double weird. First of all, wtf unlikely is here? Second, I commented on the patch that does something with this driver and pointed out to the return 0 in some cases. This one seems a band aid.
>
> Unlikely to have an error.

We don't use likely() and unlikely() here and there, you need to
provide a very good justification of its use.

For the record, I forwarded you my review against the code where you
can find much more issues with it that are subject to fix / amend.

-- 
With Best Regards,
Andy Shevchenko
