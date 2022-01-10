Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57D489E87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiAJRjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238491AbiAJRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:39:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82790C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:39:31 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p18so2530015wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O/zoD19T4vZt7Y0+pZu8hBQc8mpksUeLESRfmr/fYl8=;
        b=kxcyvwBQlZoKMBhEA/ZQ6Ef87pYTzvn9qPt1PSdQ6YymCG+QM/76HVvy2qKx0KyL6W
         qY4TgbJsl97tKRMFWbvFzx2o7MeLnvg3xkgJ1KZgFDkhf/DfsmatlDkv9J6N7iTeKTt9
         8HtfCPjIYwuQ7mG0KLlC4CbsTohVuZpFdTtIqFRuRb9fUuULuPU9//xyke6oHZQAFvZ+
         bSkrqsxSkzpUi97KiTraMZh0jWPxON3DwXHrVrLMxIaeHWt1xcbrFv/PzII4BEP3pw/T
         /33ahRlorNm+XmIee5b5lU/+HfXyOE49K6JpoedEBhqi/VIZjsYI7nbsy7gp01M8rzzO
         95iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/zoD19T4vZt7Y0+pZu8hBQc8mpksUeLESRfmr/fYl8=;
        b=z9MVhv645LPxMkYrR8LgbjHHE2NS2qZc6nQtMgBM2VjbAlw/82YR/B3heLSdZvabeb
         ewueK77cBTAMnTZiIMN5YzqsGKgKmGocdiSea+0W+LU/jL7oIPHb5f8L0hFultdl6zcj
         TskBT6Zihm7WA7LVErdo/7q7BqnKFqhgI0Lg4O/NLev81VDNtLftarkQrbGbbK85oNgY
         YTLbrdnDHuKkgPflbREhFqqiUXQmCU0+4QbYngvsT4xKDIDO8Z0lt8FrYcPuniRrF8eu
         8uNTkooQGG4md8URZPfwPr+1NiOdf6npb4QmaESBhcQbKyopnwMFxnSMCohnKh4axGRW
         FXKw==
X-Gm-Message-State: AOAM530U8YRjzxnxYT2KWz3d/6UdXRytY0G7VjMF2Xri0M0VKHSkcynW
        7FYn09DE9kpcOXm0sA/AIUC56g==
X-Google-Smtp-Source: ABdhPJxAOfUS+J3fkRCF9R/dUzNftxZ05snI2tXwY0t21tqOT5DQmlPdw6F1kusyDaHuLXkDtfUNiQ==
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr451394wmj.5.1641836369827;
        Mon, 10 Jan 2022 09:39:29 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:927:9b4:58f8:3bfa])
        by smtp.gmail.com with ESMTPSA id f10sm7674739wmg.43.2022.01.10.09.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:39:29 -0800 (PST)
Date:   Mon, 10 Jan 2022 17:39:29 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] module.h: allow #define strings to work with
 MODULE_IMPORT_NS
Message-ID: <YdxvUYRejf2K6YJq@google.com>
References: <20220108140657.3361237-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220108140657.3361237-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 03:06:57PM +0100, Greg Kroah-Hartman wrote:
>The MODULE_IMPORT_NS() macro does not allow defined strings to work
>properly with it, so add a layer of indirection to allow this to happen.
>
>Cc: Luis Chamberlain <mcgrof@kernel.org>
>Cc: Jessica Yu <jeyu@kernel.org>
>Cc: Matthias Maennich <maennich@google.com>
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

>---
>Note, there is no in-kernel user of this, I wrote this to help deal with
>some module namespace issues that Android kernels were having where we
>wanted to put the namespace name in a build #define to make things
>easier over time when combined with the change at:
>	https://lore.kernel.org/all/20220108140415.3360088-1-gregkh@linuxfoundation.org/
>
>I can also see this be used in ways to make namespace names up "on the
>fly at build time" when combined with the above-referenced change to
>create a different namespace for every time the kernel is built to do a
>poor-man's symbol mangling to make life harder for out-of-tree modules.
>Not that I would ever suggest such a thing :)
>
> include/linux/module.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index c9f1200b2312..f4338235ed2c 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -290,7 +290,8 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
>  * files require multiple MODULE_FIRMWARE() specifiers */
> #define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
>
>-#define MODULE_IMPORT_NS(ns) MODULE_INFO(import_ns, #ns)
>+#define _MODULE_IMPORT_NS(ns)	MODULE_INFO(import_ns, #ns)
>+#define MODULE_IMPORT_NS(ns)	_MODULE_IMPORT_NS(ns)
>
> struct notifier_block;
>
>-- 
>2.34.1
>
