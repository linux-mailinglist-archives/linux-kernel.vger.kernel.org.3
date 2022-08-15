Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EEB592AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiHOHyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiHOHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E03D1DA42
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660550037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yercUWOsUdeD9CXQVJd5iJAar+BoiuWj19yIWOzMs8U=;
        b=XSuduodzPh2vQ0jqmU05Xpem9Au5T8DVAaDBakEscN9QUyjqiwFKPw7rTfQdwS+Dmk+DbG
        bolvQ776dt+jOlFFURC00ZaVHg3x2H9xWR52+Jf679rbL66/QfTM7C5ImXibEOsmI8GBgq
        +3jWvNty5+eg/KS27X5a8Sn5xsB/pqU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-9oWl7teYNJGf2Sn7uHnlnA-1; Mon, 15 Aug 2022 03:53:56 -0400
X-MC-Unique: 9oWl7teYNJGf2Sn7uHnlnA-1
Received: by mail-ej1-f70.google.com with SMTP id gb41-20020a170907962900b00730961131a7so930064ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yercUWOsUdeD9CXQVJd5iJAar+BoiuWj19yIWOzMs8U=;
        b=aJlGbEyq5mwcZPfgfa2y4u+8KMXQpvGQfXZZO8pj1pmIQZOAIfzlY/dO8+cWx7W7Gy
         KJx37XZYYIkE5DGq84KG7XrPhJELTonmt19P4ha+S1lSMLMSTuucSvXoae4iOlqfV59U
         GDwCbo5KGp8lf7K+zmZ2zRc4sWHSU5kUyz0x/RkqN22i5/vfdk07A4xJyGU3EX0gKmZS
         xM0qSdTMWninY0JbnUghPXJ+F2XnoKJJ1vjfAZHSmRsxWwPAYAblGneGV+zdk4xoHeTr
         TakJT+irB0wpgTrTw6aRcZ94hCmMp5uyKqPERUUS5w+lf3PLfvbqMHlF18nBKxxM1lR1
         GmQA==
X-Gm-Message-State: ACgBeo02MozjzoGfeMOGUNqj1X8unAQkKelbWyvgqbZxjapGYu/sWrWf
        U9VEC8mAigwzb0Lnr01VeUeGkv/tw2Wi53cepHqUL2TgK1Sw0Ad0rkwr86jEHIMSbcE8QigwJgc
        BI2mv+uebgehhjid4ursXTHSZ
X-Received: by 2002:a05:6402:50cb:b0:440:8bac:1e02 with SMTP id h11-20020a05640250cb00b004408bac1e02mr14093269edb.336.1660550035026;
        Mon, 15 Aug 2022 00:53:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4AC2S98HLc61afU+gd5vXz1YaX8Kl0i9pStYW3q+4r+4mdvvoUmTiTWdtOOQFKhCnVCdoqSA==
X-Received: by 2002:a05:6402:50cb:b0:440:8bac:1e02 with SMTP id h11-20020a05640250cb00b004408bac1e02mr14093251edb.336.1660550034841;
        Mon, 15 Aug 2022 00:53:54 -0700 (PDT)
Received: from redhat.com ([2.54.169.49])
        by smtp.gmail.com with ESMTPSA id k4-20020a056402048400b004404e290e7esm6153510edv.77.2022.08.15.00.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 00:53:54 -0700 (PDT)
Date:   Mon, 15 Aug 2022 03:53:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815035207-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
 <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
 <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815031549-mutt-send-email-mst@kernel.org>
 <3df6bb82-1951-455d-a768-e9e1513eb667@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df6bb82-1951-455d-a768-e9e1513eb667@www.fastmail.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:46:36AM -0700, Andres Freund wrote:
> Hi,
> 
> On Mon, Aug 15, 2022, at 00:29, Michael S. Tsirkin wrote:
> > On Mon, Aug 15, 2022 at 12:11:43AM -0700, Andres Freund wrote:
> >> Hi,
> >> 
> >> On 2022-08-14 20:18:44 -0700, Linus Torvalds wrote:
> >> > On Sun, Aug 14, 2022 at 6:36 PM Andres Freund <andres@anarazel.de> wrote:
> >> > >
> >> > > Some of the symptoms could be related to the issue in this thread, hence
> >> > > listing them here
> >> > 
> >> > Smells like slab corruption to me, and the problems may end up being
> >> > then largely random just depending on who ends up using the allocation
> >> > that gets trampled on.
> >> > 
> >> > I wouldn't be surprised if it's all the same thing - including your
> >> > network issue.
> >> 
> >> Yea. As I just wrote in
> >> https://postgr.es/m/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de I
> >> bisected it down to one commit (762faee5a267). With that commit I only see the
> >> networking issue across a few reboots, but with ebcce4926365 some boots oops
> >> badly and other times it' "just" network not working.
> >> 
> >> 
> >> [oopses]
> 
> >> If somebody knowledgeable staring at 762faee5a267 doesn't surface somebody I
> >> can create a kernel with some more debugging stuff enabled, if somebody tells
> >> me what'd work best here.
> >> 
> >> 
> >> Greetings,
> >> 
> >> Andres Freund
> >
> > Thanks a lot for the work!
> > Just a small clarification:
> >
> > So IIUC you see several issues, right?
> 
> Yes, although they might be related, as theorized by Linus upthread.
> 
> > With 762faee5a2678559d3dc09d95f8f2c54cd0466a7 you see networking issues.
> 
> Yes.
> 
> 
> > With ebcce492636506443e4361db6587e6acd1a624f9 you see crashes.
> 
> Changed between rebooting. Sometimes the network issue, sometimes the crashes in the email you're replying to.
> 

OK I think we can safely drop the others on the Cc, and I will add
a bunch of people and relevant lists instead.
I want to fix this quickly so testing can proceed.


> > MST

