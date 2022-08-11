Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248B958FECF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiHKPIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 136AB57245
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660230492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z802gDpoJ9wWMBtv3NAnD9/R0f3Zm+XJ0jWpa2ZWjz4=;
        b=f9RbRgOYrew87E6HBvu+z5ZfQPZxtCTzYYH54SHgH9vecYWANr5U0pBqk2m9iD+cU53CIr
        rzckXLZjwJHm7iSINVb+y4w4NQzziJ+DiHiQCaYr39IQrIV67/tfUWtCsW0lMFcoDuSvGK
        HrbTP5LgULgr09e0vFi8hEe42KZ5Xvw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-192-xVjOr33OMric0fb3YJ3H5g-1; Thu, 11 Aug 2022 11:08:10 -0400
X-MC-Unique: xVjOr33OMric0fb3YJ3H5g-1
Received: by mail-ed1-f72.google.com with SMTP id m18-20020a056402511200b0043d601a8035so11334994edd.20
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=z802gDpoJ9wWMBtv3NAnD9/R0f3Zm+XJ0jWpa2ZWjz4=;
        b=2xaz7ue5neFu/zLJ+i4ohyjiS+MeDI3LulOhGnaU6/d7Oq5B7i9dmAgCyhrlxooX7V
         etpN8+H0HIaT950LldghH8tgyI3rOT974hMQS6EvRIPQinjt3PDGzZZ+qulXJDnnavqD
         yPkr+o+lcRUaR6qn4166DykaTlvRLCf8QxWxCH49PDNsuYhisMGGRf8keCsob9yZo9X9
         HkUnM9lOo9W26qXuXZW+o4LmJE2HFo3nCdMNJN6EZLTMe2ynYD/HT7qiuod59VyMHOlY
         bQ+SfxplYy7/1co5lz/7UHHpwGx+2SbnduYRdW9SCp1O1QDz6KsOLPQrFcITnx23EUOc
         4mSw==
X-Gm-Message-State: ACgBeo0uPQXQVINwpxEFCXz7xfGO7v9tDg+cIT65/Y6flkjmxFbJWQKl
        yBDIEyv2wtdFEpwtahGfkrf+Tg5+hlNVnb05OH+yfNHWxB6PZcNJHhj7jkWSsWPzMtbQGAjlSzY
        m43y9n860IgH6023izW6+AaQy
X-Received: by 2002:a17:907:9726:b0:730:9e04:f738 with SMTP id jg38-20020a170907972600b007309e04f738mr24358658ejc.631.1660230489317;
        Thu, 11 Aug 2022 08:08:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4L0J8fiQyioAhT1n/XB5jHSFXJwxcpS4Eh7tCmUHQGsrOR6XP7hr5sKx6sUsGczluaPFs23g==
X-Received: by 2002:a17:907:9726:b0:730:9e04:f738 with SMTP id jg38-20020a170907972600b007309e04f738mr24358646ejc.631.1660230489151;
        Thu, 11 Aug 2022 08:08:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906149800b00705cdfec71esm3629708ejc.7.2022.08.11.08.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:08:07 -0700 (PDT)
Message-ID: <a0688d90-8b20-fc50-56ec-d50a5601f468@redhat.com>
Date:   Thu, 11 Aug 2022 17:08:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 4/6] asus-wmi: Document previously added attributes
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Luke D. Jones" <luke@ljones.dev>
Cc:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220809025054.1626339-1-luke@ljones.dev>
 <20220809025054.1626339-5-luke@ljones.dev>
 <CAHp75VeLWGURdL9SK4+fLPRsM_Dc3bNvGSoWXKOWMSz=3CQUQg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VeLWGURdL9SK4+fLPRsM_Dc3bNvGSoWXKOWMSz=3CQUQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/9/22 11:25, Andy Shevchenko wrote:
> On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
>>
>> Documents some previously added attributes:
>> - dgpu_disable
>> - egpu_enable
>> - panel_od
> 
> Try to find a commit that introduced thouse and add the respective Fixes tag.
> 
> ...
> 
>> -                       * keyboard - 0 or 1, unknown what effect this really has
>> \ No newline at end of file
>> +                       * keyboard - 0 or 1, unknown what effect this really has
> 
> Should be part of another patch.

Ack to both remarks.

Luke please make this patch one of the first patches in your next
version / patch-series and then add the doucmentation of the new
kbd RGB backlight attributes in the patches where you are also
adding those actual attributes.

Regards,

Hans

