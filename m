Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B264F46BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383387AbiDEUll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349403AbiDEJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32CDD1704F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649151896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qlAy1ak/kV6tHK9Bt1XWUiHugsXbSUUK6OAY60z+5+8=;
        b=NhLRvLUFeNLBMxCA91f2kXruCNf6OqsL/WK8x35QtDXc8BHUN49N9Gour5zwaI/lGE8lWX
        XuhucJsMgmZvKFAlSlaw/iplhdYgnlqVOH+1UiIVc2d/w2CmDnCKMR30Ny+1rYCE5hwbAd
        AyIVdQcNsgrxPPTY3oRicVtBPulmW3A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-5xad1PVMPu-LafkGneHcgA-1; Tue, 05 Apr 2022 05:44:55 -0400
X-MC-Unique: 5xad1PVMPu-LafkGneHcgA-1
Received: by mail-wm1-f70.google.com with SMTP id n17-20020a05600c501100b0038e731cf5e1so1019167wmr.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qlAy1ak/kV6tHK9Bt1XWUiHugsXbSUUK6OAY60z+5+8=;
        b=2tfTQ1n1SUWO29w9GFfL8UmxU9eke7Aaovw983KVxIAagDX/S5c0of7ZgfEGIfzLjx
         BV/xa5+NfzLH7Dwvbl77Uo+cbBFi2FammkgTZBXUTXu4xWnUC1f5Af+gK8HSOzm67T0Y
         B3iwz8ea0HPV3a2IGZNe4KRCbI07ib9xthsZ1LaXCkPHnZksqRuEeYBm1HOEwE0x+lhL
         olphzQ8ZTWpRTu63xhYjKA6nL9xt3F1LpkVrq37UmuRUQFh48Y4ld70sI9efVAmjXD2r
         YYClXrNOyVmkpS/FszvLtaZbjEMP54uAFpCe5dXu1vkoMGfUPp4Xwf0W2tXs0kKsRJ4l
         hWfQ==
X-Gm-Message-State: AOAM532LDB8c/ca2bWTzQZaglzOvoI2HsLdb5NNtlvRuY3kVfBYBKcTP
        UAm7E9fsXAKEv0Lbhd75RQe/8P9MVr9UtLt31+kv2sYOcunJa17y4fn+t/vErBV/x0lxqWqeJux
        NOLclZZdFsOUnk0X8e3dEIDyd
X-Received: by 2002:a5d:4c81:0:b0:206:1a0a:a14 with SMTP id z1-20020a5d4c81000000b002061a0a0a14mr2042348wrs.101.1649151894299;
        Tue, 05 Apr 2022 02:44:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWpE/XeROexNdZa6r6+VHrJ+z5qdSYnqTgxi0gpvE8bk8A2NipXHyA+lP7fxdqtRRJBId/SA==
X-Received: by 2002:a5d:4c81:0:b0:206:1a0a:a14 with SMTP id z1-20020a5d4c81000000b002061a0a0a14mr2042326wrs.101.1649151894041;
        Tue, 05 Apr 2022 02:44:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c35ce00b0038c9f469979sm1640418wmq.40.2022.04.05.02.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:44:52 -0700 (PDT)
Message-ID: <d3805bb376de6d908fc051d274ca6607ebda4e27.camel@redhat.com>
Subject: Re: [PATCH] net: ax88179: add proper error handling of usb read
 errors
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Kahurani <k.kahurani@gmail.com>, netdev@vger.kernel.org
Cc:     syzbot+d3dbdf31fbe9d8f5f311@syzkaller.appspotmail.com,
        davem@davemloft.net, jgg@ziepe.ca, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        phil@philpotter.co.uk, syzkaller-bugs@googlegroups.com,
        arnd@arndb.de, paskripkin@gmail.com
Date:   Tue, 05 Apr 2022 11:44:50 +0200
In-Reply-To: <20220404151036.265901-1-k.kahurani@gmail.com>
References: <20220404151036.265901-1-k.kahurani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-04 at 18:10 +0300, David Kahurani wrote:
> @@ -354,8 +369,15 @@ static int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc)
>  {
>  	struct usbnet *dev = netdev_priv(netdev);
>  	u16 res;
> +	int ret;
> +
> +	ret = ax88179_read_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)loc, 2, &res);
> +
> +	if (ret < 0){

For the records: another recurring indentation issue is the lack of a
whitespace after the ')'.

Please address all the issues reported by scritps/checkpatch.pl before
submitting the next version, thanks!

Paolo

