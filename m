Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9284487A53
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbiAGQ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348226AbiAGQ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:28:29 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D72C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:28:28 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y18so7732541iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c73LNEILFsGj793ITcrPChPd/LwDOr0tf1RxFdlbcsI=;
        b=D4lyMC0CQ2UgzQ7bwi99PwjGuXNeeRBVkJTQxLvCaDOQBbXy9F/WXRp1FbulXPR7It
         CE4szi80JPz/mFZLqkQLIDIaAT/C9vQptcSOBhmE4Blfb9KbdAvd7z88dU67STPXkEmM
         eMg7dTA6DwtRCr7jUhFP5ru1UUK5ZARh5NhUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c73LNEILFsGj793ITcrPChPd/LwDOr0tf1RxFdlbcsI=;
        b=urJrXbWT4a2J6OiGqKFwnLJheIFwt0oxMcZtMtZeTDyt0hFs5WAaMtCUjZl0J+a2dd
         Pb8JtatbtSK76ZimF6PXMoulyhWN2hJWHAYMLdkaatPK0I7/u4R5KYJL+cyKUX0kOurc
         eOqTxL1TbpQKzUx63ySEf/s24yvBrV1ANN+wC1WkWYOFlQVSiicGzZxbwHwQ3qqZ6I1Z
         wmjE7mfhHEKQKZ4/2MSODyxpPLi9Ys8mkyWui+xh/qr/C391Ufpy9Wki9HL15G7ggiQy
         Klddcgu0Q2vfwcsHJDSVlFb7Q/z5qWVm7f/7pV5pJ0gQi6IAtQJGXLDuP7oZweRgbjj8
         nilg==
X-Gm-Message-State: AOAM530i1OobQ7POiYuM/xJ/NTgoIsJEUHYPsKfHR/0r3eYT8mpESbEv
        oPq7/pUDq4LB8o7TyozmTRVU8I9mZ6exEA==
X-Google-Smtp-Source: ABdhPJwpiOUHKusUXWdeEpR6jokfO92/F6hmpyBIFteZEgCHLRleF5iCqt+aQA1ZyPOcsb9NO5i8Sw==
X-Received: by 2002:a05:6638:505:: with SMTP id i5mr29240148jar.106.1641572908017;
        Fri, 07 Jan 2022 08:28:28 -0800 (PST)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id o21sm3720470iov.48.2022.01.07.08.28.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 08:28:27 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id r16so3286374ile.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 08:28:27 -0800 (PST)
X-Received: by 2002:a05:6e02:1a6b:: with SMTP id w11mr27948589ilv.79.1641572906912;
 Fri, 07 Jan 2022 08:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20220107103056.1.Ifc6ce6bb655ddb8ebbb0f340fcaaa58369bb009c@changeid>
In-Reply-To: <20220107103056.1.Ifc6ce6bb655ddb8ebbb0f340fcaaa58369bb009c@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 7 Jan 2022 08:27:51 -0800
X-Gmail-Original-Message-ID: <CAE=gft6yyPtpFFFNT2Lt8RGV-LE4U4W9c9KiEvPQeXNAMyH2Nw@mail.gmail.com>
Message-ID: <CAE=gft6yyPtpFFFNT2Lt8RGV-LE4U4W9c9KiEvPQeXNAMyH2Nw@mail.gmail.com>
Subject: Re: [PATCH] nvmem: qfprom: Increase fuse blow timeout to prevent
 write fail.
To:     Knox Chiou <knoxchiou@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 6:31 PM Knox Chiou <knoxchiou@chromium.org> wrote:
>
> sc7180 blow fuses got slightly chances to hit qfprom_reg_write timeout.
> Current timeout is simply too low. Since blowing fuses is a
> very rare operation, so the risk associated with overestimating this
> number is low.
> Increase fuse blow timeout from 1ms to 10ms.
>
> Signed-off-by: Knox Chiou <knoxchiou@chromium.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
