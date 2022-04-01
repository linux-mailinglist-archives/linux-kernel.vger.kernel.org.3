Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBB54EFCDD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350741AbiDAWqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiDAWqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:46:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80663CD;
        Fri,  1 Apr 2022 15:44:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m3so7368377lfj.11;
        Fri, 01 Apr 2022 15:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ibv7hjPooUg+cfvEtghGL5hSRPahsD9zFXXRzSZ+XoY=;
        b=PeGRrVIRDfksKrlCQFDeVeOo5EG4l/ke4QBxquqnC2URzOjxADt3EAKpBASnA24wWH
         4lujpUtOex3q36ISwLA7GqkE9FSVvTW6A72DIzt0EbRFJEUFialbBrrcyC/jVoNYqxon
         z66CEDQU8NfACq9o3OFhQ+j4JR0pjpSyK08adU82V7TaudcbmUfil4eXkuP/y6qfJff9
         zv288j4MbHmoHxzhBzM8Q1O8d4nIOBQ/Bh4kK0j+CBdDjgxvNy6/jWUq+VvHmy0PmI4n
         3xcLw4/LGxekXH/3Y8NEBiZcjFFyCof+wOguwC2XdcyC24srKC6Iz3IzZYPVRApWaq7K
         ZnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ibv7hjPooUg+cfvEtghGL5hSRPahsD9zFXXRzSZ+XoY=;
        b=VRPWdNGn/FTzahUrGtPTXVtjA7LBBGZ1xIkI2yGsjsw9Dy3eB6sIf3jurqEHGCiSQb
         hnutQH+/UcE8Re8Sv0HqkK+K6Pc6piKJO3Av5b7MbnhUw637t39rBhUzl+2laKMgjML3
         7vrfVs6mFVuOp6PbQaW8AQUS9rOnJRoA/jnxK92sNhU3XnDg0bA8Css3zi5pGY5GaWfE
         db5BTzq4vBEaafWZiR4az+dbt7XZ7kwJZYYhlAmU3q9u7eCeWYn5HCaMhBKQGCTQ+m7/
         e9Pd7oSwfe+UuSQ+Tx87V8ZRDnAIUowVxetCkpVBF21WHLXjNDNX5YT0H+0RsE2tnjYx
         7eiw==
X-Gm-Message-State: AOAM530W0xq0Ooz5YDZxHYlB7h4vg0I2NZpoT0jJ0hdQBVc3l9W/tMRT
        T1YJmmdzqsWIbYK1DzsNBpkQxBmPwVrTMk9uYPQ=
X-Google-Smtp-Source: ABdhPJxrs5fSlNWnALwwUXR0mZMrAGAzRjdfOA/LjAHNqmMD9l69PAjCiqYAQtSdEHps123SkZCho3qgOEMHwfgdG9E=
X-Received: by 2002:ac2:5444:0:b0:44a:846e:ad2b with SMTP id
 d4-20020ac25444000000b0044a846ead2bmr15448715lfn.545.1648853087123; Fri, 01
 Apr 2022 15:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220331215541.883746-1-jakobkoschel@gmail.com>
In-Reply-To: <20220331215541.883746-1-jakobkoschel@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 1 Apr 2022 17:44:36 -0500
Message-ID: <CAH2r5mv-GCwR74QEv4WncTN6KMHceCT+YcLX7SnmuZwO67DuFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cifs: replace unnecessary use of list iterator
 variable with head
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

It looks like this no longer applies cleanly.   Can you recheck
fs/cifs/smb2pdu.c (function smb2_reconnect_server) and see if it
applies now that it has changed e.g.


/* allocate a dummy tcon struct used for reconnect */
tcon = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
if (!tcon) {
resched = true;
list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
list_del_init(&ses->rlist);
cifs_put_smb_ses(ses);
}
goto done;
}

You had this:

--- fs/cifs/smb2pdu.c
+++ fs/cifs/smb2pdu.c
@@ -3858,7 +3858,7 @@ void smb2_reconnect_server(struct work_struct *work)
  tcon = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
  if (!tcon) {
  resched = true;
- list_del_init(&ses->rlist);
+ list_del_init(&pserver->smb_ses_list);
  cifs_put_smb_ses(ses);
  goto done;
  }

On Fri, Apr 1, 2022 at 2:23 AM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> When list_for_each_entry() completes the iteration over the whole list
> without breaking the loop, the iterator variable will *always* be a
> bogus pointer computed based on the head element.
>
> To avoid type confusion use the actual list head directly instead of
> the last iterator value.
>
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  fs/cifs/smb2pdu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 7e7909b1ae11..4ac86b77a7c9 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -3858,7 +3858,7 @@ void smb2_reconnect_server(struct work_struct *work)
>         tcon = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
>         if (!tcon) {
>                 resched = true;
> -               list_del_init(&ses->rlist);
> +               list_del_init(&pserver->smb_ses_list);
>                 cifs_put_smb_ses(ses);
>                 goto done;
>         }
>
> base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
> --
> 2.25.1
>


-- 
Thanks,

Steve
