Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D454BC84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357794AbiFNVGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbiFNVGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:06:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1D506F7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:06:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id j6so621170lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46/1VkM+MT0uixtaALVbGprso4A4lLswKLXFijAX+ZM=;
        b=UoPbLx8zacDpWTH6a7F57TgMHew7HQukBhC8V4hy+LMP7l/KQvKR1hCqDGZcYdqDYe
         2cmKHU/Wk9ecH6yDpmKby8ZMDqT5HQmi06IDlf9FCCIRq/8PQZ2mQn36B8e2wbrg5JU2
         HRzb/UOFPZIZDZH/9g2yrHaR6pyutaoHWpAwV8EJqqExaLskiqcuK7fFaE8/rP1TpkwX
         VNPvgC2BHPVLGMNS62wenauGbdD2dQT7wo1r+rvz/CcvpO16yT6MJnxMllr1/+Q0ND3p
         tTPSp6gaImBG0r+YMyPjgARyHi2+L/mUkx7AsLOe8XUF3B7K+RvNNXTXg5JkzWDy9ST6
         PCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46/1VkM+MT0uixtaALVbGprso4A4lLswKLXFijAX+ZM=;
        b=SbfjmWJvnOxBRxCFGD3KY6Ggc9Mv8KNrFF5mtk99HPz4ivSXmz9RNN45c6qNgfrKAn
         3b+WU5LnQp2QFFkOWTMLv3hg6HGFWlBUxbHvR/BzAgm92hbgBLCYxog2d9LR8hWSSOZV
         y6DrzE8JXo6hbmZZ37cTbAk/TtCwx5Zg3Yjwpw4NsWCRATcVBs3qJDhyHEgz1iEpMBva
         IqhR2WDMXwpzU7MIA/Kl51OCicFp9aAf8WIoqoqRFczTzM18gPdLF0PQwNj0jd9TQ1s4
         Mo2YtXFC9TPq8uDRXktBt/YdhTd9JbsHBxQYo3g9s5dI0LTWcnwy/M47slFG7S+jaoj5
         m6rw==
X-Gm-Message-State: AJIora/haszRf/NgTTjtioD5jDpewxZ3Z0GxYTGMFPH7snDE6/Zy43VY
        qKEsVqbYvbRVqHGLUuf9/nJsayZyxf9BX6V9Dew=
X-Google-Smtp-Source: AGRyM1tDafP86+8JuZFlvKRTKFUmpFTksn0BZuaXoh4caUGRnGk9WKiui+MnQytVDG0WbutLdQTuF/mcQBK/2LMsM0o=
X-Received: by 2002:a05:651c:a04:b0:255:bf2e:72b9 with SMTP id
 k4-20020a05651c0a0400b00255bf2e72b9mr3618703ljq.333.1655240760251; Tue, 14
 Jun 2022 14:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
In-Reply-To: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Tue, 14 Jun 2022 22:05:49 +0100
Message-ID: <CAD2FfiHpe0Dp+_t1D1giktX7R5ZDagoUf34yUGTkQAJBhwtxMA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, daniel.gutson@eclypsium.com,
        alex.bazhaniuk@eclypsium.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Richard Hughes <richard@hughsie.com>

On Tue, 14 Jun 2022 at 22:02, Martin Fernandez
<martin.fernandez@eclypsium.com> wrote:
>
> Right now the only way to check this is by greping the kernel logs,
> which is inconvinient. This is currently checked for fwupd for
> example.
>
> I understand that cpuinfo is supposed to report every feature in the
> cpu but since AMD is doing the same for sme/sev I think is good to
> have this for Intel too.
>
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index fd5dead8371c..7311172aceaf 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -570,6 +570,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
>
>         if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
>                 pr_info_once("x86/tme: not enabled by BIOS\n");
> +               if (mktme_status == MKTME_UNINITIALIZED)
> +                       clear_cpu_cap(c, X86_FEATURE_TME);
>                 mktme_status = MKTME_DISABLED;
>                 return;
>         }
> --
> 2.30.2
>
