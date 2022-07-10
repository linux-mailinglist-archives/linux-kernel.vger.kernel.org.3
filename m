Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDCD56D12A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGJT5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77C17B7FF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657483037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6rPChSJrNMOV21SPMB+KCTvjBhzyRJQxoZZsHf/z/U=;
        b=bAgmvh9swtYD0OllFq/l64NbDALj/neMzj0NyDPcBXQg6fL8NO0F7PU2OOCNDcTjk00ooS
        qHaZ50WbdQtc40gzO55wipkvCduui3cd7zkiWWePqHStp81l+GkENHRl3NwrUEQBOPW3+p
        tN3XqPj+H33zMx1lQ3VpMKI7zpRjRG0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-ueoyjrEgO8mDNngqgpBxKg-1; Sun, 10 Jul 2022 15:57:15 -0400
X-MC-Unique: ueoyjrEgO8mDNngqgpBxKg-1
Received: by mail-ed1-f69.google.com with SMTP id w13-20020a05640234cd00b0043a991fb3f3so2918428edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 12:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j6rPChSJrNMOV21SPMB+KCTvjBhzyRJQxoZZsHf/z/U=;
        b=yx8mL8ojpVgeqOhOjTuhFvYedyocDHdraoRVKZR8sXY0b0wQ2fHCe2iMvGw0bciqfM
         S5JP6Gy3Wpq+Cp/vHMIRd7VW4vzNzOw5R+U8KWS7PTfiWnfMi69dxQE3McgvcL6e5TJj
         VsyqPl86J0X6RhndcSRFdicb+j2VqVFi8coweTk+Xmbn7X97qe12kWSnFAQaPovJLu62
         ZOzeCdA8jgtuaLglePpsan5E/+aVVARYJiJdrnUoxI3vXcy/yU3yNlc05l6nQybejtuO
         8syRWmivIif6leiVv8Pz7wAu5DnExryQAHfGTEzNdH/xh/gPWQfLD/xXTq8s8bMCNtr/
         VXag==
X-Gm-Message-State: AJIora/Z+m9DDtTvBtEFD7Y722/e7Q+GQaZMpWyrtkBLJPrFXccwzgiZ
        aPmp4QCPkyymVG9z1RN7TILVUxNv9XX67UbeRzAwgCe9rGKxz1JHDoPBrCHaDI7Rpm4ugK7EX3F
        I1rAfS9FO7nmbWqfGaQMa5Mhb
X-Received: by 2002:a17:907:2c5b:b0:72b:54bd:40f8 with SMTP id hf27-20020a1709072c5b00b0072b54bd40f8mr1383569ejc.137.1657483034716;
        Sun, 10 Jul 2022 12:57:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u7rNCF5/yqaZ40q8aChIrxUxRxVr6oAworIrvtHiCFKok1ELZFgoMNqZrRV8mf/Zq8cB0/Jg==
X-Received: by 2002:a17:907:2c5b:b0:72b:54bd:40f8 with SMTP id hf27-20020a1709072c5b00b0072b54bd40f8mr1383554ejc.137.1657483034578;
        Sun, 10 Jul 2022 12:57:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906218200b0072b14836087sm1838111eju.103.2022.07.10.12.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 12:57:13 -0700 (PDT)
Message-ID: <9ce8aa53-ed70-823f-3410-1f50d5b902c9@redhat.com>
Date:   Sun, 10 Jul 2022 21:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/2] Two fixes for IFS
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>, markgross@kernel.org,
        ashok.raj@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev
References: <c416b93b-8adc-d9a8-ef0d-594cce6d9a9d@redhat.com>
 <20220710182521.60642-1-tony.luck@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220710182521.60642-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/10/22 20:25, Tony Luck wrote:
> Hans ... if you are pushing to Linus to add "BROKEN", then could
> you include these two patches to make it fractionally less broken?

Since the driver is going to be marked as BROKEN now anyways,
I don't see much value in getting these send last minute to Linus.

At this point in the kernel cycle (rc6 will be out in a couple
of hours likely) we really should avoid churn as much as possible.

Regards,

Hans


