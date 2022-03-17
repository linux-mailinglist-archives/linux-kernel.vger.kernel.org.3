Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D719F4DC599
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiCQMOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiCQMOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00A0363E6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647519171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpH3JV8H/hBysLsSPACSn7BYG305VEM8y03PDlONOH0=;
        b=DeotR6qfo8Mq8v+jiG0tX63JsycSIr66um52ixIVd9CyqzfpP5y0eFNSmr0JQSpavEYrMb
        LKKHRW8p/KoVTp9X0OmuxaBlyvFPq2Jp1XOH1XE4/RI7keWPpkxs5G2os0zyjhfzbdA6PN
        Az+RtJU+92+kp90yTQy5ca/ZXv9NKKQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-Km9zINPhOLWzT3B9sM3eUQ-1; Thu, 17 Mar 2022 08:12:49 -0400
X-MC-Unique: Km9zINPhOLWzT3B9sM3eUQ-1
Received: by mail-qk1-f197.google.com with SMTP id k23-20020a05620a139700b0062cda5c6cecso3213401qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TpH3JV8H/hBysLsSPACSn7BYG305VEM8y03PDlONOH0=;
        b=WX3S9f1IKn6tD/fcyiqYd7QrY6AOAMKJporFfePNdnDjNRkXFoV+SJyR70Ynof8K4j
         GeZId4gVU/KLolgd8InZYqrKyJ8JPW2Hq+erVnDAcLT4ahJflBjd6RCnUC7rEHXJiizT
         7mvp6KlcZ9sNcSa++Iu7L5TmtsAqCGussKzuXYJ3fEsF3rvZVktJltmWOmu221tTO06E
         9RVUC1dmYV0tzAAkUsAieUmiKNJq+4Bc9BIPHkahmNtHe/mEoeYtdSW5zUAghRl/h969
         mHNmB9O0Em/YWwsco6EQ6HKw93lHMvwZ1yY8xv4MzBakK/YGbSDHnFhFJHxW+n5X3krX
         fC3g==
X-Gm-Message-State: AOAM532SjwzygevPqTAf+wN8nMBzulyTLszqMHa7Bn9TV1R9bilML5xo
        GK+6+kpRvFGsRfrOdnKo92dJS8sYbBPzsBFfnuWdmUHMH0wivhqm2/SSShW0Uk+NbSliHRuP0VZ
        JaO/MPr/2j+LZT3CcYcOKpAaJ
X-Received: by 2002:a05:6214:21cd:b0:440:a6cb:5bf2 with SMTP id d13-20020a05621421cd00b00440a6cb5bf2mr3203760qvh.83.1647519169424;
        Thu, 17 Mar 2022 05:12:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0282MxVT5wTQA5SXHwuMHUlHvbvAy1gr0IsD1S0zCapPMh/n+mIXggm2nFNJUpg23kg6AgA==
X-Received: by 2002:a05:6214:21cd:b0:440:a6cb:5bf2 with SMTP id d13-20020a05621421cd00b00440a6cb5bf2mr3203736qvh.83.1647519169216;
        Thu, 17 Mar 2022 05:12:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm3510820qtx.89.2022.03.17.05.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:12:48 -0700 (PDT)
Message-ID: <3036d6cbac282ea1a4a9cbf54a4e643f051710c7.camel@redhat.com>
Subject: Re: [PATCH] net: dsa: Add missing of_node_put() in dsa_port_parse_of
From:   Paolo Abeni <pabeni@redhat.com>
To:     Miaoqian Lin <linmq006@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Mar 2022 13:12:44 +0100
In-Reply-To: <20220316082602.10785-1-linmq006@gmail.com>
References: <20220316082602.10785-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-16 at 08:26 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> Fixes: 6d4e5c570c2d ("net: dsa: get port type at parse time")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

LGTM, thanks! 

For the records, it looks like there is a similar issue in
net/dsa/port.c: dsa_port_link_register_of().

Thanks!

Paolo

