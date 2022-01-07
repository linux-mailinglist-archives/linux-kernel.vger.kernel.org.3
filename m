Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4005486FBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345196AbiAGBfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbiAGBfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:35:13 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7376C061245;
        Thu,  6 Jan 2022 17:35:13 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 45-20020a9d0a30000000b0058f1a6df088so5080046otg.4;
        Thu, 06 Jan 2022 17:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ywgP16oIByxs3QRc1jRR8SDOEZAjX7UvCJxKV2kqOV4=;
        b=mrh3lTBfiCf9J3eoPKI+PHd5CE9aD3+kFjRQfweXdWxj2krX/eCoEgC7mVPKYr74gZ
         P/HEUv5RFc2St+AKt7HMKIMFEkr4FCRMn1fj7sygol6eKBjN+qjVF6mPw8QemvhQfQUX
         fy+fhqkdqps5pcjkrbYQY7br0upRvbac5nqLmAvkNT9mX3npgkWdp4+yJDMPIhidv567
         Y+Z1Xx4dp80BZ6SLHQIyDhWu9NFPdZ7dityC2PUpF1PjJDpLfLHynmPPUhQOWtK8/3ET
         quxN83kXsgTIyeRE63Kfp//5zNXmybkCy8FbmSjyxSpbJSbIYWfaD5mPZ+k3VOxb/olz
         afyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ywgP16oIByxs3QRc1jRR8SDOEZAjX7UvCJxKV2kqOV4=;
        b=thnI3qhAdu0N+1gMGbcUfR1tN/DLpKqpqcm5A1+2lN5qYdtFrSJO52TWC1G5p0vhZU
         gs1Bue+5j/GXzFbeMcpt7JeSMBbBjAFahhOPBFMhCIIhehdxkSmK8JHLM/5zvhueFuMr
         ugpcPUtTeI7FCNFcU12JIt/FkLmgcloGLyszZGqcMwHf690cbUK45iYxCo2RodP6kiG6
         CJrKgMctXQBEpfBl10YXcr6QeKhUliGsPa2+s7XXvhCh0f7gOPGBD2Pvx/N+AFtbHl0y
         7RjaAwpIVQR16DtLT/Dk8XVfQGJA4X2VfonnRrud7ctdo31iLfXMSjqceBO19/LnGk3P
         ClXA==
X-Gm-Message-State: AOAM5339F/eg+pIVXIuF6dAiVNPLH5SuvRE7fDxSP8qbu6Ld3qCSIiEj
        yb1to+hbSNuKtfjaO9j2yh7HF2Lu99E=
X-Google-Smtp-Source: ABdhPJzeCW7OSrCBMsXcTSnyd7bsXkRM9ty/z7avlBtYxITWKpHY+umUnWdwBOBO03dkTdkW5XM2mA==
X-Received: by 2002:a05:6830:2:: with SMTP id c2mr44862275otp.341.1641519312889;
        Thu, 06 Jan 2022 17:35:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1sm658659otj.61.2022.01.06.17.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 17:35:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] fsi: Aspeed: Fix a potential double free
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        alistair@popple.id.au, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
 <YcldM9sgYdjMYMtH@kroah.com> <20220106081418.GH7674@kadam>
 <f2ba50fd-5c6b-e905-17ed-541dcc98c6c1@roeck-us.net>
 <edd19014-3b99-fa0b-912b-e058c14401d8@wanadoo.fr>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6926bb63-836b-b37c-3605-d6df9992bfaf@roeck-us.net>
Date:   Thu, 6 Jan 2022 17:35:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <edd19014-3b99-fa0b-912b-e058c14401d8@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 10:35 AM, Christophe JAILLET wrote:
> Le 06/01/2022 à 18:25, Guenter Roeck a écrit :
>> On 1/6/22 12:14 AM, Dan Carpenter wrote:
>>> On Mon, Dec 27, 2021 at 07:29:07AM +0100, Greg KH wrote:
>>>> On Sun, Dec 26, 2021 at 05:56:02PM +0100, Christophe JAILLET wrote:
>>>>> 'aspeed' is a devm_alloc'ed, so there is no need to free it explicitly or
>>>>> there will be a double free().
>>>>
>>>> A struct device can never be devm_alloced for obvious reasons.  Perhaps
>>>> that is the real problem here?
>>>>
>>>
>>> I don't understand how "aspeed" is a struct device.
>>>
>>
>> -static void aspeed_master_release(struct device *dev)
>> -{
>> -    struct fsi_master_aspeed *aspeed =
>> -        to_fsi_master_aspeed(dev_to_fsi_master(dev));
>> -
>> -    kfree(aspeed);
>> -}
>>
>> So "dev" is embedded in struct fsi_master, and struct fsi_master is embedded
>> in struct fsi_master_aspeed. Since "struct device" is embedded, the data
>> structure embedding it must be released with the release function, as is done
>> here. The problem is indeed that the data structure is allocated with
>> devm_kzalloc(), which as Greg points out must not be devm_ allocated
>> (because its lifetime does not match the lifetime of devm_ allocated
>> memory).
> 
> Thanks a lot for the detailed explanation.
> Crystal clear for me now.
> 
> Do you want me to send a patch to remove the devm_ or will you?
> 

Sorry, I am way behind with code reviews. I won't have time to submit a patch.

Guenter
