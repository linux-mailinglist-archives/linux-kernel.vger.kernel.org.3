Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192AD5243F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbiELEOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346291AbiELEOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82AE31E3ED2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652328862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9w/GpJ1N6HGwjmzwJoNwiCf/tw4KuMbHGSJSHCRSnro=;
        b=eFx8Vr4ksX9TMxcRSFTl+pW+2XQUtXbJfVVj6dZZFoz/yAlGD+p9fMNltnM1T8LNmv/QPz
        FAoMSToJXxCvh8ghcWLWevAHu43tCVb3UrTAt07kJdyUBZ9JtlqKcNOrx7a5T/i7FY3cgb
        2/gMU1Qxx2OE/z/QCXHiNSpImGnrm1k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-Fy-jo839OzGQR2tLnb1zJQ-1; Thu, 12 May 2022 00:14:20 -0400
X-MC-Unique: Fy-jo839OzGQR2tLnb1zJQ-1
Received: by mail-lf1-f71.google.com with SMTP id v13-20020a056512096d00b004487e1503d0so1675064lft.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9w/GpJ1N6HGwjmzwJoNwiCf/tw4KuMbHGSJSHCRSnro=;
        b=JcthfC/npq92SKty3YfYNPBIAFDma+JrD3KNYWA6V8bqWi/qLZLZtUChadvmPylpXm
         8icfa5rr34WbN5zpS7xYNML5HUYU0f44ODWjlpb/RPXjq6NXYY4UCKplVVDZSRvm/QCK
         fuU6MEbKsPKc+Af1Xm17R9P9P2pZx+xxunWp0+aY2lQ67oOuiOIB6sFuETzOeVoZJSSl
         6dGJ+JibiU4LTrwS4fLSB64yVxahCyn8LkBKmzBOf/b8K7iziDYwlj4NvZQ2izkqOnng
         hC3pJycTeZSgJVbtnWuonfV0r4g/hp42Ek4SqlHIszVWAEBJXriiL6Ps3ou6YyUqBGYI
         RttQ==
X-Gm-Message-State: AOAM531P9z9h88HmMqVocXKi/DBGbqU+WYseNHjburm3k3yC1PXVRORK
        GHUyAP6YRDt3DDMqbMQqy4eXr3TN1fuS5BE5T6digPSylILITRtwsIj0El5GvXPfhQxMGI+CIYk
        fCyl/70fowQPbwGTqELfLKY8gnpql92B1dN0x6tg/
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id d16-20020a05651233d000b00473a25ef9fbmr22664784lfg.98.1652328858633;
        Wed, 11 May 2022 21:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMXxPJuzrxrW7rPQgvHxEyCXWglbIUuK3FJKZJOgp1haPDdHY13ozgrgj11nAGFj+mUN+TUiUyhdoWwaiIlSs=
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr22664768lfg.98.1652328858375; Wed, 11
 May 2022 21:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220511125845.1332586-1-elic@nvidia.com>
In-Reply-To: <20220511125845.1332586-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 12 May 2022 12:14:07 +0800
Message-ID: <CACGkMEtGvGM7JzP+xHZyxyOFL+wzLPa6-XgfOvM=1ZEf1NqKUg@mail.gmail.com>
Subject: Re: [PATCH] net/vdpa: Use reader/writers semaphore instead of mutex
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

