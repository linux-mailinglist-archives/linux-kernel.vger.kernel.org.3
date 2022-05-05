Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D1F51CCA4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383122AbiEEXWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiEEXWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:22:34 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC535DBD1;
        Thu,  5 May 2022 16:18:51 -0700 (PDT)
Received: from [192.168.1.31] (097-089-247-249.biz.spectrum.com [97.89.247.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 253383F1AF;
        Thu,  5 May 2022 23:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1651792727;
        bh=VVnmPbFnA4OIRX+hXqQx9XDh1uWLf3BJMOQz6Bb6B4U=;
        h=Message-ID:Date:MIME-Version:Cc:From:To:Subject:Content-Type;
        b=QAYWDspQ0p7qfXYLaLcFNbtWR9OGuK7KfGOJNrX+DQDapPLCM8P0GXDLjJMeKvaTI
         I7xV1BKw/jC3askrfGgYOXKYqg3LpXL3ieB2zOjcwUsd+T82XBrgx8DpGRmWE2sfRL
         d9/+K55WDj3X4s8n8MBVEcTlJX1qAYB7f3+IextUr/TCDruW6lZixSS0LmMcLaBHw2
         QhulImiekLFVYFO7cpAv88qQVhLLZIWM0sT6QtlbVWUy3bKz2Zajr27ynfSZm9gvsn
         NXWLehTYJv3GbjqNJv5tcGjrtIN+ANiacAnijj3xuq5Yr1PkbWBcT/rfq4oVaAVDBA
         VUEA1OZpkp6wg==
Message-ID: <bdb23fe5-51ae-8873-a3d7-85f377877c79@canonical.com>
Date:   Thu, 5 May 2022 19:18:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-rt-users@vger.kernel.org
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     tglx@linutronix.de
Subject: Issue With real-time patches on 5.15.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I ran into a build failure after applying the rt40 real-time patches[0] 
to an Ubuntu 22.04 kernel. The Ubuntu kernel is based on upstream stable 
5.15.y(5.15.34 currently).  I believe this patch is the specific one 
that introduces the build issue: 
0086-locking-Allow-to-include-asm-spinlock_types.h-from-l.patch.

After a bisect, the following commit was identified as the cause for the 
build failure:
b50854eca0e0 ("x86/pkru: Remove useless include")

This commit was added to mainline as of 5.16-rc1 and not Cc'd to stable, 
so it should not exist in 5.15.y.  However, it was purposely added to 
the Ubuntu kernel to enable x86 AMX support[1].

The real-time kernel build failure can be resolved by reverting commit 
b50854eca0e0.  The failure seems to be due to the removal of an include 
of xstate.h from pkru.h and caused spinlock_t to not be defined.  The 
commit would only be reverted for the real-time kernel and not any other 
kernels.  I wanted to see if reverting the commit is the proper 
approach, or if cherry-picking additional commits might be a better 
solution in preparation for additional changes that might be coming in 
the future?

Any suggestions would be greatly appreciated.

Thanks,

Joe


[0] 
https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15.34-rt40.tar.gz
[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1967750
