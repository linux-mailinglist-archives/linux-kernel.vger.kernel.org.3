Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34F4EF901
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350148AbiDARfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347779AbiDARfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66B11223BCB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648834394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Daavgji11xj//qvsLsFxiM724qMZ15R42qv55u4KCLY=;
        b=jTiNBhRoJQCFWjoDF1rCPchi4T8LxfR0t1BmamAUVOTl4gRmy7WuIqt+YAyS0PER+sNtWR
        Ik77eKMOIs1p+aF64VH378NrA1VbVl4RtZ8bFKDs5qQcEtFJWMJUuXXd7pMqxIsawOxMBJ
        7yAkRzIj0PoKUhBrEK8kiPwJZCP/72o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-KfJaLa4bOZCZv5oFHdRLlw-1; Fri, 01 Apr 2022 13:33:13 -0400
X-MC-Unique: KfJaLa4bOZCZv5oFHdRLlw-1
Received: by mail-qt1-f199.google.com with SMTP id h11-20020ac87d4b000000b002e1c9a3ae51so2513963qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 10:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Daavgji11xj//qvsLsFxiM724qMZ15R42qv55u4KCLY=;
        b=0md0zM6CMnPOsLXwDPW3P467biRoXGS2EL0dRvaLfz/TfeEkBIM1rr+Js9lFvkfDwE
         fXqlLWXVnTxASqP6sr7Ub1YU/RD4honiJ+uXuXEV9k6YnZ2LwfTWhq6wVISX23aKLFzq
         p7w9wOOgN78SkknbqQpDZlHm1CvQDaF3EouvqR38FBlxwwhxTe9ncvsPdAmS3vjsp0L+
         /Kq7xvi/ax55sv0PrZ0wo23SUxfH2X/YN5DmeJV2ZbX0yMyzlyhqCqISi4unNhH/PTNM
         /fm6oIKZP+kiSDYIEb8zdrne4KLWadczGV6us2SncVZj3sfazsjKBrNABZa93ow12OK3
         3KDA==
X-Gm-Message-State: AOAM533w6EppjLzsKqGwqISZDnkucsJdJu58ucqxf+yJgZ5nk6I0qb77
        +egqf2K/fce5dh5KL71hSrC2s5qdrwpsCWEFKCHoihxBx5Gr14mIQjsHErClpvVieoMgKEgI5OU
        nAOA75clbiSVHGNkUfJAvnZeTNOF/RleSzaqLZYUyTDB2H5lKflmyxuaPuKgAgKRa2Yngomc=
X-Received: by 2002:a05:620a:4409:b0:67d:af50:e422 with SMTP id v9-20020a05620a440900b0067daf50e422mr6916345qkp.405.1648834392570;
        Fri, 01 Apr 2022 10:33:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaUZhIjAnL6LCLe12tSjtsfoB+ETuDz4t/mPXzDh31K9bDNEBar3AjtturUnJFuUJQ8CIW8Q==
X-Received: by 2002:a05:620a:4409:b0:67d:af50:e422 with SMTP id v9-20020a05620a440900b0067daf50e422mr6916328qkp.405.1648834392285;
        Fri, 01 Apr 2022 10:33:12 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm2272787qtx.58.2022.04.01.10.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 10:33:11 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: btintel: fix btintel_download_firmware stub
 signature
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220331174959.3421978-1-trix@redhat.com>
 <5F44BE52-C933-4A86-8197-C0FFAD6DE1E0@holtmann.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <96a12c2a-0ad9-dc66-86af-e388a725d403@redhat.com>
Date:   Fri, 1 Apr 2022 10:33:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5F44BE52-C933-4A86-8197-C0FFAD6DE1E0@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/22 10:22 AM, Marcel Holtmann wrote:
> Hi Tom,
>
>> On Mar 31, 2022, at 19:49, trix@redhat.com wrote:
>>
>> <Mail Attachment>
> please fix your email client to send this properly inline. Or use git-send-email.

I did use git-send-email.

I am not sure what the problem is.

Tom

>
> Regards
>
> Marcel
>

