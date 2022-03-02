Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547E94CA596
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiCBNHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiCBNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 331E6C249E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646226382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0fMnk0i2vLioTpWExJ0LC4UAikEb9oOUvO98xL5/80=;
        b=QPu0Xsjlsv0OV3L0HugoK8kdnQeLwLtA4dLM/8tTF9pMgmNj0KGh1WCOY4/ysCTOcs5sbY
        kv7g3Gm702+WwkWBN0XI7dspU6fOA2B6rkozd/9zMbKrYlClE8gh6K3g/ErXm0FVNM6oQc
        LHGse4MaIDvl4d1vRLsuWvGl4MCAudY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-ga1XHNdaPouaeqX_nfL1Sg-1; Wed, 02 Mar 2022 08:06:21 -0500
X-MC-Unique: ga1XHNdaPouaeqX_nfL1Sg-1
Received: by mail-wm1-f71.google.com with SMTP id bg33-20020a05600c3ca100b00380dee8a62cso487565wmb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 05:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/0fMnk0i2vLioTpWExJ0LC4UAikEb9oOUvO98xL5/80=;
        b=0aZj0wuH381mjGqNrOGibYHARUIAM3QgrX9V1OmDtLONRUon6gPcpVXdCtWsHuOqE3
         obznakv2Ify2JG1GRBNASelrodwBPQF4cnH8FMqFe5O/bE1HhE3cK39dUAR2Y/RHtogU
         2U57yOMoOxJroj74rX7Q6oDzrbbaKT1DmXUo+gBUiNyA+FiKQtT1LNGJ95vH6zPM5bUJ
         EXevYTy3vqjMYrWs0JxYPRUyhjrg98QtzVR46/tN+UfZmiTYw6GyxE4zwXj8jXi5MZeS
         rbdRbouk4WA+TVHHgvsbSxqIGowubzhOk9yVLBUWcbJNf/quU4EqxPYt6Hnlp5O4Rwzv
         wZhg==
X-Gm-Message-State: AOAM53051l14x/TMRqYlWSewRXZwR5whA2fkQmolV4d+G8G3wpQxQPzR
        uAB2ys5Bg/JlKPFO4c0+59gwzWVjg4hKRwQHOskUhREie3H8xNF1N/fuiSDFddUzgkryQ6PuyJ+
        vnVOYjn4VGypFWbRfZpF/3jxC
X-Received: by 2002:a05:600c:602a:b0:381:4245:ec26 with SMTP id az42-20020a05600c602a00b003814245ec26mr17603282wmb.25.1646226380004;
        Wed, 02 Mar 2022 05:06:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1+nJ+l+dkYyyuQOpSfQyIgX1YDsaGTdYillGKYMXZjSRwlRMKKCr6zJiD+Ls1nk7mSP8fFg==
X-Received: by 2002:a05:600c:602a:b0:381:4245:ec26 with SMTP id az42-20020a05600c602a00b003814245ec26mr17603270wmb.25.1646226379803;
        Wed, 02 Mar 2022 05:06:19 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm5583452wml.43.2022.03.02.05.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:06:18 -0800 (PST)
Date:   Wed, 2 Mar 2022 08:06:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>, Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 3/3] wireguard: device: clear keys on VM fork
Message-ID: <20220302075957-mutt-send-email-mst@kernel.org>
References: <20220301231038.530897-1-Jason@zx2c4.com>
 <20220301231038.530897-4-Jason@zx2c4.com>
 <20220302033314-mutt-send-email-mst@kernel.org>
 <CAHmME9r6zXw6cByqpbhEBKkvpejrLqGMn55E-uOCQ0V1mQi1LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r6zXw6cByqpbhEBKkvpejrLqGMn55E-uOCQ0V1mQi1LQ@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 12:44:45PM +0100, Jason A. Donenfeld wrote:
> Hi Michael,
> 
> On Wed, Mar 2, 2022 at 9:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > Catastrophic cryptographic failure sounds bad :(
> > So in another thread we discussed that there's a race with this
> > approach, and we don't know how big it is. Question is how expensive
> > it would be to fix it properly checking for fork after every use of
> > key+nonce and before transmitting it. I did a quick microbenchmark
> > and it did not seem too bad - care posting some numbers?
> 
> I followed up in that thread, which is a larger one, so it might be
> easiest to keep discussion there. My response to you here is the same
> as it was over there. :)
> 
> https://lore.kernel.org/lkml/CAHmME9pf-bjnZuweoLqoFEmPy1OK7ogEgGEAva1T8uVTufhCuw@mail.gmail.com/
> 
> Jason

Okay. The reason to respond here was since this is the user of the
interface. Maybe unite the patchsets?

Thanks,

-- 
MST