On Wed, May 11, 2022 at 8:58 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Use rw_semaphore instead of mutex to control access to vdpa devices.
> This can be especially beneficial in case process poll on statistics
> information.
>
> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 64 ++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 0fb4a615f267..ced634f94f76 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -18,7 +18,7 @@
>
>  static LIST_HEAD(mdev_head);
>  /* A global mutex that protects vdpa management device and device level operations. */
> -static DEFINE_MUTEX(vdpa_dev_mutex);
> +static DECLARE_RWSEM(vdpa_dev_lock);
>  static DEFINE_IDA(vdpa_index_ida);
>
>  void vdpa_set_status(struct vdpa_device *vdev, u8 status)
> @@ -238,7 +238,7 @@ static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>
>         vdev->nvqs = nvqs;
>
> -       lockdep_assert_held(&vdpa_dev_mutex);
> +       lockdep_assert_held(&vdpa_dev_lock);
>         dev = bus_find_device(&vdpa_bus, NULL, dev_name(&vdev->dev), vdpa_name_match);
>         if (dev) {
>                 put_device(dev);
> @@ -278,9 +278,9 @@ int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>  {
>         int err;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>         err = __vdpa_register_device(vdev, nvqs);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(vdpa_register_device);
> @@ -293,7 +293,7 @@ EXPORT_SYMBOL_GPL(vdpa_register_device);
>   */
>  void _vdpa_unregister_device(struct vdpa_device *vdev)
>  {
> -       lockdep_assert_held(&vdpa_dev_mutex);
> +       lockdep_assert_held(&vdpa_dev_lock);
>         WARN_ON(!vdev->mdev);
>         device_unregister(&vdev->dev);
>  }
> @@ -305,9 +305,9 @@ EXPORT_SYMBOL_GPL(_vdpa_unregister_device);
>   */
>  void vdpa_unregister_device(struct vdpa_device *vdev)
>  {
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>         device_unregister(&vdev->dev);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>  }
>  EXPORT_SYMBOL_GPL(vdpa_unregister_device);
>
> @@ -352,9 +352,9 @@ int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev)
>                 return -EINVAL;
>
>         INIT_LIST_HEAD(&mdev->list);
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>         list_add_tail(&mdev->list, &mdev_head);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(vdpa_mgmtdev_register);
> @@ -371,14 +371,14 @@ static int vdpa_match_remove(struct device *dev, void *data)
>
>  void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev)
>  {
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>
>         list_del(&mdev->list);
>
>         /* Filter out all the entries belong to this management device and delete it. */
>         bus_for_each_dev(&vdpa_bus, NULL, mdev, vdpa_match_remove);
>
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>  }
>  EXPORT_SYMBOL_GPL(vdpa_mgmtdev_unregister);
>
> @@ -532,17 +532,17 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct sk_buff *skb, struct genl_info *i
>         if (!msg)
>                 return -ENOMEM;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
>         if (IS_ERR(mdev)) {
> -               mutex_unlock(&vdpa_dev_mutex);
> +               up_read(&vdpa_dev_lock);
>                 NL_SET_ERR_MSG_MOD(info->extack, "Fail to find the specified mgmt device");
>                 err = PTR_ERR(mdev);
>                 goto out;
>         }
>
>         err = vdpa_mgmtdev_fill(mdev, msg, info->snd_portid, info->snd_seq, 0);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         if (err)
>                 goto out;
>         err = genlmsg_reply(msg, info);
> @@ -561,7 +561,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>         int idx = 0;
>         int err;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         list_for_each_entry(mdev, &mdev_head, list) {
>                 if (idx < start) {
>                         idx++;
> @@ -574,7 +574,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>                 idx++;
>         }
>  out:
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         cb->args[0] = idx;
>         return msg->len;
>  }
> @@ -630,7 +630,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>             !netlink_capable(skb, CAP_NET_ADMIN))
>                 return -EPERM;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>         mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
>         if (IS_ERR(mdev)) {
>                 NL_SET_ERR_MSG_MOD(info->extack, "Fail to find the specified management device");
> @@ -650,7 +650,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>
>         err = mdev->ops->dev_add(mdev, name, &config);
>  err:
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>         return err;
>  }
>
> @@ -666,7 +666,7 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>                 return -EINVAL;
>         name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>         dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
>         if (!dev) {
>                 NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -684,7 +684,7 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>  mdev_err:
>         put_device(dev);
>  dev_err:
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>         return err;
>  }
>
> @@ -750,7 +750,7 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
>         if (!msg)
>                 return -ENOMEM;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>         if (!dev) {
>                 NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -768,13 +768,13 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
>
>         err = genlmsg_reply(msg, info);
>         put_device(dev);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         return err;
>
>  mdev_err:
>         put_device(dev);
>  err:
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         nlmsg_free(msg);
>         return err;
>  }
> @@ -816,9 +816,9 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>         info.start_idx = cb->args[0];
>         info.idx = 0;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_dump);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         cb->args[0] = info.idx;
>         return msg->len;
>  }
> @@ -1016,7 +1016,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>         if (!msg)
>                 return -ENOMEM;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>         if (!dev) {
>                 NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -1037,7 +1037,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>  mdev_err:
>         put_device(dev);
>  dev_err:
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         if (err)
>                 nlmsg_free(msg);
>         return err;
> @@ -1075,9 +1075,9 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>         info.start_idx = cb->args[0];
>         info.idx = 0;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_config_dump);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         cb->args[0] = info.idx;
>         return msg->len;
>  }
> @@ -1104,7 +1104,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>                 return -ENOMEM;
>
>         index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>         if (!dev) {
>                 NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -1124,7 +1124,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>         err = genlmsg_reply(msg, info);
>
>         put_device(dev);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>
>         return err;
>
> @@ -1132,7 +1132,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>         put_device(dev);
>  dev_err:
>         nlmsg_free(msg);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         return err;
>  }
>
> --
> 2.35.1
>

