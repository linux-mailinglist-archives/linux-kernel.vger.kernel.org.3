Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685624E8709
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiC0IyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 04:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiC0Ix6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 04:53:58 -0400
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43D31D0E8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 01:52:19 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 22R8qHNg047403
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:52:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1648371132; x=1650963132;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O7kXkCdvhvkq/xOJDYOOrEuPdlDIk8ke1X+ujPivqOc=;
        b=ElHHF3EcNDRUAW8hyeIYHGqck2a8/UujzBMHet2ql7Jkpr7oaB7w6OJPGoBg1W11
        Bq9vVLj4YGbWEwT/utY5bhVE1q8FKEwPtvn0FaO5z4n6UPuZiIpU2wuu6p5jACpP
        pMKbx0K91DiNP2LLKyBdCdDkLJpr56qm8dN/02fVOQeffXkSWt0CUGD8mzk+KN9x
        19HYd7WToHqmVXRlmag/YX36IqQ//wYgflQ9gUc2G9roqxZgKu8dqvocBqjqQ3gn
        LruNfrpxPo26b0VrhVX8YhEqQ/caigpMilCOA20AdiM0YFKtlOxEVPDvLVHgUE2B
        6crZP2Kf7jCCMVIKWpD+LA==;
X-AuditID: 8b5b014d-f2ab27000000641e-21-624025bc924b
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 66.EE.25630.CB520426; Sun, 27 Mar 2022 11:52:12 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 27 Mar 2022 11:52:11 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Conor.Dooley@microchip.com
Cc:     mick@ics.forth.gr, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
Organization: FORTH
In-Reply-To: <ebaa9b4e-9e37-e2f4-2bee-37d324e7302b@microchip.com>
References: <20220322132839.3653682-1-mick@ics.forth.gr>
 <ebaa9b4e-9e37-e2f4-2bee-37d324e7302b@microchip.com>
Message-ID: <941622f4f76ecd5bc071e310479b3ad3@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXSHT1dWXePqkOSwdmVYhZbf89it5iyaQe7
        xeVdc9gstn1uYbNofneO3eLl5R5mi7ZZ/A7sHm9evmTxONzxhd3j4aZLTB6bl9R73PmxlNHj
        UvN1do/Pm+QC2KO4bFJSczLLUov07RK4MhoXCRdM5qhY8GY/SwPjKbYuRk4OCQETiQu7JrB2
        MXJxCAkcY5Q4s3IFK0TCVGL23k5GEJtXQFDi5MwnLCA2s4CFxNQr+xkhbHmJ5q2zmUFsFgFV
        iTdNG9hBbDYBTYn5lw6C1YsIyEn8/3WGGWQBs8BqRomJk1rBFggL+EpMWrkDzOYXEJb4dPci
        mM0p4Chxuq0B6DoOoIvyJSY+jYO4wUXi2rbJUEerSHz4/YAdpEQUyN48V2kCo+AsJJfOQnLp
        LCSXLmBkXsUokFhmrJeZXKyXll9UkqGXXrSJERz+jL47GG9vfqt3iJGJg/EQowQHs5IIr+xZ
        +yQh3pTEyqrUovz4otKc1OJDjNIcLErivCzXZJKEBNITS1KzU1MLUotgskwcnFINTBN3/iw5
        P3PJO7kv0fZr3044xx8/f/ejIrMXxTfFM6N+VjSfjUxbdFb8y+zE7J0f33dyeAQ7H7b4eknm
        6+Jq03fTBXdI60sseCd34EvRO86jiZerLk99/ic80+zL7B0F3BeWe36q6Fu4Qa1Kq/LLJZ+I
        i10dvdsjjCfOTPv3wnzrY7Owg9dLN7Dbavdznjj/+PjmedfZNmz1jmRdbnb6vHu4TW/M27PS
        sX4e11s72mR4F3OtPKGjluI4ax+b1vLIj7FpoiKN/96kMwfm6SzxUH9ZLR6WuWzZ7W8hbRfs
        rAXyXi6bsvOD/VOhRQLf563cfOgmb4LUga401q83RNLDp917lJeSNbvyxoXCVRffvZdVYinO
        SDTUYi4qTgQAbcQ2iu4CAAA=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2022-03-24 11:37, Conor.Dooley@microchip.com έγραψε:
> On 22/03/2022 13:28, Nick Kossifidis wrote:
>> In case the DTB provided by the bootloader/BootROM is before the 
>> kernel
>> image or outside /memory, we won't be able to access it through the
>> linear mapping, and get a segfault on setup_arch(). Currently OpenSBI
>> relocates DTB but that's not always the case (e.g. if FW_JUMP_FDT_ADDR
>> is not specified), and it's also not the most portable approach since
>> the default FW_JUMP_FDT_ADDR of the generic platform relocates the DTB
>> at a specific offset that may not be available. To avoid this 
>> situation
>> copy DTB so that it's visible through the linear mapping.
>> 
>> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> 
> Albeit in a backport, I tested this on a PolarFire SoC based board.
> So I guess, Tested-by: Conor Dooley <conor.dooley@microchip.com>
> 
> And a lot cleaner than using create_pgd_mapping in setup_vm_final to do 
> it :)
> 
> Thanks,
> Conor.
> 

Thanks !
