Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D54F1F35
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiDDWmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiDDWmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:42:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F2656439
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=MoHK6CDLxM8OKokZRtLof+OJ17ZVmNTtNJ4h0pYEAC0=; b=hxBa3lsW/sg50L70Js2RoegUKA
        jhhISe0FgFbpAk5zn77bHe7IqUj4mo3REKHjGWMVKNGZ+bil/ldB3mIL7iyaGiFxjSeA6eCAouyRV
        ASpHWa9mnncA2d0Hs9F4SJc87dBaSmqUCBF71B8I6ghocsvH+FLhIsHbkkruaU+whE97RcsbBQLvg
        8ihE9Y1YDZDbS0va11SrJgKn/+IDijiqALqL9LQQ++mRwpVTvCAwmpsYQC3bJ/6fP5GKfTPCQsRR3
        EpKe2rd3gAumTqvfVYD8g1w3JAHBz6bYIlMIj6wGd6jyJHp7Ji/d7VZphhej6Z2j5fPl2x3ClJOnQ
        NSkaScGg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbUdg-00658B-SP; Mon, 04 Apr 2022 21:53:35 +0000
Message-ID: <d5c831f3-91db-4ba7-fa30-51847588c305@infradead.org>
Date:   Mon, 4 Apr 2022 14:53:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] sound/oss/dmasound: fix build when drivers are mixed
 =y/=m
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20220403222510.12670-1-rdunlap@infradead.org>
 <CAMuHMdUCdGKE04U4yMqv7TPUztwfih7aLwoTfEP5vcATW=CCxw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdUCdGKE04U4yMqv7TPUztwfih7aLwoTfEP5vcATW=CCxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 4/4/22 06:57, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Mon, Apr 4, 2022 at 12:25 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> When CONFIG_DMASOUND_ATARI=m and CONFIG_DMASOUND_Q40=y (or vice versa),
>> dmasound_core.o can be built without dmasound_deinit() being defined,
>> causing a build error:
>>
>> ERROR: modpost: "dmasound_deinit" [sound/oss/dmasound/dmasound_atari.ko] undefined!
>>
>> Modify dmasound_core.c so that dmasound_deinit() is always available.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks for spending more time on this ;-)

Well that bot keeps reporting this problem, although I suppose
that we could ask for it to be ignored...

>> --- linux-next-20220401.orig/sound/oss/dmasound/dmasound_core.c
>> +++ linux-next-20220401/sound/oss/dmasound/dmasound_core.c
>> @@ -1424,27 +1424,29 @@ int dmasound_init(void)
>>         return 0;
>>  }
>>
>> -#ifdef MODULE
>> -
>>  void dmasound_deinit(void)
>>  {
>> +#ifdef MODULE
> 
> I think this #ifdef must not be added: if the modular subdriver
> calls dmasound_deinit(), the resources should be freed, else a subsequent
> reload of the subdriver will not work.  This does mean all variables
> protected by "#ifdef MODULE" must exist unconditionally.

OK, I like that simplification.

> Alternatively, the test can be replaced by "#ifdef CONFIG_MODULES".
> 
> One big caveat below...
> 
>>         if (irq_installed) {
>>                 sound_silence();
>>                 dmasound.mach.irqcleanup();
>>                 irq_installed = 0;
>>         }
>> +#endif
>>
>>         write_sq_release_buffers();
>>
>> +#ifdef MODULE
> 
> Likewise.
> 
>>         if (mixer_unit >= 0)
>>                 unregister_sound_mixer(mixer_unit);
>>         if (state_unit >= 0)
>>                 unregister_sound_special(state_unit);
>>         if (sq_unit >= 0)
>>                 unregister_sound_dsp(sq_unit);
>> +#endif
>>  }
>>
>> -#else /* !MODULE */
>> +#ifndef MODULE
>>
>>  static int dmasound_setup(char *str)
>>  {
> 
>> --- linux-next-20220401.orig/sound/oss/dmasound/dmasound.h
>> +++ linux-next-20220401/sound/oss/dmasound/dmasound.h
>> @@ -88,11 +88,7 @@ static inline int ioctl_return(int __use
>>       */
>>
>>  extern int dmasound_init(void);
>> -#ifdef MODULE
>>  extern void dmasound_deinit(void);
>> -#else
>> -#define dmasound_deinit()      do { } while (0)
>> -#endif
>>
>>  /* description of the set-up applies to either hard or soft settings */
> 
> ... Below, there is:
> 
>     typedef struct {
>         [...]
>     #ifdef MODULE
>         void (*irqcleanup)(void);
>     #endif
>         [...]
>     } MACHINE;
> 
> This means the MACHINE struct is not compatible between builtin
> and modular code :-(  Hence the "#ifdef MODULE" should be removed,
> or replaced by "#ifdef CONFIG_MODULES", too.

ditto

> P.S. I think the younger myself is responsible for this mess.
>      Please accept my apologies, after +25 years...

:)

I'll see how it goes.  Thanks.

-- 
~Randy
