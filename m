Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48910563959
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiGASwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGASwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:52:22 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC5B3F8B4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:52:22 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 261Iq6Tq3982421
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 1 Jul 2022 11:52:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 261Iq6Tq3982421
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022060401; t=1656701527;
        bh=2N7jRJtbTNw+ZIOZOKSt9LkxX4Iody1wnGfu2eEsWwQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=fod+EMPi8IXHOs6YwDVsdaCnq7FlnIOSG7SyV0XPLz1HeMjCAf6+XpYhymVg0n35r
         J500hniLpGU96QijOCSv7XokiS8WdkJVdTLAVoTebaFEKCNR9KWKOzCFfF5v41F8bx
         RIKmPrFuIEwpAmaAxCSqulFh1JdeGgAf8iz0ueY75EQlW8GcPHHBcUcdz57gpv+/jQ
         TPAsCMmasdWcHRUP+LOJW5d3wG8aJRMeX5hx7cB1HCTfPGJg4CmY7IXli3LBuTbAJn
         A7auZKWgfNdvybs5AYC4cGL4fNn48iemGc/brYdLi7Bx8RJ3WsPJVss8hQudS8FOpn
         J2z2b0tl4ExNQ==
Date:   Fri, 01 Jul 2022 11:52:03 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5=5D_x86/setup=3A_Allow_pas?= =?US-ASCII?Q?sing_RNG_seeds_via_e820_setup_table?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Yr8/+3qha3nCRLOD@zx2c4.com>
References: <20220630133106.35970-1-Jason@zx2c4.com> <20220701175808.188604-1-Jason@zx2c4.com> <05A1E6F8-432A-4D68-9CF8-C77A3FC68584@zytor.com> <Yr8/+3qha3nCRLOD@zx2c4.com>
Message-ID: <709B69E7-DEC8-428C-9555-254E32C834A9@zytor.com>
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

On July 1, 2022 11:42:03 AM PDT, "Jason A=2E Donenfeld" <Jason@zx2c4=2Ecom>=
 wrote:
>Hi Peter,
>
>On Fri, Jul 01, 2022 at 11:25:49AM -0700, H=2E Peter Anvin wrote:
>> Please correct the incredibly confusing title of this patch=2E
>>=20
>> The setup_data linked list has nothing to do with memory types (e820),
>> except that memory types is one kind of data that can be passed on by
>> this mechanism=2E This title makes it sound like you are passing random
>> data in as a memory type, which could make some bizarre sense if it
>> were, say, some kind of ring buffer preconfigured by the BIOS/VMM/boot
>> loader to be continually overwritten with new random data=2E
>
>Yea that is pretty confusing=2E Alright, I'll retitle that to something
>like:
>
>    x86/setup: Allow passing RNG seeds via setup data
>
>Hopefully that matches more, considering the function that does the work
>is called "parse_setup_data"=2E
>
>(I'll wait some more time before posting yet another v+1 with that
>change, in case others have more feedback=2E)
>
>Jason

We usually refer to it as setup_data (with the underscore) to indicate tha=
t it is a name and not a description=2E
