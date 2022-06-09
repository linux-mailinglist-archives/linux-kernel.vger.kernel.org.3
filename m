Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61475455C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344984AbiFIUga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiFIUg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EEF6F3FB0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654806987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dgea+t4oiPPgtuKt/vNqsbsyWPPitCsrOvboiSTnKV8=;
        b=Y1jL7lRCM/aX+urTFTMvL4T7scusc/SjCAhqQNOw/lSJEm1Mj+J/9ioXA4Z9geQOYk/FA0
        t8KL8TkLwuSC2P8ng7+3JKn/tf3hGH3BBp5RVj5pxxkWZgGaPhLpRm9ngZUS/V3LlbD25j
        E9e4+p/VIINVePYnIPUFd5UYLlKKE08=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-ZqxGssiPPaqTbnJEqg4-vA-1; Thu, 09 Jun 2022 16:36:25 -0400
X-MC-Unique: ZqxGssiPPaqTbnJEqg4-vA-1
Received: by mail-wm1-f69.google.com with SMTP id v125-20020a1cac83000000b0039c6608296dso201556wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 13:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dgea+t4oiPPgtuKt/vNqsbsyWPPitCsrOvboiSTnKV8=;
        b=u5+QT2C8yx+N/5aHnSGaw6+ls4eW8Q//kn3PPbqW9vYe3G9pNQUaG27PY9+5MIiqYq
         eiGB5HR/WlgxSdxomzEnnjshbtHrj2zD2eunDQT5CvRR8cAhZgbJbgddkY+ZnF3kMjNN
         7HJbnSO/gNIsLqe5xJ812OYxIBMkKPXnsyPU9ysiHvyl0WQMl0Xjv/yMQytldPasJlc5
         3SgXdqaaRqLojkeV1VdBY8x7Bify2XnjYxrepkEzwdTq34Tv2JAH5pL985ci3ejxhK+D
         8VEAFtqk9KgBKGFe6ZR2Dlgqf0HX1el9ENrHuWZ6+B6C+dTkNXMssvv4y2X9LoER/FrT
         yO0Q==
X-Gm-Message-State: AOAM532xeNuGPYYj+k7ezDocn7guFZ2CWlrI+aOnEqPIDRg3w2gfEvnR
        Py4datsoTPWn22W6rQzmPDp9pXl4N6sDzs8DkPTUbsOiC01wu6JHyyCoxkBxEgFTrf2wyBU+W9L
        ctZvMwCiKD3YN2L6lhs2iniPl
X-Received: by 2002:a1c:4604:0:b0:39c:4769:3bb7 with SMTP id t4-20020a1c4604000000b0039c47693bb7mr5141981wma.115.1654806983777;
        Thu, 09 Jun 2022 13:36:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNbDJfNALDz7ISZlvVgawVkm3IKJZPFLuDtDUJ3DMffggrrY4IQZ1wxEvoZhgRxtpLILArNg==
X-Received: by 2002:a1c:4604:0:b0:39c:4769:3bb7 with SMTP id t4-20020a1c4604000000b0039c47693bb7mr5141959wma.115.1654806983430;
        Thu, 09 Jun 2022 13:36:23 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x8-20020adff0c8000000b00210a6bd8019sm24923451wro.8.2022.06.09.13.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:36:23 -0700 (PDT)
Message-ID: <9d837076-f666-c3c3-dd09-5c3705da23e6@redhat.com>
Date:   Thu, 9 Jun 2022 22:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 3/4] fat: add renameat2 RENAME_EXCHANGE flag support
Content-Language: en-US
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@verbum.org>,
        Alberto Ruiz <aruiz@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Kellner <ckellner@redhat.com>,
        Carlos Maiolino <cmaiolin@redhat.com>
References: <20220609093638.664034-1-javierm@redhat.com>
 <20220609093638.664034-4-javierm@redhat.com>
 <878rq54pf1.fsf@mail.parknet.co.jp>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <878rq54pf1.fsf@mail.parknet.co.jp>
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

Thanks for your feedback.

On 6/9/22 21:17, OGAWA Hirofumi wrote:
> Javier Martinez Canillas <javierm@redhat.com> writes:
> 
>> +static void vfat_update_nlink(struct inode *dir, struct inode *inode)
>> +{
>> +		if (S_ISDIR(inode->i_mode))
>> +			drop_nlink(dir);
>> +		else
>> +			inc_nlink(dir);
>> +}
> 
> [...]
> 
>> +	vfat_update_dir_metadata(old_dir, &ts);
>> +	/* if directories are not the same, update new_dir as well */
>> +	if (old_dir != new_dir) {
>> +		vfat_update_dir_metadata(new_dir, &ts);
>> +		/* nlink only needs to be updated if the file types differ */
>> +		if (old_inode->i_mode != new_inode->i_mode) {
>> +			vfat_update_nlink(old_dir, old_inode);
>> +			vfat_update_nlink(new_dir, new_inode);
>> +		}
>> +	}
> 
> Looks like unnecessary complex (and comparing raw i_mode, not S_ISDIR(),
> better to change before make dir dirty).  How about this change, it is
> only tested slightly though? Can you review and test?
>

Your change looks good to me and indeed the logic is simpler than in mine.

I've also tested it and AFAICT it works correctly as well. Do you plan to
squash this or should I respin a new revision of the whole patch-set ? If
you want to post it as a follow-up I'm also OK with that.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

