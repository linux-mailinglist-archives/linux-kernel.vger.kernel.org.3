Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D79758CC99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiHHRSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHHRSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F4819582
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659979092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKAu41n3gkA/Ahv6E2S2ts7XOL3RyEEoyqkn6AaGP4E=;
        b=BS8T8B++HH/2Nffks/OgmcQ+/DiTRxrsfDgTsHuBwHkXCQP0Tlu5TuBCDMcoH2fUhZLFCt
        sDB0zYAC7cD5gBQTGoDUD8LadglT9+lJDvdhg1/lHQiGWPlqUkhiAfy+jAsQGo+SGbe1/M
        ERAdmLuU1EMrlmOa2z5Vfs/RllXOKh0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-QnMtOzwNMNaVCw5wHj_qtA-1; Mon, 08 Aug 2022 13:18:11 -0400
X-MC-Unique: QnMtOzwNMNaVCw5wHj_qtA-1
Received: by mail-ed1-f71.google.com with SMTP id l19-20020a056402255300b0043df64f9a0fso6018105edb.16
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 10:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TKAu41n3gkA/Ahv6E2S2ts7XOL3RyEEoyqkn6AaGP4E=;
        b=DEp1ByeEhBJE96JWK7ZmYZwaK0k8odCTOJHbc4G42hxZ1TSoi5Oqf++X1xZNO74h+p
         bREvhNIDMGzYMYQccbczKoO9J/tf8AJVV3dbhsJkB41+pLGjMX/x3kOHNGfY8RRVydk5
         xtlO4psoFSELxjvmUWZo6Xj+nh/K3rgyaqmO1gBsrq1abFOg+y0GNFKPPDGmF8Cf086k
         wNoaiFnha6oCzEtQSlFK323tSHDgg41JuZc24oB9LRJJdJyLYH0ksUey9wYTIT8TPnI2
         +42nErF/MsFk4U49cKaulUFGfeDQlu7/V6Q7bNNL8y+hknd4v1lhKfeTAGX+Ttr4Q9Hq
         vWYQ==
X-Gm-Message-State: ACgBeo3Ocn/p0So/DNipSlGLr49532UDZVtf351r9+IM/WLl9XfM6sJ5
        s2G55hVi7vVx+a75K49w7MkJBGEp78tnTuPPoJjhZvO30fJ3DDOq4Alu23BJ5CA8FPehDABHCKS
        5mW2QAraEdvjKWpdeHQwIk/AB
X-Received: by 2002:a17:906:ee8e:b0:730:4a24:f311 with SMTP id wt14-20020a170906ee8e00b007304a24f311mr14963998ejb.420.1659979089849;
        Mon, 08 Aug 2022 10:18:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR44hVBeXJU7FHG0sjwizFAx9Qo52adACKicXWhC6N3TqNMwlGlf84kpgf0EQmbREOdwJ4jF+Q==
X-Received: by 2002:a17:906:ee8e:b0:730:4a24:f311 with SMTP id wt14-20020a170906ee8e00b007304a24f311mr14963984ejb.420.1659979089630;
        Mon, 08 Aug 2022 10:18:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7d5cf000000b0043d6ece495asm4838875eds.55.2022.08.08.10.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 10:18:08 -0700 (PDT)
Message-ID: <3de107e3-a5f1-9cb4-6187-774694a3b7b1@redhat.com>
Date:   Mon, 8 Aug 2022 19:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] asus-wmi: Adjust tablet/lidflip handling to use
 enum
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Luke D. Jones" <luke@ljones.dev>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220808031132.10075-1-luke@ljones.dev>
 <20220808031132.10075-2-luke@ljones.dev>
 <CAHp75Vds+DmQdeuSM7ixtZiX60jg83CWveFZNcQoQ=QyiqcvUw@mail.gmail.com>
 <23e2630c-2328-40cd-836b-f3b619ff6a4b@redhat.com>
 <CAHp75VcW+aSCSAE-FRqJxwwGWwDz+38GY4FrceWVso6BT8=sWg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VcW+aSCSAE-FRqJxwwGWwDz+38GY4FrceWVso6BT8=sWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/8/22 18:24, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 6:13 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 8/8/22 17:48, Andy Shevchenko wrote:
>>> On Mon, Aug 8, 2022 at 5:12 AM Luke D. Jones <luke@ljones.dev> wrote:
> 
> ...
> 
>>> To the switch-cases, please add a "default" case to each of them.
>>
>> The switch-cases are on an enum type, so adding a default is
>> not necessary and adding one will actually loose the useful
>> compiler warning about unhandled enum values.
> 
> It's good if you can cover all enum values, which usually you can't.
> enum according to the standard should be located in the type that is
> enough to keep it and be compatible to a char. This means that the
> code somewhere else may assign anything to enum (actually enum values
> are type of int) and without default you can't see the difference here
> and the compiler probably will be happy. That said, I doubt the
> usefulness of such a warning. But it's up to you.

I would prefer to not introduce a default label in this case; in
the unexpected case that the value gets set out of the enum range
then the switch-case will be a no-op and any added default would
also be a no-op, so adding a default gains us nothing.

Regards,

Hans

