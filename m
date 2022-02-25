Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FB44C40D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiBYJBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiBYJBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:01:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FDDD23532A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645779639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yjsnjHpaBinX7MM5tJ9UIuWndzGDnQagKF9W18KWAaQ=;
        b=W0UXWFj/2+iK+gUGvD2iJU68plELZwPkMMtTbE9Luldxy1kBX6/TgZ3jY+J5toCUmRT7jv
        hUFYftt7CcMDjcCnKcDHOcdYpi2GgXNwFIPI9P8zRccv+cplKrBdyxPIlY6XiYFMdlKyuF
        BEq4MOJG46F/B3kMPdqw0PjL99i4Vgs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-5NjlxOZSOZ-VwkrKJwLN-Q-1; Fri, 25 Feb 2022 04:00:31 -0500
X-MC-Unique: 5NjlxOZSOZ-VwkrKJwLN-Q-1
Received: by mail-ej1-f71.google.com with SMTP id nb1-20020a1709071c8100b006d03c250b6fso2353443ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yjsnjHpaBinX7MM5tJ9UIuWndzGDnQagKF9W18KWAaQ=;
        b=APANYb68tMY3D8tGGFsg05PKTbSMD9H/XTYAQxdeaf7M147RJFuvONZKmz/WXGQOfF
         r9I0FmzYp0io5m897bXONqFEm2NSbPksqG0dGA2GLa/eAUohRwedYDUVhg4vdfGYK5xX
         zCYFnmLzVa2q4JT0TaQtWqy5nQNphxaeeHh/twldoQICVpaR70mkQ/8Gj1/vzcGi4Yr5
         6bgOfZh8VgSqBkkbz3GagyBUDqvYIkiz7atLkHmAQ9X+4X71+Zcdm6eTKXMRHDcYQ5LQ
         Ntn7ZGA6yPr5WErag3PjrpM2qv24ZqmhvXVJw7cYdd57izVf0+CrQ31pzI5ZQ47hFyBm
         gWsQ==
X-Gm-Message-State: AOAM533J1xzMBLN3jsgVfZGTNPpHPGurbgSnLo2e0qVnszGdupFjUv+x
        qXK1cRijf4wXHUgpfkKNivz/rUNb54BpjSuems0TCU4d+utPFBAdT7+H2KjWnTw5CpfnZ/mS2za
        lyzK2j4wrcGRmpZKd+TksSfB/
X-Received: by 2002:a50:fb02:0:b0:40f:bd67:205f with SMTP id d2-20020a50fb02000000b0040fbd67205fmr6114527edq.409.1645779629515;
        Fri, 25 Feb 2022 01:00:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqPkrTdXWxgM2d4HfcORxPA8W/xV9csIqTFM/hA1TMDU87hzFU52NpcBYCM0EtftCxzGa5oA==
X-Received: by 2002:a50:fb02:0:b0:40f:bd67:205f with SMTP id d2-20020a50fb02000000b0040fbd67205fmr6114507edq.409.1645779629294;
        Fri, 25 Feb 2022 01:00:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402078700b0041290431e83sm995760edy.108.2022.02.25.01.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 01:00:28 -0800 (PST)
Message-ID: <f93673f6-4035-f877-43b6-84510698960a@redhat.com>
Date:   Fri, 25 Feb 2022 10:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: platform/x86: Add Intel Software Defined Silicon driver
Content-Language: en-US
To:     "Colin King (gmail)" <colin.i.king@gmail.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <13f987a0-197a-d0db-6f97-c7358d4723da@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <13f987a0-197a-d0db-6f97-c7358d4723da@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/24/22 23:25, Colin King (gmail) wrote:
> Hi,
> 
> Static analysis with clang scan has detected a potential issue in the following commit:
> 
> commit 2546c60004309ede8e2d1d5341e0decd90e057bf
> Author: David E. Box <david.e.box@linux.intel.com>
> Date:   Fri Feb 11 17:32:50 2022 -0800
> 
>     platform/x86: Add Intel Software Defined Silicon driver
> 
> The issue is as follows:
> 
> static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, size_t *data_size)
> {
>         int ret;
> 
>         lockdep_assert_held(&priv->mb_lock);
> 
>         ret = sdsi_mbox_acquire(priv, info);
>         if (ret)
>                 return ret;
> 
> Note: the return above does not assign a value to *data_size

And in this return ret != 0, so we have size==not-set, ret!=0

>         return sdsi_mbox_cmd_read(priv, info, data_size);
> }
> 
> 
> static long state_certificate_read(struct file *filp, struct kobject *kobj,
>                                    struct bin_attribute *attr, char *buf, loff_t off,
>                                    size_t count)
> {
>         struct device *dev = kobj_to_dev(kobj);
>         struct sdsi_priv *priv = dev_get_drvdata(dev);
>         u64 command = SDSI_CMD_READ_STATE;
>         struct sdsi_mbox_info info;
>         size_t size;
>                ^
> Note: size is not initialized
> 
>         int ret;
> 
>         if (!priv->sdsi_enabled)
>                 return -EPERM;
> 
>         if (off)
>                 return 0;
> 
>         /* Buffer for return data */
>         info.buffer = kmalloc(SDSI_SIZE_READ_MSG, GFP_KERNEL);
>         if (!info.buffer)
>                 return -ENOMEM;
> 
>         info.payload = &command;
>         info.size = sizeof(command);
> 
>         ret = mutex_lock_interruptible(&priv->mb_lock);
>         if (ret)
>                 goto free_buffer;
>         ret = sdsi_mbox_read(priv, &info, &size);
> 
> Note: a failure in scsi_mbox_read can lead to variable size not being assigned a value.

Right if that is true then the following still holds:

size==not-set, ret!=0

> 
>         mutex_unlock(&priv->mb_lock);
>         if (ret < 0)
>                 goto free_buffer;
> 
> Note: failure with ret < 0 going to free_buffer
> 
>         if (size > count)
>                 size = count;
> 
>         memcpy(buf, info.buffer, size);
> 
> free_buffer:
>         kfree(info.buffer);
> 
>         if (ret)
>                 return ret;

This is still valid here: size==not-set, ret!=0

so we hit the true path of the if and return ret, not size.

Regards,

Hans


> 
>         return size;
> 
> Note: uninitialized value in size being returned. This is an error.
> 
> }
> 

