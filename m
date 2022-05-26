Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D5534E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiEZLYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347143AbiEZLYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E968B69CEE
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653564276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHAlnYokbPDm5sHzersK7AiNCY1b15v1iGws20Njocw=;
        b=aVDAczMq9nRxOLYbwWDuqmBJIhqvC17XLoLFl1CkE3VEE3BJ+xxYYh6N41BkkwAUaJT+O5
        ur2j0bsELLMONzNNoVW8fpr3WKOEroC7aywhjT/SZIRieJ79i+45soj29BOW3i4FJZlOLv
        3TaNxFZODJP+3YUKr/jwGkuspAGVaug=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-BRl3iok8NLy-mC4kq65rAw-1; Thu, 26 May 2022 07:24:35 -0400
X-MC-Unique: BRl3iok8NLy-mC4kq65rAw-1
Received: by mail-wm1-f72.google.com with SMTP id u12-20020a05600c19cc00b0038ec265155fso2869857wmq.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rHAlnYokbPDm5sHzersK7AiNCY1b15v1iGws20Njocw=;
        b=akn2sozCxEsPX9N+fTSVunHzBbzJL2nOU+Hvspn0qRBXHdtufNx74g5aRIKszsLxIc
         OvAGzRPvX46V5XWoAaLh2ul3LrucDbL7WdglS1q+x44Sj2K7e/nMEYC0elPa0yCEH8cU
         8ouLdTrom8XrisPvSiuZ41TfZRC24rYIKiQF4u+4wGkkSqOmygddjLkYaa6Vd6M9AgNM
         4gGjwsVwUFg3hRJuuYdgs4GCaZ41pxY33u/Gm43VFBmPsNeAHrPlfCsv7MZX9rFCWBxy
         zqNXgGR2cFa8m3bRUPrwSVk2yv4xn864rF9L/2Iw9AQukyRJy2uc6RSzv2C0sE/D9Csh
         +Zfw==
X-Gm-Message-State: AOAM5325lSPXHclV5Oxgm/umTND6pMXkhcsD9LEp0yTauB2xfLdGGDA+
        b5A80TF95xxVxtYnFP3DDTiM6lPuCs8xzdX37V9m0GvxdFjP/CxzA/IK/2m66l9cD8phATZJaSX
        kOv69ghFn6UVlNiO5A5dcCdkG
X-Received: by 2002:adf:d1c6:0:b0:20f:c7dc:8466 with SMTP id b6-20020adfd1c6000000b0020fc7dc8466mr20941650wrd.43.1653564274204;
        Thu, 26 May 2022 04:24:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVhEt94v61sw8ti8f9sTXCoLOXwnzyGUf1wdEfVwHoxd1ZJYbH2PGE0KfqATe1+yEk07VXVQ==
X-Received: by 2002:adf:d1c6:0:b0:20f:c7dc:8466 with SMTP id b6-20020adfd1c6000000b0020fc7dc8466mr20941635wrd.43.1653564274009;
        Thu, 26 May 2022 04:24:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id z24-20020a7bc7d8000000b003974ba5cacdsm1570171wmk.35.2022.05.26.04.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:24:33 -0700 (PDT)
Message-ID: <081b216e6496e8cc2284df191dcc2d8b604d04f7.camel@redhat.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: fix potential double free in
 le_scan_cleanup()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 26 May 2022 13:24:32 +0200
In-Reply-To: <20220526094918.482971-1-niejianglei2021@163.com>
References: <20220526094918.482971-1-niejianglei2021@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-26 at 17:49 +0800, Jianglei Nie wrote:
> When "c == conn" is true, hci_conn_cleanup() is called. The
> hci_conn_cleanup() calls hci_dev_put() and hci_conn_put() in
> its function implementation. hci_dev_put() and hci_conn_put()
> will free the relevant resource if the reference count reaches
> zero, which may lead to a double free when hci_dev_put() and
> hci_conn_put() are called again.
> 
> We should add a return to this function after hci_conn_cleanup()
> is called.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  net/bluetooth/hci_conn.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index fe803bee419a..7b3e91eb9fa3 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -166,6 +166,7 @@ static void le_scan_cleanup(struct work_struct *work)
>  	if (c == conn) {
>  		hci_connect_le_scan_cleanup(conn);
>  		hci_conn_cleanup(conn);
> +		return;

This looks not correct. At very least you should release the
hci_dev_lock.

Cheers,

Paolo

