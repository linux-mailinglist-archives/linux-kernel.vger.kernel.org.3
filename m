Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8B7482153
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 02:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbhLaBo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 20:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242471AbhLaBo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 20:44:28 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E742C061574;
        Thu, 30 Dec 2021 17:44:28 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id iy13so22425589pjb.5;
        Thu, 30 Dec 2021 17:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TZjER95UmKt9tkxdzo6ulN0VUUKpHWsIMP43D9luT3Y=;
        b=iYHwZI0+/fZ+Ih9cG6VfsjartsycTQ+8LU6+D9c//7cNbkQvh7lHZ9NRCIogpKMHh3
         F3u1Psnk0aY9Zht45HEDhQ6jZExyYtxcZtjBgRBS2j8WaZzjoGCySG7bx9A9a7XjyR/7
         deY0jtY6UdmYSz/VG08ecHiWGso7oUWvtYiONnBW9cYIDvN1XZOVs3Mef2JokqAlaGGU
         kaLBOsnNs6fcnQWbuOQYDr6BXr/cVsQkJ9w2X0E4KXlqv1aZRYjltG2V9j+GowmQT3Mf
         UyGbuiTYr+4Xy+vNoVrmFpQLWF3alSz/D1/e/bk8GZ0Azh+r7hW3LQ0XDiJ15yCiyDTR
         7+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZjER95UmKt9tkxdzo6ulN0VUUKpHWsIMP43D9luT3Y=;
        b=73nFJxAT4BUjElUFc3YTPvfA2KHQk/grpNLlAkVNVTK9w9LZIUTJeXWxi42xNZ3A5Q
         a6bjV5eyEzCpMx4+Pm03kxrnUMuHn5OGClYuv8oGZ+6dgR1NSzvc3jdcu4NmNleXIU2T
         wX4RUP0qkctbm85aW/O2MIcAwCBACV7YcJiatq2A0W/rfwsPfsw+sp2PPrctFazYVtQY
         1lXbBfnVsEo+KLoocmeO+Vt8HpoDEIQEqS+7TphopzlRh9uyvdIm8PKFczbkIMY5+/st
         gaSURr8oqWTvTCT+hKWvuDbkbPW+QG7pHS/cvVoGy3pckK9ze2CePWJJINmurG5UPwNe
         ny5w==
X-Gm-Message-State: AOAM532Yu6kS6V4dJqL3ED0toyTdZ7y3rHsgl9+FBlxuBb23nPCx41kR
        zb6s5cXsrOQXEWlSKUQj+sfTnjD2ssjGEA==
X-Google-Smtp-Source: ABdhPJxg7PQDaMFvvRZ5NKwdcrglQ2/xxakDEeZvecKFqb61vhCDuVn5lBCayPCT4Q2E8OXiRJl2Nw==
X-Received: by 2002:a17:903:1c4:b0:149:45fb:d6f0 with SMTP id e4-20020a17090301c400b0014945fbd6f0mr32824523plh.143.1640915068003;
        Thu, 30 Dec 2021 17:44:28 -0800 (PST)
Received: from [0.0.0.0] (ec2-18-162-113-223.ap-east-1.compute.amazonaws.com. [18.162.113.223])
        by smtp.gmail.com with ESMTPSA id f14sm29494696pfv.215.2021.12.30.17.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 17:44:27 -0800 (PST)
Subject: Re: [PATCH v2 1/2] usb: gadget: don't release an existing dev->buf
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, axboe@kernel.dk, stern@rowland.harvard.edu,
        jj251510319013@gmail.com, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211230043815.18899-1-hbh25y@gmail.com>
 <20211230043815.18899-2-hbh25y@gmail.com> <Yc2R+nIOG6aJ+hea@kroah.com>
From:   Hangyu Hua <hbh25y@gmail.com>
Message-ID: <6f7806af-1818-dbab-9e21-fee54a60d42b@gmail.com>
Date:   Fri, 31 Dec 2021 09:44:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yc2R+nIOG6aJ+hea@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I misunderstood the meaning of Alan. He didn't ack this patch. We stil 
disscuss about this. I am sorry.

On 2021/12/30 下午7:03, Greg KH wrote:
> On Thu, Dec 30, 2021 at 12:38:14PM +0800, Hangyu Hua wrote:
>> dev->buf does not need to be released if it already exists before
>> executing dev_config.
>>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> I missed this, where did Alan ack this patch?
> 
> thanks,
> 
> greg k-h
> 
