Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD49517100
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiEBN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiEBN4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:56:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90C13DC6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:52:32 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s27so18472557ljd.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kxY6XEDI7XOoO08e1j2VYG2/2iDuEgkmEgQ7wiqVynE=;
        b=fwiKPFjFCxmDq7YqB9IrFsckC6E9c687H64f+nt/JkS6Z28U3t/Lzjt7eyezeINl6i
         hxBFfQJRQqBYl8uBZy32zHox8mXbQ+So9BDeC5QuxomlKsTxV6BJ+SBynmdkwSkBlNQ8
         9gC6OXZgHkcfFmnLGO2th6lA6wojCJwPO/pSOOLjresgcyaFOu2xB8nm4BaRwxSE+qGN
         34nEjuW/qSpA7BQyx0k3Y2D1N9gy3CudwwW/bvuutK2GuQpy290Heeu6qrUIbphc8h6a
         WfpyZt/rJSEoZt59ALV8EtjhJvev3kXEk+1wSihpr+DRNQuF31q87JCF8Dp3oqWTst+m
         nsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kxY6XEDI7XOoO08e1j2VYG2/2iDuEgkmEgQ7wiqVynE=;
        b=IfGyAViIg+i53xgF7KLp18m2UWOwjvWGBNd1t6yCdapxp87LkObEZedjWLG9DFWBaM
         xGWw9H2Pmqpg+TVArVdF8FRTu+9+MjaBqTm+m8t+no/5iS6I2z+KX8CPmlTD3jJAvco2
         ZoTE0tXCNGSZGdehfmv81+xyNacVRzzp4MTewOnjCJhT9gNokU5zPXJDi4gDF0Vmw16Q
         VhyZvEUGVsif/R1ff1oXlFyUVg2KRfrkghvbnjWGFyXiunX5Lv0lTmUTP6MtD3RuMaiI
         Ewir9S334ccyS68v8PNTZWr9OA26JIhvEWvYeofNkjtqzGT/bTJOkBM8sv5yNhTaVC7i
         S2qA==
X-Gm-Message-State: AOAM533tSuHhrK1WaJ/IvIJCpTahlTt8yG6Nnabn2TA4PhXP85iUtxKp
        6E198gi8QYad4pnVHv1rMNk=
X-Google-Smtp-Source: ABdhPJz2KbQGozEKkN2yAT7NZKMjZzpophd5jYaCUAiThjO2GlhjiPUckUzvvHZhdwwiSjZ4bgieiA==
X-Received: by 2002:a2e:7c0d:0:b0:24f:b33:c6ab with SMTP id x13-20020a2e7c0d000000b0024f0b33c6abmr7895048ljc.516.1651499550807;
        Mon, 02 May 2022 06:52:30 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id i12-20020a2ea22c000000b0024f3d1daec1sm1068851ljm.73.2022.05.02.06.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:52:29 -0700 (PDT)
Subject: Re: [PATCH v2 08/19] xen/shbuf: switch xen-front-pgdir-shbuf to use
 INVALID_GRANT_REF
To:     Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20220428082743.16593-1-jgross@suse.com>
 <20220428082743.16593-9-jgross@suse.com>
 <CAPD2p-nisRgMOzy+w2jx5ULfZTyv4MqtG0wkV9jNn3wNg415sQ@mail.gmail.com>
 <b05fe983-8f9e-da3d-1bf0-e121ba969ae3@gmail.com>
 <f209285a-6fcc-27af-b8ff-7e517e9eb250@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <a3a01110-f330-bec9-24c6-81d0ec5cc59a@gmail.com>
Date:   Mon, 2 May 2022 16:52:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f209285a-6fcc-27af-b8ff-7e517e9eb250@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.05.22 16:31, Juergen Gross wrote:


Hello Juergen


