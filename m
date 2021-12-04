Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA0468879
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhLEACo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbhLEABC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 19:01:02 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B9BC0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 15:57:36 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso8528381otf.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 15:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2Are/pOeo/9e+L+foVN7ZV/ID2TszqSQl2DcVZYr+s=;
        b=AQMbi/3cy1tKxN6gXp+JvWfHQTZgZn9dnnzs0J9GqbJYtAEbnB+XEj86F77+G/yE0A
         OGYY4N3MBdWan4gpG/UY4H/oWILmTCIPKchkgCyWCQhbmKS5XLuP/sd0+xZ8ZFJjKSUB
         /f+5kLqhlOAiIed0vF27tTt03HvKYBYY39Wbk9UqmyFmNHb15aUrv5jkecnjQvFCcfM1
         ek5MbLK41cw6AzXRGJa/qA7WxnRPQK8ZW4x95XtpTV0lNIvZITC4uKCupmcEYAvQ1a2N
         F46d32eDdS41pG86kXhe+Pe2EqdIUc/j6ZYcl3/qxXrUfD4HrUGK1usTGm/1/yxbqq5/
         FAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2Are/pOeo/9e+L+foVN7ZV/ID2TszqSQl2DcVZYr+s=;
        b=wd8DEC9i0q6Xt//NqM0YGhY20gw0+D5IYfaHu3jKl10kU6EcVcD7PsxAHRGCFQ8yna
         6uvWCFfBgE/9xHqS0Uc9zUYS5VfDTsFL+UOhYjg4oQNo6oQr0DLmLTB4NZQKO6T9BTZt
         ofuRenY4uBEPdwiLNlzsRWu/38QmoMtKRKaNnAjszlxZL9qZML+DlHCjNptM7DNVECcF
         ZIDueyD9b+nAZs22FULlwvSNXyrVOdDD2d1a0NWj04H7iHV2JxuyM8BUReQCekFqe9BZ
         ZpVaP068vrrBxZAIOPFDhrnirzRM+KlKdrbtLe7BV9h41huz3qKv2RERqdIr9dhhHFUP
         wwAw==
X-Gm-Message-State: AOAM5314Kf803dDHIB02GdLlXXqk/9PPDmGjrcP5ZiTjDM7eGpwWRo3K
        VNeH35HVWpUImaST82KU3vnMslJpjX+1bZ+THilz8w==
X-Google-Smtp-Source: ABdhPJwTCZBbVyT5ZyFmeQQXcWw2Tcmz1VahQQn526w+qv7ID1nUKQ0NoVTLw1PQcnohuV19A3c7RmJyeu2D1TQ5JZ4=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr22103278otl.237.1638662255645;
 Sat, 04 Dec 2021 15:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20211129153330.37719-1-nbd@nbd.name> <20211129153330.37719-13-nbd@nbd.name>
 <CACRpkdacgoT-K4qZoBpMx8RiPcvOf=YmrTP36LKyizcQk+VyUQ@mail.gmail.com> <c42f4ea0-2879-01cf-1db8-ed39844959fc@nbd.name>
In-Reply-To: <c42f4ea0-2879-01cf-1db8-ed39844959fc@nbd.name>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Dec 2021 00:57:24 +0100
Message-ID: <CACRpkdbekZsKvoMmCtDV2Ui=ZyZA3ymZJL459Y0WgD=-mNyd=w@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] gpio: Add support for Airoha EN7523 GPIO controller
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, john@phrozen.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 6:59 PM Felix Fietkau <nbd@nbd.name> wrote:

> I just looked at the datasheet and the driver code again, and I think
> EN7523 is too strange for proper generic GPIO support.

Yup I see that John explained it to me in the past, no problem.
Let's do it like this then, but just drop select GPIO_GENERIC
from KConfig since it's not used.

With that oneliner change:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
