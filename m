Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8420859AEBF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbiHTPAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbiHTPAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 11:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF916597
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661007601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRBJ+kAGwL9njr3QeEpYkg6rLy9UHweAjQ9xbzfD4hM=;
        b=PbbBfGrMfZZNZniUjgb1S0tQLY0lYEaucbywL3E38OCEeDL7hMC1fmDi7HiWldYEpsvhj6
        3FMpNGkkSySMsWk3KiUVSgUVVqS6hu11Tpz2S+bgGS2oMIUkRHAm2uXEOUTNop2M/qhjVP
        uveQe723YltmVdPiaGcF206WWxaJTRk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-KOfTOhjLOpSOaj1jmJCmHA-1; Sat, 20 Aug 2022 10:59:57 -0400
X-MC-Unique: KOfTOhjLOpSOaj1jmJCmHA-1
Received: by mail-ed1-f69.google.com with SMTP id b13-20020a056402350d00b0043dfc84c533so4309760edd.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 07:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iRBJ+kAGwL9njr3QeEpYkg6rLy9UHweAjQ9xbzfD4hM=;
        b=b0hYx+FfFTxXQWqJp0ZLiuPvTSbe7PiO9siJ8T5Q/0fDA+J7PtgLTgeZxyd7pVT1CK
         BBvyOEm6D6qn/q0IR664YpAsKjS+rcwB7/K+Y/rtOl+cLO2GRG9cjNhK1Ie69fKnE4fI
         td2OOe0pb+59YYcKOwvE6rmiUnl8+c9I3y0bbZtTXdrGJYPwWD1o0QAxf7j/DacN3Dgt
         7gzqu4vdquph1CtN0l/LPc3MMBTTN6LWUSaa9O5zGLbPZ+YxaS4Ba9S1O7lrU/VdaWNm
         lRaWAizVld9iBE2f0NlDDbHHqcgGULCFcfzPxgcOnUXK7PsQgOHF2yq4w/Oz1fXpL2jZ
         f7Ww==
X-Gm-Message-State: ACgBeo0GWHhZ8gM8GspZFIzPXYpqPVnc6dsPls1mYIIiMc42/zlDKtcG
        AYj9015wgV3aK6oEFXry0Bf6N5sH8kEDrHto37u+oR1KwMdDYSwsgmdZr845KeBDGB8FILWZNGa
        xDoYRGQ/Ld5gN5ZDaFcWYWSK6
X-Received: by 2002:aa7:dd50:0:b0:440:3e9d:784 with SMTP id o16-20020aa7dd50000000b004403e9d0784mr9937680edw.195.1661007596853;
        Sat, 20 Aug 2022 07:59:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7iYD2MRBgV5NEFkuv9ew7bcztbYfWXBL8oqUI0InxYrx8Gz1WG2JPPGpklNs2KDJrFKXZvLQ==
X-Received: by 2002:aa7:dd50:0:b0:440:3e9d:784 with SMTP id o16-20020aa7dd50000000b004403e9d0784mr9937668edw.195.1661007596675;
        Sat, 20 Aug 2022 07:59:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id i15-20020a1709063c4f00b0073132fa9393sm3666326ejg.65.2022.08.20.07.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 07:59:56 -0700 (PDT)
Message-ID: <13600e0c-bde2-198f-26c4-00531f277bf8@redhat.com>
Date:   Sat, 20 Aug 2022 16:59:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/4] remove useless files
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>
Cc:     lkp@intel.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <202208200447.kdEhBy9a-lkp@intel.com>
 <cover.1660977535.git.namcaov@gmail.com>
 <63626444-a7ee-a0c4-ec0a-f44a810e25ea@redhat.com>
 <CA+sZ8B8ouMSMmArTVzbkqeWQx4Zqg2=gPaviTrkOFvBoswv_Jg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CA+sZ8B8ouMSMmArTVzbkqeWQx4Zqg2=gPaviTrkOFvBoswv_Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/20/22 16:35, Nam Cao wrote:
> Hi
> 
> On Sat, Aug 20, 2022 at 2:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> Patch 1/4 seems to be missing?
> 
> Patch 1/4 is there:
> https://lore.kernel.org/linux-staging/46d73e331bae2192a328f6691763f39ea6c18b08.1660977536.git.namcaov@gmail.com/
> 
>>
>> Also please squash patches 3 and 4:
>>
>>    staging: rtl8723bs: remove odm_NoiseMonitor.o from Makefile
>>    staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c
>>
>> together. Ion other words remove both the files and the Makefile
>> target in a single patch please.
> 
> Sorry but I am not sure what I am supposed to do with kernel test bot.
> I agree that it makes sense to squash these 2 commits together. However,
> I separated them because I want to have 1 patch addressing the problem reported
> by the bot, so that I can put the "Reported-by" line to this patch.
> 
> If I squash them, should I still put in the "Reported-by" line, despite the
> commit not exactly fixing the reported error. Or should I just leave it out?

You should just leave it out, that is the standard thing to do for
bot reported problems which are fixed before the patches are merged.

Regards,

Hans

