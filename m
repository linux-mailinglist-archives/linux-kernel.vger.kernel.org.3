Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34D255540F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377702AbiFVTM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiFVTMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:12:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9600F2BE3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655925173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhjwqkPhJ9xw/9qovQS6fJqX4XywzD52eVaz4HaaZtQ=;
        b=IyDlSK5caWluxhX1Iqmer4g3X3vPDBm3bZx0FHfdj7D96LKJAhQx7fX+hbBx4OEIrwnBst
        ky3BkMB2qf8XO+rgt6AdFxJyw0Yz9+/XNHP+tsBUB5YaDj1SM+b9S5gU0D7Cp3MCrlD2Nj
        cltJPHPW2D/RSsl8mUkIrTuvP+0lv5I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-ObPU_-5HOVCXrIW5SrZAtw-1; Wed, 22 Jun 2022 15:12:52 -0400
X-MC-Unique: ObPU_-5HOVCXrIW5SrZAtw-1
Received: by mail-qv1-f69.google.com with SMTP id g29-20020a0caadd000000b004702ed3c3f5so12437460qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zhjwqkPhJ9xw/9qovQS6fJqX4XywzD52eVaz4HaaZtQ=;
        b=nLrzTYVdl1N6P4iRTqoSZSeYVa1zTLDhzZSCNiVgb2ZxkrbPr84GqJlcgBNBoSimcx
         uJdz2Lfc88z9Eaecb9H4H49EHZJ0tTg2Ay/YBl2DmsPIG2kyu9OdjOaTn5nlbBoUXF2+
         BE6/PuD1Hfvv09/UUD3yFIdr2sAp0JtDGKN1NHtdoyJ7juHnkidkvpbpWkTIWBe67SUR
         fV4bQO2sU3qyLtkeX1n0ez2aTB7/vK3ejVjuNups02YQ/ivHw/hS3it116q+g9jiA4M6
         LnFDc0FvEaK3HD/LqGuou0KS6MeXsyzJvg4G/Rnw1EyWaWBi5c1DTTynf5VdjGkc99VN
         8vxg==
X-Gm-Message-State: AJIora8Aj5PHEoSsHppK6OrZz4lpHxM6MPj1VVwlc+GR3mE2knylRYKO
        vFV2bbPux8QnwU4NyAaA9f0RhzTLtLQfDydUlzCsvmWmSv29N+/7cpel0+dw1RJx3BXDHI5C2mj
        s7QTTu//GvP/aEHBTFn/KqeO7
X-Received: by 2002:ac8:570b:0:b0:305:e83:af43 with SMTP id 11-20020ac8570b000000b003050e83af43mr4620304qtw.416.1655925171815;
        Wed, 22 Jun 2022 12:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u2yK6CJukE0PWUjhgIUO/v1rQGRwOO/j+saV7GVNjDPEvsJ8FGIj5m8+xhCHJwjmfYxEXiRg==
X-Received: by 2002:ac8:570b:0:b0:305:e83:af43 with SMTP id 11-20020ac8570b000000b003050e83af43mr4620282qtw.416.1655925171532;
        Wed, 22 Jun 2022 12:12:51 -0700 (PDT)
Received: from t14s.localdomain (c-73-69-212-193.hsd1.ma.comcast.net. [73.69.212.193])
        by smtp.gmail.com with ESMTPSA id bb33-20020a05622a1b2100b00304ea0a86cesm14906820qtb.81.2022.06.22.12.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 12:12:50 -0700 (PDT)
Message-ID: <4a9629d0e8f14afbbb3c342c17c1633c9e882e9a.camel@redhat.com>
Subject: Re: Plumbers conf presentation on -fanalyze?
From:   David Malcolm <dmalcolm@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 22 Jun 2022 15:12:49 -0400
In-Reply-To: <CAKwvOdmJgU_MZjwuVXz5QvFdA4+eTHKqxT06HMAq=Hau03ar9Q@mail.gmail.com>
References: <CAKwvOdnb-DiAnq4bT7XiJpFtqyJYpWNw1shEp8gWYpVmUpRBaA@mail.gmail.com>
         <8c5012c88989a8f05a3b67540b9172336c57ddf7.camel@redhat.com>
         <CAKwvOdmJgU_MZjwuVXz5QvFdA4+eTHKqxT06HMAq=Hau03ar9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-21 at 15:06 -0700, Nick Desaulniers wrote:
> On Thu, Apr 14, 2022 at 3:08 PM David Malcolm <dmalcolm@redhat.com>
> wrote:
> > 
> > On Thu, 2022-04-14 at 14:42 -0700, Nick Desaulniers wrote:
> > > Hi David,
> > > Jose and I are currently in the planning process to put together
> > > a
> > > Kernel+Toolchain microconference track at Linux Plumbers
> > > Conference
> > > this year (Sept 12-14) in Dublin, Ireland.
> > > 
> > > We had seen
> > >  
> > > https://developers.redhat.com/articles/2022/04/12/state-static-analysis-gcc-12-compiler#scaling_up_the_analyzer
> > > particularly the section on The Linux kernel and were wondering
> > > if
> > > you'd be interested in presenting more information about -
> > > fanalyze to
> > > kernel and toolchain developers there?
> > 
> > Thanks!  I'm very much interested, but am not yet sure about travel
> > (both in terms of (a) budget and (b) possible new virus strains). 
> > Is
> > this conference going to be purely in-person, or hybrid virtual/in-
> > person?
> 
> Hi David,
> If you're still considering attending Linux Plumbers conf, please
> submit a proposal:
> https://lpc.events/event/16/abstracts/
> Please make sure to select "Toolchains Track" as the "Track" after
> clicking on "Submit new abstract."
> 

Hi Nick

Thanks, I've registered to attend, and have submitted this abstract:

  https://lpc.events/event/16/abstracts/1293/

("GCC's -fanalyzer and the Linux kernel" #177)

Hope the above looks good.

Dave


