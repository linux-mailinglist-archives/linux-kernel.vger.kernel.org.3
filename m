Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B3524568
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350167AbiELGMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350142AbiELGL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:11:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAC76D952
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:11:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b32so5227956ljf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NEB+jrNm+Tn2FtofeaBVpeeoHMLJsewS6l3Qc041rsM=;
        b=NNEUu6kPZ1arfW4eHUTQDHxPZV/kgJ370ELIRRoRiXNWZ5JJi9ZCFJO/R344mtpCg0
         vrL8s3NxqydBsjCxs5i3xi6bIjgpDLx/+cyNPZScHQ4l3rj85FQUP8NsYNUKGPyKHiwL
         HkLijvpLEQCy8RojLGQhtygKeI+z+sETXEpoy5R+qPsiQgVbcQokY51YeREWOqH2qspM
         rNibrz1iHC4ETdUPQBJutTzoVJlSAmvAjiiUAjOGdBaQMREZx2lZg9Gh0RHnQEd60wTq
         yXnEBA3TkTar00aJ1t5mx+OkH2e8EamaGMjyBereZye249/Hpp8mTJrGf2KQAlwKUCrS
         UFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NEB+jrNm+Tn2FtofeaBVpeeoHMLJsewS6l3Qc041rsM=;
        b=oL9UHqcuYjDOF30OzRjHUzKiHXLeSfybiipNlGVMua0sY6B1nyfVbJJaAuQ/K/QJWi
         IMRpBmFN1ZlqofyemgEovechb+7GMG4W6SEQq7jWbRQg+9f9WRAe3/bbicSwLYmX+7Q3
         7sb49zhDhyUKOJ0fhe9vCEDrdaQ9fRL1mPO8YaLApifkOderpJbLoUCM2qJkDxWpmgUv
         /dkAS+RDkVDsloi1LgEP0vyjGWqJRXeTi/lW85gbwtQGu1VWLGsI3BBTBn2FxM8Mjh6y
         eRUKQQ/75I5knZlfGUwr2rkT4h2bcS4SCORv86+pMuVlbNccmkBPF4ieNXzhHxAO8Oyt
         T31Q==
X-Gm-Message-State: AOAM533tjJwbQXVuTuMd9cTui3LuLkXjffCQ95bh7BySFE2WC8kLLC+U
        ZR66N8a9NwRl3WEZR3aeMRY=
X-Google-Smtp-Source: ABdhPJyMRNpNOP2eL5Vb3YEt2h7dyYcK52kqLFmo+atTAmUfpAkUnaLLPD4zU5Qj2p/8dIrpHs9V/Q==
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id d21-20020a05651c089500b00250c5ecbc89mr13159344ljq.251.1652335910783;
        Wed, 11 May 2022 23:11:50 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id 17-20020ac24d51000000b0047255d2119asm617346lfp.201.2022.05.11.23.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 23:11:50 -0700 (PDT)
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
 <8409e636-94e3-e231-f181-c76a849534a1@gmail.com>
 <24748b59-e2ed-1d7d-801e-ab9dc12b0983@oracle.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <749e79d0-c920-adee-c145-edc4153a99f9@gmail.com>
Date:   Thu, 12 May 2022 09:11:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <24748b59-e2ed-1d7d-801e-ab9dc12b0983@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.05.22 00:09, Boris Ostrovsky wrote:


Hello Boris


>
> On 5/11/22 2:00 PM, Oleksandr wrote:
>>
>> On 07.05.22 21:19, Oleksandr Tyshchenko wrote:
>>
>> Hello Boris, Stefano
>>
>>
>>> From: Juergen Gross <jgross@suse.com>
>>>
>>> For support of virtio via grant mappings in rare cases larger mappings
>>> using consecutive grants are needed. Support those by adding a bitmap
>>> of free grants.
>>>
>>> As consecutive grants will be needed only in very rare cases (e.g. when
>>> configuring a virtio device with a multi-page ring), optimize for the
>>> normal case of non-consecutive allocations.
>>>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>> Changes RFC -> V1:
>>>     - no changes
>>>     Changes V1 -> V2:
>>>     - no changes
>>
>>
>> May I please ask for the review here?
>
>
>
> I had a quick look but I am stuck on get_free_seq(), I need to stare 
> at it some more. Unless someone else reviews this, I will try to get 
> to this in the next couple of days.


Thank you!


>
>
>
> One thing I did notice is
>
>
>>
>>> @@ -1452,6 +1624,13 @@ int gnttab_init(void)
>>>           }
>>>       }
>>>   +    i = gnttab_interface->grefs_per_grant_frame * 
>>> max_nr_grant_frames;
>>> +    gnttab_free_bitmap = bitmap_zalloc(i, GFP_KERNEL);
>>> +    if (!gnttab_free_bitmap) {
>>> +        ret = -ENOMEM;
>>> +        goto ini_nomem;
>>> +    }
>
>
> This overwrites 'i' and will break error handling at ini_nomem.


Indeed, will fix. Thank you for pointing this out.


>
>
> -boris
>
>
-- 
Regards,

Oleksandr Tyshchenko

