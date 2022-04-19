Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB85065B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349306AbiDSHZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349296AbiDSHZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A74832041
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650352947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZr6M/RZmb6/46Ixt/CqkBe4H7W2TOgxImOhZARYVog=;
        b=PBhzozr5SXHm7hSfEVdyYAIorcErJRfZrxyZUQCxJfYp2vrr3DaZv6WfE8Fg+1Jrp/AXwg
        SE0AzGW7J3DsnMpmQ+PelmDh0hGLVvqUzffXyXZRXO27dkYLLcXi/0EHJG9oOyOMIH2ket
        V1oKYumibe5jCL2diTMjG1A/f158FrE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-eLdABLDWNXWgRHXDGPYx0Q-1; Tue, 19 Apr 2022 03:22:24 -0400
X-MC-Unique: eLdABLDWNXWgRHXDGPYx0Q-1
Received: by mail-wm1-f72.google.com with SMTP id d6-20020a05600c34c600b0039296a2ac7cso807785wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eZr6M/RZmb6/46Ixt/CqkBe4H7W2TOgxImOhZARYVog=;
        b=X01dJT6/xtQBtgjcEjOT07QME4DsqSMw4O3b5rp8aFVGPsE+VHuMsTNy28eABWRfyE
         qi3nG4JuURNfF+C91n1fgTcQUbcTxHbFWL7RkYLstvSrhio4jlIFL/vLmEhMoXXwXiiS
         GFeLaWb5/5uVP35CVlw3bjvH0OybthlKP+hWTgYR7+Vi7yloNtI1ka2a7AX9KSIoS97l
         CyISMRvbvLVl2Jp84Dr/denOx5WYUjdKVlWxTheUYnNvXiJJmaWeOzDjLbtdeVqxuGLu
         5q8AELEJMSORomZcSqU2huKq/UhrdoL+Z8aJT7bmKRGHw2R3rrvBTjGDptRq4XsDfKFK
         8DRg==
X-Gm-Message-State: AOAM533wQgo8B42Nj7e7NGhnCooc7yBQp9DvVcuyX5kcVhOVQ604ReVJ
        QHsSunbTC9d/ku7AgZw93pfR9/xYpyufcMix8OhJ32lWcxpDmu1v7Tpr1l5Q8AFb6Q3u1YeSK8v
        qNxRheKRmQ2HY8hcg6oiO77sO
X-Received: by 2002:a05:600c:3582:b0:391:e041:f3a2 with SMTP id p2-20020a05600c358200b00391e041f3a2mr17301831wmq.126.1650352943531;
        Tue, 19 Apr 2022 00:22:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/UeOtJ/J4radpq0TyJONOLz7bLBbt8qoF30bJsYeesbS32A7rfqg+FAUl2auACvPnfCtwWA==
X-Received: by 2002:a05:600c:3582:b0:391:e041:f3a2 with SMTP id p2-20020a05600c358200b00391e041f3a2mr17301814wmq.126.1650352943276;
        Tue, 19 Apr 2022 00:22:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id f4-20020a7bc8c4000000b0038ebbe10c5esm18408233wml.25.2022.04.19.00.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 00:22:22 -0700 (PDT)
Message-ID: <5cd406e8f8e77f6025d77ec1e0e46296694002d4.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net: ethernet: Prepare cleanup of powerpc's
 asm/prom.h
From:   Paolo Abeni <pabeni@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Douglas Miller <dougmill@linux.ibm.com>,
        Dany Madden <drt@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
        Geoff Levand <geoff@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org
Date:   Tue, 19 Apr 2022 09:22:21 +0200
In-Reply-To: <f995b36fc3f2a3793038300388f06d1c3dd7e69a.1650011798.git.christophe.leroy@csgroup.eu>
References: <f995b36fc3f2a3793038300388f06d1c3dd7e69a.1650011798.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for the late reply.

On Fri, 2022-04-15 at 10:39 +0200, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.

It's probably my fault, but I really can't parse the above. Could you
please re-phrase?
> 
> In order to clean it up in a further step, first clean all
> files that include asm/prom.h
> 
> Some files don't need asm/prom.h at all. For those ones,
> just remove inclusion of asm/prom.h
> 
> Some files don't need any of the items provided by asm/prom.h,
> but need some of the headers included by asm/prom.h. For those
> ones, add the needed headers that are brought by asm/prom.h at
> the moment, then remove asm/prom.h

Do you mean a follow-up patch is needed to drop the asm/prom.h include
from such files, even if that include could be dropped now without any
fourther change?

If so, I suggest v3 should additionally drop the asm/prom.h include
where possible.


Thanks!

Paolo

