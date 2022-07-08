Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14F56AFB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbiGHAe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 20:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiGHAey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83B7F4D157
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 17:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657240491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sAdfxmW8RF+AZ9EDvY1OeIPpyhjibGeFRdYERWEBXJ0=;
        b=Jn39eivsh135ZVyHq9a0+h8KkVtve948+CWsC5a6AomjIJYoVuWy0eH25dYnbIB21gU7U6
        XRRiHIn89BJKp5jx8WHE9qtnzAQRvctJTvaTkJG8rOkutImunWI0+AMIeFPapxhbLfq/vP
        4VYtLM9l+sunWG0LoPsEw83cUxjJ1Ds=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-IyK90cPhN8y06buKGUeyrQ-1; Thu, 07 Jul 2022 20:34:50 -0400
X-MC-Unique: IyK90cPhN8y06buKGUeyrQ-1
Received: by mail-pl1-f199.google.com with SMTP id e8-20020a17090301c800b0016a57150c37so9233548plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 17:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sAdfxmW8RF+AZ9EDvY1OeIPpyhjibGeFRdYERWEBXJ0=;
        b=gA2OadpClDv/DcYAZxb8xfa8uVrgW2T56qkGZpcZZYXMUTF73grodamt8cnOJc9FRT
         TovOwsGXgj/NGuDW1nUEadmg+ZLQcUyJ06fzBgSSPJYgRmn21QGdClkQgs2CxvJaUuoU
         QFxkZRK2cS0RxbPgqwO88xS1pgGYH6O64udKEYwxBHUHoOTAKaDYfZPYkHxGu85xSn/q
         x8jHW6/hUlYaiIIDDJ1eCRG+hGIqTaqIR0OvrTP2dD9vTp3U+uDCR2lXQ9RDeKAMENtB
         zk3+gdPzo5lswIJmcqhILlmQ+/WejhrVx7ktDXfKf4dhgcZ2M8dCpWFby4p3edy91uxp
         QPcw==
X-Gm-Message-State: AJIora99IYXA0GAc4OI0MgOmpuF0mcuIe8yC73e0BrOC59Ypcatl9m1A
        RMIgMWXI8gCi+BmO1aWz+3fF+XuQArMCU8WMcBdapltAKj3rHK/sVZ4Pf4MbrSEqyGaqz34AFtf
        iHgpJTmR8lMHq85235wNWJnAc
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr1000614pfl.38.1657240489538;
        Thu, 07 Jul 2022 17:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSUVNLziJFu4GfOCBs8dy/vRXb0JGhtZPTokt7fqNMumRCZo7HOzSxp0rdxI9MeBMR5F9NbA==
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr1000587pfl.38.1657240489335;
        Thu, 07 Jul 2022 17:34:49 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m22-20020a62a216000000b005289753448fsm6160102pff.123.2022.07.07.17.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 17:34:48 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] netfs: do not unlock and put the folio twice
To:     David Howells <dhowells@redhat.com>
Cc:     idryomov@gmail.com, jlayton@kernel.org, marc.dionne@auristor.com,
        willy@infradead.org, keescook@chromium.org,
        kirill.shutemov@linux.intel.com, william.kucharski@oracle.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cachefs@redhat.com,
        vshankar@redhat.com
References: <20220707045112.10177-2-xiubli@redhat.com>
 <20220707045112.10177-1-xiubli@redhat.com>
 <2341366.1657197157@warthog.procyon.org.uk>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <7f5467e2-c01a-b327-44f7-97cd34e4e0b1@redhat.com>
Date:   Fri, 8 Jul 2022 08:34:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2341366.1657197157@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/7/22 8:32 PM, David Howells wrote:
> xiubli@redhat.com wrote:
>
>> URL: https://tracker.ceph.com/issues/56423
> I think that should be "Link:".

Okay, in ceph tree we are using the "URL:".

-- Xiubo

>
> David
>

