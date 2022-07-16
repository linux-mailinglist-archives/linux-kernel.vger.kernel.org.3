Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134F65770F6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 21:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiGPTDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGPTD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 15:03:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1239C1CFEE;
        Sat, 16 Jul 2022 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+vY9Nyy0TwISdW8zYpRWKHHMN2zvj6lxaP9oRlRW5VE=; b=zLf3kVg4Z7/CBgKIAeG5Bbpc3w
        eeS0m/ZHAAACyF5gXE6Vn2OTGI1yfEHMfx6NRip6xxotNix8Sv68aGdCfOSufd6L0r8zHUiVHn3Wv
        SJ5McTRMMcwyKqyCnH7flmgYyBjwgfctcFDZ8mo26iAcX15E1zjFYOy9TMRoJ6Lsyusup6BOUF4Vt
        fWKxBao9tOw3om6CTNZZV56E2ZbyBE4Znd8q0j9pGiWwyWsdTq029+69SdOfy8bHpJOYgTBKlcwZE
        +rPRDnXlijkMZg91D8R8Ss/wImPbPBQqTkE5nuQNZP0uWP4vNJTzh2XfH9Z6TAQu8YDWKI2sgvMba
        yyHXR+5Q==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCn4Y-000ANg-Mj; Sat, 16 Jul 2022 19:03:26 +0000
Message-ID: <5fc2c89d-5aaf-3b81-64cc-7e69b16266c9@infradead.org>
Date:   Sat, 16 Jul 2022 12:03:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BUG] media: cx88-alsa: Found a bug at the probe time
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMhUBj=bs8rbiPGX1qOv9FSU8m=TdRZqqJGvRcynKbaWwf_A-A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMhUBj=bs8rbiPGX1qOv9FSU8m=TdRZqqJGvRcynKbaWwf_A-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/14/22 18:54, Zheyu Ma wrote:
> Hello,
> 
> I found a bug in the driver cx88-alsa.
> 
> When the driver fails in the function snd_cx88_create() at the probe
> time, it will cause a UAF bug as follows:

It's not a UAF. It's a WARN() macro with an IRQ management problem,
as shown in the next 2 lines below:
> 
> [   24.343899] Trying to free already-free IRQ 0
> [   24.344815] WARNING: CPU: 7 PID: 389 at kernel/irq/manage.c:1895
> free_irq+0x3a4/0x7c0
> [   24.348448] RIP: 0010:free_irq+0x3a4/0x7c0
> [   24.356716] Call Trace:
> [   24.357124]  snd_cx88_dev_free+0x71/0x100 [cx88_alsa]
> [   24.358008]  release_card_device+0x7d/0x190
> [   24.358699]  device_release+0x97/0x1c0
> [   24.359022]  kobject_put+0x144/0x1c0
> [   24.359329]  snd_card_free+0xec/0x150
> [   24.360078]  cx88_audio_initdev+0x8f4/0xce0 [cx88_alsa]
> 
> Since I'm not familiar with the driver, could you please give me some
> hints to fix it?
> 
> regards,
> 
> Zheyu Ma

-- 
~Randy
