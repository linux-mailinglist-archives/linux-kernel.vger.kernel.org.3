Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBF84C0E79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbiBWItu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbiBWItr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEB386D961
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645606159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZO5iPLXZh9/zLU63MqNpGXlDn4/4qG+Ki+TYrCOa5pI=;
        b=hg95z9yYQnX7NNj7nTdofd6t4XjNd+rhFvAtXx54Tw1Q+KX0+q2LiNdvWYp/LcwRzBOGrQ
        2RvNPpnXkLvJ1ah+BWTI5xhoFtipOqzBdPCCH1VYScNP+uvmrqSDZwanCJ/lJR8a0fOz1f
        Ux8f+IqyC2eerv4iNN7wsaDvV0HAeXs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-BpCnMQ_qNiqeAYHVkl21UA-1; Wed, 23 Feb 2022 03:49:18 -0500
X-MC-Unique: BpCnMQ_qNiqeAYHVkl21UA-1
Received: by mail-wm1-f70.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1510758wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZO5iPLXZh9/zLU63MqNpGXlDn4/4qG+Ki+TYrCOa5pI=;
        b=XycszglEAoJzrbCq4uVhmTBbsYNEgw8XrmhbjVwK3XLZMsws2JqoLkQ88qKzmollbP
         iRe7tiFbKStvGwxooaeTbFqWKgg0p7IUPQiRk0yzemft8lmsbS6lwKPySoCI6/R2mpEu
         lDN+fSI26dYYMYbfdQs2BjgKGwkQYqwq3rG28HhXN7wQSvLVr8CMprcRf5t+s6mxr/hf
         eiEQSD0AJfEEDYb3xl6Jsox5qwLG69j8AwZCeygbxuESWCwOhCT8aurU6Z5eZw30yLlk
         XpUTjh2cNgQm92FFDyhzDgy2fnG/kOJLnJwinXSFUqBGm27DoIwf97BXERck1ht/pk2w
         83AA==
X-Gm-Message-State: AOAM5336Md9Q0ilem6LKpK2nBNyveMTXtZG/w07LTsbu/KJ6SzG8G9WC
        g3Z3Rm74O7jY4izM+v/+XszVMtcwyBv+HcfWZ6HcVRZjsKjOuOZ29Y4YruUWfJlPbW7+yf9bMYv
        c22MFjwWH6McGZETRfvWXHpzb
X-Received: by 2002:a05:6000:1186:b0:1ea:9a78:78a4 with SMTP id g6-20020a056000118600b001ea9a7878a4mr4453068wrx.361.1645606157330;
        Wed, 23 Feb 2022 00:49:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvaeljVatnfPsgwHaBTLl8rvsOMDo5gP30pl/GDOr4cTERUfFiyl6ovTLMjJjuFpG4h7/1KQ==
X-Received: by 2002:a05:6000:1186:b0:1ea:9a78:78a4 with SMTP id g6-20020a056000118600b001ea9a7878a4mr4453054wrx.361.1645606157094;
        Wed, 23 Feb 2022 00:49:17 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q2sm53789345wrw.14.2022.02.23.00.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 00:49:16 -0800 (PST)
Message-ID: <88d84e26-9b8c-443d-ebe7-7a7c92f2b595@redhat.com>
Date:   Wed, 23 Feb 2022 09:49:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] debugfs: Document that debugfs_create functions need not
 be error checked
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220222154555.1.I26d364db7a007f8995e8f0dac978673bc8e9f5e2@changeid>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220222154555.1.I26d364db7a007f8995e8f0dac978673bc8e9f5e2@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello Doug,

On 2/23/22 00:46, Douglas Anderson wrote:
> As talked about in commit b792e64021ec ("drm: no need to check return
> value of debugfs_create functions"), in many cases we can get away
> with totally skipping checking the errors of debugfs functions. Let's
> document that so people don't add new code that needlessly checks
> these errors.
> 
> Probably this note could be added to a boatload of functions, but
> that's a lot of duplication.  Let's just add it to the two most
> frequent ones and hope people will get the idea.
> 

Agreed. The first contact point for folks looking for the function's
return values will probably be these two, I second that is enough.

> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  fs/debugfs/inode.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 2f117c57160d..3dcf0b8b4e93 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -450,6 +450,11 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
>   *
>   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
> + *
> + * NOTE: it's expected that most callers should _ignore_ the errors returned
> + * by this function. Other debugfs functions handle the fact that the "dentry"
> + * passed to them could be an error and they don't crash in that case.
> + * Drivers should generally work fine even if debugfs fails to init anyway.
>   */

Thanks a lot for adding this. I was confused why the kernel doc didn't mention
anything like that, yet most drivers didn't check and just ignored the errors.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

