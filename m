Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0781A5AD77E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiIEQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiIEQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64711FCE1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662395553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nq/yrAoY/S8Xm7ZtUA1bcp3k0IAyIFeAXHDNpfXqDek=;
        b=Sm1D0a8PSx8ruAgskFJVdUJ+0ForWRvQJdco56AslwhPO+jrc7YtBn1D9a3ACzHjJ5cycU
        p0NDObCuNeAmpN7nngcztt/OqU8Hq43Dt0f+W597Z5x2RWCwsNFE+T1v93KUZDRQzt/6X7
        dA0DDk5SULh0o50S5MFSsvcu817A4lk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-396-YMKTNtknOaGEFN_bE0UcEg-1; Mon, 05 Sep 2022 12:32:32 -0400
X-MC-Unique: YMKTNtknOaGEFN_bE0UcEg-1
Received: by mail-wm1-f70.google.com with SMTP id i132-20020a1c3b8a000000b003a537064611so5549882wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 09:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Nq/yrAoY/S8Xm7ZtUA1bcp3k0IAyIFeAXHDNpfXqDek=;
        b=ZldEF5TFGeleS1UfpsuSjiePZ0UsENqufEqT/9+zAwAxiMSBSB82YkU5yTTYnSTQfQ
         0IX6ARrYYl81qfwzZxYe9TM4oRMyDKtRgS1x5YSdHUf5xXs1TagMqwIZd/JKkQyLN8Ic
         1B5Vp9YGNaeG8R1m6fn/919EjjI2M1cnhYTKWssrS5MrccL34oHbG12WriL0S1PBwD5W
         hBndHPGU3OcpYwlrWbBDHObZNGDhkpU6Yt8mpIVPxCa0zCDWDRRhbjkiDgMmG8v01jDx
         hveq1VlNTN1RabBFsxgfVn+36GCOTIo0ItUS49aadzklu8vMlEq5s49FAsIikXMGqmuv
         kPkQ==
X-Gm-Message-State: ACgBeo3Eg33LNdm9IdDI+BJW+GexlnwLwJQtf0uU9wPunZ/xDZi9e7at
        tnkwq4Gm19Ro2AACZha38X1MGX/pKAQdnJxcvLELQvt2YgFHEpooItkrNX53Y3Y4Ylz3qkG/V/H
        NzcXIksob3MMuVW0u1uL1f0Ql
X-Received: by 2002:a05:600c:410c:b0:3ab:ac5:c126 with SMTP id j12-20020a05600c410c00b003ab0ac5c126mr10014971wmi.158.1662395551505;
        Mon, 05 Sep 2022 09:32:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7UaTlgCWrird/WwC6iciEBOOSvADvM81ZF6WYU89A5DSeixda30BJUGqKXUQGmLy6BKMHOWQ==
X-Received: by 2002:a05:600c:410c:b0:3ab:ac5:c126 with SMTP id j12-20020a05600c410c00b003ab0ac5c126mr10014954wmi.158.1662395551253;
        Mon, 05 Sep 2022 09:32:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id bd7-20020a05600c1f0700b003a331c6bffdsm11341158wmb.47.2022.09.05.09.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 09:32:30 -0700 (PDT)
Message-ID: <08c54ddd-b74e-9f6c-f5eb-13e994530ad6@redhat.com>
Date:   Mon, 5 Sep 2022 18:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, svens@linux.ibm.com
References: <20220905084148.234821-1-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] KVM: s390: vsie: fix crycb virtual vs physical usage
In-Reply-To: <20220905084148.234821-1-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.22 10:41, Pierre Morel wrote:
> Prepare VSIE for architectural changes where lowmem kernel real and
> kernel virtual address are different.

Bear with me, it used to be

	crycb = (struct kvm_s390_crypto_cb *) (unsigned long)crycb_o;
	apcb_o = (unsigned long) &crycb->apcb0;

and now it's

	apcb_o = crycb_o + offsetof(struct kvm_s390_crypto_cb, apcb0);


So the real issue seems to be

	crycb = (struct kvm_s390_crypto_cb *) (unsigned long)crycb_o;

because crycb_o actually is a guest address and not a host address.


But now I'm confused, because I would have thought that the result 
produced by both code would be identical (I completely agree that the 
new variant is better).

How does this interact with "lowmem kernel real and kernel virtual 
address are different." -- I would have thought that &crycb->apcb0 
doesn't actually access any memory and only performs arithmetical 
operations?

> 
> When we get the original crycb from the guest crycb we can use the
> phys_to_virt transformation, which will use the host transformations,
> but we must use an offset to calculate the guest real address apcb
> and give it to read_guest_real().

Can you elaborate where phys_to_virt() comes into play?

If this is an actual fix (as indicated in the patch subject), should 
this carry a

	Fixes: 56019f9aca22 ("KVM: s390: vsie: Allow CRYCB FORMAT-2")

-- 
Thanks,

David / dhildenb

