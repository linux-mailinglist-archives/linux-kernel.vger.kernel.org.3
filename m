Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A165852C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiG2PfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbiG2Pe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:34:58 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89B87F42;
        Fri, 29 Jul 2022 08:34:38 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id k129so4926318vsk.2;
        Fri, 29 Jul 2022 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsepfAh2sVan0JpOAgxHTcOazKlnxLYgtOW/AxgZcI8=;
        b=EaAsFddzpLXmRGXTacSJqczFNzhxbTrX7cHRpCTrTAU1nJfbXnq6CNlNZNnrHtpoWf
         qm4WFMuCHEqn7ub+xvp2zIVo7WLQTlYGWbHlzfBwjPpNzYhbWm5oh1j4DGxl00tWRdzK
         VTox+qXr/bvBsRzVw5xnPdi3m04DpB6a3d7l1KAWTBeE+X906nKpD5+ec6ncmx4tnYVI
         HOjd/XVO1CpbuOAmGTEhqjXPdMhektsyf9ZdK9SB5qRWhXg1WQETtsYR4zkmSdVy7OPy
         B0c+KjTCTlM1r3D/BUChhGz4MHxP/fmwWfqMt4CS688QNzsFH57bUKtzbuQQluTOhnRz
         DPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsepfAh2sVan0JpOAgxHTcOazKlnxLYgtOW/AxgZcI8=;
        b=IKLLv+Ql5fOZbix9KRzcPnyDHfcnFlkFsxVSWt4eLpiaDSJ12+pSKWIzorzc/h9YoV
         hQJbK4E8S7RCMfwtK5lvhxYXj1ad3UbR+h46+O9es+0W8nX3h206KaGz1XZBhxIJYdUK
         gaA36omGau9wqKv4cUaxs36KEAJa3PpDRnnB0hbLUh5tyuAZK/WXWbmRRJ3z1vjwR/PT
         9g3gBT+9eQIhkYo28Z2BLyYfJb8NqhqweBpSDpFhMC2NIyJ5wNI5fpqeRSX6c3h0xtIb
         0MqBWRL6cRCyPtHtNJhpWBaaJYzL3VBctIIOb4PWj3Tr+IXAhnst9cM95OlyW06Sq1LO
         OMwA==
X-Gm-Message-State: AJIora8ONHl7pmC3pW0rTIgO8rkaEQskmAit8EwTOj+kqNREx2KpXWaH
        1Hpy56vLOo6953qu8EFqYdvx6gPmmVr9nDgyi5hAJQ0V
X-Google-Smtp-Source: AGRyM1srJ4TooxctHqFUoSfJBK3Q6E9G3XIQTD3MHbxh04qsncX+db4k2Q/MqaPHGK0yapdOgVCQF1xFU3ZhcBImUWY=
X-Received: by 2002:a67:ca87:0:b0:358:5a89:b2c0 with SMTP id
 a7-20020a67ca87000000b003585a89b2c0mr1534569vsl.60.1659108877818; Fri, 29 Jul
 2022 08:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220729074935.115072-1-yangyingliang@huawei.com>
In-Reply-To: <20220729074935.115072-1-yangyingliang@huawei.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 29 Jul 2022 10:34:26 -0500
Message-ID: <CAH2r5muo6yBej4J_2P+09WNmDoCSW3vbgR4JwM-42B0SQoUotA@mail.gmail.com>
Subject: Re: [PATCH -next] cifs: fix wrong unlock before return from cifs_tree_connect()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Fri, Jul 29, 2022 at 2:45 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> It should unlock 'tcon->tc_lock' before return from cifs_tree_connect().
>
> Fixes: fe67bd563ec2 ("cifs: avoid use of global locks for high contention data")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  fs/cifs/connect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 931d4b6fafc8..1362210f3ece 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -4583,7 +4583,7 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
>         if (tcon->ses->ses_status != SES_GOOD ||
>             (tcon->status != TID_NEW &&
>             tcon->status != TID_NEED_TCON)) {
> -               spin_unlock(&tcon->ses->ses_lock);
> +               spin_unlock(&tcon->tc_lock);
>                 return 0;
>         }
>         tcon->status = TID_IN_TCON;
> --
> 2.25.1
>


-- 
Thanks,

Steve
