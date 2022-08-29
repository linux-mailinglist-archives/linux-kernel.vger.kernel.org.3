Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB775A56B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiH2WGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiH2WG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:06:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FAF7C528;
        Mon, 29 Aug 2022 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=P3K8cup/y+wMV7tUMPG65ep2f7jK01WajUYZs4w/b1o=; b=fumkbiciW68/IwHsvzttJ0LzYE
        le134MtLJz8EcFVRCCDk7xFCOu+m36sBU+ceGoRZNKf9sdXpfPbBHQ9iZ5+JvaO5fuxnVCmazFX41
        f5DvCDm5AAigN3ytYIu9xrLE8wIGxThtLVFn/BR+1wO1RqSw3X1kmfihH+xITu4mJl8CNWacjSyu3
        yBZwPIo9UZzhtwYw8G4MDJprRyqeU5JFoO0tMlsNHM7MwDdaEmdmGBuZuc3QjnvPo4MQgwCrtjpU7
        pLbadj1a4ooG24C6QaCJHFSqk/RkiC5mfLumiE00CfzZcFF205QYJWitw6j54Fm/fOnE+4yWWdRkw
        nFU+LsFA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSmte-00D0MI-0p; Mon, 29 Aug 2022 22:06:18 +0000
Message-ID: <cf3a3cbd-c189-a120-124f-98d6adac058d@infradead.org>
Date:   Mon, 29 Aug 2022 15:06:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: thermal driver patch
Content-Language: en-US
To:     Steven J Abner <pheonix.sja@att.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
References: <DL9RGR.8W3XFSCFFYXI2.ref@att.net> <DL9RGR.8W3XFSCFFYXI2@att.net>
 <0f961ea6-4948-0b7a-e01d-d62ca4065af8@infradead.org>
 <L9MDHR.JVBXTJ2L6TPP2@att.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <L9MDHR.JVBXTJ2L6TPP2@att.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

[adding Rafael, Daniel, linux-pm]


> [    5.244369] thermal thermal_zone0: failed to read out thermal zone (-61)

Some driver is returning -ENODATA to the thermal core....

Any suggestions?


On 8/29/22 05:20, Steven J Abner wrote:
> 
> 
> On Mon, Aug 29, 2022 at 05:47, Randy Dunlap <rdunlap@infradead.org> wrote:
>> a. the exact message(s) [copy-paste]
>> c. what kernel version is causing the problem
> 
> [    0.000000] Linux version 5.18.12-051812-generic (kernel@sita) (gcc (Ubuntu 11.3.0-4ubuntu1) 11.3.0, GNU ld (GNU Binutils for Ubuntu) 2.38.50.20220629) #202207150942 SMP PREEMPT_DYNAMIC Fri Jul 15 10:10:55 UTC 2022
> [    5.244369] thermal thermal_zone0: failed to read out thermal zone (-61)
> 
> [    0.000000] Linux version 5.4.204-0504204-generic (kernel@kathleen) (gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1)) #202207071639 SMP Thu Jul 7 16:59:09 UTC 2022
> [    5.207243] thermal thermal_zone0: failed to read out thermal zone (-61)
> 
> as to reproduce, can only think of saying: boot up kernel without patched?
> 
> additional info that may? help:
> I did not trace what calls 'update_temperature', just saw any call to it
> will cause message due to it's call to 'thermal_zone_get_temp', which states
> no thermal_zone_device should provide or be requesting an update.
> It may be that if 'thermal_zone_get_temp' where removed was actual function's
> intent, and all instances in this file and other function's use was a case of designer debugging or signaling a deprecated API? That was my intent on saying
> 'for you to do and review', because it looked like a lot of functions could be
> updated to take into account that no device should call functions that start off
> by calling 'thermal_zone_get_temp'.
>  It is more probable that my patch suggestion is wrong and calls to
> 'update_temperature' are suppose to fail with return -ENODEV always allowing
> other calls to 'update_temperature' to fail also. With proposed code, I've not
> seen adverse side effects. It just removed dmesg error, but was hoping I would
> get lucky and it was the reason for CPUTIN -62C without actually hard work of
> finding real reason.
> 
> additional dmesg info:
> only other 'thermal' are 'thermal_sys' loading governors
> smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: 0x0)
> from lspci:
> Kernel driver in use: k10temp
> from lsmod:
> nct6775
> hwmon_vid
> these 2 removed in personal configs, but used in the two ubuntu kernel builds:
> wmi
> wmi_bmof
> 
> Steve
> 
> 

-- 
~Randy
