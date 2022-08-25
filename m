Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344C35A0B22
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiHYIOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiHYIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABABB5A3C0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661415233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0OAvi4g9IUniVLfjcM2VZtFCmVJ+wiXvyhOCxHuPbYM=;
        b=N3EHq1w454Tbl+u8y3Ep+cwpA7qrrIL9naB0/5F9Mc5PzXdiCn+YvhmcssLrSnjm7CZr4k
        pE6oVE1RAaWRaW09fksHkXjdmHcPnCrMTE1qN3LNJuTTa/0RrNF9dh8rV11BSHPC1EvprS
        e/iiHLhG23mck/FihSGzfVl3ZwkENec=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-AZPRZxv-MDW3DgxLKxnyZQ-1; Thu, 25 Aug 2022 04:13:52 -0400
X-MC-Unique: AZPRZxv-MDW3DgxLKxnyZQ-1
Received: by mail-ed1-f71.google.com with SMTP id h17-20020a05640250d100b00446d1825c9fso6828059edb.14
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0OAvi4g9IUniVLfjcM2VZtFCmVJ+wiXvyhOCxHuPbYM=;
        b=SamMonDU+9lzHtHwO2+bi3w7BAximYqw1GG0zu8rbtzQ0QdEwl0zZg5lgiSt7zBQDY
         g9dg4zUtRsPpsLfD1tvL8xfEgjaE3yfDrxrZAr6TJMhpo6XjUA1glnNjipLD8RGEW51O
         A8W1W9cN+eVTaXR0mxaM/C0Hcph/fwHA6T5EIVemMh67CBuRty1ZLhfi3JKLMMz9ielg
         9rMpNZcNH4/vqijs41TBgoDhx6nNkt/vUt4TOJb0sSg7VgD4cmPnodwggPmQwxd9KczP
         le0J/iOjCop0eJtDbBYHHB0CiFIfy/ZFE0YAAQ7YULB7c5NvIVxFU1U0AyAvKlLV1Ebk
         RLZw==
X-Gm-Message-State: ACgBeo3j/8Abgs0i6lYcS7biWOsBzSNQ7cq0MMrR5B40rQaDna92OYfH
        ARV8nVTmJrIjBloGcJhiOF8x2f1TMEpjLuT7+0Qu+jQRAkCA6RN+yeoxYb9QqSYzs8pGRO1M8Av
        aDCukUyy2YoH6tmo8an/vMgfd
X-Received: by 2002:aa7:dc0a:0:b0:447:a7c0:54de with SMTP id b10-20020aa7dc0a000000b00447a7c054demr2249691edu.261.1661415229609;
        Thu, 25 Aug 2022 01:13:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4bnLV4TMJCebHeCZycFZc+6Gj0EHaxIaXe+1xWyqk2KfeYVy01bKoWJDgk9godBVb+MT3rGg==
X-Received: by 2002:aa7:dc0a:0:b0:447:a7c0:54de with SMTP id b10-20020aa7dc0a000000b00447a7c054demr2249675edu.261.1661415229418;
        Thu, 25 Aug 2022 01:13:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906728300b00730b3bdd8d7sm2128773ejl.179.2022.08.25.01.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:13:48 -0700 (PDT)
Message-ID: <c692c9e7-4938-12c2-3bd0-1d9811ad2b58@redhat.com>
Date:   Thu, 25 Aug 2022 10:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Content-Language: en-US
To:     PaddyKP Yao <ispaddy@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, PaddyKP_Yao@asus.com,
        andy.shevchenko@gmail.com, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, linux-kernel@vger.kernel.org,
        luke@ljones.dev, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
 <20220711024718.1700067-1-PaddyKP_Yao@asus.com> <20220824100615.GA1049@bug>
 <20220824110908.GB111@AA2000783-NB2.corpnet.asus>
 <ca13b742-7bb9-da20-4e50-2d04233aaf93@redhat.com>
 <20220824111734.GA8434@AA2000783-NB2.corpnet.asus>
 <YwbQYlqZ3H0NgaUu@paddy-ASUS-EXPERTBOOK-B1400CBA>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YwbQYlqZ3H0NgaUu@paddy-ASUS-EXPERTBOOK-B1400CBA>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/25/22 03:29, PaddyKP Yao wrote:
> Hi Hans,
> 
> On Wed, Aug 24, 2022 at 07:17:34PM +0800, PaddyKP Yao wrote:
>> Hi Hans,
>>
>> On Wed, Aug 24, 2022 at 01:11:32PM +0200, Hans de Goede wrote:
>>> Yes. Since I have already merged your original patch can you please make
>>> this a new patch on top of your original patch ?  In other words just
>>> make this 1 small change in the new patch:
> 
> Thanks for your help. I already submited new patch by below mail.
> And may I use author PaddyKP_Yao@asus.com instead of my gmail account for
> this new patch?

Yes I will fix-up the author to match the Signed-off-by when applying
the patch.

Regards,

Hans

