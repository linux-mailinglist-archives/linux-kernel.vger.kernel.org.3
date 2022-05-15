Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E28527AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 01:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiEOXa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 19:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiEOXaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 19:30:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8253D248C4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 16:30:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r188-20020a1c44c5000000b003946c466c17so7320238wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Tzz1rA6Fgb65ukeWrPYab4JZ//621hgrkzmZpjH7kc=;
        b=LGxbGuQ0DVXhYm3c2JWXDEZeRRaZ2FCwqjlfVrV+s19MFPzH1FlvCJ0HxMwkU/8Sat
         Za9EFqFa3NbNymp++Th2wm3GRTk8QpImAmvLp+VwIK8OlOg7vgq+y2bVVrXwcXOC7kEm
         OUwozZrDtXwiISPwOd3ZcpBh9WGHdlloppv7da3wgWXEhgmcZo+hYVnoHpJPjfz4ecSp
         9w09zOdRIX2Tm3zbqC/gxmODq9dccJE12HvXjLKQl7tU1qsyZuRCgl7htpA9MNNz0uEF
         AkLhlDDv6uo8OWlkVbd2LFicyJ14lApHIb4/x22QaSB98F0xG6vTMMP76mrPbIXtSkGb
         jyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Tzz1rA6Fgb65ukeWrPYab4JZ//621hgrkzmZpjH7kc=;
        b=uZShAPyz8To629N3auM2eQfi9KRvxpaZ9wAssRtlWDjxqWLjW+63OEv/U1N80uGHps
         BDYVyAPQ/VdLyKLJ46HLi2TeKx9Iqwh/jTRwo9Id9lru9ln870WTZafmXP18/aFdQSJ4
         szxZK8Kx0TNXFkQG4BNV/aJBcEnTzlzzxJdq5aLNytT/SJLnamfzC4IkrdRThQD57pW/
         a4fHOKdkUXdMiltyRNs6rI8J7PgCgv+p8VTSYNv+z9rPuJaayGAA+q3rdm6Hni/MRGU2
         Mb+iHVFZcPqiQ0cTSWFCHPFll6hLg0n2wJpUTmDIcSmbflOVbVrnFwblhjbQPZ+oHBU4
         OzUQ==
X-Gm-Message-State: AOAM533KrqwLwqoQOdJlubV2xyGlLJqMijKDI23EtpfsOH5UXdGDzyPP
        LrVMueko2MB4syRRrPsS/4U1m8TkrAy27gimh0qj
X-Google-Smtp-Source: ABdhPJxUa8kUMmh9IPvo0tTSJYv/s/dvohZgbxlDFxJ0O4aPOitf+TFHm9XmtPwWwk9PrPYPgFoQ0fVHLV2BONZq+aU=
X-Received: by 2002:a05:600c:34d6:b0:397:caa:15d4 with SMTP id
 d22-20020a05600c34d600b003970caa15d4mr542440wmq.190.1652657421952; Sun, 15
 May 2022 16:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220514211455.284782-1-sshedi@vmware.com> <20220514211455.284782-4-sshedi@vmware.com>
In-Reply-To: <20220514211455.284782-4-sshedi@vmware.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 15 May 2022 19:30:11 -0400
Message-ID: <CAHC9VhThHh5e0zBGN2Yu+EbiO9TsOUzo=YAOpyejrjX3-Gj49Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] audit: remove redundant data_len check
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, eparis@redhat.com,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 5:15 PM Shreenidhi Shedi <yesshedi@gmail.com> wrote:
>
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

As a FYI for the non-audit folks on the To/CC line, patches 4/5 and
5/5 were resent to just the audit relevant folks so I'll follow-up
there.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 7690c29d4ee4..0749211d5552 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1390,7 +1390,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                                                  str);
>                         } else {
>                                 audit_log_format(ab, " data=");
> -                               if (data_len > 0 && str[data_len - 1] == '\0')
> +                               if (str[data_len - 1] == '\0')
>                                         data_len--;
>                                 audit_log_n_untrustedstring(ab, str, data_len);
>                         }
> --
> 2.36.1

-- 
paul-moore.com
