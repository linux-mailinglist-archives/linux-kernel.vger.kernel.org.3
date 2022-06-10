Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6888054677E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbiFJNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245684AbiFJNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:42:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BCB2CE2F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:42:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t2so22810290pld.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KmSVR4lZDux7jMqzZ5egDwaC7vwqVO8iWjyTpI9KDa8=;
        b=IwEigTeRxHv+eJO2kblhKX0VSwzDZqbX/BEEi9BwfpxlirL/T2N7R02Dyx+tWn8o3f
         sbr0Iq8tf+R50x86cWYa2d01DW101by3v99p+XKee1wmstSSnitQJ1FIGkQiJo66dbwj
         dt9iOb27KMW8qlL71ToC7je3RRbC+l8Pz5idQ3QIOoRpDhohitBwgFziUa9cSnoAclMT
         sEiyzLLvMW9+uQ5QMfQFAsrrHFB5EBXSDjg+HnJ5e/3Aa4nePETN0Z5zo6+yqJtIr1LH
         PxygE795YkLDs3lKYLZMLisjjX8VLqUfxDvBO7uHgh4Z0b5Vaktgzz9pI4KI3oDbR1fa
         MJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KmSVR4lZDux7jMqzZ5egDwaC7vwqVO8iWjyTpI9KDa8=;
        b=MWfBjay2dRlVZar8ozhLlyGQRPTh+8UxnbklRSQkp4la8EZF5xlkdO/cG0LPyQEHad
         uhXUJWiDuEeoH67A4W51NcWjbVTiu1SZ14F2LTKdsaVv7DZ1AtgYGWmaJ5BpLLVaPji/
         SRPAlL5RFJdnjb4oKwsFSscN50jQ0HpoFVhy3YOVzI443dzmOJ+k3PvTOiucPr8FVM/6
         qqRrPMXVHtIyRNzGdT0uqBvzUXzHlV/CIOGFIqNAGLhjl0ce+WYMGhl5jMpR+do/ODKZ
         JPLPh/hZ/R35zhJL07ly8J5KNgkbPWToNX2guETDtYBdNi9VYW7IIxW2RDU+THlzjsa4
         vO4w==
X-Gm-Message-State: AOAM530KXfQlDkPC/eOIDgh9T9dbAOV8Xm0xWtSE6xFGISlKkaY1aUf9
        +pOEzgq07ieyISeqXdkgKGM=
X-Google-Smtp-Source: ABdhPJwSqR0nLnXzui6B0LIle86hHQTJO+gW5yr/cb38X0JBZBgs/ExvxkfQydQsBInhV5vbRJj4iw==
X-Received: by 2002:a17:903:215:b0:15e:cae9:7622 with SMTP id r21-20020a170903021500b0015ecae97622mr45415597plh.28.1654868526179;
        Fri, 10 Jun 2022 06:42:06 -0700 (PDT)
Received: from [192.168.0.103] ([106.51.241.182])
        by smtp.gmail.com with ESMTPSA id d9-20020a656b89000000b003fd7e217686sm11475912pgw.57.2022.06.10.06.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 06:42:05 -0700 (PDT)
Message-ID: <a7fea025-1919-b2d7-e69e-136983c2e386@gmail.com>
Date:   Fri, 10 Jun 2022 19:12:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] char: lp: ensure that index has not exceeded LP_NO
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
References: <20220603130040.601673-1-sshedi@vmware.com>
 <YqNG5H+JbNJMeOWq@kroah.com>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <YqNG5H+JbNJMeOWq@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/22 6:58 pm, Greg KH wrote:
> On Fri, Jun 03, 2022 at 06:30:39PM +0530, Shreenidhi Shedi wrote:
>> From: Shreenidhi Shedi <sshedi@vmware.com>
>>
>> After finishing the loop, index value can be equal to LP_NO and lp_table
>> array is of size LP_NO, so this can end up in accessing an out of bound
>> address in lp_register function.
>>
>> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
>> ---
>>  drivers/char/lp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
>> index 0e22e3b0a..d474d02b6 100644
>> --- a/drivers/char/lp.c
>> +++ b/drivers/char/lp.c
>> @@ -972,7 +972,7 @@ static void lp_attach(struct parport *port)
>>  			if (port_num[i] == -1)
>>  				break;
>>
>> -		if (!lp_register(i, port))
>> +		if (i < LP_NO && !lp_register(i, port))
>>  			lp_count++;
> 
> How can this ever be needed?  Look at the check further up for the check
> of lp_count which prevents this from every going too large.
> 
> So how can an address be accessed out of bound here?
> 
> thanks,
> 
> greg k-h

Thanks for the review. Assume lp_count is less than LP_NO now and we enter the for loop
and for some reason for loop exits after i reaching the value LP_NO and right after that 
we call lp_register() with i and I can be equal to LP_NO.

-- 
Shedi
