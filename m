Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A77532790
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbiEXK2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiEXK16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9FC88DDC8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653388077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ra5cwPB2RKeJFrF9zZyO4Umr/f1WXajqESiGHwwfSas=;
        b=e/9lykK4KYzxgxyTVj/VE/aRLz3esKvlxePlwtqXfF4V0gk+npSkIdE4cemiWbpf34gFxW
        fy8JTDrqhCLPXdx+4G6dkaifdnD/R4iqTIkmnRzGqK9uglQ0XqXGKgJ7Gho7XrbkLHGYYr
        ro+WOf3c8vwYG3ge0+w3150QMfmhVl8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-owGS8zyAPYarb1a4XUaJgw-1; Tue, 24 May 2022 06:27:55 -0400
X-MC-Unique: owGS8zyAPYarb1a4XUaJgw-1
Received: by mail-qk1-f198.google.com with SMTP id z13-20020a05620a100d00b006a3870a404bso4005923qkj.17
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ra5cwPB2RKeJFrF9zZyO4Umr/f1WXajqESiGHwwfSas=;
        b=qDz05Ba7SBbjbaP1zUfscmFIvKBkNrLocxxgmAV2tyF7/H0zi78h6l9aGMATa2SKVa
         p+7I3ok0RBkQFIFL7WqwQAB6vpo/aPqE+P+U/cOrLM14kwbkcumjmrumuCmp63Ig2OvI
         UAIA2sO/oPQkEUTlgG6l0OBBwFhpbk5C9bDDUR2sJSJ4TqXEnEsxy4dR3qvj23Dv1pUQ
         v6zBiQYbnq3+2fHooqNGwox66CjjQOrZzZQ5sShZyP+LSKxz+5tPv4e7t8uwsBGKDD+5
         nVTR8zrEQtocsmjcY5gYowEBGwlVi+3PcVRTb4168vYyqOyV7WbHo2KoC66t7+p9Ne0+
         4RsA==
X-Gm-Message-State: AOAM5321xHb4upPgOBnY28TjVnSkQaT3JBNiQp7ps2MNszsQ7hDw1PR7
        xmb3C3mZzhwwfWeh3c+D33fGw3mxSizG9k+DnVsufVzFuSa4pszEoWK92xlqOcdenoxYgWcpRB9
        ogHyXVWs0b1DidgGt+uEQPs6T
X-Received: by 2002:ac8:5e0c:0:b0:2f9:145a:ddd with SMTP id h12-20020ac85e0c000000b002f9145a0dddmr17667853qtx.34.1653388075097;
        Tue, 24 May 2022 03:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjCuHGv/yfJfLImRBpikrRRa2fkL3tHIrfeeClYVW+ZxWFqFtc4R5CmB+NvdYjpsvQcds5BA==
X-Received: by 2002:ac8:5e0c:0:b0:2f9:145a:ddd with SMTP id h12-20020ac85e0c000000b002f9145a0dddmr17667843qtx.34.1653388074886;
        Tue, 24 May 2022 03:27:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id l26-20020ac848da000000b002f39b99f66fsm5983450qtr.9.2022.05.24.03.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 03:27:54 -0700 (PDT)
Message-ID: <195ae1109ca06c690f3fba7475e789180a328654.camel@redhat.com>
Subject: Re: [PATCH V3] octeon_ep: Remove unnecessary cast
From:   Paolo Abeni <pabeni@redhat.com>
To:     Haowen Bai <baihaowen@meizu.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 May 2022 12:27:51 +0200
In-Reply-To: <1653374469-30555-1-git-send-email-baihaowen@meizu.com>
References: <1653374469-30555-1-git-send-email-baihaowen@meizu.com>
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

Hello,

On Tue, 2022-05-24 at 14:41 +0800, Haowen Bai wrote:
> ./drivers/net/ethernet/marvell/octeon_ep/octep_rx.c:161:18-40: WARNING:
> casting value returned by memory allocation function to (struct
> octep_rx_buffer *) is useless.
> 
> and we do more optimization:
> 1. remove casting value
> 2. use obvious size
> 3. use kvcalloc instead of vzalloc
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

This looks like net-next material and net-next is closed for the next 2
weeks:

http://vger.kernel.org/~davem/net-next.html

Please repost when it re-opens.

Thanks,

Paolo

