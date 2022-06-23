Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2E5558993
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiFWTvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiFWTvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:51:16 -0400
X-Greylist: delayed 3597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Jun 2022 12:51:15 PDT
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533CB1E7;
        Thu, 23 Jun 2022 12:51:15 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 25NIMqIa1294203
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 23 Jun 2022 11:22:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 25NIMqIa1294203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022060401; t=1656008574;
        bh=yPR8n8gQ6dVLtX830iKeJU5ojINLZInrepZE/uEszNU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=er7qtRymZfIxZTCmBzdiQOaT9sgecnfHHau1qec/d4ZsNGp1S4IbzlkDm4wm2DzyD
         RcffhT2oLnHYmNbDQJKdr+8JDECqsW7mBl6QPIfENIGnsD4Cip/YkKWVWfgsXN59BN
         BZ2VQuXZnu2MwPrxSMpYXRfKaLRQDNuF6iVfLyq/tB8SSt4bdIezjsoh+oO8rhmieU
         dDvX+Gup28nAvZFrgFOsOzlsKUB6nbTnltY1xlPbI2f6FK73oHFFAzph6QJWYDFLYk
         Adg4LCSNbEuBI4uEGEBQGmjStLROs6fCVh7A3LiyZVhbpHfanTbzG7ANa2iSENnC6d
         FJX9mkpSn6gig==
Date:   Thu, 23 Jun 2022 11:22:52 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Dave Hansen <dave.hansen@intel.com>, lizhe.67@bytedance.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
CC:     lizefan.x@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC=5D_memmap=3A_introduce_cmdline_param?= =?US-ASCII?Q?eter_=22memmap=3Dnn=5BKMG=5D=24=22_without_start_addr?=
User-Agent: K-9 Mail for Android
In-Reply-To: <de2500c4-fce4-31dc-29bc-aa3007027eb9@intel.com>
References: <20220623062402.12392-1-lizhe.67@bytedance.com> <de2500c4-fce4-31dc-29bc-aa3007027eb9@intel.com>
Message-ID: <0EA9CBD4-D083-4546-BFAC-9C3A97420E5B@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 23, 2022 7:06:36 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> wr=
ote:
>On 6/22/22 23:24, lizhe=2E67@bytedance=2Ecom wrote:
>> In our scenario, we need reserve or alloc large continous memory like
>> 256M in machine which have different memory specification at just
>> boot phase for a user land process=2E
>
>Just marking the memory reserved doesn't do any good by itself=2E  There
>must be some *other* kernel code to find this reserved area and make it
>available to userspace=2E
>
>It seems kinda silly to add this to the kernel without also adding the
>other half of the solution=2E  Plus, we don't really even know what this
>is for=2E  Are there other, better solutions?  I certainly can't offer an=
y
>because this changelog did not provide a full picture of the problem
>this solves=2E

Don't we already have a large contiguous physical memory allocator for thi=
s reason (misdesigned hardware?)
