Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A104F177A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbiDDOra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379689AbiDDOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8B13389
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649083337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXiWPffxpHbWQ2eIaoK3c/FiSIjbtVnbbyc5wOi1X2k=;
        b=KC0T5noqfmU2spQqb8t9kaEs+S7HaGie9N7S7YS4L3iF8FyrM0TRZWnYz1DrrRnWf5tsFe
        onRxrsAubXGO+S19rhqwlZnV2lxCV/j+P7qHws2F1S0ghfdKN2bG9DdFKuFzt4N4Yr/r5G
        xGrhaYBRtxHMKRBjCQxKQwbLU57GNJU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-iuZBHrvUNPGLHF6zZUm4uQ-1; Mon, 04 Apr 2022 10:42:16 -0400
X-MC-Unique: iuZBHrvUNPGLHF6zZUm4uQ-1
Received: by mail-wm1-f72.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so5074384wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXiWPffxpHbWQ2eIaoK3c/FiSIjbtVnbbyc5wOi1X2k=;
        b=JsFtD10Dl2Dd53VNSTwcTG2mbeV7Hoou/liAyBPgHVLOUXUKKjc2ruz+lVzj+W3XnI
         Lwm+4g+msI1a6/36IIlwbVOr380TRt0sowd2H4nx7VSf9kItxbG3Drj63uuRccNK0H4q
         UYMnnaDiK0I30mR4EPPD+1lIPbsqXHB+VicLsftK+QTXCn4zqi1yN7Qlq5ea67OgIuHQ
         jI3dNsfUDD3NcEBeqARvnxZvaT3WXKiqAYqXUOk5/KssQ42Ffwhv6+lrbdNoXnwY2UkL
         RFIvf7iz59B28w/BASy6J+Grrh6nClyLDpMF74k11h2nG2b3Bt75s1CBFSkS60neov+l
         CZLw==
X-Gm-Message-State: AOAM530itp5SL+CBCnnziQ6l/y5/Zd/8MO1D8iTMYzTcezlbK3zdzzwL
        pThNsmVlptMvuv0TIjAOaFZJ0MkXRVj/MmTuU9svwF7DaeW9sgrf3AZtCvgYcyogKzE1Gz25Zgl
        dJWO3PyxPvwbmC4bygvcUaZtvK1fBdg3mdzj8sGiX
X-Received: by 2002:a5d:4684:0:b0:206:160d:e0c9 with SMTP id u4-20020a5d4684000000b00206160de0c9mr2639821wrq.493.1649083334825;
        Mon, 04 Apr 2022 07:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg+AfJaKH2047sRS+vqJejShKW3qlU7AVJoJsOCrGfYlFDGBqiqqYdurFN8nbwtgyAQlaX7ImMjM46ne0LI5w=
X-Received: by 2002:a5d:4684:0:b0:206:160d:e0c9 with SMTP id
 u4-20020a5d4684000000b00206160de0c9mr2639801wrq.493.1649083334618; Mon, 04
 Apr 2022 07:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220331223857.902911-1-jakobkoschel@gmail.com> <20220331223857.902911-2-jakobkoschel@gmail.com>
In-Reply-To: <20220331223857.902911-2-jakobkoschel@gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 4 Apr 2022 16:42:03 +0200
Message-ID: <CAHc6FU41FSZHGx+H1zBsBEnLo2s2fViDKJV4P-LJXg3s5xP4WA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gfs2: replace usage of found with dedicated list
 iterator variable
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob,

On Fri, Apr 1, 2022 at 12:40 AM Jakob Koschel <jakobkoschel@gmail.com> wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  fs/gfs2/quota.c    | 13 ++++++-------
>  fs/gfs2/recovery.c | 22 ++++++++++------------
>  2 files changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index be0997e24d60..dafd04fb9164 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -443,7 +443,7 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
>
>  static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
>  {
> -       struct gfs2_quota_data *qd = NULL;
> +       struct gfs2_quota_data *qd = NULL, *iter;
>         int error;
>         int found = 0;
>
> @@ -454,15 +454,14 @@ static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
>
>         spin_lock(&qd_lock);
>
> -       list_for_each_entry(qd, &sdp->sd_quota_list, qd_list) {
> -               found = qd_check_sync(sdp, qd, &sdp->sd_quota_sync_gen);
> -               if (found)
> +       list_for_each_entry(iter, &sdp->sd_quota_list, qd_list) {
> +               found = qd_check_sync(sdp, iter, &sdp->sd_quota_sync_gen);
> +               if (found) {
> +                       qd = iter;

we might as well get rid of 'found' here like in the below two
changes. Let me fix that up.

>                         break;
> +               }
>         }
>
> -       if (!found)
> -               qd = NULL;
> -
>         spin_unlock(&qd_lock);
>
>         if (qd) {
> diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
> index 016ed1b2ca1d..2bb085a72e8e 100644
> --- a/fs/gfs2/recovery.c
> +++ b/fs/gfs2/recovery.c
> @@ -55,17 +55,16 @@ int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
>  int gfs2_revoke_add(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
>  {
>         struct list_head *head = &jd->jd_revoke_list;
> -       struct gfs2_revoke_replay *rr;
> -       int found = 0;
> +       struct gfs2_revoke_replay *rr = NULL, *iter;
>
> -       list_for_each_entry(rr, head, rr_list) {
> -               if (rr->rr_blkno == blkno) {
> -                       found = 1;
> +       list_for_each_entry(iter, head, rr_list) {
> +               if (iter->rr_blkno == blkno) {
> +                       rr = iter;
>                         break;
>                 }
>         }
>
> -       if (found) {
> +       if (rr) {
>                 rr->rr_where = where;
>                 return 0;
>         }
> @@ -83,18 +82,17 @@ int gfs2_revoke_add(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
>
>  int gfs2_revoke_check(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
>  {
> -       struct gfs2_revoke_replay *rr;
> +       struct gfs2_revoke_replay *rr = NULL, *iter;
>         int wrap, a, b, revoke;
> -       int found = 0;
>
> -       list_for_each_entry(rr, &jd->jd_revoke_list, rr_list) {
> -               if (rr->rr_blkno == blkno) {
> -                       found = 1;
> +       list_for_each_entry(iter, &jd->jd_revoke_list, rr_list) {
> +               if (iter->rr_blkno == blkno) {
> +                       rr = iter;
>                         break;
>                 }
>         }
>
> -       if (!found)
> +       if (!rr)
>                 return 0;
>
>         wrap = (rr->rr_where < jd->jd_replay_tail);
> --
> 2.25.1
>

Thanks,
Andreas

