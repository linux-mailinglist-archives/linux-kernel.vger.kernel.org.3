Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1085576DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiFWJmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiFWJmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E73654991E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655977370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtCRYQelrWKnz3SabeELJkqPRwIFLNLfCWPVojFD6BI=;
        b=gGxsFcUW8eY+aT3mqO9IIa00LmDUZPTWiRD7gp1XWEWh6YV9CkFgEydL2xSdt8FBFKOKn9
        KAwAMAGHI3MqTfUcuuC/bJlGCrA1fe91ESJYweNVwcs+Q9/AYXHhzSHtGhQ7KNrLEYAXUW
        zQs/fJuxwnmC+vJm4ylxN/SF4vWbYUE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-W9jINi83MKqvCr4Jud14Jg-1; Thu, 23 Jun 2022 05:42:46 -0400
X-MC-Unique: W9jINi83MKqvCr4Jud14Jg-1
Received: by mail-wm1-f70.google.com with SMTP id j20-20020a05600c1c1400b0039c747a1e5aso1157073wms.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GtCRYQelrWKnz3SabeELJkqPRwIFLNLfCWPVojFD6BI=;
        b=wsCLDUSS3g8x/uhrd+PkqJReBtgOsz8+s1F7djksAfSfLWOWUnQZUbfVpA2SzwF5bY
         8aGmFf399NtXZ2IxyPSc9pGV9VlFKdINHoR0+Iyv3nr/embebBA+dQRqdJCjadNqhzbX
         sD1wAuHjPg751UUTJfJJUgn6dTPF5/JIZdIZNptlQDUz6E7lgqdfi9RzUApm5JhwmdLr
         DDJ2gY+Dvri71KK+HY4Alq+0oZyPVZGFwK8Tk71IhSYETC8ZyOynGJRw3629kE06MALM
         FV/FOpy7WWEPqt2yxwJ9YW7PulfVRaeBF90skv5E56Qv/FhtlMHsL8/32QrdDqRq8+De
         w8aQ==
X-Gm-Message-State: AJIora/K5IKmDOyaqX0ydiv4zX9PMkqH8ufZzZS8Rb10/BAQ3BCsaMAn
        6xqUulfndmsveC9mEaqR/X+31zEZT74vV1LqlgjbMaxZhlOH2L/uM61jeocou7lQFwu8l5cnu1Y
        xkCldXBAUMM5/wvkfY81f/S9f
X-Received: by 2002:a5d:64ca:0:b0:218:5503:d0c3 with SMTP id f10-20020a5d64ca000000b002185503d0c3mr7366173wri.168.1655977365301;
        Thu, 23 Jun 2022 02:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ta/upeL0MWo4wy9b8nuJ+Bd6LqtH80hM/pfDo2zEAWKUxK2lzvqema85h+mKsgXOVFSUYYIQ==
X-Received: by 2002:a5d:64ca:0:b0:218:5503:d0c3 with SMTP id f10-20020a5d64ca000000b002185503d0c3mr7366159wri.168.1655977365033;
        Thu, 23 Jun 2022 02:42:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b0021b8749728dsm15873560wrs.73.2022.06.23.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 02:42:44 -0700 (PDT)
Message-ID: <39279ba0ced207f484b664fe5364fa4ee6271cfb.camel@redhat.com>
Subject: Re: [PATCH] nfc: st21nfca: fix possible double free in
 st21nfca_im_recv_dep_res_cb()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Hangyu Hua <hbh25y@gmail.com>, krzysztof.kozlowski@linaro.org,
        sameo@linux.intel.com, christophe.ricard@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 Jun 2022 11:42:43 +0200
In-Reply-To: <20220622065117.23210-1-hbh25y@gmail.com>
References: <20220622065117.23210-1-hbh25y@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-22 at 14:51 +0800, Hangyu Hua wrote:
> nfc_tm_data_received will free skb internally when it fails. There is no
> need to free skb in st21nfca_im_recv_dep_res_cb again.
> 
> Fix this by setting skb to NULL when nfc_tm_data_received fails.
> 
> Fixes: 1892bf844ea0 ("NFC: st21nfca: Adding P2P support to st21nfca in Initiator & Target mode")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/nfc/st21nfca/dep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
> index 1ec651e31064..07ac5688011c 100644
> --- a/drivers/nfc/st21nfca/dep.c
> +++ b/drivers/nfc/st21nfca/dep.c
> @@ -594,7 +594,8 @@ static void st21nfca_im_recv_dep_res_cb(void *context, struct sk_buff *skb,
>  			    ST21NFCA_NFC_DEP_PFB_PNI(dep_res->pfb + 1);
>  			size++;
>  			skb_pull(skb, size);
> -			nfc_tm_data_received(info->hdev->ndev, skb);
> +			if (nfc_tm_data_received(info->hdev->ndev, skb))
> +				skb = NULL;

Note that 'skb' not used (nor freed) by this function after this point:
the next 'break' statement refears to the inner switch, and land to the
execution flow to the 'return' statement a few lines below.
kfree_skb(skb) is never reached.

Paolo

