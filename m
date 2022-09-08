Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306985B16E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIHIZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIHIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A4D345F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662625524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vnkvot4M9lG5xTS18xARZyv61dU23JiFJA7U0ihCpA=;
        b=Fs4PDg1LRqLO5lRnNbx4QhDH3KYB1lyPD9rY4MC5pH2fAD1pKh33WqJaIPY3cbdNtkjszr
        bkThXPedZmnJjBX2IqNf/vOKXLSr8HgM2QDWSwUCJd5srsqBoR16pXfXrG2t6ae4DozVPB
        bwBg0l/kOxSkEn8I5IHMJVJRcHlPTtI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-120-efJskJgOMGe5F8zQXzn7TA-1; Thu, 08 Sep 2022 04:25:23 -0400
X-MC-Unique: efJskJgOMGe5F8zQXzn7TA-1
Received: by mail-qt1-f200.google.com with SMTP id z6-20020ac875c6000000b0034454b14c91so13942004qtq.15
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=8vnkvot4M9lG5xTS18xARZyv61dU23JiFJA7U0ihCpA=;
        b=QbXKWNP7J5Tm8SPu8bDJx85kiFj7E2gMOTKhNR5VYyB6hSNe/WdHxi3ammUpXnFGYx
         yKk6ywyh3EtpifYloEvWHglIBbV3RTGx9ZAQ+ig3384H5HXSRlbvPPbNXMprOOBoMLrE
         4nXMyDj1tSrtKRxCuI134GiZNtuwHta0i/+abNkhubuf5T1yLm22pdUYaKVICs+v2ayk
         pxbqpFeXlRbuJRO7kC1KnegOECT7T0zamURRsQzh6fXUxRGWvC4/w3o2a+ZjJUATbZly
         KmtITf9G1ke8p6njqh4fXMaNY+sMENOhgTBUpXs2onXlPRPi9lzekQSs8Z/P7yYpiS9d
         uSnQ==
X-Gm-Message-State: ACgBeo02wPjVMUSoE29sx8PRahE8J37Sor+rb2XxWusy7rVYYg+l3maz
        iFIIl5Mzs5psDppREdVwgu28JMS0BGgk3l64Jets2ddCFVztRqVabGk5QH64PJKMJNjt2yAcAsU
        +5kt6nC+Kj3sgipPLxFWFLeLq
X-Received: by 2002:a05:620a:488e:b0:6bb:3f84:d175 with SMTP id ea14-20020a05620a488e00b006bb3f84d175mr5511004qkb.587.1662625522290;
        Thu, 08 Sep 2022 01:25:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7WL/XsMoUG5GX69icxKiBPEm17mvgWkJkdT1o5b/1KnaPdUY5FzdDPBRyYucqyskfLfkIT2w==
X-Received: by 2002:a05:620a:488e:b0:6bb:3f84:d175 with SMTP id ea14-20020a05620a488e00b006bb3f84d175mr5510997qkb.587.1662625522071;
        Thu, 08 Sep 2022 01:25:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id m25-20020ac84459000000b00344cb66b860sm14415062qtn.38.2022.09.08.01.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:25:21 -0700 (PDT)
Message-ID: <f62937889fdb5613a59ae1f3f5c05207c07bd6e2.camel@redhat.com>
Subject: Re: [PATCH net-next] net marvell: prestera: add support for for
 Aldrin2
From:   Paolo Abeni <pabeni@redhat.com>
To:     Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Taras Chornyi <tchornyi@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Taras Chornyi <taras.chornyi@plvision.eu>
Date:   Thu, 08 Sep 2022 10:25:17 +0200
In-Reply-To: <GV1P190MB20194E2C26F15E21AF1C6E5CE47E9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
References: <20220905131414.8318-1-oleksandr.mazur@plvision.eu>
         <GV1P190MB20194E2C26F15E21AF1C6E5CE47E9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
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

On Tue, 2022-09-06 at 08:18 +0000, Oleksandr Mazur wrote:
> Apparently i've missed the colon to the subject:
> > net marvell
> instead of "net: marvell".
> 
> Should i resend V2 with mentioned issue fixed?

Yes, please. Additionally I think this should target the -net tree.

Thanks!

Paolo

