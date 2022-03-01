Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4494F4C9232
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbiCARws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiCARwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:52:47 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB29210FF1;
        Tue,  1 Mar 2022 09:52:05 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id u3so28756038ybh.5;
        Tue, 01 Mar 2022 09:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35y70918qwBmXToXnIlfMJ+QtDpOKlYytNslF63tLek=;
        b=tUmv2TORQghAzhlhQNYo8KLFpmAIlug1u6HGmbK7p8+Rsv00GkDaNzrWe6blLVRPoA
         /Rv0+xGJl67XJ+j1KcJSRA4rwu9kkh9dlj2dh+jtdxnTmpuzolTpHu/uEuBx4uN56oPW
         576F6/PzeyaDITJfi/f+72cG1PLRy+PMoru4XILaKYLKpow732UclyfRTELVZdI0zCDG
         9iZQKkgIFlJ7rfBvmy9THhDAHuJFRxRzAU2+SKd6iHIslJO1QWOv429spunXFUGTQGPi
         oCowzEqOgFczR3BXNO2jom+SfFBK1uqUvU3GrC4qc36F+WJZtCdOakX8C4GQBl7T1Z6e
         y8wg==
X-Gm-Message-State: AOAM5307YnRMjtjwotJBSIqG4wgB8oYHCfcxhb7DaFRYsPSA2EHykMAW
        ffWgHBjtwJA3yZ69i2GyO4r2JDqNAndaGSflYOU=
X-Google-Smtp-Source: ABdhPJwv7AFIWqHBfBLq39zM/tZSi4P5b9S8dgIgqDdTxwpg6EUYOKmCzvTZnlclki3/Ate2AJPe9j+vAM1hdvdQuqs=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr23181765ybe.365.1646157125190; Tue, 01
 Mar 2022 09:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20220228220532.8531-1-rdunlap@infradead.org>
In-Reply-To: <20220228220532.8531-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 18:51:54 +0100
Message-ID: <CAJZ5v0gW4O8pTgCPPh7TSdc0YZqz2NbqPWPVH4G5ijEr-YUVcA@mail.gmail.com>
Subject: Re: [PATCH] PM/hibernate: fix __setup handler error handling
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:05 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> If an invalid value is used in "resumedelay=<seconds>", it is
> silently ignored. Add a warning message and then let the __setup
> handler return 1 to indicate that the kernel command line option
> has been handled.
>
> Fixes: 317cf7e5e85e3 ("PM / hibernate: convert simple_strtoul to kstrtoul")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Fabian Frederick <fabf@skynet.be>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> Cc: Len Brown <len.brown@intel.com>
> ---
>  kernel/power/hibernate.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20220228.orig/kernel/power/hibernate.c
> +++ linux-next-20220228/kernel/power/hibernate.c
> @@ -1329,7 +1329,7 @@ static int __init resumedelay_setup(char
>         int rc = kstrtouint(str, 0, &resume_delay);
>
>         if (rc)
> -               return rc;
> +               pr_warn("resumedelay: bad option string '%s'\n", str);
>         return 1;
>  }

Applied as 5.18 material, thanks!
