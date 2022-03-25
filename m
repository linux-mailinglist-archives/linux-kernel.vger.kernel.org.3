Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2444E79A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377166AbiCYRHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376341AbiCYRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:07:31 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFC6E6158;
        Fri, 25 Mar 2022 10:05:53 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id d134so4273221ybc.13;
        Fri, 25 Mar 2022 10:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2ABLv19JiS78ES/UtJ3BIWAYEAvBaUS9WokW8BL62Y=;
        b=tKjVL39UVLMprkB1IDvY9gtsfJ0Kvh8yuMMXE2MZD2smPYH4fZnQQVmICeem7UnjEi
         mpFjlYg/hpef10guHCT1bx6yHNZksocINCjzRpoqOA3eo+w6qlIGXXt54Qw97PdoC6PM
         paSZUYg4t5P9cmB7dEFNT/MrThWPHtB9G/UKKrfhwhwrXSlQ8rbf1gyY96y2qOPUedqP
         pJR+o+dcU0wSLdBjbuATAqvUGRnJlUMkav1/sivdWwOot2xUWoMdqpsgkc3paTGG2OPv
         lpgL0mLSrImUyGLabPNsor1DUzSRmxiJj8CPpXL5/JF8LU6/OjkQ7Ku328vHEOt4+aW2
         VAbA==
X-Gm-Message-State: AOAM530MOdCyOjahoDPO9ugN7DgrA4DxVuWgVyMybE3yR4hENOtxELQQ
        UaXmJN6hKxvKtBZ2roq44QCIccJaAgj15K4nZ2o=
X-Google-Smtp-Source: ABdhPJxLJBlfF/OPan4uA6gXvJFdWQWEnbXPDjSmWmoWLdS88OS8oS7k4+T+GD4+8dPzQyZ5ZwXAyYAO83o1MNBll2g=
X-Received: by 2002:a25:6d05:0:b0:633:b0f5:6c1e with SMTP id
 i5-20020a256d05000000b00633b0f56c1emr11078175ybc.137.1648227952925; Fri, 25
 Mar 2022 10:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220324070441.56591-1-jakobkoschel@gmail.com>
In-Reply-To: <20220324070441.56591-1-jakobkoschel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Mar 2022 18:05:41 +0100
Message-ID: <CAJZ5v0h4xdKoH+Q7-J9d8KR1HZD1AaOgcZ4pUdXRsYGiC4HdUg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: ipmi: replace usage of found with dedicated list
 iterator variable
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 8:04 AM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
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
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/acpi/acpi_ipmi.c | 39 ++++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index a5fe2926bf50..0555f68c2dfd 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -353,29 +353,27 @@ static void ipmi_flush_tx_msg(struct acpi_ipmi_device *ipmi)
>  static void ipmi_cancel_tx_msg(struct acpi_ipmi_device *ipmi,
>                                struct acpi_ipmi_msg *msg)
>  {
> -       struct acpi_ipmi_msg *tx_msg, *temp;
> -       bool msg_found = false;
> +       struct acpi_ipmi_msg *tx_msg = NULL, *iter, *temp;
>         unsigned long flags;
>
>         spin_lock_irqsave(&ipmi->tx_msg_lock, flags);
> -       list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
> -               if (msg == tx_msg) {
> -                       msg_found = true;
> -                       list_del(&tx_msg->head);
> +       list_for_each_entry_safe(iter, temp, &ipmi->tx_msg_list, head) {
> +               if (msg == iter) {
> +                       tx_msg = iter;
> +                       list_del(&iter->head);
>                         break;
>                 }
>         }
>         spin_unlock_irqrestore(&ipmi->tx_msg_lock, flags);
>
> -       if (msg_found)
> +       if (tx_msg)
>                 acpi_ipmi_msg_put(tx_msg);
>  }
>
>  static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
>  {
>         struct acpi_ipmi_device *ipmi_device = user_msg_data;
> -       bool msg_found = false;
> -       struct acpi_ipmi_msg *tx_msg, *temp;
> +       struct acpi_ipmi_msg *tx_msg = NULL, *iter, *temp;
>         struct device *dev = ipmi_device->dev;
>         unsigned long flags;
>
> @@ -387,16 +385,16 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
>         }
>
>         spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
> -       list_for_each_entry_safe(tx_msg, temp, &ipmi_device->tx_msg_list, head) {
> -               if (msg->msgid == tx_msg->tx_msgid) {
> -                       msg_found = true;
> -                       list_del(&tx_msg->head);
> +       list_for_each_entry_safe(iter, temp, &ipmi_device->tx_msg_list, head) {
> +               if (msg->msgid == iter->tx_msgid) {
> +                       tx_msg = iter;
> +                       list_del(&iter->head);
>                         break;
>                 }
>         }
>         spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
>
> -       if (!msg_found) {
> +       if (!tx_msg) {
>                 dev_warn(dev,
>                          "Unexpected response (msg id %ld) is returned.\n",
>                          msg->msgid);
> @@ -482,15 +480,14 @@ static void ipmi_register_bmc(int iface, struct device *dev)
>
>  static void ipmi_bmc_gone(int iface)
>  {
> -       struct acpi_ipmi_device *ipmi_device, *temp;
> -       bool dev_found = false;
> +       struct acpi_ipmi_device *ipmi_device = NULL, *iter, *temp;
>
>         mutex_lock(&driver_data.ipmi_lock);
> -       list_for_each_entry_safe(ipmi_device, temp,
> +       list_for_each_entry_safe(iter, temp,
>                                  &driver_data.ipmi_devices, head) {
> -               if (ipmi_device->ipmi_ifnum != iface) {
> -                       dev_found = true;
> -                       __ipmi_dev_kill(ipmi_device);
> +               if (iter->ipmi_ifnum != iface) {
> +                       ipmi_device = iter;
> +                       __ipmi_dev_kill(iter);
>                         break;
>                 }
>         }
> @@ -500,7 +497,7 @@ static void ipmi_bmc_gone(int iface)
>                                         struct acpi_ipmi_device, head);
>         mutex_unlock(&driver_data.ipmi_lock);
>
> -       if (dev_found) {
> +       if (ipmi_device) {
>                 ipmi_flush_tx_msg(ipmi_device);
>                 acpi_ipmi_dev_put(ipmi_device);
>         }
>
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
> --

Applied as 5.18-rc material, thanks!
