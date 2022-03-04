Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724424CE044
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 23:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiCDWjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 17:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiCDWjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B57F124593
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 14:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646433522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCMnoGKikt99i+bOvmFuu+myd6ACV9D1g1NEWSuvSEg=;
        b=Xv1u34TO203kFaGzIBfVjsDTWjaZFkzfQMml721J7GpLeahTZzwTx9/73UvU5pfcgZNqPP
        2EQeCP0crc8WU+E34HnIZJ3pWXR+bd3Bo4UuZf4p4JD69XUo2pfp16ff+/ESB8zZa4T8cB
        kQwCfUFPoCfwMrXtG/YDbE7AXZZzWzE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-kp8RTgukOeuKIK-Wv479lg-1; Fri, 04 Mar 2022 17:38:41 -0500
X-MC-Unique: kp8RTgukOeuKIK-Wv479lg-1
Received: by mail-qt1-f198.google.com with SMTP id g11-20020ac842cb000000b002dd2c58affaso7271543qtm.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 14:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pCMnoGKikt99i+bOvmFuu+myd6ACV9D1g1NEWSuvSEg=;
        b=A9TwExgeBxmjQRx3O68eOeI20XLn0OzugtITeYTExHXoYKlAmD8Epv4n+0LelcerJU
         es5Lc2VzvBYMC60xqoI3BYf33rqYMI2HNabmiO0E7g7EHNMh6FkgZ3pngHXvjVwJpJd4
         Ios5gcN5FvUO/gSSHpYH1D8xhJ/8VQTlmbF0ffjpW0lrGlEIGi9Edx7CX6nUa/fHgK8T
         zAVtUC7o5Ay5JBMT6rnlF7Zxha0wqWj6ooBuB7tlsRarQePmhEYY4pJX7WZIPdnS3B/z
         Jk5ojT7xh6WoUk4KIx8bbK/ZeMM+FXot3rF/VLS4hUZSPJuVhVYStTou+b8uQeeYsleB
         ec+Q==
X-Gm-Message-State: AOAM530TMuTL72J8yy+KkB3uaWZaqhliDHdrGeiCaPRUCsm3iiuVnGez
        rbKLVV1kKaAetfRgMaPjMb25q5gR+SgAmRPxJBZ6GbAPS2IRQAsS5flkHSceDnYSkMcf5kiATnJ
        VjXumx1s4am9KB3nkQgTcPsF4
X-Received: by 2002:a05:620a:372c:b0:67a:de08:875e with SMTP id de44-20020a05620a372c00b0067ade08875emr574235qkb.149.1646433521342;
        Fri, 04 Mar 2022 14:38:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1p6YxKKR4VWsIy4ZmjNNbsE6elG5BIMU9tJKjj/hlKR7R2HxTWr2egC175Bkb4O+EYPxtiA==
X-Received: by 2002:a05:620a:372c:b0:67a:de08:875e with SMTP id de44-20020a05620a372c00b0067ade08875emr574221qkb.149.1646433521171;
        Fri, 04 Mar 2022 14:38:41 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id d16-20020ac85ad0000000b002d71c463d9csm4117216qtd.24.2022.03.04.14.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 14:38:40 -0800 (PST)
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Finn Thain <fthain@linux-m68k.org>,
        Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20220127151945.1244439-1-trix@redhat.com>
 <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
 <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>
 <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
 <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
 <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
 <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org>
 <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>
 <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org>
 <CANiq72kOJh_rGg6cT+S833HYqwHnZJzZss8v+kQDcgz_cZUfBQ@mail.gmail.com>
 <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>
 <9dc86e74-7741-bb8e-bbad-ae96cebaaebc@redhat.com>
 <CANiq72nsKijH4zgLoEpiiq4462r1zYmaiDs13SEHDYR3aQziUw@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4f535f31-b993-7365-4964-9f7549afc2a1@redhat.com>
Date:   Fri, 4 Mar 2022 14:38:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CANiq72nsKijH4zgLoEpiiq4462r1zYmaiDs13SEHDYR3aQziUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/4/22 6:02 AM, Miguel Ojeda wrote:
> On Fri, Mar 4, 2022 at 2:46 PM Tom Rix <trix@redhat.com> wrote:
>> The churn level will be very high.
> Nobody is planning to reformat the entire kernel, at least not until
> the tool is close enough to the kernel style, which will take a while.

The churn on a single file like this is high.

There is no way to separate just one type of change, you get all the 
changes.

Not having an opt-in/out per type of change is a flaw that makes 
clang-format not ready.

Tom

>
>> Until clang-format has an opt-in mechanism, I do not think clang-format
>> should be used.
>>
>> .clang-format should be moved to staging/ to reflect its not being ready
>> status.
> What is not ready about it?
>
> It is a fairly useful tool that some people is already using, either
> for full file formatting or for sections within their editor.
>
> Cheers,
> Miguel
>

