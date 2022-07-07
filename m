Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D243856975A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiGGBUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiGGBUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B29832E69C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657156814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhRef+FkSZ+CxsMXJPxXaTYZ1wHLp5/yViMAXOga9OA=;
        b=jFVIFomxcZCRsyX0HVEeXXGL5CMd2taR/RvfjiHzk5Y9UHE6K1Kl4I0O9CizmhWVn5cifM
        t1GWzR8VA04Fjq7euTDRBg8mVvrCpbrLZ3SQ0dmcunKb++WMNdO8GECYPGjR3erwUZryjm
        xJ27CuTyv+bok4YxLUyzsghd/Pu/Udc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-WBOQZcRuO3OMoHQC6sEMKA-1; Wed, 06 Jul 2022 21:20:13 -0400
X-MC-Unique: WBOQZcRuO3OMoHQC6sEMKA-1
Received: by mail-pg1-f200.google.com with SMTP id 11-20020a63070b000000b00412b2e755d5so648108pgh.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 18:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XhRef+FkSZ+CxsMXJPxXaTYZ1wHLp5/yViMAXOga9OA=;
        b=kQTS1Z0xXMB4J/aGRNRQXG0e23eI8Jy2chqsq4wJXEsGqDzNiD56UES0x4nMBdvdRJ
         EO5xVRvAsnAH+hdPAxVwOKof2CVR5QPhLWeszjpYRDZyung43HXlRV3sBNcvPIKuhCqJ
         UIve+EsUICDezsfTeITbnZa5n6FLOTuh9bnEx0GPgA1R79NZJCgYQE5C+vsv7Hv+OG4I
         gbExEO9s08xBKWXKmUAYYCqLAA9h5mjs24zjSqaSM0u20+cReoKO6ySImyIb2+v6A9ii
         1wXvMq5J2WSBxH6Z7+VU2wxjphqv8axWOdknSs+8uLHtnnsJZcfm7UbPrYbGq66bYEnj
         jrOQ==
X-Gm-Message-State: AJIora8EsPVXGRqP0ZY/aCBgO1Gm/mfVqQlZMDEXOVFrILArLOHlRupW
        dzUytPOpFej6p0/6e5vy+K6ZxWgRyWS0QFqZBs9+1lO+fe0+YZyF91VtskRYYx2WhWfyHFP3OcE
        LZF8V6dbRE37HeU1iJShYI5QiN77P21pDSRPMAGGFA46ShFjX7sw0jN41U0lk9HTNY8jhJhuzPQ
        ==
X-Received: by 2002:a17:902:7e8a:b0:16b:bc73:73bc with SMTP id z10-20020a1709027e8a00b0016bbc7373bcmr33191575pla.8.1657156812377;
        Wed, 06 Jul 2022 18:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vrNM1b0FLX4BeO8l5eCMZ8/8AxY6F5s6PSvYq0EjhOCrUEXjYTctmluydyxVAQfU3h9XB3/Q==
X-Received: by 2002:a17:902:7e8a:b0:16b:bc73:73bc with SMTP id z10-20020a1709027e8a00b0016bbc7373bcmr33191526pla.8.1657156811954;
        Wed, 06 Jul 2022 18:20:11 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l15-20020a63da4f000000b0040d0a57be02sm24236158pgj.31.2022.07.06.18.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 18:20:11 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] fs/dcache: export d_same_name() helper
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jlayton@kernel.org, idryomov@gmail.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220526011737.371483-1-xiubli@redhat.com>
 <20220526011737.371483-2-xiubli@redhat.com>
 <YsYFZU2Y2hkyVT3r@bombadil.infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <36cb99e2-e612-0b85-8b7e-7d9cb02c2838@redhat.com>
Date:   Thu, 7 Jul 2022 09:20:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YsYFZU2Y2hkyVT3r@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/7/22 5:57 AM, Luis Chamberlain wrote:
> On Thu, May 26, 2022 at 09:17:36AM +0800, Xiubo Li wrote:
>> Compare dentry name with case-exact name, return true if names
>> are same, or false.
>>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>
>    Luis

Thanks Luis!

-- Xiubo

>

