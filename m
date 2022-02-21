Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5604BE54F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350205AbiBUJb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:31:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350325AbiBUJW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:22:26 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E2638785
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:09:54 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id h9so30486142qvm.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6EQDaBYYRWCb4oKT3vUObC3Be0bsFP7kZxVaalF3tc=;
        b=Cczgnc3hB0XtCzfgl7LdCO6WUTg9u2Fsi9YsLmQEJB899o45iwZ4tZwnEQcbietqoC
         e/2+bGj0AovnQ4uDXMONdl/ODnzegfoDjW7/BVnikZPjb4gy62+wQapqK3oZMeYKI5qN
         6Tz7eMuSQG/xcbFcEQGzFOIoyPrl5Q/fV25t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6EQDaBYYRWCb4oKT3vUObC3Be0bsFP7kZxVaalF3tc=;
        b=qkERubR3UM5Rk+NMI4tXm5iOpvrBVUc+t1oAatzGto+PqSJSg8+13OOzYNc6hIT4Ic
         Wx7af7HMZzNY+dkHk7K5j6x6hOtRAPp3Ir5IsLB1YTwdbUmoWWQdGWUyrp8FGEjgT/pR
         Mgbts7C7eH33ovv0KwEfUEyadUbSWMif1iFp/N0eZxmmLfykvgf1gdlHfSpSAtn/36Lb
         yebnqXikRUJXGZ7vhXuzm9Q8dHpFqIjchZ6R0c5Dl4lrB88dijYEDKJxqfINTa6R8Mi+
         LNchl0TIBj6YCscuTqPMmjz47JzaQ8ekoiDfNa6wT53xv9wKavIReIPI2fCt+dnO70ww
         rmTA==
X-Gm-Message-State: AOAM5336vW8oUz2Fwh2CRTB2A9JnDhiZZVd7qhheNYOjRKZ1iXJgsiQN
        2mFFSPWEviTSowVsi3Zhz7OWwoXzrfWwtnBQ5OfXnLUBNpc=
X-Google-Smtp-Source: ABdhPJwNfRrnlsfOC2RtSKZjqfK6d/2Zwn+FNsucSttU93RuMNvEAh9qxL07IhQwvjKDaqbtTvVWeo2SbpF+FCS+VI8=
X-Received: by 2002:a05:622a:1b8d:b0:2c6:59a9:360e with SMTP id
 bp13-20020a05622a1b8d00b002c659a9360emr16559597qtb.678.1645434593594; Mon, 21
 Feb 2022 01:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20220207161640.35605-1-eajames@linux.ibm.com>
In-Reply-To: <20220207161640.35605-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Feb 2022 09:09:40 +0000
Message-ID: <CACPK8XeGyGdVw-KzdCXD_JAL3Qymp_hY-v4pqP9GtxjpQ7G5rw@mail.gmail.com>
Subject: Re: [PATCH] fsi: Add trace events in initialization path
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Jeremy Kerr <jk@ozlabs.org>, Ingo Molnar <mingo@redhat.com>,
        Alistair Popple <alistair@popple.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 at 16:17, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add definitions for trace events to show the scanning flow.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Thanks Eddie. I've applied this with Steven's r-b.

