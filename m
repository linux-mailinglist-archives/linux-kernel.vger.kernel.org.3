Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4F4509D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388055AbiDUKGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377263AbiDUKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C289275E5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650535395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3vq86JCoV+C9mqU7b1xTiv86MtelUtShbMIhjJUfw1o=;
        b=BKO+688cDStPykeI2+/IdI83fmBeJlQ2YEpzJ1H9KMziLaYzXCpnQWUlbPhZkGx7Oghgkp
        GuYB+2D/uwm6FpfPwJr/oQNTRfxDYQAgsz8c70jcRFYlanp3iOD6Ebm1mha9fTned32roS
        +ryP8Q1YVqOsPcxOLqA5iKMTxNvEzXs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-fp5YRlyNMq-d5zAdNXeW2A-1; Thu, 21 Apr 2022 06:03:13 -0400
X-MC-Unique: fp5YRlyNMq-d5zAdNXeW2A-1
Received: by mail-ed1-f69.google.com with SMTP id dk9-20020a0564021d8900b00425a9c3d40cso448054edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vq86JCoV+C9mqU7b1xTiv86MtelUtShbMIhjJUfw1o=;
        b=09TOAjx7Xv2mvNPkWuxp8j7eNdsIz0AIgxsPN50uFzFrUD6ODnrW41rTbCskV+sLU0
         tNqE/r6KxksJpwWr2Afzok7CawXcPxpdnmQp86mDYWbqGyPScjSpcxorZhZygAYgQHyG
         nhVFPi+wiU+72te+R6rH/jaIejW5W24s0njOq9EPcaqoo14TLfbQ8eIeczJJKOlcZxnt
         5lDP+IM10fVQFFUJVJdO5jOD8BbA2NatopOQEEDmqIxmFnSxDrr7JB54DDXjtMIOidV6
         qVWdjN+qsLl6gkZ3/RFzzc0cRs2aEntks3a/w0P/qi3S/Wrih7jQdytgoOJLVmqjdAku
         QWGg==
X-Gm-Message-State: AOAM531WMCGJ+YoFHcCANMsCDBWeBvwIza9ETLE7X+g5NaHJVWkBRr30
        JyVoQ1hPabJB1/swCSZn1+P1EncK+34Ycv3jmiG03DsOi66XyofhbsTXuAltOeudgeVwUY332qr
        4Ul3+CGgyBDik1Bua8yA4TXilGmGQCOXQg20jNr9R
X-Received: by 2002:aa7:cc02:0:b0:411:487e:36fe with SMTP id q2-20020aa7cc02000000b00411487e36femr28151581edt.338.1650535392785;
        Thu, 21 Apr 2022 03:03:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx22YA5KZkNZRsKrQK63lKlMUWFkiMYZjR3oC031zsx7RXTsV6IvSw8sKZUCnChK6go16jMM5+1Tiq6ih81uUw=
X-Received: by 2002:aa7:cc02:0:b0:411:487e:36fe with SMTP id
 q2-20020aa7cc02000000b00411487e36femr28151563edt.338.1650535392596; Thu, 21
 Apr 2022 03:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220413141606.8261-1-vdronov@redhat.com> <YmErJGiTYjlOus5D@gondor.apana.org.au>
In-Reply-To: <YmErJGiTYjlOus5D@gondor.apana.org.au>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Thu, 21 Apr 2022 12:03:01 +0200
Message-ID: <CAMusb+TSLV11mhVNh3EMcs2p9CTJH8uHdE-bum9vWryHjJWiCw@mail.gmail.com>
Subject: Re: [PATCH 0/2] hwrng: cn10k - Optimize random number generator driver
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:00 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> All applied.  Thanks.

Thanks a ton, Herber!

Best regards,
Vladis

