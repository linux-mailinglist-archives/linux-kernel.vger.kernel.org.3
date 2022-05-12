Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A73524400
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbiELERG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbiELERE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 201161F68E5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652329022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nWbAcC5FNfHptQ9LOrLEmiCRoHP7fuwDJCSDzfJtlPs=;
        b=GLgyfEtcXgeTZ7mqe0xSyYnC5H/Xi2K1YrC2JHlZHCypvGCIEIBAAMBJmjtrD7KyASm6UC
        T+iRHX7K9p3VAR+nR3M4sQaK0Mi8CPio+a5pvfAs0xjrv1CavXLMZh0iqelrOmJlXAJnjy
        gp2rwixF9yPXxc9zYSQUBea+phfzffU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-6KpDr2neOyuFe9-8RFXUiA-1; Thu, 12 May 2022 00:17:00 -0400
X-MC-Unique: 6KpDr2neOyuFe9-8RFXUiA-1
Received: by mail-lj1-f198.google.com with SMTP id m5-20020a2e8705000000b0024f0fca4516so1199295lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWbAcC5FNfHptQ9LOrLEmiCRoHP7fuwDJCSDzfJtlPs=;
        b=AhRyP7PIzG6duQB5p7+n3iwvcKcv558b7le7fm6x4i0TlG2vlQDGU16WvGeOMMoImS
         vqpf9ljJKVrTk09e6vSm5o7ROi0KEwxYQr+8XDqYwtaMkqLCLGuylof+lXwI+6yNmFF0
         3cgDqOxgfvtRq71rZpTkTHSl9+xpmyPKAU2mxbRNRui+NSxorEXSiEv0xR+KUJazl68P
         pW4X4oVJO4oTVsBNVDiESaIzEis+ASc0QoByW2MfNdTCoZnbcFB3ZdBWy9iaxUXS7m6l
         RQg1nTQwZpRQP2H5u9ExfNlSPociG4j4e0joA//jMPVxtidflk8UoSpxmjDYbY2ZEqJR
         yiJw==
X-Gm-Message-State: AOAM531IkKDK8xLzjbUUqnT9JQgt5z7LCQyJ+sqJ/G/wC9BloH+6lvch
        lntXmKqGteCK9DDuzRqqCvikBZW/GBFQNsOAxDTCp4hqdL6fqWC+eTbe87S6gwphLivn5muU5R/
        DbC0tsYY/O0ZjJNGN+SbdLHDu4iLZnh8T+sqgST9Y
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id h16-20020a19ca50000000b00471f556092bmr22275121lfj.587.1652329018950;
        Wed, 11 May 2022 21:16:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqLAe52aFmtc+0GRPlfXryAbcmK9F8xqKCqbMEXRgK+5kNtP1dCuwfUe4PS/JXUaam3EoOd/RiICH6rsBNVb0=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr22275113lfj.587.1652329018751; Wed, 11
 May 2022 21:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220511105642.124806-1-elic@nvidia.com>
In-Reply-To: <20220511105642.124806-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 12 May 2022 12:16:47 +0800
Message-ID: <CACGkMEv2FGZ3na_HpAWorjBPN1vSp4_pmjz0s9O_hOoSihCL-w@mail.gmail.com>
Subject: Re: [PATCH v1] vdpa: Warn if MTU configured is too low
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

On Wed, May 11, 2022 at 6:56 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Following the recommendation in virio spec 1.1, a device offering
> VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
>
> Print a warning if this recommendation is not met.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 -> v1:
>   chage pr_warn to netlink warning to userspace
>
>  drivers/vdpa/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 91f4c13c7c7c..0fb4a615f267 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -583,6 +583,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
>                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>
> +/* Recommended virtio spec 1.1 section 5.1.4.1 */
> +#define VIRTIO_MIN_PREFERRED_MTU 1280
> +
>  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>         struct vdpa_dev_set_config config = {};
> @@ -634,6 +637,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>                 err = PTR_ERR(mdev);
>                 goto err;
>         }
> +       if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MTU)) &&
> +           (config.mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) &&
> +           config.net.mtu < VIRTIO_MIN_PREFERRED_MTU))
> +               NL_SET_ERR_MSG_MOD(info->extack, "MTU is below recommended value\n");

Can this function be used for warning? I have a quick cscope that
tells me it's probably used only for error.

Will it be better if we fail only when the device supports VERSION_1?

Thanks

>         if ((config.mask & mdev->config_attr_mask) != config.mask) {
>                 NL_SET_ERR_MSG_MOD(info->extack,
>                                    "All provided attributes are not supported");
> @@ -1135,7 +1142,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
>         [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> -       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, ETH_MIN_MTU),
>  };
>
>  static const struct genl_ops vdpa_nl_ops[] = {
> --
> 2.35.1
>

