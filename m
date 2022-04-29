Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA651544D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380246AbiD2TVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380239AbiD2TVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:21:44 -0400
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCFAAC93C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:18:24 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 23TJIKui068991
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 22:18:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1651259895; x=1653851895;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BqOKa8AtSZmxxbB7EZVp+eH4ck8Ou2iydBBlT5ZDTMI=;
        b=YMQHCjdYRN5ORiMTOPRaTYnEnL4FVJkozhCD7/XQyF3XmXKFnBGO1kR6LJchQVsV
        31vV+Jp7iSMQrD0vVYGBm0faLsPTLG4Vaq+54zHfZZeePulDR2W+6NDivCfV/lR5
        PfLGY92Upr5HVTss3tyfjyXOqF2vJJ86Sy4li/arXjKIyjRThWyXgFa0cCMJEdwg
        r/suP0yonWoYPDytHJo9hZajelf1g0Ps+b6oo+xqQoDlDaLdF6KHLXOwwsvCgeyl
        UiEWGOuegdDS2sCDzHS2YaWB+tOQh6+GhqwuGcUjS5mmqE0mfQ7OPjki9e7frQlp
        LWefAiNmBwL9s6xhoTYL3A==;
X-AuditID: 8b5b014d-f2ab27000000641e-9f-626c39f728d9
Received: from enigma.ics.forth.gr (enigma-2.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 4F.50.25630.7F93C626; Fri, 29 Apr 2022 22:18:15 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
MIME-Version: 1.0
Date:   Fri, 29 Apr 2022 22:18:14 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
Organization: FORTH
In-Reply-To: <mhng-6c123e84-9530-46f6-a5ec-6b908bb92f95@palmer-ri-x1c9>
References: <mhng-6c123e84-9530-46f6-a5ec-6b908bb92f95@palmer-ri-x1c9>
Message-ID: <e3b6a7ed7dc612d7338bc95d8fbbfdfc@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXSHT1dWfe7ZU6Swd9ZfBZbf89it7i8aw6b
        xbbPLWwWze/OsVu8vNzDbNE2i9+BzePNy5csHoc7vrB7PNx0iclj85J6j0vN19k9Pm+SC2CL
        4rJJSc3JLEst0rdL4Mr48LabsaCTveLjg68sDYx7WbsYOTkkBEwkfv9ZytbFyMUhJHCcUWL3
        9ZVsEAlLic2fXrKA2LwCghInZz4Bs1kEVCX2nN0HVsMmoCkx/9JBsLiIgLrEgdd3mEFsZoHl
        jBKv/tqA2MICvhKTVu4AW8YvICzx6e5FMJtTwF1i5+7d7F2MHECL3SSW/8+EWOUisezKX6jb
        VCQ+/H7ADjHSQmLqlf2MELa8RPPW2cwTGAVmIbluFpKyWUjKFjAyr2IUSCwz1stMLtZLyy8q
        ydBLL9rECA5qRt8djLc3v9U7xMjEwXiIUYKDWUmE98vujCQh3pTEyqrUovz4otKc1OJDjNIc
        LErivOzPwpOEBNITS1KzU1MLUotgskwcnFINTBIuNsXft8RwnSn3qlu8pMxnieulBRlbZ+Tv
        eX+eO3anW2LHBfFHteHWeXWWltHZi2TDLd4pJR8zinadYpW4O3LWn86j+jVpHZPMz70TKLnZ
        ed7k09P7Uvxhuidfxl+aNGFyOsfXJq+nvpuuMap67VfSv/Eg5JNMnXP2w/tlm4PVd26rKTS/
        mnLKdGvr8T2H5R0XdS9gZJFmZGExbz75sFD0dbHKKQ+rc1/rJp2cYrLpVNfBzz5STyWq+G5u
        OzgvO7vEZdIDo4/XLn7aI3XybUz5CTX5X8lPp3fM0ytdd/flrE+Pj/kvPZw9TV3gtsznqLsO
        RiWi6YydXC+mqUWKKruX6ujrrhcT/+M85dTSC0osxRmJhlrMRcWJAMDVrWzZAgAA
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2022-04-29 18:28, Palmer Dabbelt έγραψε:
> On Thu, 28 Apr 2022 14:48:14 PDT (-0700), Palmer Dabbelt wrote:
>> On Mon, 25 Apr 2022 23:11:23 PDT (-0700), mick@ics.forth.gr wrote:
>>> Hello Palmer,
>>> 
>>> Any updates on this ?
>> 
>> Sorry about that, it's on fixes.
> 
> Not sure if I just wasn't paying attention yesterday or if I'm
> grumpier this morning, but that "RISC-V-fixes: " prefix is just a bit
> too odd -- I know we've got a split between "RISC-V" and "riscv" so
> maybe it doesn't matter, but even that is kind of ugly.
> 
> I re-wrote it, but I'm going to let it round trip through linux-next
> so I'll send it up next time.
> 
> Sorry, I know this happened twice recently but I'll try not to make a
> habit of it.
> 

Don't worry about it, just let me know what works better for you, would 
"[PATCH -fixes] riscv:" be ok next time ?

Regards,
Nick
