Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B42658686B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiHALsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiHALr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:47:59 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE3B357E3;
        Mon,  1 Aug 2022 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:References:
        In-Reply-To:CC:To:From:Date:content-disposition;
        bh=n1QDzMIn7q6Ny8LwPM5IAT+CNJilpebjRyh2FU+SV1U=; b=OjQajb/B5ykj1otlr+Tqx4bDle
        NrFNViJYV9RTTFaMtgmk+yTXtwIzioYmI0LTsXaAWAJGqqRSJwXj4WFTLSybmO6kZAszLlGoSMmJw
        oOzYa6aOKzA5YVliSkpWeN+zTwEBGR3akfsNX2TcPGq8V/nqA3VO5oBS02ho945t9hUwYYNhuThSi
        gyhS9ZpwNOEbOVl625URB1ir97/K7vuDYcc0PoZGwb9bP8vZIZmOsBxA5BzvNZwANC9QmyVQsOlEk
        3o7KKrDiWjrVO9MzZVyedpHsBD+BveRkqPTlUKxNrGGfizJLWeB7Tu5jGFfJHLkckN4FYESJUNAZe
        1p2V9n8g==;
Received: from hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net ([142.162.113.129] helo=[127.0.0.1])
        by ale.deltatee.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oITtj-005MV1-FM; Mon, 01 Aug 2022 05:47:48 -0600
Date:   Mon, 01 Aug 2022 08:47:40 -0300
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Song Liu <song@kernel.org>, Christoph Hellwig <hch@infradead.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPhsuW4jtiuNPzC2aK-Jo80X15AWdYi7HQ2n7YWqVP6Uux3hYg@mail.gmail.com>
References: <20220727210600.120221-1-logang@deltatee.com> <20220727210600.120221-2-logang@deltatee.com> <YuKZmloAcZWY5of8@infradead.org> <CAPhsuW4jtiuNPzC2aK-Jo80X15AWdYi7HQ2n7YWqVP6Uux3hYg@mail.gmail.com>
Message-ID: <215E9FEF-69F9-44AB-A5B0-FD3C8335E985@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 142.162.113.129
X-SA-Exim-Rcpt-To: song@kernel.org, hch@infradead.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 1/5] md/raid5: Refactor raid5_get_active_stripe()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 29, 2022 7:48:48 PM ADT, Song Liu <song@kernel=2Eorg> wrote:
>On Thu, Jul 28, 2022 at 7:13 AM Christoph Hellwig <hch@infradead=2Eorg> w=
rote:
>>
>> On Wed, Jul 27, 2022 at 03:05:56PM -0600, Logan Gunthorpe wrote:
>> > Refactor the raid5_get_active_stripe() to read more linearly in
>> > the order it's typically executed=2E
>> >
>> > The init_stripe() call is called if a free stripe is found and the
>> > function is exited early which removes a lot of if (sh) checks and
>> > unindents the following code=2E
>> >
>> > Remove the while loop in favour of the 'goto retry' pattern, which
>> > reduces indentation further=2E And use a 'goto wait_for_stripe' inste=
ad
>> > of an additional indent seeing it is the unusual path and this makes
>> > the code easier to read=2E
>> >
>> > No functional changes intended=2E Will make subsequent changes
>> > in patches easier to understand=2E
>>
>> I find the new loop even more confusing than the old one=2E  I'd go
>> with something like the version below (on top of the whol md-next tree
>> that pulled this in way too fast=2E=2E)
>
>This looks good to me=2E Christoph, would you mind send official patch
>for this?
>
>Thanks,
>Song

I'm on vacation this week, but I'd be happy to send patches addressing Chr=
istoph's feedback when I'm back next week=2E

Thanks,

Logan
