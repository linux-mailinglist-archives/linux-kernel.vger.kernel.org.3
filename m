Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3711522F77
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbiEKJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbiEKJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C2EF216043
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652261681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QX0Cj/+aTx+xhTnveWbfnDHJZzn7y8L+bKOgxixU/4k=;
        b=hDzlbyLm7GZXxGE9dBXfhEWibVha6WsU793sM/cXLarNEqKhP3wOY0LScjx28oJC7Q8oag
        OfLygSggYAi+ToworhliWbBASi05dFQCdjHFnQefBeCGTftpNesHW5giIAUpR+7jCONSxz
        k+y30tNTO4ZSdCvrna0ZcvhuOF58y1Y=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-b7KMcMagMZu-qRhuB-ZbNA-1; Wed, 11 May 2022 05:34:39 -0400
X-MC-Unique: b7KMcMagMZu-qRhuB-ZbNA-1
Received: by mail-lf1-f69.google.com with SMTP id h15-20020ac24daf000000b00472586ed83dso578706lfe.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QX0Cj/+aTx+xhTnveWbfnDHJZzn7y8L+bKOgxixU/4k=;
        b=fS7Ue9z52as4HOs98pT7lBI0u8xSEcYCpftDEzlHZNKGLXYRbgYDSB/imO1cc6xMFr
         y62FPFmjDuvSWHi8qyNaRl12eTK3RaEHgXSbg+00jWdul1hh6JUd3GTjdPvcUacj3X6P
         iIVn/LNtR58MAj/5+TbPBJlQrO086XDEtudIu3FrGPNOT2dgu6V+YGtKpBX8cFL7B1hA
         zUoxYLtGjMUj+tyMD7VMjE0WmTWdxLquggW7ShSk5fCK9xxLg/KjYfT6p+tTbjTlOqFf
         TBt7vrL4UD4um0byfV2disaYdKQaAMYFb3u7mxMJcdDsqGsnhi5MFzgpIxtQigvMe67M
         Wbug==
X-Gm-Message-State: AOAM5314E8vuQWiK8Y2R34ulG2rVVUi0iLuf9drbBp6X9CkPi41A7DZG
        SOEc3UZll5bQtYLYnCtwUjXQtomKWTihrq1ZwtbCqj0sXcJekyGfwa398IFNJsqT8VI6tvOxQmu
        aZy6MHfgLzAr2xlmoKG17JVyxihpeLJRoKnQBuISx
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id e20-20020ac24e14000000b004741f4d9b86mr12529118lfr.257.1652261678188;
        Wed, 11 May 2022 02:34:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwSR3boxqB9WdjMa8GSORmdjNZKJuW9jsa+GGmDPHgBa8GPteEbR7AZJKTagjR6DSaEVD6g/u41NoP+SGevjE=
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id
 e20-20020ac24e14000000b004741f4d9b86mr12529040lfr.257.1652261676518; Wed, 11
 May 2022 02:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220511084804.82482-1-elic@nvidia.com>
In-Reply-To: <20220511084804.82482-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 11 May 2022 17:34:25 +0800
Message-ID: <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Warn if MTU configured is too low
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

On Wed, May 11, 2022 at 4:48 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Following the recommendation in virio spec 1.1, a device offering
> VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
>
> Print a warning if this recommendation is not met.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

I wonder why it's a must?

> ---
>  drivers/vdpa/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 91f4c13c7c7c..961168fe9094 100644
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

Should be <= ?

Thanks

> +               pr_warn("MTU is below recommended value\n");
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

