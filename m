Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404FB54299E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiFHIkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiFHIi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D8CF1E300A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654675010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2k+jKIfHZoA1h8TQDCXVxq0+BaAqWOwfnPdkWgL4PK4=;
        b=JdwHHsQvNhuTwvGBKaTEhdrxmRGHkwjPw8BRcNjnQT39If0aqTEglNne7xRQNFW7YYjXS+
        AdBCJfBdIDHDJ8I5Mp9e+KeJeO/trFhyGS/ItW6ffQL5lXiFuvbYs0YoKXisY88LozmMip
        u8fHCNlXze2aQwVyPuFRdIbqpLTEcnA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-clBYffUIPcmPkIk8RAsy5g-1; Wed, 08 Jun 2022 03:56:48 -0400
X-MC-Unique: clBYffUIPcmPkIk8RAsy5g-1
Received: by mail-wr1-f70.google.com with SMTP id h2-20020adfe982000000b002102da95c71so4493694wrm.23
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2k+jKIfHZoA1h8TQDCXVxq0+BaAqWOwfnPdkWgL4PK4=;
        b=RuldbKpxQOD/gbCZiVIMlNiLUQ7Z6gR59Lwdto1fIpkUheM5S50Sks0pg8hcvTngoX
         R8juLCzY3ToG3vxMlxmqEZr9OIcrSSSph0KjiwYo0IowTbrYBzOv/Znp/yG77SGYW5ID
         irHCQyP8SXv38cYR6zczRsFh3+PDRlsdHBtFFULxRYyfArQLNBBU2L2AAnxlUqfyfWAg
         Dsu4Zcio5gvvm6DyG2jajYlSq0g6nFQr9selMW+S4+jiV+gbedreOeIACMpIwD9ONImj
         1XyoQouuMmbEGXciyN3qjTfK4XS1RqIIB+huQVuH1gBz8D1tomgYivScsZPaOk0Chw5j
         feUQ==
X-Gm-Message-State: AOAM530WpgmHaiQfp5yWFFB3N8W+PM9w6CnMNHPae2NR5R9dRKwv4ygo
        x7kzc1sO5a8MTFQ/3Qn7YizRKwFXbkBeH8P3zJBXAkuforW5V0BsgMHwB213pr/ZHwjoq+TTReK
        8xpSWW24lsPZhQDOQJIbLzUeb
X-Received: by 2002:a7b:c456:0:b0:39c:5d1e:661d with SMTP id l22-20020a7bc456000000b0039c5d1e661dmr5660327wmi.15.1654675007756;
        Wed, 08 Jun 2022 00:56:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGvvkN3Uxl/AE0OJUIVBs5rdbg2Ex7lGchsJScH3UTWwhM20U3V484mKeSchgYaohBskDAdw==
X-Received: by 2002:a7b:c456:0:b0:39c:5d1e:661d with SMTP id l22-20020a7bc456000000b0039c5d1e661dmr5660295wmi.15.1654675007509;
        Wed, 08 Jun 2022 00:56:47 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o10-20020adfeaca000000b0020c5253d8c2sm20003671wrn.14.2022.06.08.00.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 00:56:47 -0700 (PDT)
Message-ID: <05bfb010-6b00-edb1-0e28-889a2ff71503@redhat.com>
Date:   Wed, 8 Jun 2022 09:56:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/4] fat: add support for the renameat2 RENAME_EXCHANGE
 flag
Content-Language: en-US
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Lennart Poettering <lennart@poettering.net>,
        linux-kernel@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20220601173204.1372569-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220601173204.1372569-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello OGAWA,

On 6/1/22 19:32, Javier Martinez Canillas wrote:
> Hello,
> 
> The series adds support for the renameat2 system call RENAME_EXCHANGE flag
> (which allows to atomically replace two paths) to the vfat filesystem code.
> 
> There are many use cases for this, but we are particularly interested in
> making possible for vfat filesystems to be part of OSTree [0] deployments.
> 
> Currently OSTree relies on symbolic links to make the deployment updates
> an atomic transactional operation. But RENAME_EXCHANGE could be used [1]
> to achieve a similar level of robustness when using a vfat filesystem.
> 
> Patch #1 is just a preparatory patch to introduce the RENAME_EXCHANGE
> support, patch #2 moves some code blocks in vfat_rename() to a set of
> helper functions, that can be reused by tvfat_rename_exchange() that's
> added by patch #3 and finally patch #4 adds some kselftests to test it.
> 

I think that addressed all the issues you pointed out in v3, please let me
know if there's anything else that is needed for this patch series.

Would these be merged by you or should I ping someone else? I'm not
that familiar with how filesystem patches make into the mainline tree.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

