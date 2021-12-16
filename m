Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92C0477530
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbhLPPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbhLPPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:00:32 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5BC061574;
        Thu, 16 Dec 2021 07:00:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y12so87067029eda.12;
        Thu, 16 Dec 2021 07:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L049ONQywJ6H/KZx9A7zcZi3+9QPQbN67lLTXpZqhJg=;
        b=Y0CCyIX577ItMuVjdK7JK8S3erVUlwtSe05Y/0yfQu00Xox2RQ34Mft3N3Tvv+HHf2
         Tg9+wMomgiknz17BgjyK9WQKsfa48pSUcZmkf1FL8h9JQHUlPqYlC+HvM4Q7UixtljTV
         U3Mh5WLIFcM6YMuP8Y8ZxqwLEKhRvrOAWL/VuUDsnRFLV9fIw5vFpOws/UPwE24VbR18
         MlaWMbitpIIpuBtTIY9/Bn9PKJo0teb7IdnF4KVYCQyI83FSHHW2KTAZywmFIkfTuMxK
         0amWx/yCFeJSIkRZl3A1qGZBNggfeUqJ6x3zHy3augRwPGfIY1eGo/GqKI11YlqXhPqO
         7Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L049ONQywJ6H/KZx9A7zcZi3+9QPQbN67lLTXpZqhJg=;
        b=KdYhrtfozbtsAoWY2m0FHJq5eD9uNSvJtPJ7G0O7/yFtbA8hXfI76Mg6Vvvg8eBqSD
         LLEgPvkfQgDIiS6Ipm6TXfefLdTBcVz4fBUIQgdbBAMznhoH2Q1QsxMh3ACahlMLRtyf
         0SXsJ6JRTN7w0JH1zTVCQpivvzh2iZ5U23eNDMl9COrpNutKs8s/7DTt1N18+WL5BMRx
         rLlnFhJXzmONrk2jP4+PgX7d+DvT66OPYlRwl9f3p/nwPMM3NfDcs17O13UDEcSD3/7S
         wvoja2AdpEtyd6QOrxvvGSfWVahk7Pk7w2WzTAbBNdkHC467FuTRQy2otW0nUaGndQQe
         KEEQ==
X-Gm-Message-State: AOAM532NPmR9g9wQEGl0wSeL2lLsymduxoSBtxBbW5FNKI0TmhanwRRX
        kRh5mrqt4xCNOWfCt+aQowM=
X-Google-Smtp-Source: ABdhPJwM22q+zKYOW3oqdNbMsAG8SeJf3yN12RL90IIq1gsRVgdIJQLHi/OKiuYN6ZUGrAXAyTlQ6Q==
X-Received: by 2002:a17:907:7211:: with SMTP id dr17mr14718856ejc.204.1639666826368;
        Thu, 16 Dec 2021 07:00:26 -0800 (PST)
Received: from zenorus.myxoz.lan (81-224-108-56-no2390.tbcn.telia.com. [81.224.108.56])
        by smtp.gmail.com with ESMTPSA id n3sm2473969edw.58.2021.12.16.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:00:26 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:00:21 +0100
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: zram_drv: replace strlcpy with strscpy
Message-ID: <20211216160021.1b9e6d87@zenorus.myxoz.lan>
In-Reply-To: <YbsRlDYT2BfgrXRX@infradead.org>
References: <20211215192128.108967-1-mikoxyzzz@gmail.com>
        <20211215192128.108967-3-mikoxyzzz@gmail.com>
        <YbsRlDYT2BfgrXRX@infradead.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 02:14:44 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Dec 15, 2021 at 08:21:28PM +0100, Miko Larsson wrote:
> > strlcpy shouldn't be used; strscpy should be used instead.
> 
> I think the proper API to use here would be kmemdup_nul.

Thanks for the heads-up! That only seems to apply to the assignment of
'file_name'. The usage of strscpy seems to be correct in the other two
cases, though (since they're char arrays.) I suspect I might be wrong
though, since my knowledge of C is shabby at best.
