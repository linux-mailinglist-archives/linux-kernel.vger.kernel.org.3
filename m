Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298EC520B66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiEJCo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiEJCoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 999679154C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652150458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=btuSt+eTiboN9EpYdhYjr//P8XlvonQ50rzV3e6NBaU=;
        b=TO1hx16UrxNuTF9+7/yp8CLSgdweQ7od1U6ld1WcSQifyBN6pkzb+0CzjKXQDnyLQIHkQV
        GLWW/+hdzOXs1Vs+M0MvYWh1LQsG6h7/8cy/4a8npCwLqINVvqcVr13NttE7fOCJp3Tpd+
        XZqqhXMnTvpKKv41fZw9xXyVohUVz9g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-jXuMnlcDMfSuyUWjFhGkdw-1; Mon, 09 May 2022 22:40:57 -0400
X-MC-Unique: jXuMnlcDMfSuyUWjFhGkdw-1
Received: by mail-lj1-f198.google.com with SMTP id x4-20020a05651c104400b0024f253d777fso4684099ljm.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 19:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btuSt+eTiboN9EpYdhYjr//P8XlvonQ50rzV3e6NBaU=;
        b=uw7dDhx8KmzPv2+IgCtDJMha9nvAM76aEGJimrLX8+Ltqpz7ntj1/D+BLc4E8gjFdU
         GlEe+bvfK6Hr81tr1GdyZWVPmfPK13X+NoJrGNekoQ4F9VrtN6R4lUWcfjq1826x5Eff
         q84yAACKDcD3P1/t+F84Y+pdm2uePnQdc1do2+kAaGIGifFyQK2VUkRJjnXspLhqMyqf
         jR+2W6sJLFvsWY3U8r20bdlWEkRvcKpGGwiTQwvgd9lrzQQhAPkzgtELATcw7CRU875a
         1xFFQXipORMoyaf2FsTyKwIANUKpW2ZzWVXNpbVfmk1KCrsqBhZBACRWQBwB8uaHi29Z
         7HwA==
X-Gm-Message-State: AOAM53006bARnKEaIsR9Nr1eqoqF75BQXi7hA3ULp7aXH4+BGuOTT4g4
        BZveukXzJ3YSOD83iagpBhZpQpywRFjVl+gCxskPrHdaqnqXJopPCHlELKjJbT+324U70+xd+Ht
        AKB2DcReWFGgeXENM3NYRl20dGKFBroyKmYHoICkw
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id h16-20020a19ca50000000b00471f556092bmr14762567lfj.587.1652150455983;
        Mon, 09 May 2022 19:40:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx466G++VqLk0Dv1De6DAfZjSjfHh3BKVNXytAvyofCCuDsxodfSwD1fVt/PLRyuQ58RkwsIcxETi0sYcfjero=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr14762559lfj.587.1652150455802; Mon, 09
 May 2022 19:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220508163317.204673-1-elic@nvidia.com> <20220508163317.204673-2-elic@nvidia.com>
In-Reply-To: <20220508163317.204673-2-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 10 May 2022 10:40:44 +0800
Message-ID: <CACGkMEs35nLewkMzP0p4mBHtiYb0DQaMmnG_EEpUad18ygnqxg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 12:33 AM Eli Cohen <elic@nvidia.com> wrote:
>
> In vdpa_nl_cmd_dev_get_doit(), ff the call to genlmsg_reply() fails we

I guess you mean "if" here?

> must not call nlmsg_free() since this is done inside genlmsg_reply().
>
> Fix it.
>
> Fixes: bc0d90ee021f ("vdpa: Enable user to query vdpa device info")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Other than the above typo.

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 2b75c00b1005..fac89a0d8178 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -756,14 +756,19 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
>                 goto mdev_err;
>         }
>         err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
> -       if (!err)
> -               err = genlmsg_reply(msg, info);
> +       if (err)
> +               goto mdev_err;
> +
> +       err = genlmsg_reply(msg, info);
> +       put_device(dev);
> +       mutex_unlock(&vdpa_dev_mutex);
> +       return err;
> +
>  mdev_err:
>         put_device(dev);
>  err:
>         mutex_unlock(&vdpa_dev_mutex);
> -       if (err)
> -               nlmsg_free(msg);
> +       nlmsg_free(msg);
>         return err;
>  }
>
> --
> 2.35.1
>