> ---
>  drivers/fsi/fsi-core.c                   | 11 ++-
>  drivers/fsi/fsi-master-aspeed.c          |  2 +
>  include/trace/events/fsi.h               | 86 ++++++++++++++++++++++++
>  include/trace/events/fsi_master_aspeed.h | 12 ++++
>  4 files changed, 108 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 59ddc9fd5bca..3a7b78e36701 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -24,9 +24,6 @@
>
>  #include "fsi-master.h"
>
> -#define CREATE_TRACE_POINTS
> -#include <trace/events/fsi.h>
> -
>  #define FSI_SLAVE_CONF_NEXT_MASK       GENMASK(31, 31)
>  #define FSI_SLAVE_CONF_SLOTS_MASK      GENMASK(23, 16)
>  #define FSI_SLAVE_CONF_SLOTS_SHIFT     16
> @@ -95,6 +92,9 @@ struct fsi_slave {
>         u8                      t_echo_delay;
>  };
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/fsi.h>
> +
>  #define to_fsi_master(d) container_of(d, struct fsi_master, dev)
>  #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
>
> @@ -524,6 +524,8 @@ static int fsi_slave_scan(struct fsi_slave *slave)
>                         dev->addr = engine_addr;
>                         dev->size = slots * engine_page_size;
>
> +                       trace_fsi_dev_init(dev);
> +
>                         dev_dbg(&slave->dev,
>                         "engine[%i]: type %x, version %x, addr %x size %x\n",
>                                         dev->unit, dev->engine_type, version,
> @@ -1006,6 +1008,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
>
>         crc = crc4(0, cfam_id, 32);
>         if (crc) {
> +               trace_fsi_slave_invalid_cfam(master, link, cfam_id);
>                 dev_warn(&master->dev, "slave %02x:%02x invalid cfam id CRC!\n",
>                                 link, id);
>                 return -EIO;
> @@ -1080,6 +1083,8 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
>         if (rc)
>                 goto err_free;
>
> +       trace_fsi_slave_init(slave);
> +
>         /* Create chardev for userspace access */
>         cdev_init(&slave->cdev, &cfam_fops);
>         rc = cdev_device_add(&slave->cdev, &slave->dev);
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 0bed2fab8055..7cec1772820d 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -449,11 +449,13 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
>  {
>         struct fsi_master_aspeed *aspeed = dev_get_drvdata(dev);
>
> +       trace_fsi_master_aspeed_cfam_reset(true);
>         mutex_lock(&aspeed->lock);
>         gpiod_set_value(aspeed->cfam_reset_gpio, 1);
>         usleep_range(900, 1000);
>         gpiod_set_value(aspeed->cfam_reset_gpio, 0);
>         mutex_unlock(&aspeed->lock);
> +       trace_fsi_master_aspeed_cfam_reset(false);
>
>         return count;
>  }
> diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
> index 9832cb8e0eb0..c9a72e8432b8 100644
> --- a/include/trace/events/fsi.h
> +++ b/include/trace/events/fsi.h
> @@ -122,6 +122,92 @@ TRACE_EVENT(fsi_master_break,
>         )
>  );
>
> +TRACE_EVENT(fsi_slave_init,
> +       TP_PROTO(const struct fsi_slave *slave),
> +       TP_ARGS(slave),
> +       TP_STRUCT__entry(
> +               __field(int,    master_idx)
> +               __field(int,    master_n_links)
> +               __field(int,    idx)
> +               __field(int,    link)
> +               __field(int,    chip_id)
> +               __field(__u32,  cfam_id)
> +               __field(__u32,  size)
> +       ),
> +       TP_fast_assign(
> +               __entry->master_idx = slave->master->idx;
> +               __entry->master_n_links = slave->master->n_links;
> +               __entry->idx = slave->cdev_idx;
> +               __entry->link = slave->link;
> +               __entry->chip_id = slave->chip_id;
> +               __entry->cfam_id = slave->cfam_id;
> +               __entry->size = slave->size;
> +       ),
> +       TP_printk("fsi%d: idx:%d link:%d/%d cid:%d cfam:%08x %08x",
> +               __entry->master_idx,
> +               __entry->idx,
> +               __entry->link,
> +               __entry->master_n_links,
> +               __entry->chip_id,
> +               __entry->cfam_id,
> +               __entry->size
> +       )
> +);
> +
> +TRACE_EVENT(fsi_slave_invalid_cfam,
> +       TP_PROTO(const struct fsi_master *master, int link, uint32_t cfam_id),
> +       TP_ARGS(master, link, cfam_id),
> +       TP_STRUCT__entry(
> +               __field(int,    master_idx)
> +               __field(int,    master_n_links)
> +               __field(int,    link)
> +               __field(__u32,  cfam_id)
> +       ),
> +       TP_fast_assign(
> +               __entry->master_idx = master->idx;
> +               __entry->master_n_links = master->n_links;
> +               __entry->link = link;
> +               __entry->cfam_id = cfam_id;
> +       ),
> +       TP_printk("fsi%d: cfam:%08x link:%d/%d",
> +               __entry->master_idx,
> +               __entry->cfam_id,
> +               __entry->link,
> +               __entry->master_n_links
> +       )
> +);
> +
> +TRACE_EVENT(fsi_dev_init,
> +       TP_PROTO(const struct fsi_device *dev),
> +       TP_ARGS(dev),
> +       TP_STRUCT__entry(
> +               __field(int,    master_idx)
> +               __field(int,    link)
> +               __field(int,    type)
> +               __field(int,    unit)
> +               __field(int,    version)
> +               __field(__u32,  addr)
> +               __field(__u32,  size)
> +       ),
> +       TP_fast_assign(
> +               __entry->master_idx = dev->slave->master->idx;
> +               __entry->link = dev->slave->link;
> +               __entry->type = dev->engine_type;
> +               __entry->unit = dev->unit;
> +               __entry->version = dev->version;
> +               __entry->addr = dev->addr;
> +               __entry->size = dev->size;
> +       ),
> +       TP_printk("fsi%d: slv%d: t:%02x u:%02x v:%02x %08x@%08x",
> +               __entry->master_idx,
> +               __entry->link,
> +               __entry->type,
> +               __entry->unit,
> +               __entry->version,
> +               __entry->size,
> +               __entry->addr
> +       )
> +);
>
>  #endif /* _TRACE_FSI_H */
>
> diff --git a/include/trace/events/fsi_master_aspeed.h b/include/trace/events/fsi_master_aspeed.h
> index a355ceacc33f..0fff873775f1 100644
> --- a/include/trace/events/fsi_master_aspeed.h
> +++ b/include/trace/events/fsi_master_aspeed.h
> @@ -72,6 +72,18 @@ TRACE_EVENT(fsi_master_aspeed_opb_error,
>                 )
>         );
>
> +TRACE_EVENT(fsi_master_aspeed_cfam_reset,
> +       TP_PROTO(bool start),
> +       TP_ARGS(start),
> +       TP_STRUCT__entry(
> +               __field(bool,   start)
> +       ),
> +       TP_fast_assign(
> +               __entry->start = start;
> +       ),
> +       TP_printk("%s", __entry->start ? "start" : "end")
> +);
> +
>  #endif
>
>  #include <trace/define_trace.h>
> --
> 2.27.0
>
