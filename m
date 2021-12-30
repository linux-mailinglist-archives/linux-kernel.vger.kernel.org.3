Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307C8481F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbhL3SeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:34:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241698AbhL3SeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640889254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIGwMr+PvmyXXqjC3pPNsZTdUcIdkSnzJcVmxj7v5XY=;
        b=NpVgyUunl02nUhd5eoqKWhBUu1VMaGcnOi7r1X/3gDIjNxNXWSfotCJd9bHGcollWP/O7j
        xTaz606x2+wJpnN953rNm3emI58trPCSA44QBALzXdDiYhxKfFlcy+YUFd1zMtgZrhgHUt
        GSQflX/zwvwJTRyYttCdyiS/QlTXPqI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-UxHbCXTsNxaHq1mw9GiV1Q-1; Thu, 30 Dec 2021 13:34:12 -0500
X-MC-Unique: UxHbCXTsNxaHq1mw9GiV1Q-1
Received: by mail-ed1-f71.google.com with SMTP id w6-20020a05640234c600b003f916e1b615so8363550edc.17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FIGwMr+PvmyXXqjC3pPNsZTdUcIdkSnzJcVmxj7v5XY=;
        b=GOZ5RbEwjeblw4So514ibzCssLm2zidjCMv85C/GkPJLvDB1qrKUCt/OCxePN71GIO
         Ze6bgpE3wAbklNbf7XvVAXKMkguPFLlcJdzZn4MZUUJLivQnjPqVZig56/iRg0QbsCZ+
         Cy5yDmG8mPvzK7wKrC/29UN7V72KigTGrdTG8xmRIWHUJH0dm2glAY2XzEPXG1gyI/EE
         wYN1Q/KEcoH/Qd8/Gm74T6VAaOv2k/N9HxDiG9EAVN3hlQ8kUgR1ertBxNLV4t6uPpb3
         RHMvyIRPNPRwF4W9MkWv6849xBCs+j8HN3rsUOJL1cu30hlcdZODY2eFRPT/4FX0q8C0
         Ps/g==
X-Gm-Message-State: AOAM533l1AawP6UA0R9n450YTGw/ziNzw95v5lf2kgpTzG002goASpko
        M+2+dXbRXimdCwruu8u+NNj9UyzQXFeZ72lZvEDby9LJkoQ51nwk+yporUyKvtjUDPxAb1oiKw9
        xRs8ZT03YBn1jVE2UiOiTfLhP
X-Received: by 2002:a17:906:c147:: with SMTP id dp7mr25414293ejc.173.1640889251756;
        Thu, 30 Dec 2021 10:34:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxifA6H+4QTxin7cYDQI5pp+iHVtSBrm3OLfoZZKSi9zPQD+E8lr1XfGFEkTnOUbCyH4Oa+pg==
X-Received: by 2002:a17:906:c147:: with SMTP id dp7mr25414275ejc.173.1640889251529;
        Thu, 30 Dec 2021 10:34:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id ho9sm7846191ejc.86.2021.12.30.10.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 10:34:11 -0800 (PST)
Message-ID: <f47f24a1-bd34-4a30-959f-962c9df6afc6@redhat.com>
Date:   Thu, 30 Dec 2021 19:34:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] x86/platform/uv: use default_groups in kobj_type
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Justin Ernst <justin.ernst@hpe.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <20211229141332.2552428-1-gregkh@linuxfoundation.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211229141332.2552428-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/29/21 15:13, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the uv sysfs code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: Justin Ernst <justin.ernst@hpe.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/uv_sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
> index 956a354b57c1..625b0b79d185 100644
> --- a/drivers/platform/x86/uv_sysfs.c
> +++ b/drivers/platform/x86/uv_sysfs.c
> @@ -175,6 +175,7 @@ static struct attribute *uv_hub_attrs[] = {
>  	&cnode_attribute.attr,
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(uv_hub);
>  
>  static void hub_release(struct kobject *kobj)
>  {
> @@ -205,7 +206,7 @@ static const struct sysfs_ops hub_sysfs_ops = {
>  static struct kobj_type hub_attr_type = {
>  	.release	= hub_release,
>  	.sysfs_ops	= &hub_sysfs_ops,
> -	.default_attrs	= uv_hub_attrs,
> +	.default_groups	= uv_hub_groups,
>  };
>  
>  static int uv_hubs_init(void)
> @@ -327,6 +328,7 @@ static struct attribute *uv_port_attrs[] = {
>  	&uv_port_conn_port_attribute.attr,
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(uv_port);
>  
>  static void uv_port_release(struct kobject *kobj)
>  {
> @@ -357,7 +359,7 @@ static const struct sysfs_ops uv_port_sysfs_ops = {
>  static struct kobj_type uv_port_attr_type = {
>  	.release	= uv_port_release,
>  	.sysfs_ops	= &uv_port_sysfs_ops,
> -	.default_attrs	= uv_port_attrs,
> +	.default_groups	= uv_port_groups,
>  };
>  
>  static int uv_ports_init(void)
> 

