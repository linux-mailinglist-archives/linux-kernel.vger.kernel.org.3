Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2C1520E69
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbiEJHeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbiEJHN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A1642AC6FC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652166598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znTslfdmFvdK3fxVyAt5nB+yfBihwlJfOKZNpeLAkaM=;
        b=LLjq1Hf2eiiYb/iPsFf6ljr3J5N/43oFEXS8XhfiNJ8IvS678lWYCIBWn0nfjmogdPAzs4
        fqp3EjvSL6t4LTztzaGi6RA5j6FuCVc0qZ5CJMqlUmO+ogWeNqtePWitI4mm3TbbQ4gqbS
        yO2Sol5kZtvf7kq+zhA/A1L4wnKMHjM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-wwdszn9eMhSYCdfuBbqqvQ-1; Tue, 10 May 2022 03:09:57 -0400
X-MC-Unique: wwdszn9eMhSYCdfuBbqqvQ-1
Received: by mail-wm1-f71.google.com with SMTP id v124-20020a1cac82000000b003948b870a8dso849980wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=znTslfdmFvdK3fxVyAt5nB+yfBihwlJfOKZNpeLAkaM=;
        b=cJjTKi06mjkT9cRZE9hX1RejpRj9fxu6nobq+CWLA9dOfJun0Yf+OAyZpA9WqKWD2x
         eusC/vQohYeOHSEifzmj0D9g5pt3rUB925tWy1cLpZ4LDlFFfQnO5ldCOdXrNj1Zawkm
         TUQ+lzGfC/otW6iyXl4cCYBuMSaB4nYwoRc/vHeJSo7KFofYDTRFWGzGl7v6qOr3IwVc
         IE1JTyQ3OLJgpQNn9EbAivK+Zq4bx4hkEBFIkYRfq2t+TRNdWqx0CVbbEBWJ49tSRMJc
         hC6khFERf8xMDSF7r0r+drscs+kLDUq8bfzrVQ+5/Ow5Btsop31ZBZmTWKBITLJ68er6
         10Kg==
X-Gm-Message-State: AOAM5332gOQlN+W0skh1SOJ9v2ldkKNQb06RFMRiByrEslA+eJhsjscA
        nBV2ptcviRXxma+Jtx887s7xvo1EWYaBeb85caodxHtp7fBAm3+MMHUyf5xV5FtlNyWJ+NGbVff
        NBJcET7PiAuj2jFihifw+exia
X-Received: by 2002:a05:600c:4f8f:b0:394:85c3:cf9 with SMTP id n15-20020a05600c4f8f00b0039485c30cf9mr13602836wmq.125.1652166595703;
        Tue, 10 May 2022 00:09:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBNeLQtsWHQ6Ur1dLDNXNzr8t3qbTWrEf7RLMNxCLHn50u1qdG8vUEnpZmbA2YPRNSHQpTxA==
X-Received: by 2002:a05:600c:4f8f:b0:394:85c3:cf9 with SMTP id n15-20020a05600c4f8f00b0039485c30cf9mr13602816wmq.125.1652166595305;
        Tue, 10 May 2022 00:09:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003942a244f40sm1659279wms.25.2022.05.10.00.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 00:09:54 -0700 (PDT)
Message-ID: <0b66ddcc8428231632e7e1050045b2c282dc92d7.camel@redhat.com>
Subject: Re: [PATCH net v2] net: macsec: retrieve the XPN attributes before
 offloading
From:   Paolo Abeni <pabeni@redhat.com>
To:     Carlos Fernandez <carlos.escuin@gmail.com>,
        carlos.fernandez@technica-engineering.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 May 2022 09:09:53 +0200
In-Reply-To: <20220506105540.9868-1-carlos.fernandez@technica-engineering.de>
References: <20220506105540.9868-1-carlos.fernandez@technica-engineering.de>
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

On Fri, 2022-05-06 at 12:55 +0200, Carlos Fernandez wrote:
> When MACsec offloading is used with XPN, before mdo_add_rxsa
> and mdo_add_txsa functions are called, the key salt is not
> copied to the macsec context struct. Offloaded phys will need
> this data when performing offloading.
> 
> Fix by copying salt and id to context struct before calling the
> offloading functions.
> 
> Fixes: 48ef50fa866a ("macsec: Netlink support of XPN cipher suites")
> 
> Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>

I'm sorry for nit-picking, but you must avoid empty lines between the
the 'Fixes' and the 'Signed-off-by' tags (or any other tag).

Additionnaly you should include a summary of the changes WRT the
previous patch version, see e.g. commit cec16052d5a7.

The patch contents looks good, but it's better if you address the
above, thanks!

Paolo

