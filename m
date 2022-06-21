Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB0D5533C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351280AbiFUNfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351611AbiFUNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 719F5E72
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655818449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97r4nb+6YDmj9qEHE13vmcMBxY84qaiGZ9+orHa4Vtc=;
        b=eWIDV6gClWVhyzO/MY4riOrJevfmLzpHze/CSoyFf/o7bEOzMnrM+ebkatgcuBRvinQ7Gd
        wMX7yNuKgC0Ut+nvz4GK3BZN1EMDsKFQYhKca75ljO/7Zx3CE0CW4N8/tLgcdUHCurloUL
        obW42DvNFabgeErAWuwgXS6e+ELyS0o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-h6SzaM2oNOaC6zetPSWK4w-1; Tue, 21 Jun 2022 09:34:06 -0400
X-MC-Unique: h6SzaM2oNOaC6zetPSWK4w-1
Received: by mail-qv1-f71.google.com with SMTP id m1-20020a0cf181000000b0046e65e564cfso14321714qvl.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=97r4nb+6YDmj9qEHE13vmcMBxY84qaiGZ9+orHa4Vtc=;
        b=37WZgpXGTwiLc/d+NLTHVTYtAbOHA5AQr3gA8/SCc4kzal3MzM/gE1KAqKJyRY7QQO
         FmgDoC1bIcOaXjCh0kGI6sxtIqR/zZRlZkTev9qCbJ4Uz+6VzlW0tT6ozSRTbIPxKIuy
         EPg0uxWcwqFrRAoq68uuOi2z3tZST4XW6fE8akZq9V/XRtD2wITMY7YnaINydd77ofXh
         XI9DBxJnBuGAB+y2dyDmQ7H8KtX6P89u+yu2qExdsx+0whaX7Dz8qxJoKIdmpDivUfXr
         15zDyZ7nu/5/tVARigLTyfZGF68VbXTdS6NjNR0cxQ6W+HFR3MRpmJ7IiDu3bDO7kALL
         gaxQ==
X-Gm-Message-State: AJIora+4R6122F71FsAG2ZZwCnkuBS4RwAyk7YYTDlCMNiuAb3ci7quK
        gxXeNTehPaD/17S9AJcgD9BesF06BRjknalYRBwwSzz9OhlG4TJKNLJGF8lbIHusvn3lW1NWfYk
        ZQk4uhGC4YSsjj9xR4OcDlnfZ
X-Received: by 2002:a05:622a:4c7:b0:306:69bf:d1f8 with SMTP id q7-20020a05622a04c700b0030669bfd1f8mr23975810qtx.68.1655818445804;
        Tue, 21 Jun 2022 06:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vN9l87oObdmFwig7dlyIvhe7i9Qpoa8feNQP5vgBbzmJSwwtTTmYXVRLZYn7OG2pk+1YLUAg==
X-Received: by 2002:a05:622a:4c7:b0:306:69bf:d1f8 with SMTP id q7-20020a05622a04c700b0030669bfd1f8mr23975763qtx.68.1655818445388;
        Tue, 21 Jun 2022 06:34:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006a6a904c0a5sm14347236qkp.107.2022.06.21.06.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 06:34:05 -0700 (PDT)
Message-ID: <30a683ae5375ca67d10563fe8475074baeb3d7d3.camel@redhat.com>
Subject: Re: [PATCH -next] net: pcs: pcs-xpcs: Fix build error when
 CONFIG_PCS_XPCS=y && CONFIG_PHYLINK=m
From:   Paolo Abeni <pabeni@redhat.com>
To:     Zheng Bin <zhengbin13@huawei.com>, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, boon.leong.ong@intel.com,
        rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gaochao49@huawei.com
Date:   Tue, 21 Jun 2022 15:34:01 +0200
In-Reply-To: <20220621131251.3357104-1-zhengbin13@huawei.com>
References: <20220621131251.3357104-1-zhengbin13@huawei.com>
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

Hello,

On Tue, 2022-06-21 at 21:12 +0800, Zheng Bin wrote:
> If CONFIG_PCS_XPCS=y, CONFIG_PHYLINK=m, bulding fails:
> 
> drivers/net/pcs/pcs-xpcs.o: in function `xpcs_do_config':
> pcs-xpcs.c:(.text+0x64f): undefined reference to `phylink_mii_c22_pcs_encode_advertisement'
> drivers/net/pcs/pcs-xpcs.o: in function `xpcs_get_state':
> pcs-xpcs.c:(.text+0x10f8): undefined reference to `phylink_mii_c22_pcs_decode_state
> 
> Make PCS_XPCS depends on PHYLINK to fix this.
> 
> Fixes: b47aec885bcd ("net: pcs: xpcs: add CL37 1000BASE-X AN support")
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---
>  drivers/net/pcs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index 22ba7b0b476d..faec931b1e65 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -8,6 +8,7 @@ menu "PCS device drivers"
>  config PCS_XPCS
>  	tristate "Synopsys DesignWare XPCS controller"
>  	depends on MDIO_DEVICE && MDIO_BUS
> +	depends on PHYLINK
>  	help
>  	  This module provides helper functions for Synopsys DesignWare XPCS
>  	  controllers.
> --
> 2.31.1

Thank you for the patch. There is already a similar fix pending:

https://patchwork.kernel.org/project/netdevbpf/patch/6959a6a51582e8bc2343824d0cee56f1db246e23.1655797997.git.pabeni@redhat.com/

Cheers,

Paolo

