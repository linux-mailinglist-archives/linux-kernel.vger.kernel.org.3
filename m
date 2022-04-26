Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A909F510690
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353673AbiDZSTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350866AbiDZSTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E74BCA0CF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650997000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVgIa5VojhJQmFpaigVxKBbsCXWJBMH1RAn1ujk7PRM=;
        b=Y/CAdBTN2Hicvj2JmArRC6JY6tMboGaTyDUzpSjPjrqMrviu6aOHYwuhwsLEQ1y0BDIl7K
        JI1bLmAFN1G+s1nt5ruMKZ/wPw0xIfj4AMlNetNDp+CujmrJDKyuD2cA6H9StILRTzmlMI
        NP16v1GBTH/3BupP1H33ryUx6vSLCCI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-S3SjU1AaMBGxIfhhMs5uFA-1; Tue, 26 Apr 2022 14:16:39 -0400
X-MC-Unique: S3SjU1AaMBGxIfhhMs5uFA-1
Received: by mail-qt1-f200.google.com with SMTP id x10-20020ac8700a000000b002c3ef8fc44cso10457436qtm.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fVgIa5VojhJQmFpaigVxKBbsCXWJBMH1RAn1ujk7PRM=;
        b=VhdVDeVNRiDCTmSpvN5ZoEZkaKLWDy3zIaEpg4i2kr1hUJKi2t7phuxEHnJslogzN1
         koHG2rCZoDfKipeleXqITbONYaLqrv1EQcGZKpnei2uNwYN7fZ3O88fxuM17+WHGE4NG
         D3u8d+r5L/tUKCvPz5sKOCTgxA2aGL9yd0AalDrc8XwQR7AlwJHGJzBYhKbigx5hG2SG
         SGM9UX9ceSfXEq/E2q2zrMLpHlhma7yfNVk+wbNeZzd/vmCPBwZ9DVYUcMO702FmRhb5
         O5NJ5R2/BxGtHS2kw5nXCB2vIo5hOY98DvBV98KyE/DUBKNXvuuHOY4FVDdrhIQ0yG9x
         +yXw==
X-Gm-Message-State: AOAM533seT6w1zBe87tEQyHikkkkkdobKXV0ZdQv2Q2lk+3PVi4Lsyhr
        gEiMc57BMJhr4J5ploLEVVH9sNm1US7UoxZzxJTsl50raRmJ20xMW3LsHBLdEeOIWjZbSEB4gPG
        70p6n6PxROdGTv2yDSxSb1xWJ
X-Received: by 2002:a37:8d46:0:b0:69e:6b77:f4c9 with SMTP id p67-20020a378d46000000b0069e6b77f4c9mr14005920qkd.96.1650996998485;
        Tue, 26 Apr 2022 11:16:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzerrK0bIUs13gQCY8RmGVefmuG6cHRoTRh0nUnFq7Yi9W2qY/3jruZ+Z2t3dFRiI2Xbx2aAg==
X-Received: by 2002:a37:8d46:0:b0:69e:6b77:f4c9 with SMTP id p67-20020a378d46000000b0069e6b77f4c9mr14005906qkd.96.1650996998279;
        Tue, 26 Apr 2022 11:16:38 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002f363eccb2csm5954200qtw.89.2022.04.26.11.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 11:16:37 -0700 (PDT)
Subject: Re: [PATCH] tty: n_gsm: return -EINVAL when adaption is not supported
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220426120554.1120585-1-trix@redhat.com>
 <Ymfhtv5b9M33AQuc@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4789ae7a-64a2-566b-d445-b8433d3f867a@redhat.com>
Date:   Tue, 26 Apr 2022 11:16:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Ymfhtv5b9M33AQuc@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/26/22 5:12 AM, Greg KH wrote:
> On Tue, Apr 26, 2022 at 08:05:54AM -0400, Tom Rix wrote:
>> The clang build fails with
>> n_gsm.c:940:13: error: variable 'size' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>>          } else if (dlci->adaption == 2) {
>>                     ^~~~~~~~~~~~~~~~~~~
>>
>> The else should return an error, so return -EINVAL.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> What commit id does this fix?  Any reason you didn't cc: the author of
> the recent changes to this code?
Sorry missed this part.
> Is this the same issue that 0-day reported?

Maybe, it was part of next's update today.  Where is 0-day reported ?

Tom

>
> thanks,
>
> greg k-h
>

