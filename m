Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61DF56CA33
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiGIOuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGIOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C8A71AF3D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657378200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2GDUzN3l0qxO/Hqli77WYp9WmA8Xfb4Bjw+PpkPjgE=;
        b=fEYHQqQ3cW7ixMXyFK6n8CYCXCo1PIlFFkmHG/yk/wa2cuI1AMgkjEGN4WPDuDxdSlVcdi
        mN9RDgFZXBPaMsTLqauve3dwFSOrI8MPqr52gJVE+FxJO/457IKpC9ZZzUxrC55kI1sFrX
        aCYBrWlBQrhbj7n6d2/rejapy3kjr3M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-9B2M7VrHP2maNPTcegY5qw-1; Sat, 09 Jul 2022 10:49:59 -0400
X-MC-Unique: 9B2M7VrHP2maNPTcegY5qw-1
Received: by mail-ed1-f70.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so1122594edc.15
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 07:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=Z2GDUzN3l0qxO/Hqli77WYp9WmA8Xfb4Bjw+PpkPjgE=;
        b=1thO0iWTHDMS5M0cJ/nE3CPhdSFfJCMhTzo1ETerTx02zYTOiBEFltbkJvRkYpS1tW
         x+FyaUqo+Nt4bPvoXK6nlr3vdq3Vy8XXs8DEf6jNUZX9bo9P430d3QxHoaQWZR3u+xvz
         xcmpOUay6DKfB1oXFIIFxE4Bvd9wKro39QmykUXf81PwJExVF9mhGc9uTSpGAq++5Urm
         d9dosynGtAl3Vsmw9L6PrDYGq9V+40MAoBKx/3vfQkz7unhX8lveROnExwMHYhEt0agN
         UFH4GbsbeOu6j2EY17q115nDFGMGyv5kPm+/0ENr3oS0FeT6RYa2jXpluafpyPgQOIRh
         Ly4g==
X-Gm-Message-State: AJIora85GQsNddKCZjZbZWOB2hajwMca5Ch1IEvat8ez663UKrexZcK4
        vH4IPvxBdCDLXrWkaErO3OJ9sllU+cvhXyp//J4nQkMaEpJG7JfJGoRSt8nKkZNIazJgfaRRR4E
        YlyWTakWqWrgFBi88NVPcx9be
X-Received: by 2002:a17:907:1c9d:b0:726:3666:2ea4 with SMTP id nb29-20020a1709071c9d00b0072636662ea4mr9251484ejc.547.1657378197858;
        Sat, 09 Jul 2022 07:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t7swZutTwFRmzp4K87Butk8yX03IUfLsvruhrGJA3qp1QYs+a6KCEABk5oRVNxfkF4tLKHtQ==
X-Received: by 2002:a17:907:1c9d:b0:726:3666:2ea4 with SMTP id nb29-20020a1709071c9d00b0072636662ea4mr9251473ejc.547.1657378197707;
        Sat, 09 Jul 2022 07:49:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id az21-20020a170907905500b0072b02f99e55sm663737ejc.197.2022.07.09.07.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 07:49:57 -0700 (PDT)
Message-ID: <8211e5ce-7ab0-312d-3d64-00c94440a676@redhat.com>
Date:   Sat, 9 Jul 2022 16:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        PaddyKP_Yao <ispaddy@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Luke Jones <luke@ljones.dev>, PaddyKP_Yao@asus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>
References: <20220708084816.1140540-1-PaddyKP_Yao@asus.com>
 <20220708090731.1237488-1-PaddyKP_Yao@asus.com>
 <CAHp75Vc-5Py8heCJ4bKh1-7y+U+ycJxRuYdFwiT=NM5=gLqwQw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHp75Vc-5Py8heCJ4bKh1-7y+U+ycJxRuYdFwiT=NM5=gLqwQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<accidentally hit send to soon, trying again>

Hi,

On 7/9/22 13:44, Andy Shevchenko wrote:
> You have sent two patches with the same version, your submission
> confuses everybody, which one are we supposed to consider?

Also the From of this email: PaddyKP_Yao <ispaddy@gmail.com> and
the Signed-off-by:

Signed-off-by: PaddyKP_Yao <PaddyKP_Yao@asus.com>

do not match. If you want the Author field of the commit to
bet set to match the Signed-off-by, but have trouble submitting
patches from your Asus email I can fix this up for you when
applying. Please let me know if you want me to do this;
or fix this issue for your next patch.

Regards,

Hans




> 
> On Fri, Jul 8, 2022 at 11:08 AM PaddyKP_Yao <ispaddy@gmail.com> wrote:
>>
>> In some new ASUS devices, hotkey Fn+F13 is used for mic mute. If mic-mute
>> LED is present by checking WMI ASUS_WMI_DEVID_MICMUTE_LED, we will add a
>> mic-mute LED classdev, asus::micmute, in the asus-wmi driver to control
>> it. The binding of mic-mute LED controls will be swithched with LED
> 
> switched
> 
>> trigger.
> 
> ...
> 
> Not reviewing code because of the above.
> 
> Hint: `git format-patch -vX ...`, where X is a version number will
> help. And when cooking a new version don't forget to add a changelog
> between versions.
> 