> On 29.04.22 17:28, Oleksandr wrote:
>>
>> Hello Juergen
>>
>>
>> On 28.04.22 21:03, Oleksandr Tyshchenko wrote:
>>>
>>>
>>> On Thu, Apr 28, 2022 at 11:28 AM Juergen Gross <jgross@suse.com 
>>> <mailto:jgross@suse.com>> wrote:
>>>
>>> Hello Juergen
>>>
>>> [sorry for the possible format issue]
>>>
>>>     Instead of using a private macro for an invalid grant reference use
>>>     the common one.
>>>
>>>     Signed-off-by: Juergen Gross <jgross@suse.com
>>>     <mailto:jgross@suse.com>>
>>>     ---
>>>      drivers/xen/xen-front-pgdir-shbuf.c | 17 ++++-------------
>>>      1 file changed, 4 insertions(+), 13 deletions(-)
>>>
>>>     diff --git a/drivers/xen/xen-front-pgdir-shbuf.c
>>>     b/drivers/xen/xen-front-pgdir-shbuf.c
>>>     index a959dee21134..fa2921d4fbfc 100644
>>>     --- a/drivers/xen/xen-front-pgdir-shbuf.c
>>>     +++ b/drivers/xen/xen-front-pgdir-shbuf.c
>>>     @@ -21,15 +21,6 @@
>>>
>>>      #include <xen/xen-front-pgdir-shbuf.h>
>>>
>>>     -#ifndef GRANT_INVALID_REF
>>>     -/*
>>>     - * FIXME: usage of grant reference 0 as invalid grant reference:
>>>     - * grant reference 0 is valid, but never exposed to a PV driver,
>>>     - * because of the fact it is already in use/reserved by the PV
>>>     console.
>>>     - */
>>>     -#define GRANT_INVALID_REF      0
>>>     -#endif
>>>     -
>>>      /**
>>>       * This structure represents the structure of a shared page
>>>       * that contains grant references to the pages of the shared
>>>     @@ -83,7 +74,7 @@ grant_ref_t
>>>      xen_front_pgdir_shbuf_get_dir_start(struct xen_front_pgdir_shbuf
>>>     *buf)
>>>      {
>>>             if (!buf->grefs)
>>>     -               return GRANT_INVALID_REF;
>>>     +               return INVALID_GRANT_REF;
>>>
>>>             return buf->grefs[0];
>>>      }
>>>     @@ -142,7 +133,7 @@ void xen_front_pgdir_shbuf_free(struct
>>>     xen_front_pgdir_shbuf *buf)
>>>                     int i;
>>>
>>>                     for (i = 0; i < buf->num_grefs; i++)
>>>     -                       if (buf->grefs[i] != GRANT_INVALID_REF)
>>>     +                       if (buf->grefs[i] != INVALID_GRANT_REF)
>>>     gnttab_end_foreign_access(buf->grefs[i], 0UL);
>>>             }
>>>             kfree(buf->grefs);
>>>     @@ -355,7 +346,7 @@ static void backend_fill_page_dir(struct
>>>     xen_front_pgdir_shbuf *buf)
>>>             }
>>>             /* Last page must say there is no more pages. */
>>>             page_dir = (struct xen_page_directory *)ptr;
>>>     -       page_dir->gref_dir_next_page = GRANT_INVALID_REF;
>>>     +       page_dir->gref_dir_next_page = INVALID_GRANT_REF;
>>>      }
>>>
>>>      /**
>>>     @@ -384,7 +375,7 @@ static void guest_fill_page_dir(struct
>>>     xen_front_pgdir_shbuf *buf)
>>>
>>>                     if (grefs_left <= XEN_NUM_GREFS_PER_PAGE) {
>>>                             to_copy = grefs_left;
>>>     -                       page_dir->gref_dir_next_page =
>>>     GRANT_INVALID_REF;
>>>     +                       page_dir->gref_dir_next_page =
>>>     INVALID_GRANT_REF;
>>>
>>>
>>> I faced an issue with testing PV Sound with the current series.
>>>
>>> root@salvator-x-h3-4x2g-xt-domu:~# aplay /media/MoodyLoop.wav
>>> Playing WAVE '/media/MoodyLoop.wav' : Signed 16 bit Little Endian, 
>>> Rate 44100 Hz, Stereo
>>> (XEN) common/grant_table.c:1053:d1v2 Bad ref 0xffffffff for d6
>>>
>>> Here we have an interesting situation. PV Sound frontend uses this 
>>> xen-front-pgdir-shbuf framework. Technically, this patch changes 
>>> page_dir->gref_dir_next_page (reference to the next page describing 
>>> page directory) from 0 to 0xffffffff here.
>>> #define INVALID_GRANT_REF  ((grant_ref_t)-1)
>>>
>>> But according to the protocol (sndif.h), "0" means that there are no 
>>> more pages in the list and the user space backend expects only that 
>>> value. So receiving 0xffffffff it assumes there are pages in the 
>>> list and trying to process...
>>> https://elixir.bootlin.com/linux/v5.18-rc4/source/include/xen/interface/io/sndif.h#L650 
>>>
>>>
>>>
>>> I think, the same is relevant to backend_fill_page_dir() as well.
>>
>>
>> In addition to what I said yesterday:
>>
>> PV Display also uses this xen-front-pgdir-shbuf framework. It's 
>> protocol (displif.h) also mentions the same as sndif.h if the context 
>> of gref_dir_next_page:
>>
>>   * gref_dir_next_page - grant_ref_t, reference to the next page 
>> describing
>>   *   page directory. Must be 0 if there are no more pages in the list.
>>
>>
>> With that local change both PV devices work in my environment.
>>
>> diff --git a/drivers/xen/xen-front-pgdir-shbuf.c 
>> b/drivers/xen/xen-front-pgdir-shbuf.c
>> index fa2921d..ad4a88e 100644
>> --- a/drivers/xen/xen-front-pgdir-shbuf.c
>> +++ b/drivers/xen/xen-front-pgdir-shbuf.c
>> @@ -346,7 +346,7 @@ static void backend_fill_page_dir(struct 
>> xen_front_pgdir_shbuf *buf)
>>          }
>>          /* Last page must say there is no more pages. */
>>          page_dir = (struct xen_page_directory *)ptr;
>> -       page_dir->gref_dir_next_page = INVALID_GRANT_REF;
>> +       page_dir->gref_dir_next_page = 0;
>>   }
>>
>>   /**
>> @@ -375,7 +375,7 @@ static void guest_fill_page_dir(struct 
>> xen_front_pgdir_shbuf *buf)
>>
>>                  if (grefs_left <= XEN_NUM_GREFS_PER_PAGE) {
>>                          to_copy = grefs_left;
>> -                       page_dir->gref_dir_next_page = 
>> INVALID_GRANT_REF;
>> +                       page_dir->gref_dir_next_page = 0;
>>                  } else {
>>                          to_copy = XEN_NUM_GREFS_PER_PAGE;
>>                          page_dir->gref_dir_next_page = buf->grefs[i 
>> + 1];
>
> I think I'll introduce a proper define for that purpose.


I think it would be the best option.



>
>
>
> Juergen

-- 
Regards,

Oleksandr Tyshchenko

