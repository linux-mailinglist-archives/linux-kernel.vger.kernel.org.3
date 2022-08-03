Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1495358908E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiHCQc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbiHCQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B7C813E12
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659544220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JEGwHpj/JAt/PomUVgL9JssMeg6/tOcFaY2m43nKSN0=;
        b=Qsq1l1VHPkrjuuGo/2Fuuz1ox0J1J06YwtVvywoMA8wNol/uTRiWyhxupisnxJga+dZ7QY
        YnUuOx6KgDWq56rlzZbQ2PSa/OX8psClISEIGZyzRphqCoHpzbNfYkVz7qLIxwfl77YF9v
        /M5tF2e+I6XZpVnrbaebYVvsOgmIPHA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-AuBm3siPN_G6Bz-I-Sfj_w-1; Wed, 03 Aug 2022 12:30:19 -0400
X-MC-Unique: AuBm3siPN_G6Bz-I-Sfj_w-1
Received: by mail-qk1-f198.google.com with SMTP id bk21-20020a05620a1a1500b006b5c24695a4so13911492qkb.15
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 09:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=JEGwHpj/JAt/PomUVgL9JssMeg6/tOcFaY2m43nKSN0=;
        b=r/8tAqabDkx/YKvIuuTvWpg0e/rAo5BlBmsJ18HaiGLfsprCPQVxbWxSz1Yc/yQvUT
         aDo8eKnTIOxqmikrhL8SELFesG5sTfraLRgmNTSMeiusRDuJ+Wv5MBkNxC4XX1J7Mdbn
         T4RP0w7mgEG2tOdtiKJT7ec5okDF1yJxOSa7PYlPYUI4Vsni67dW/GylB+IcGdVvUPkM
         uQZ/Gu7tgqaia0j5OJu4wdTfHz3eAuhU1BjaX38uPC9L+hCwcJDuZqFGfbFgi9eRXcS5
         j3N8vNoyC8VKVWTVothrLcnOjsKaGgHMruHpjznvYTB8Ewbl7pcfKPGR8UE2M/vLWQQp
         fa6g==
X-Gm-Message-State: ACgBeo0ddp3w4F9T8XEMQmMfvgB9h6YnIgqw0el+3qorY3jUAIFnm1We
        bxfcotmFyDyZA89tGjKfLe2dGKhy+qREMEix0z8FO/pNJTYUni1O6kTsPbeH0u9hDi/5dbaHfAL
        XZAVJDYXIAFYATDXePbNBAaI=
X-Received: by 2002:a05:6214:4110:b0:476:d05d:71b3 with SMTP id kc16-20020a056214411000b00476d05d71b3mr9018252qvb.62.1659544218810;
        Wed, 03 Aug 2022 09:30:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5LbF1YWJL806wlgYMcddrY8rF1HHtfxNxg5ADl1BxWTZTR5HYT7ulzVwzYJpFHKEpcrLpQxA==
X-Received: by 2002:a05:6214:4110:b0:476:d05d:71b3 with SMTP id kc16-20020a056214411000b00476d05d71b3mr9018234qvb.62.1659544218629;
        Wed, 03 Aug 2022 09:30:18 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id bs11-20020a05620a470b00b006b5ef0aff29sm13015523qkb.87.2022.08.03.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:30:17 -0700 (PDT)
Date:   Wed, 3 Aug 2022 12:30:16 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org,
        Zdenek Kabelac <zdenek.kabelac@gmail.com>, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 1/1] dm: add message command to disallow device open
Message-ID: <YuqimBLSh/4wvoDU@redhat.com>
References: <20220704000225.345536-1-dlunev@chromium.org>
 <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
 <YtB45Lte5UhlEE6y@redhat.com>
 <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
 <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com>
 <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
 <CAONX=-ft=ewFDui4jmd2fvcNr2EJc90=ZNOueDdp6HaPZmvObQ@mail.gmail.com>
 <Yun4LH+StcuBXRtO@sol.localdomain>
 <CAONX=-esLr5bGUks_a8wQBky37NnCawh2eOMemYg32HcPA7pmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONX=-esLr5bGUks_a8wQBky37NnCawh2eOMemYg32HcPA7pmA@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03 2022 at 12:29P -0400,
Daniil Lunev <dlunev@chromium.org> wrote:

> > This seems like an access control policy, which the Linux kernel already has a
> > lot of mechanisms for.  Chrome OS already uses SELinux.  Couldn't this be solved
> > by giving the device node an SELinux label that no one has permission to open?
> That would be the ideal solution, but there is a number of challenges
> that prevent
> us enabling enforcement on all SELinux domains unfortunately. While in the long
> run that would be a preferred option, in the short run this doesn't
> seem feasible. I
> would assume the problem of enabling full SELInux enforcement would plague
> any big project that didn't have them enabled from the get going.
> --Daniil

I'm not going to take this patch. It isn't the proper way to handle
preventing use of a DM device. In addition, the patch's header doesn't
speak to a proper review/audit of implications this change would have
on all aspects of a DM device's capabilities. If Chrome OS needs this
as a stop-gap then please carry it as needed.

Regards,
Mike

