Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AF65439F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiFHRJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiFHRIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C6A43EB9D8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654707350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4c8kGlgcgrySz70HHDv3Jz1c20zdeqf7rzk7asprMI8=;
        b=cvCn4Sm1YcFG4XZuQ/Q0SaAt4O6/YXlUzNlvcvvJTT2EFrJUpJJbAmA7G+PNAVnELMYNaL
        BR1QGQeY8x2qDbAXbA2iQWQcXrQvJGCseMhsXTKIedqAu4bRffxFJEGK3Y2EXJ8fGWJ3Iy
        9RdEsc9A+hJauKtV7a0HYesEtmJQ+ec=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-Z4ulRD0EPeupZmb-unxJZQ-1; Wed, 08 Jun 2022 12:55:49 -0400
X-MC-Unique: Z4ulRD0EPeupZmb-unxJZQ-1
Received: by mail-wm1-f69.google.com with SMTP id 130-20020a1c0288000000b0039c6608296dso521982wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4c8kGlgcgrySz70HHDv3Jz1c20zdeqf7rzk7asprMI8=;
        b=u6ZvPw1i2hHb5fX463S8c3MYH3H759SYLrW9BqlWFLLbZG3nlvklc8zG7qVw+hb6pz
         C+/Srvq3rIuowGrGaS8QC/rA1+CABIlMVFAkVBdwG9Y21MVZCvZxsnrmOe76pXN3nyq/
         YK4A9UJ9LxLiZcvF8VUrwCyZ2US3/Mv3PaaDiXOIh1APX2NqvYkCZ1A14HSBgfOJbebZ
         trfw7cIOoamxk9nfTZLIxC+zeaudwUD/i9TMEvZrLw3JCF1yTLpxWKWZ8vZHGJf9pfcw
         RIkzlCXG9p0L/maiVuZjVwEaobsix6axLW++Itul25s26iMM85LWGeS37Y7IbRvSYKvQ
         QyBQ==
X-Gm-Message-State: AOAM531GJY2ZEaVhSgYWmXpnSDRWcUuXSn8J9sDjqzQK7dCN9R7G/0Av
        +oo1UDbYIufQj8JUvVOipPFuBZa74eLz/BYCyI9RCsooKcmU794RUpGTfmrl6YSTJewA2VM+1Cu
        BrjpeG1JohAht1M7wMxuOg1Bv
X-Received: by 2002:a7b:c38b:0:b0:39c:6964:34a2 with SMTP id s11-20020a7bc38b000000b0039c696434a2mr113073wmj.165.1654707347720;
        Wed, 08 Jun 2022 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmqFMT3St6HAi8RPajZ9r15OOhueVRwHt+W2kyTeKxnY4OPBCQCb/ev3QASKILUM+KF2WEPQ==
X-Received: by 2002:a7b:c38b:0:b0:39c:6964:34a2 with SMTP id s11-20020a7bc38b000000b0039c696434a2mr113053wmj.165.1654707347536;
        Wed, 08 Jun 2022 09:55:47 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q16-20020adff790000000b0021863a560f6sm2410490wrp.3.2022.06.08.09.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 09:55:47 -0700 (PDT)
Message-ID: <ddd3eb76-5595-4946-95c2-067d5fbaae99@redhat.com>
Date:   Wed, 8 Jun 2022 18:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 3/4] fat: add renameat2 RENAME_EXCHANGE flag support
Content-Language: en-US
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>
References: <20220601173204.1372569-1-javierm@redhat.com>
 <20220601173204.1372569-4-javierm@redhat.com>
 <87h74vteb1.fsf@mail.parknet.co.jp>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87h74vteb1.fsf@mail.parknet.co.jp>
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

On 6/8/22 16:33, OGAWA Hirofumi wrote:
> Javier Martinez Canillas <javierm@redhat.com> writes:
> 
>> +	/* update ".." directory entry info */
>> +	if (old_dotdot_de) {
>> +		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
>> +					    old_dotdot_de);
>> +		if (err)
>> +			goto error_old_dotdot;
>> +		drop_nlink(old_dir);
>> +		inc_nlink(new_dir);
>> +	}
>> +
>> +	if (new_dotdot_de) {
>> +		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
>> +					    new_dotdot_de);
>> +		if (err)
>> +			goto error_new_dotdot;
>> +		drop_nlink(new_dir);
>> +		inc_nlink(old_dir);
>> +	}
> 
> Probably, we should change the nlink only if both of dotdot update are
> succeed and different file type. Otherwise, we would have to revert the
> nlink change on error path (and can remove unnecessary update as bonus).
> 

Agreed. I'll wait a few days before posting v5 in case you have more
comments on the other patches.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

