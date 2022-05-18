Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB352AF6F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiERA4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiERA4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:56:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B373B53E19
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:56:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id bo5so682317pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=yDgYs69aYpE5cCmLQl2Cv+lIMkj9co2v6xy0rPEyLP4=;
        b=QG8/780XFdeOjf6Tk1390skY8U2i3Cu7cYj/wEYoTlWBXmydHMLdR9lFrcMPu9AMqP
         cwiqJ8R19AYYxGMiF7NYXyxIyBAWTAOrPur3M86/lezpinIR4QT23bEqznE1Vtqv6QGH
         uihJ7aXOEr8jASh13zBQgJO7x8/DcygzXbzr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=yDgYs69aYpE5cCmLQl2Cv+lIMkj9co2v6xy0rPEyLP4=;
        b=6KPeKuBqM2uPwHcARVDSpIhmUNCxacHcXQxvD/nmc4KyE2vfiL2W2+xHem9scBPnpG
         JGc9CjuC4yLaevNh5G6yCPUOqUfPNFIoW0L3r5b60w0RY3uoKU8O9FTfORS0JSbVKbDM
         /+lwNgW4J63Cia8rX8FOqBajFaQ8/dJ0A9tx6y/MK1wiPoh+Ns+88wp5LOycvVuHx00w
         S8rD33hB9bhyB3a35dgo97PiWjc8OsvldJkQZq4WvVb2DGFwjh9Il4/zDqFTpM2DnAwY
         mjAFC4yFI8aztXNxpYBmTHOLV9zicS4cq9dLbPsnIIkdQaVhqR3gYa+fvJED/b1fqwmK
         09HA==
X-Gm-Message-State: AOAM533drGHLYImZpi2l43jvdbAYlKSK32gIhml0DM80OnWX6mm/GGai
        +RZ50EfJzH6zs+PXeA1Ufh96fg==
X-Google-Smtp-Source: ABdhPJwenNdlotq5UDBntG2qJ7wMwz8x/PVESzy4GrFUfi6C4Huw6jHETVPuvF3RYWRgCZgD40Mg7Q==
X-Received: by 2002:a62:1ad4:0:b0:510:c635:e516 with SMTP id a203-20020a621ad4000000b00510c635e516mr25346520pfa.42.1652835366235;
        Tue, 17 May 2022 17:56:06 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b0015e8d4eb1c7sm239696plb.17.2022.05.17.17.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 17:56:05 -0700 (PDT)
Date:   Tue, 17 May 2022 17:56:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
CC:     Christophe de Dinechin <dinechin@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] bitmap: Fix return values to be unsigned
User-Agent: K-9 Mail for Android
In-Reply-To: <YoQfzJGaDF5BQ7E4@yury-laptop>
References: <20220517212234.868181-1-keescook@chromium.org> <YoQfzJGaDF5BQ7E4@yury-laptop>
Message-ID: <5E266B49-F765-438D-870A-E9F6D8646F20@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 17, 2022 3:21:00 PM PDT, Yury Norov <yury=2Enorov@gmail=2Ecom> wrot=
e:
>On Tue, May 17, 2022 at 02:22:32PM -0700, Kees Cook wrote:
>> Hi,
>>=20
>> As mentioned in the last patch:
>>=20
>> Both nodemask and bitmap routines had mixed return values that provided
>> potentially signed results that could never happen=2E This was leading =
to
>> the compiler getting confusing about the range of possible return value=
s
>> (it was thinking things could be negative where they could not be)=2E F=
ix
>> all the nodemask and bitmap routines that should be returning unsigned
>> (or bool) values=2E Silences GCC 12 warnings:
>>=20
>>  mm/swapfile=2Ec: In function =E2=80=98setup_swap_info=E2=80=99:
>>  mm/swapfile=2Ec:2291:47: error: array subscript -1 is below array boun=
ds of =E2=80=98struct plist_node[]=E2=80=99 [-Werror=3Darray-bounds]
>>   2291 |                                 p->avail_lists[i]=2Eprio =3D 1=
;
>>        |                                 ~~~~~~~~~~~~~~^~~
>>  In file included from mm/swapfile=2Ec:16:
>>  =2E/include/linux/swap=2Eh:292:27: note: while referencing =E2=80=98av=
ail_lists=E2=80=99
>>    292 |         struct plist_node avail_lists[]; /*
>>        |                           ^~~~~~~~~~~
>>=20
>> This splits up the patch into the bitmap and nodemask halves, and drops
>> a needless change to the random node helper=2E
>>=20
>> I note that Alexey and Rasmus touched on this area in the past, fixing
>> up node ids to be unsigned:
>>=20
>> ce0725f78a56 ("numa: make "nr_online_nodes" unsigned int")
>> b9726c26dc21 ("numa: make "nr_node_ids" unsigned int")
>> 33c4fa8c6763 ("linux/nodemask=2Eh: update bitmap wrappers to take unsig=
ned int")
>>=20
>> If anyone else would like to carry this, please let me know=2E I'm happ=
y
>> to carry it in my tree=2E
>
>I think it should go thru my tree, if no objections=2E

Sure thing! Thanks for the review=2E I'll send a v3 with the variable upda=
ted and tools/ refreshed=2E

-Kees


--=20
Kees Cook
