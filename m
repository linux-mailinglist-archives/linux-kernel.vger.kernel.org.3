Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257B159E7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245391AbiHWQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245175AbiHWQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91190115B54
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661260244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3KIONbPiHyRMeK7Ev2jQpkhdNrH3jXKSsU32bty/nk=;
        b=BxrHBuz8EBBanm/JbDLKjnuilIaB0sI8pr+dgA4+ANFEFOK6D1D9Mq5ln4UMwbPwkYkCWc
        d1gDMnZfdltEDjK4SL9mQdIzrihViSAl6i5FGB1GL+j6fmvBQEjKdl0q1UOed1y4ojQ6JT
        hqGIKoAmYqWupGPQxkJwseax16tQ8Go=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-255-PoqpmEb2OISMi2cOvE_RRQ-1; Tue, 23 Aug 2022 09:10:43 -0400
X-MC-Unique: PoqpmEb2OISMi2cOvE_RRQ-1
Received: by mail-qt1-f198.google.com with SMTP id ci6-20020a05622a260600b0034370b6f5d6so10593615qtb.14
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=K3KIONbPiHyRMeK7Ev2jQpkhdNrH3jXKSsU32bty/nk=;
        b=UBDt+ywekeyLRKH/d58TGB0wT5PmOcnWX/+NkNfPLe49SpeLpoM09q9SWevIoOLcRF
         7aa+Xmn7LaW3P1YmET7CSHYF+0onGIFgdX22/fSK5XgXIfgy55MeJklKi740/N3xXZtX
         t10N9WA4kEoZqgYAGafmqYU75KYaN2k2bSVsFBkVDb1iZvUUf39hLzbCAT4PrX1hkpyq
         RY5ZWkjRn6hvooZCX/FVeD9LX0jli/L2zb0XuiUpFuDPKSySLt4DFV8pjgKoR4DNJ3+t
         mLeeRCSd+DcGcaDJTjXQtlEeQkn3Gqm09nFWoSiiBIjwA14ihA9+RLSOkQqEC5hk9bv3
         kt0A==
X-Gm-Message-State: ACgBeo0H+l312ymxcbHkvnrNMfiSkIPkAXe1Cej3EN7FQO/rc8lbIxSW
        FNFUZ5mjD0D4SepqnXj6p+UbNTea8fwlhGLKKTNAf9gEvMEeJh3XIHaNnZSzi8LS8DPRjXP/owZ
        O2wGKqD5cAbWGlm3ODOWuQ2Sp
X-Received: by 2002:ac8:4e4a:0:b0:343:7e05:d2a8 with SMTP id e10-20020ac84e4a000000b003437e05d2a8mr19418484qtw.67.1661260242849;
        Tue, 23 Aug 2022 06:10:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR40k3HniorFJFBf5+wfj6pczi8EhQyml3G2Dh8I4rf0W+nqJePB+WvUB4zQjJjHNIs8Kh/Rfw==
X-Received: by 2002:ac8:4e4a:0:b0:343:7e05:d2a8 with SMTP id e10-20020ac84e4a000000b003437e05d2a8mr19418454qtw.67.1661260242581;
        Tue, 23 Aug 2022 06:10:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a254d00b006b633dc839esm13460029qko.66.2022.08.23.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:10:42 -0700 (PDT)
Message-ID: <6f147fbd31980c6155ea6e7deba26d8210ed6afd.camel@redhat.com>
Subject: Re: [PATCH 1/4] net: mediatek: sgmii: fix powering up the SGMII phy
From:   Paolo Abeni <pabeni@redhat.com>
To:     Alexander Couzens <lynxis@fe80.eu>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Golle <daniel@makrotopia.org>
Date:   Tue, 23 Aug 2022 15:10:38 +0200
In-Reply-To: <20220820224538.59489-2-lynxis@fe80.eu>
References: <20220820224538.59489-1-lynxis@fe80.eu>
         <20220820224538.59489-2-lynxis@fe80.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 2022-08-21 at 00:45 +0200, Alexander Couzens wrote:
> There are cases when the SGMII_PHYA_PWD register contains 0x9 which
> prevents SGMII from working. The SGMII still shows link but no traffic
> can flow. Writing 0x0 to the PHYA_PWD register fix the issue. 0x0 was
> taken from a good working state of the SGMII interface.

do you have access to register documentation? what does 0x9 actually
mean? is the '0' value based on just empirical evaluation?

Thanks!

Paolo

