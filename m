Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72905017C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbiDNPuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352538AbiDNPku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B2FBDA0B3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649949642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64iwfqlvvcwkVV5nuqa1Iklmprqi6kfS6cUNegnWB6U=;
        b=BsV7ZsDn10oGhJQS+UrIw5p9Yx/oC3XrRAflCzFmu1NQFrX38czODAo1VVUc3pcCfSlNnJ
        RMggM5WAyI+VeX3m8szCEWeMe+uY1RqyHISU6S4s8wrYKMHN29EC+S7IfARug/IDsHGkAh
        8YXJhIr+VZ0wyRjiJmBCurtQ895Dkog=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-wCArkRvZNkGAAxr3yJI33Q-1; Thu, 14 Apr 2022 11:20:33 -0400
X-MC-Unique: wCArkRvZNkGAAxr3yJI33Q-1
Received: by mail-wm1-f69.google.com with SMTP id i184-20020a1c3bc1000000b0038e4c5968b5so4688018wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=64iwfqlvvcwkVV5nuqa1Iklmprqi6kfS6cUNegnWB6U=;
        b=r3QzJtkwtlpCynphR69h8trOEwW/bqnCtQypGLq37HniJLdLDKMhB1ppZws3C9TwAt
         u8nixe+bUvowmEi/GlFWemWbUK343JdxLH+taRXo7XvopGesRXe9a5eEfDSuly3gQ79v
         My6uSNVSyXerkUDJLQxnYBTePqht+F0eJO/Tg67RvbmAvUr+YH8x1LquHFGj2cZYEJP5
         qeqgg/X0sNrEpo9IP9Ly0OcX8dfcdU4lnAR3g2fNFrB3ELWQ3Bg4HRE9nMn0XsA09npP
         KQkv3CAJVfSyXi0KTXeO64hwVuzy6pR5El5+K0pJs6s9qQ75bwHLq939lktPcX2Qch4J
         buYw==
X-Gm-Message-State: AOAM5321IxjbMonWeHNhZ1yojH4XgfNZVzai+BqDgK49rpPZIbJe2V3z
        FLVo6GnerQHYj9qgxRYIeTr3Y3cnZlo5TbfZp/vxcmQqBi+8chLgq3TdW/DABwR/1kE22wJf3+r
        Q2GARXs0mMpx0Nb9edZLmpaTr
X-Received: by 2002:adf:f44d:0:b0:207:b33f:ea7b with SMTP id f13-20020adff44d000000b00207b33fea7bmr2460565wrp.628.1649949632202;
        Thu, 14 Apr 2022 08:20:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz28lZEMTJTb47EK9BNZSqS459NBUwBeb5BJhEgjG6VLFN5Y0XBH7mSIlwX3WKRvFNLHP3QEw==
X-Received: by 2002:adf:f44d:0:b0:207:b33f:ea7b with SMTP id f13-20020adff44d000000b00207b33fea7bmr2460559wrp.628.1649949632011;
        Thu, 14 Apr 2022 08:20:32 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id u1-20020a056000038100b00207a578e9d4sm2054623wrf.89.2022.04.14.08.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 08:20:31 -0700 (PDT)
Message-ID: <f4fa9962-a13f-dcc3-2ac3-e235545072cc@redhat.com>
Date:   Thu, 14 Apr 2022 17:20:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] kvm: selftests: Fix cut-off of addr_gva2gpa lookup
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Andrew Jones <drjones@redhat.com>
References: <20220414010703.72683-1-peterx@redhat.com>
 <Ylgn/Jw+FMIFqqc0@google.com> <Ylg4Nel3rDpHUzKT@xz-m1.local>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ylg4Nel3rDpHUzKT@xz-m1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 17:05, Peter Xu wrote:
> 
> So sadly it's only gcc that's not working properly with the bitfields.. at
> least in my minimum test here.

Apparently both behaviors are allowed.

Paolo

