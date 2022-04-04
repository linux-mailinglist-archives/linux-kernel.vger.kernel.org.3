Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F144F1C54
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381528AbiDDV0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379841AbiDDSQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:16:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3860E3EA98
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:14:27 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b43so13982321ljr.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jA9O88Cl7Cj3DV9YqV3pxHKzHcpN0w127uH0DJrDu6A=;
        b=cSyT5s8jfuk/1JR9/fI/Gqs9xQ74yToQSFVeEVZE16CzTs4y1cTOu7dQy0iEotcwpp
         QXie2PHfvs7leMvJi+X5kQ9GgPivCzeYCJMWlKDtfiv2fOJIgHccPOImyRc3tPvaXTWK
         I8gGR4josMrjK3iFj9rmn3/SieCQXjuOAEUL34WHsC4u4g2N1HZD+eDal9zVcALYiNGD
         z97IvYhjqplonvMwwlZxugT2/f2yTjszKbrnzmJxMKd/56uQxqNMRguv/Obf8GOX+7v/
         dUVZIvh+sRDUDSFPb/VkLSB7RsQkgdLAVyXMGApGh89rPO6CofiKvMSSLJXP4dWDEbfD
         A3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jA9O88Cl7Cj3DV9YqV3pxHKzHcpN0w127uH0DJrDu6A=;
        b=O63aWE+1ALzMX+A5QfvXmZpGunH9RJhcKRXbnBbulXjRGXXqvZp7Wq23phUTc3GtCg
         O1yADUs7RCD0w48jvHpX5xpNLw11ivJoZF8QiZHG+SC51ZrdzYe2Noj+3lhH9JbiPAt6
         wkUUaHwxYj1pdERGtCVi91yHLIoMnPQig9W8erxupyv848M0cTTSgtjgNBieSNO6MQ5b
         ZJMMhNeeja2ilb0TgC+M1Tpp0aF7K9Ajlz+cQ++JX0d6DTveKqcsMBMxlIUjLvDS2m2F
         RFRwfkK/jTdaktsenUsEaim715lknByrSbVu0mVoOGPLL4cyed3+hrtqSmlmv2/9SRwB
         FV5w==
X-Gm-Message-State: AOAM532lzcKe0gC/sdfQ8UmRJboEMl5tlGHUcMvjNCMCbe+NZqc9KhTq
        A5FtMzfTTHHzA8mnFgp1NEN1ReE903A3Us6ajIljjA==
X-Google-Smtp-Source: ABdhPJy6X4VfItY0Exvmm9zT3KLeOkR4u/yRf3ZAF3nadtPeZPD3a5V5gvnOVvP+rwxXW2K1ofGissW4GbSk2e/aaR8=
X-Received: by 2002:a2e:611a:0:b0:249:83e5:9f9b with SMTP id
 v26-20020a2e611a000000b0024983e59f9bmr546393ljb.165.1649096065187; Mon, 04
 Apr 2022 11:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220318003927.81471-1-colin.i.king@gmail.com>
In-Reply-To: <20220318003927.81471-1-colin.i.king@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Apr 2022 11:14:13 -0700
Message-ID: <CAKwvOd=jyrdkMHPR3ZNQHattOxXcS1SseAHvrXWQC2H6tDB-Xw@mail.gmail.com>
Subject: Re: [PATCH] scsi: message: fusion: mptbase: remove redundant variable dmp
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 5:39 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Variable dmp is being assigned a value that is never read, the
> variable is redundant and can be removed.
>
> Cleans up clang scan build warning:
> drivers/message/fusion/mptbase.c:6667:39: warning: Although
> the value stored to 'dmp' is used in the enclosing expression,
> the value is never actually read from 'dmp' [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/message/fusion/mptbase.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> index e90adfa57950..9b3ba2df71c7 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -6658,13 +6658,13 @@ static int mpt_summary_proc_show(struct seq_file *m, void *v)
>  static int mpt_version_proc_show(struct seq_file *m, void *v)
>  {
>         u8       cb_idx;
> -       int      scsi, fc, sas, lan, ctl, targ, dmp;
> +       int      scsi, fc, sas, lan, ctl, targ;
>         char    *drvname;
>
>         seq_printf(m, "%s-%s\n", "mptlinux", MPT_LINUX_VERSION_COMMON);
>         seq_printf(m, "  Fusion MPT base driver\n");
>
> -       scsi = fc = sas = lan = ctl = targ = dmp = 0;
> +       scsi = fc = sas = lan = ctl = targ = 0;
>         for (cb_idx = MPT_MAX_PROTOCOL_DRIVERS-1; cb_idx; cb_idx--) {
>                 drvname = NULL;
>                 if (MptCallbacks[cb_idx]) {
> --
> 2.35.1
>
>


-- 
Thanks,
~Nick Desaulniers
