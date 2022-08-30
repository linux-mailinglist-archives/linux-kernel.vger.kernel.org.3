Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF76D5A6E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiH3U2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiH3U2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:28:01 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8347D27CC6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:27:59 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11f0fa892aeso11291352fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ILs+3Gk6I7yM+s5w9W2XlXLcFie3L1z8g352KV+BqGM=;
        b=QS/UAm96K8CqO69ixyOwmxU+q3UF78G4ywHicDQH0UzEelZzizqIonli2UT+tc1MD0
         yoyUlEZUbx+knPIGGB6jU8gv4eUosAta5byLZ6v9hZvm8mprzY7/43zxiwSYIXKHQKyU
         D56wWVQYnwPypikBhQspsgr5ldrXNvH2oy39Tx0cC+QbD+4aM5Zvw5Jws0Y7joCaLkR0
         I6Nd8xJnR/huWRzj1P0rMaVGkxPZRIYEdPtv8AXj5IZvv6nYVToMjTP2J5ivdzwHMSCz
         YzMSAkUKGQBybw9X3bUKijVqrFU2/agxnYRoRCGod5i2tzQr7X9OY6uyQgUERUVBw+GQ
         2iFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ILs+3Gk6I7yM+s5w9W2XlXLcFie3L1z8g352KV+BqGM=;
        b=fM3/V3394mSae9pce54M6dNRUzbziPGy8KwFZpA/ocxNXCuQL1L59KnLMr0ZV+5lH9
         /gpaFMbBVutEi6GEfPY+J/+wIBvTferSjCvtqcKFZrYvUKkGP7h0Qb8lp0dnwwYknqLu
         zNI4WwnEVMFTl4Nvwim0S7xImKqD55vhciDGvTGE6Wua2JmfdXXoHaoP4dF/0IMcXEeh
         caeAZWnKUvxnGSXmRV2raHDhCQ5XSSNVX/caA6xiLQPOkPOsC5LTM5Swo86cDDtq70rx
         NdA137VQyYNchnAwwvjMiR5Zr4Kobo7GkEpU+ndOxPJcr0s+lyWuA243NfhloxOwVMzN
         Ci+g==
X-Gm-Message-State: ACgBeo0eVGbiTNcjtpipXKGmVVNX8pSj4++/kzWA3sFxZSnB8XHGqtAE
        izGrPSPfqirFvh2fXYGdoD4YJBoCDWpbNnMMVSAJ
X-Google-Smtp-Source: AA6agR5GXY/SSUrrKA0f+B0gOebBUix5D+aX5TyY5xdYvfX0NMft8c+ica2iPBq+WzI+kwdMyHsXODwzMF9N6YCF8yM=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr11344787oao.136.1661891278876; Tue, 30
 Aug 2022 13:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220830084124.284688-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220830084124.284688-1-ye.xingchen@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 16:27:48 -0400
Message-ID: <CAHC9VhSGL7d_dSM-oLbH8wiAoms08U+53csKSET-gygk7gqrwQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] selinux: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 4:41 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value sel_make_perm_files() directly instead of storing it
> in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  security/selinux/selinuxfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Merged into selinux/next, thanks.

-- 
paul-moore.com
