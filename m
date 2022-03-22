Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA34E37BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiCVD5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiCVD5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:57:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99714F43
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:55:32 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t7so13559064qta.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tlfk3ONNPBbJUJbNtqy9j6rAiRGYBugmq+fxnnZcr+Q=;
        b=IFQWsGyIJJF6MdPAt31vuIJLMHHHHxLkreyan030730msKBzy3/LxS/lharYDduXpa
         jQ7vIhH5n7zs/jJAhL/PBY/1yjOfgBRj1b9XsxnfG1yW3ZxP7MyPsmTz2zcI+iJ5i53I
         FuoFvwRWmuz2NAAfoznPh5zlq4PmFjCCNC5/Q8HHO7pbUUvk6+77/dzQGOcWQypB8nKH
         r2SKZvIxeJGAcP0iNfumQV4rbL+JYGB4a8l0RtiqLjqK2obGKjkkB6SLLkvBqEZT1lqA
         IT/fPiDbuAu7/74GZFTc/nP+zFoZMI6skXFuMxy003IR+qA1fFd+idC5JczQzHdUCS2n
         UDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tlfk3ONNPBbJUJbNtqy9j6rAiRGYBugmq+fxnnZcr+Q=;
        b=1c0cyxZv3jtprblEM0cxDz4Phm3wRsp0x7bY98SF3Eoyb2LKs083RB3s5mOUwinZLl
         Hah0vXofcu8XStlLXN/usvDDTkq0WScXDok5l2Sg5zAULFv712VRM5jG978rIls6FhLJ
         Rv/7qkf7zTDBflrih6leE5e00pVCLwhAZ6xx73TzRHlOB/9h3Xctr3FzWLtsTABqHaKV
         EksBbmyxFI4Rp4Sx0VgfU6JKVAxjHDW4CpZ5ozWS/Lc6omCRVdh6BzBfPlbIqhRq280H
         qmI/LkfFJl8dmmPJTHQ6ecYFcprwbRmqA4c3q8hsg7qXWbUu9j1e1ekEZVy3M0QeR0f2
         kYkw==
X-Gm-Message-State: AOAM532myonI4srxDBU/67e4I39ZXR7rGPzwsvBHGEsYwiW6bELfWoTS
        aAlw/ZBGjLivgWwtETTQXgb5uq7Y0c8=
X-Google-Smtp-Source: ABdhPJwbz0+kgdbZ7QxP2heKuPfOEbvu2liSOWvqfzkXgTtMrxIBn9UCKFIT/VLNZ5ERGFucy+9mLQ==
X-Received: by 2002:a05:622a:1346:b0:2e1:d588:df3a with SMTP id w6-20020a05622a134600b002e1d588df3amr19161237qtk.457.1647921331064;
        Mon, 21 Mar 2022 20:55:31 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.googlemail.com with ESMTPSA id u187-20020a3792c4000000b0067e679cfe5asm5048876qkd.59.2022.03.21.20.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 20:55:30 -0700 (PDT)
Subject: Re: [PATCH] tools/vm/page_owner_sort.c: add switch between culling by
 stacktrace and txt
To:     Yinan Zhang <zhangyinan2019@email.szu.edu.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20211129145658.2491-1-zhangyinan2019@email.szu.edu.cn>
 <f0a8099b-3c60-3e34-078a-be3c1280ca61@gmail.com>
 <20220321133825.6f003c62381edbab361a8d96@linux-foundation.org>
 <623932d3.1c69fb81.e3278.ab09SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <0f3fca6a-cd9d-a5f7-2eda-3e3a9ceae564@gmail.com>
Date:   Mon, 21 Mar 2022 23:55:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <623932d3.1c69fb81.e3278.ab09SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 10:22 PM, Yinan Zhang wrote:
> I replied to the email a few months ago. Did you receive it?

The patch was applied anyway. Anything in this subsystem gets
applied within a day or two regardless of feedback. Personally,
I'm not motivated to review anything because of that.

--Sean

>=20
> on 2022/3/22 4:38, Andrew Morton wrote:
>=20
>> These comments were not responded to:
>>
>> On Mon, 29 Nov 2021 21:23:41 -0500 Sean Anderson<seanga2@gmail.com>=C2=
=A0 wrote:
>>> This is working as designed. IMO there's no point in separating
>>> allocations like this which differ only in PID and timestamp, since y=
ou
>>> will get no grouping at all.
>>>
>>>> The info of second block missed. So, add -c to turn on culling
>>>> by stacktrace. By default, it will cull by txt.
>>> Please keep the default to actually do something in the cull step.
>>>
>>> ...
>>>
>>>> @@ -162,6 +171,9 @@ int main(int argc, char **argv)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 't=
':
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cmp =3D compare_num;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'c':
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
cull_st =3D 1;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
>>> Can we set a "cull_cmp" variable like cmp?
>>>
>>> Looking forward, I think something like
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0page_owner_sort --cull=3Dstacktrace --sort=3D=
times foo bar
>>>
>>> would be nice.
>>>
>> Which is unfortunate.
>>
>> I'll send the patch in to Linus anyway, as many other patches
>> syntactically depend on it.=C2=A0 Please work with Sean to address the=
se
>> issues and lets get this resolved over the next few weeks.
>>
>> Also, please cclinux-mm@kvack.org=C2=A0 on changes to page_owner.
>>


